Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFCE63C05F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232083AbiK2Myn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiK2Myl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:54:41 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B06037F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:54:39 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id h28so16193pfq.9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zHJtTzaFLX6ofD+/NiRHkEzuNp9VdRYHtRRZa+mw5zg=;
        b=J3lc5U9UawdedrKxvO6foM+se+Hdnwj1FkQeqAGC5/VBa8ti+BAB+Ws+tyj2pyxU4S
         /4CaGl0KEvx6iVZKMSgqXiXLp1xzUVkOfsfi0dS468MztsyU0W3BaPlrA/U3EX7czdr8
         iQQRN5UAPKhmEXuGeqYU9K1X6GiTkeME/rj6KDmumo7ppHPs667JLVpph9lKVeuGNxzw
         6R5yKfzMVjk8DrW48t1nS/P2oStuEnjWNI76NrIi2d6OVvX3teBiYi/uiAyY65d6SFus
         Dk7Kxau7SChDxOFgTDdtfyPXjGybyFo21nqOC13rFeLMHy9zoakA6HY3Fd/lxeE5/Gt9
         U8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHJtTzaFLX6ofD+/NiRHkEzuNp9VdRYHtRRZa+mw5zg=;
        b=2i1wQnqNwnRPXukIsE31IO47II8UM85YDg+xB5pRkWel6/BwycfOC6FM88ZABHN9JY
         I/abfk+0HH/B8OHx5Lh+Ig9Abgpx2FTWuiB78132lfDNP7MV17mUgHwHk4NI8gdTWpdg
         euQubHFxmlkTuoW2WJgRh8vh3R0F/A0nYFf17EdWeXcQ4+VeaalPLnziHKARMaEEDVVr
         lPs2plSTl0Q5zLLnosJQJV6LU2JnMvZL1ZunIYCMyzQhXLFEm3Zj4sbuhlwlw9XSKPEn
         +05VDWN7QuMWpxKlrDoDyv7ct2DacvdxmUkEUVg0bgh53D7IyE0Wp7kaufzj4cU6NHXW
         x4yQ==
X-Gm-Message-State: ANoB5plCr1a4HMsdXl5cCbej6sqAfsnFIrbqTNSfRTPRH3s2mR/xFztF
        32PLGgOfwF+h/kNh12Y+8CnKjYkj7Qx076aGZYBYdw==
X-Google-Smtp-Source: AA0mqf6jBiO2Uwf+P77xMfYQu/HDmnoLvThm7Xv6DfpoSUqp9iWV5JNZQCrEsqy7CJQQ0I5ZBI/08gOyptbY58Ckaqc=
X-Received: by 2002:a63:501c:0:b0:477:650a:c29a with SMTP id
 e28-20020a63501c000000b00477650ac29amr31158504pgb.541.1669726479384; Tue, 29
 Nov 2022 04:54:39 -0800 (PST)
MIME-Version: 1.0
References: <20221123095506.1965691-1-yebin@huaweicloud.com>
In-Reply-To: <20221123095506.1965691-1-yebin@huaweicloud.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 29 Nov 2022 13:54:03 +0100
Message-ID: <CAPDyKFrRKkNjswGrDS+Uts1qYToQnV_ACXe_zNrqDJXkjjqv-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc_test: fix missing assignment of 'file' when
 register debugfs file
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     wsa+renesas@sang-engineering.com, kvalo@kernel.org,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 at 10:34, Ye Bin <yebin@huaweicloud.com> wrote:
>
> From: Ye Bin <yebin10@huawei.com>
>
> Now, 'file' is always NULL. obviously, 'file' is used to store return value of
> 'debugfs_create_file()'.
>
> Fixes: a04c50aaa916 ("mmc: core: no need to check return value of debugfs_create functions")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Applied for fixes, by amending the commit message and by adding a
stable tag, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/mmc_test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index 6cd6f8a94a71..156d34b2ed4d 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -3174,7 +3174,8 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
>         struct mmc_test_dbgfs_file *df;
>
>         if (card->debugfs_root)
> -               debugfs_create_file(name, mode, card->debugfs_root, card, fops);
> +               file = debugfs_create_file(name, mode, card->debugfs_root,
> +                                          card, fops);
>
>         df = kmalloc(sizeof(*df), GFP_KERNEL);
>         if (!df) {
> --
> 2.31.1
>
