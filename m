Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21A606CA470
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbjC0MqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjC0MqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:46:18 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3074684;
        Mon, 27 Mar 2023 05:46:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so8643186wrb.11;
        Mon, 27 Mar 2023 05:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679921167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fYIGAgh3bNQtQ2hkLhWzVHkkyMwA2A5wfdDvnocQpCQ=;
        b=OtF5U5GeGMC1joLpFhdjkzQSJl2EpNpTlz9dgob+XXltcZTyEVsyud07oqsVyyE8Ni
         3pfq20RG85/LXrAr2IlkhLLtWEnjMXIg60PPNouvkfSP4eb29R/uqFHyO71VrX8qeZr9
         o1X1wRpoo3JjbY5A6DeNnr5kph4BKPzJdKXRE7z0TkFqLErrcezfd5RJbQmaTDn00AzF
         XmTBYQ5cu17kcjsKEkcHJHrhPZUo9YYeHBnz1UBvbdnqPBLvs4uCEO8XHv/ryysm+hjl
         fOeVSFU5iq3wP/sOYdVwPp44td+VgKKMfZrQIiQhXhmi7/xz8b/KAWz1YEh2GFmu9jy2
         gp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYIGAgh3bNQtQ2hkLhWzVHkkyMwA2A5wfdDvnocQpCQ=;
        b=EgQ4aydbAYluEHRM2RwRclax1bBUYzL4jT0MB1w19xk8Kd9dpXPnEL/f/hL3HieI4d
         LiAvzfQ/IRAEkZ2JLBwv+gNpygIpQ/lCJH6KKDxkW7/L5hQk9LPWA0SQ6Ih25V0B1sxo
         VAbGHfe5XkP2QGXyY6aCzAdXPf04B6m6KYO6ZQFYkxXTcVkbLGdM/JT6hX0HEpIfA1fX
         RgAmS2NSvri1TmNeGsLbeoCS9VbwD8lX6J1GUa5H0lIWtMw+B+SCU0Yo+Kif5Xor0Hml
         o61gMhAmvWFgM3vsmUnEJEbdtO+PxH/5+ZTTaKMcnrqqtCmtfR4EOyMFHJvGlNcjC73j
         fTSw==
X-Gm-Message-State: AAQBX9dZf34E/wdaor3KFHMp5SW+sVTfY3TsRRZTX159uT3hn6HkY6nA
        FLx4lW8z64/NzZUMYkQfhZkbMCWZyC4ImGLx
X-Google-Smtp-Source: AKy350Yb6KtmVuwqs6rupocORTaQKhgvxpira9yWvAE63AxgWO2SnPEYWy1Lgar60+D+9m7kWGbbUw==
X-Received: by 2002:adf:eace:0:b0:2cf:e3d0:2a43 with SMTP id o14-20020adfeace000000b002cfe3d02a43mr11015922wrn.4.1679921167038;
        Mon, 27 Mar 2023 05:46:07 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id x4-20020a1c7c04000000b003ee0d191539sm13662716wmc.10.2023.03.27.05.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:46:06 -0700 (PDT)
Date:   Mon, 27 Mar 2023 17:46:04 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Dan Carpenter <error27@gmail.com>
Cc:     outreachy@lists.linux.dev, Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: nvec: replace udelay() with usleep_range()
Message-ID: <ZCGQDLEsCr6dY6/e@khadija-virtual-machine>
References: <ZCGK4+zUDT1lLz6s@khadija-virtual-machine>
 <453453f4-1496-4735-8fab-efb7e4240e05@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <453453f4-1496-4735-8fab-efb7e4240e05@kili.mountain>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 03:25:43PM +0300, Dan Carpenter wrote:
> On Mon, Mar 27, 2023 at 05:24:03PM +0500, Khadija Kamran wrote:
> > Replace 'udelay()' with 'usleep_range()' with 1000us as upper limit.
> > This issue is reported by checkpatch.pl script.
> > 
> > CHECK: usleep_range is preferred over udelay; see
> > Documentation/timers/timers-howto.rst
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> 
> This kind of change requires you to test on the hardware and have
> slightly in depth knowledge of the spec.

Okay, thank you!

Regards,
Khadija


> 
> regards,
> dan carpenter
> 
