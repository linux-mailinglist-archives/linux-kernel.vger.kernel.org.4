Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715555BFE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiIUMwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIUMwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:52:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B472E98355
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:50:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n40-20020a05600c3ba800b003b49aefc35fso3692354wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fnBorM5qyNu7mcscToponXq4ufmHa2XOmr0Lac37Wtw=;
        b=EirY1sgJDlIbfsPXrmIUhfdIZ05RWhNFOEuJyFlMIo3jtQDwn2i9YtEyC8QH3g4XFJ
         a6F/8gu+eiADvCiE/yoAWA9K0kBVQ24wGw5E0uz+KGw9LTi91sXQ+TKtJjoM8AN84PDZ
         elJcjiJO3vt8wF3CGiqn7jehiVKCmVW9ufbpHm9RCU3PiTbRjDWdZYKVUE4I6onN9Hwr
         ywYc60T9+RhFjb1QeODjmgHwx2L+jh/U7Thvhrq9SpgoMCVKF7A+/Rhf3YipIi++yerJ
         /mUyHfj+Ae8FtKO5VS4247PehYUizSCv51dbk0rAqrg/sdC++a2cXoiMzHY0l4/7ns4U
         jpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fnBorM5qyNu7mcscToponXq4ufmHa2XOmr0Lac37Wtw=;
        b=flygI5/0LmwwCLBMY6wLwrGl1UB6CEtbOLrWeSdLl3JXtzLIV9y1UiON9PrZbgGVP8
         ZyYqJ8g3rB2nH1ckM2dleAI6Be1HIzd7y8/P3dJ23RmO05KdgLR4HsrP76ryAH+HmHwN
         aTduIpvMwoTGJcgxa4/thMZzsqYrchBkFyjMXPwW3R8k59DJZSrtPdfMEDcu7Kf09M7v
         DEayZiSA2kYrh5zzj5AibevwySzpJtop/wzd2Wl23G4hM2uV2NSNWUjQv8ZTRpxd05R3
         GVnqwkP56dIOPA6HG35AawZpCfWVGuigrztIn6u+Xi6kjV6QzkGFEfZVY1SyBxhzUXvq
         AboA==
X-Gm-Message-State: ACrzQf3a9fstM3zfnQyWSLF2EGCWjfDHn8ddBWPueTQio45R/N4solsE
        eXTxI21+ANs+gXlUGrqVppij32/jd67mwZJp7iJkWw==
X-Google-Smtp-Source: AMsMyM7GTrGUTUvn/K7MGG6E7i3/6IBBtiOiZUyD5ZU/lJN45FyOgQLnyteWjLYnqX5xOw+vr84/CafW8h8eRW0qDiw=
X-Received: by 2002:a7b:ca54:0:b0:3b4:fb06:9b1 with SMTP id
 m20-20020a7bca54000000b003b4fb0609b1mr1593977wml.67.1663764606823; Wed, 21
 Sep 2022 05:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220920064648.215375-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220920064648.215375-1-ye.xingchen@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 21 Sep 2022 14:49:30 +0200
Message-ID: <CAPDyKFpNwQfsbOmmp3i1XyggSVbJ8NO89MneyUh30aahjHdhRA@mail.gmail.com>
Subject: Re: [PATCH linux-next] mmc: rtsx_usb_sdmmc: Remove the unneeded
 result variable
To:     cgel.zte@gmail.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sept 2022 at 08:46, <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value rtsx_usb_send_cmd() directly instead of storing it in
> another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 5fe4528e296e..5798aee06653 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1042,7 +1042,6 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
>                 unsigned char timing, bool *ddr_mode)
>  {
>         struct rtsx_ucr *ucr = host->ucr;
> -       int err;
>
>         *ddr_mode = false;
>
> @@ -1097,9 +1096,7 @@ static int sd_set_timing(struct rtsx_usb_sdmmc *host,
>                 break;
>         }
>
> -       err = rtsx_usb_send_cmd(ucr, MODE_C, 100);
> -
> -       return err;
> +       return rtsx_usb_send_cmd(ucr, MODE_C, 100);
>  }
>
>  static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> --
> 2.25.1
