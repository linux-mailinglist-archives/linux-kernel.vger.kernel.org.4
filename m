Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9359968052C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 05:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235278AbjA3Erh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 23:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjA3Ere (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 23:47:34 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2385259;
        Sun, 29 Jan 2023 20:47:34 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b5so3111079plz.5;
        Sun, 29 Jan 2023 20:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mwAuq4KqeI3hBJrRDktuJknztZh3QeguF7B7DzVkWY=;
        b=hIwkO9Frl5fptfPcsYleQBOm8RiJS0nzSchqBE99iXaPLjdjpPkjYgup+weYYooGVy
         2MhgFdIurVLUIBLBsBBfWwT9mJ9uJPAIQe/gdue4Q9CeOumpIfdefkX1Zoea/VVz4ceD
         sagFuut4db5T9ZLIBwzyWguyTDqH3inMSJbSFaRlamdi7EcLxq0g3kKBdCB3Sk+qcA5Y
         HwXdDnj5UMLu738R6fBUfrLAe65O7qdduxRSlz5hkqMFYxvJSG4UF4T1GA4WYvxJ2zQo
         awBTYrtKpQIqHdFTW6Lm+JQhnE9VChI2EIeQJPNL5vdbqwEq+JMZSBzZc8jo6NmUMJ2T
         ggpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mwAuq4KqeI3hBJrRDktuJknztZh3QeguF7B7DzVkWY=;
        b=LZ+u6ILJubqGoIzZbPWK6keJEW/XZWVRLwqmXU2674i9EqjTgfak3+uI25O0+1/OIj
         S6DCxoAm8L1STAIOxTcdQBcAF3IWlCtR010KlcdovdRamTyHXJXawAwqy9CpBHX+HnMD
         8KTp0TTmat8hJrbZztoP7ItZAIBrb0L5XlhsgIXKYb8RywnoNGPkftXSANAsaUhwqFx4
         ek+naIIKf6wlhYvenyLFa+IH/R7sw9iH1aalWq5Er8hLK9Fu3Uirfj0d0MNNbn086Dae
         QIro4eiTyQFs81GIZdFMHJKZEwx6/4Y9xmJWS/qZUffn+Q41eY/l69xDDNQyRDdyItAU
         hKwA==
X-Gm-Message-State: AFqh2krNaGMtrHSm5ZXU7SgvzVgltzeALK4oQslIGWXAXppWbb5/89Sx
        vI6aQhJ6gPOpQX9ccOwObMg=
X-Google-Smtp-Source: AMrXdXu6QZZTNoUYeOcivG3RunO4q5wvdv449dWvOJhG8TJe1Lk048ucUM//uSH1BSgJtCgV20cdqg==
X-Received: by 2002:a17:903:11d1:b0:195:e2cc:6f35 with SMTP id q17-20020a17090311d100b00195e2cc6f35mr48400905plh.59.1675054053501;
        Sun, 29 Jan 2023 20:47:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:6882:174b:bc70:101])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b001932a9e4f2csm2229044plt.255.2023.01.29.20.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 20:47:32 -0800 (PST)
Date:   Sun, 29 Jan 2023 20:47:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     ye.xingchen@zte.com.cn
Cc:     wsa+renesas@sang-engineering.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: =?iso-8859-1?Q?altera?=
 =?iso-8859-1?Q?=5Fps2_-_Use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fres?=
 =?iso-8859-1?Q?ource=28=29?=
Message-ID: <Y9dL4poPM02ThdBG@google.com>
References: <202301281603290601283@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301281603290601283@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 04:03:29PM +0800, ye.xingchen@zte.com.cn wrote:
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
