Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2AC5FDB56
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiJMNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJMNph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:45:37 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56792CD5DF
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:45:32 -0700 (PDT)
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 411FA3F462
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 13:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1665668730;
        bh=oZ6CYTlr9nmUWE7+jRrggJImi8t0ASm4Ymm/aHcOngU=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=FuxOBTZvfPYRD4b9DW6Z0gIWw2h8Nxd4Hm1Lvaiq8n5MhUS4sV6O7RyVfZMH/zoJF
         p3oI76FMTpag0hEqCi63j6biHT1oesowp+Yu65sU3DfCgjuqhkV8Msp0pyVNfwMHNa
         UuRMd6/dX0u9UoBuwwqM9pa6baiUIHZX+p7OzAM3VxGg2fGHwltBpfocnQ1i0HoGbM
         aOe6MCXUzZK18meLy4alz6MZwQCNuF8n2JUUSK/2aXKIKNwIY3K8yoNt7D0XzlYzBg
         jwGz0aLT1570xmU0DcgyFhiQAMPir3pJqxM6TNeCk8kVQtoEB03cmWHbmYNX1FaiPp
         Y6GrNISN5qPpw==
Received: by mail-vk1-f198.google.com with SMTP id a78-20020a1f9851000000b003a7ed513454so293163vke.18
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:45:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oZ6CYTlr9nmUWE7+jRrggJImi8t0ASm4Ymm/aHcOngU=;
        b=K+F/nboNSgkBFRijyBWR6w2u1qlov0K7L3tyCkF+lcbJXcG1/BsBD1/osbidFqsn+J
         uHyKyFnkiP6v3+xZrSf9SAOH38kA7SA2ENyiv/7axEg+gC7TWDF/hZAHYvydNSYKCYFM
         +1FtGfx3qvrlL901j7UB7Eb/YsRC09OTd1CH1CKMsTOhH3w3rZPGVmjzhgv29xp9S7e/
         p86aHXs5RstIYAn2juY2BhiIueLxYwA+xW9Jja/62h6vBamX5qzSpY/knL9PaKg4XmEh
         jP4qjjJqCGwVRr2vbFfmyDSldrUvefbrYgKdoqKvs29z+1fIMowaKIb/W1CIehEshw8z
         KSOg==
X-Gm-Message-State: ACrzQf3W1mLbPqMBMoaQIHaXh0DmWgzARMGRx+IXtf3u0+8xds8s6v7s
        YbX3urq6EBdqJWZlTd+2FT1Jq3+9j/E4Dt+edRLb9uFRf+0QauhsRSo8o56V2NYoqa1Hwmt+730
        K/srP7JHVG8Kj9x2mWWpMDALC7vt1zxbOiuaEtHn2IJ+qXojYnBUcVTiQsg==
X-Received: by 2002:a17:902:e547:b0:178:2aee:ab1d with SMTP id n7-20020a170902e54700b001782aeeab1dmr34472936plf.29.1665668718317;
        Thu, 13 Oct 2022 06:45:18 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78ePohGhlrfbrYkXpKivNlFC+CQIg8yVU6ZbPumGZajp4N0UnQTsqgfJE8Lxw5R7/it6j1tWtvQQpctBkLJMY=
X-Received: by 2002:a17:902:e547:b0:178:2aee:ab1d with SMTP id
 n7-20020a170902e54700b001782aeeab1dmr34472899plf.29.1665668717972; Thu, 13
 Oct 2022 06:45:17 -0700 (PDT)
MIME-Version: 1.0
References: <20221012221028.4817-1-mario.limonciello@amd.com> <20221012221028.4817-2-mario.limonciello@amd.com>
In-Reply-To: <20221012221028.4817-2-mario.limonciello@amd.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 13 Oct 2022 21:45:06 +0800
Message-ID: <CAAd53p4sKdFL-DcPet2srtisiX_Qr9qpiV159Xj9YSUM9yiLPw@mail.gmail.com>
Subject: Re: [PATCH 1/1] pinctrl: amd: Add dynamic debugging for active GPIOs
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 6:10 AM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Some laptops have been reported to wake up from s2idle when plugging
> in the AC adapter or by closing the lid.  This is a surprising
> behavior that is further clarified by commit cb3e7d624c3ff ("PM:
> wakeup: Add extra debugging statement for multiple active IRQs").
>
> With that commit in place the following interaction can be seen
> when the lid is closed:
>
> [   28.946038] PM: suspend-to-idle
> [   28.946083] ACPI: EC: ACPI EC GPE status set
> [   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.950152] Timekeeping suspended for 3.320 seconds
> [   28.950152] PM: Triggering wakeup from IRQ 9
> [   28.950152] ACPI: EC: ACPI EC GPE status set
> [   28.950152] ACPI: EC: ACPI EC GPE dispatched
> [   28.995057] ACPI: EC: ACPI EC work flushed
> [   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.995131] PM: Triggering wakeup from IRQ 9
> [   28.995271] ACPI: EC: ACPI EC GPE status set
> [   28.995291] ACPI: EC: ACPI EC GPE dispatched
> [   29.098556] ACPI: EC: ACPI EC work flushed
> [   29.207020] ACPI: EC: ACPI EC work flushed
> [   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
> [   29.211095] Timekeeping suspended for 0.739 seconds
> [   29.211095] PM: Triggering wakeup from IRQ 9
> [   29.211079] PM: Triggering wakeup from IRQ 7
> [   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
> [   29.211095] PM: resume from suspend-to-idle
>
> * IRQ9 on this laptop is used for the ACPI SCI.
> * IRQ7 on this laptop is used for the GPIO controller.
>
> What has occurred is when the lid was closed the EC woke up the
> SoC from it's deepest sleep state and the kernel's s2idle loop
> processed all EC events.  When it was finished processing EC events,
> it checked for any other reasons to wake (break the s2idle loop).
>
> The IRQ for the GPIO controller was active so the loop broke, and
> then this IRQ was processed.  This is not a kernel bug but it is
> certainly a surprising behavior, and to better debug it we should
> have a dynamic debugging message that we can enact to catch it.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

This is very useful, thanks for the patch!

Acked-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

> ---
>  drivers/pinctrl/pinctrl-amd.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 4691a33bc374f..8378b4115ec0d 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -628,13 +628,16 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
>                 /* Each status bit covers four pins */
>                 for (i = 0; i < 4; i++) {
>                         regval = readl(regs + i);
> -                       /* caused wake on resume context for shared IRQ */
> -                       if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
> +
> +                       if (regval & BIT(WAKE_STS_OFF) ||
> +                           regval & BIT(INTERRUPT_STS_OFF))
>                                 dev_dbg(&gpio_dev->pdev->dev,
> -                                       "Waking due to GPIO %d: 0x%x",
> +                                       "GPIO %d is active: 0x%x",
>                                         irqnr + i, regval);
> +
> +                       /* caused wake on resume context for shared IRQ */
> +                       if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
>                                 return true;
> -                       }
>
>                         if (!(regval & PIN_IRQ_PENDING) ||
>                             !(regval & BIT(INTERRUPT_MASK_OFF)))
> --
> 2.34.1
>
