Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54305680530
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:48:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjA3EsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:48:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjA3Er5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:47:57 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CAD213B;
        Sun, 29 Jan 2023 20:47:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z1so3863929pfg.12;
        Sun, 29 Jan 2023 20:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UW0uF3JndnGe88x0zatrkBLgb8pknqyoqUxSsqTqjg=;
        b=duNG+6h+C7oMf7sPI7j3C9pFC3aTStn3hftQa51EAeDg8GQxtEq2rldyBqzRyzpX11
         Qo7uVuvtytO0BjQjkvfcALsP2B7UHmBtZ1jSgSkYE6+tanXkvdSN9DJ2SoAi9yJoyS4x
         Kl0H9MYu+2tqaj8v8SewhjlAnZxW3B2ghbXzWHQx9HORjKi208cd+YeG8Ldo2mrFlDBz
         e7sQBLK4QI4nhRNealG32XtMIQi6IR3JnIglzKbuGgT8p5qgBPRtItvvSQd8VbK890Rj
         m59Sjx9XoCq6mtVA5r+CB+y9HfA5B8Mqgi/mAgbd4qCjo937drMFChZJbTFG+Cx+TElI
         A/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UW0uF3JndnGe88x0zatrkBLgb8pknqyoqUxSsqTqjg=;
        b=qWRY5Z1tecuSFT6cKswR3ZxA3+ym0MR/5HjHoekLGMxm+Tn/EnqWH7AWEGwGNIVBSy
         lIvuBPl39S+ClSwHGk9TQT/2YFS7FNWUR5Tv9BA2wlKY2qQJiovV4oME6LVxx3itcl36
         bitR3novnnd7IT4KTq8UbnL49OHZCprLZE2qNLDEqEmJ1HgglqQOPshlGYt5PTTpE780
         f+OHfEFfbXD2tzdmB4MdK8ZY+IBp14MFx/YHA3JoAW8Rq5djxIAQXzLYgKgPgTjbNXiy
         Kba6azhsXR/kDJlT2w+Slh6aN0/Dd4yB6ynPAcnEhvAs+zt2jb13QZetgeXr72+ior+2
         qjzA==
X-Gm-Message-State: AO0yUKVf+QZDS9heC3EFL8LQnXMZV9oE4Iu0WZ32uNee2VSyR8kukjj5
        zRt7orA/fwmAEH1U6A3+om+VTAdAq8k=
X-Google-Smtp-Source: AK7set8UXarjW57NDvVqAgkvRYoxSb5/hRxhE3Aqe6dr3jsPXTnyaTklGE5afGOp/ZeEQ7X3syvEeg==
X-Received: by 2002:aa7:9ac3:0:b0:593:adfa:84f6 with SMTP id x3-20020aa79ac3000000b00593adfa84f6mr5194321pfp.23.1675054075302;
        Sun, 29 Jan 2023 20:47:55 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id q17-20020a62ae11000000b0057709fce782sm6411678pff.54.2023.01.29.20.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:47:54 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:47:51 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: arc_ps2 - Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <Y9dL91AFFT/GvrIP@google.com>
References: <202301281606309671328@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281606309671328@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:06:30PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied, thank you.

-- 
Dmitry
