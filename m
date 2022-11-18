Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA3B62FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:14:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiKRSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbiKRSN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:13:56 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC97AF6B;
        Fri, 18 Nov 2022 10:13:54 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8144656wme.5;
        Fri, 18 Nov 2022 10:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kwXpWHa6FKMsiVUpTzBEVcezafSgFw7qVXGPI1PvE5U=;
        b=F8adC3rgd5ZZBX8LOJzEVxPFpYCL3cyBxeyrmnqjYQovrdGhmaVcUNf8tT3AoU9BWR
         KKRjopWoMN6vQc3MTqhJKVQYX3bmX57ElyLlHe4btKjVF5VEwolAV0AP7uf+ShT1l+Sw
         JxR7fFhjqk7xsgfyqUSEHTAxf0ThLkvKzbGWJhGbDDKUzr2RAUeXNE7SEYsnNELfJxMg
         Qa1pYIVgRlktE+6D/WJrBSymjfCrZc119LBFmK75Hp1jr7WmauEAlNjVibPgeen0C2HV
         qvqeeFWxOEZBYPJOFJC6eAvktyxGY4theb/syatWuLbdA/nOwfuEcSzPhE52ozE7tcJy
         71Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwXpWHa6FKMsiVUpTzBEVcezafSgFw7qVXGPI1PvE5U=;
        b=5W4fWnQY/AN1gPQ9Ofmv0hvdFvhyAAFsJMUx2UkNMgtuchT7iL0M63zZwgI7RZauEa
         QV1Ol39au7bgSUA7xR0PL64eRpVPZL009BWd2Z6VXgMkwl+Ez0lNCFi5d4s7t7TJFr6Q
         VpN8VfaJy6/Kmad/2qNzXKXDJSm1u+af2tO6pMmLYLZjzET46F1AJKLZCaVDI2lJv0iT
         Ul7VXaRPbTubEDZFqhHI4aKSSqts3wxWOfoImF9nbilSE0gIRAjiem1Nu4y+sOuHCXm3
         96XUTCfUUvVi6AOMaWRveD3xdtWLQxUtplvuFBJSvO0XM+eWoxRY1yx6Rrm0HfZhvujb
         OrOg==
X-Gm-Message-State: ANoB5plFf1/wzzGsk2tNEYbD9MqCLH6yUcl+E+rbBbGqCCUULjP+I58z
        a0qDFSlEivjp9vfMlx3eSXnL8SdpmVhiVNrMAdc=
X-Google-Smtp-Source: AA0mqf4OIz0Wwotp7QZYGy2xN9YzActkzSRmxw5BFgNs0xAhuTuDB247L2qhSwjolHr/pNAerhG3Fv3aeEtT4OZO+jM=
X-Received: by 2002:a7b:c00a:0:b0:3cf:e8f0:ad11 with SMTP id
 c10-20020a7bc00a000000b003cfe8f0ad11mr9492684wmb.65.1668795233073; Fri, 18
 Nov 2022 10:13:53 -0800 (PST)
MIME-Version: 1.0
References: <20221116200150.4657-1-linux.amoon@gmail.com> <20221116200150.4657-2-linux.amoon@gmail.com>
 <bdcd2071-8f56-b829-7e78-3fc9efec09fc@wolfvision.net> <CANAwSgQkwXb0KE+1856egmUyTx_pmr9hq6nk8-0YoMQJdBoDvQ@mail.gmail.com>
In-Reply-To: <CANAwSgQkwXb0KE+1856egmUyTx_pmr9hq6nk8-0YoMQJdBoDvQ@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Fri, 18 Nov 2022 13:13:41 -0500
Message-ID: <CAMdYzYp6GPO_mz=ctR7Pgs1iwtNjR0a6_0K492Fy=i55T9DMnQ@mail.gmail.com>
Subject: Re: [linux-next-v2 1/5] arm64: dts: rockchip: Fix gmac phy mode to
 rgmii on Rock 3A SBC.
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chukun Pan <amadeus@jmu.edu.cn>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 4:35 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Michael,
>
> On Fri, 18 Nov 2022 at 12:33, Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
> >
> > Hi Anand,
> >
> > On 11/16/22 21:01, Anand Moon wrote:
> > > On rk356x ethernet phy support reduced media independent interface (RMII)
> > > and reduced gigabit media independent interface (RGMII).
> > > So set the phy mode to rgmii to support clock delay, also
> > > add TX and RX delay for phy-mode.
> >
> > Based on this commit message I still don't understand what you are
> > actually trying to fix here. If you encounter network problems/stability
> > issues, please let me know what test triggers the faulty behavior.
> > Please describe the problem you are facing in detail here or in the
> > cover letter.
> >
>
> Ok, Ethernet does not work on my Radxa 3A see boot logs.
>
> [0] https://gist.github.com/moonlinux/bb56c787031226fbb9f69121564e76a2
>
> Please find this updated commit message.
>
> As per the schematic and datasheet PHY mode is RGMII
> Use 2ns clock delay to RXC for RXD and TXC for TXD latching.

rgmii-id mode does exactly this in the phy (your realtek chip). By
setting the mode to rgmii, you're telling the phy that delays are set
elsewhere, either in hardware or in the controller. You're then
handling them in the controller. While the delays aren't documented in
the TRM, I've long suspected that the defaults of 0x30 and 0x10 equate
to the standard 2ns delay. So you're setting the delays much higher
than the default means you need to add *more* than the standard 2ns
delay for your device to work.

This is why I've been asking if you have tested these. You need to set
each value and find the lowest and highest possible values that work,
then take the median value between those two.

>
> > > Fix the following warning
> > >
> > > [    7.365215] rk_gmac-dwmac fe010000.ethernet: Can not read property: tx_delay.
> > > [    7.365219] rk_gmac-dwmac fe010000.ethernet: set tx_delay to 0x30
> > > [    7.365224] rk_gmac-dwmac fe010000.ethernet: Can not read property: rx_delay.
> > > [    7.365228] rk_gmac-dwmac fe010000.ethernet: set rx_delay to 0x10
> >
> > If the only purpose of this patch is to get rid of this warnings, it may
>
> No, the intent is to fix the PHY mode to RGMII and fix the delay.
> [ 7.066357] rk_gmac-dwmac fe010000.ethernet: init for RGMII_ID
>
> > make sense to set them to dev_dbg as Peter pointed out.
> >
> Ok, will update this in the next version.
>
> > Best regards,
> > Michael
> >
> Thanks
> -Anand
