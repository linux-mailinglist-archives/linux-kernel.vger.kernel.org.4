Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD265D7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjADQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjADQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:06:28 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFDFA1BEA1
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 08:06:27 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so34736472pjj.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 08:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoMsanQfdrnJNpK+VHphw12WDh7b/ImX3dHhODz+IvA=;
        b=xTS8w7m0XrsQQYE15w0Gmn+j7j9adCpRTTi1yI86BOf1Ey2uLEUmfrH0yoZbFjVWm4
         fBDOTqraLqcuSMaiYFb+uZTm6Mx/iXsvbHPX39ZfeQ6LH/TDkKKGYHhpa7h8zfXP/KQI
         LW6AkV7EJFtzd4tcPol6Fi6Ccr/Wn8Y6lXp0hPjXaeNq06WyHnQqS+5Ffq+/cQ54+5BB
         AABHT07Lj8MP0y84HSwyBxZbzwTPfDdbb2xBoftOlDMJUWlzz/El7TNjP01HnxhavgJK
         hYavH+0i8lleDyhCGaSc6eZP8JaiUlPaFGr1ES6R7f55/zMgM37q94e2/rD7Po/ypTg4
         LFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoMsanQfdrnJNpK+VHphw12WDh7b/ImX3dHhODz+IvA=;
        b=aCjwZGor/d2yn8G2wjkM8Eb/0YXksPZYZkWDc9YW/DmXpK+SdfnW9SO89zws3qfxiq
         oFkCcQyYnvkCoAmF5Y336Mvt3nN4x9rUhMSWkH62Gid5hE8Am6ZujJlSCh6Mjp2N7FQI
         A5rdRMeyGKWZGQRFHeJEYzlYzL2MgYQT5y39lj/EUwhKIOKhheOFZVgfWH223sNNY6uB
         Hg98RI9a1NhK925QzM7BtyiAsH/vZfpZSVGHqly11+0Yw7TwM4AwKpcHbB+yRey6wBkk
         XOI2si9lncojA/X4/tvuzABC7FI/yRJnAQmqQ1/lEHarOoJH6opcf0xZZHCJYeX1g7Vt
         eFdA==
X-Gm-Message-State: AFqh2krjYJ3YdD5Rs9F0Uuf77UacIWKdb/CG1zkzLeE3L3nbWm7hUSSL
        21T5TLl0sSQhTKUzyFTZcXI0tVjz81dsHt4sO8ioNA==
X-Google-Smtp-Source: AMrXdXu0Zkm98NSEmToInkvbeoOiqHqFC2u77W6RRb8vCi1vUtqqdRNIozRRUc8NnGm/zSv0I6VrewLi0U1sjbVAX7E=
X-Received: by 2002:a17:90a:c083:b0:226:6c53:fc27 with SMTP id
 o3-20020a17090ac08300b002266c53fc27mr877853pjs.202.1672848387129; Wed, 04 Jan
 2023 08:06:27 -0800 (PST)
MIME-Version: 1.0
References: <20221227122227.460921-1-william.qiu@starfivetech.com>
 <20221227122227.460921-4-william.qiu@starfivetech.com> <CAPDyKFqziA+PB__v8nJzgkTuM9ZszW8X2U-akvRFv0_qwZ22OA@mail.gmail.com>
 <14433b44-8359-b9e8-446c-bb49e86bf48f@starfivetech.com>
In-Reply-To: <14433b44-8359-b9e8-446c-bb49e86bf48f@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Jan 2023 17:05:50 +0100
Message-ID: <CAPDyKFrH=U-Sz1Kx2AJ+X_FXi9GcEdHXjO+aC=MXpGP_+xgOsQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv: dts: starfive: Add mmc node
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jan 2023 at 07:08, William Qiu <william.qiu@starfivetech.com> wrote:
>
>
>
> On 2023/1/2 22:03, Ulf Hansson wrote:
> > On Tue, 27 Dec 2022 at 13:22, William Qiu <william.qiu@starfivetech.com> wrote:
> >>
> >> This adds the mmc node for the StarFive JH7110 SoC.
> >> Set sdioo node to emmc and set sdio1 node to sd.
> >>
> >> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> >> ---
> >>  .../jh7110-starfive-visionfive-v2.dts         | 25 ++++++++++++
> >>  arch/riscv/boot/dts/starfive/jh7110.dtsi      | 38 +++++++++++++++++++
> >>  2 files changed, 63 insertions(+)
> >>
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> >> index c8946cf3a268..d8244fd1f5a0 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-v2.dts
> >> @@ -47,6 +47,31 @@ &clk_rtc {
> >>         clock-frequency = <32768>;
> >>  };
> >>
> >> +&mmc0 {
> >> +       max-frequency = <100000000>;
> >> +       card-detect-delay = <300>;
> >
> > Nitpick:  This seems redundant for a non-removable card!?
> >
>
> Will drop
>
> >> +       bus-width = <8>;
> >> +       cap-mmc-highspeed;
> >> +       mmc-ddr-1_8v;
> >> +       mmc-hs200-1_8v;
> >> +       non-removable;
> >> +       cap-mmc-hw-reset;
> >> +       post-power-on-delay-ms = <200>;
> >> +       status = "okay";
> >> +};
> >> +
> >> +&mmc1 {
> >> +       max-frequency = <100000000>;
> >> +       card-detect-delay = <300>;
> >
> > Nitpick: This looks redundant for polling based card detection
> > (broken-cd is set a few lines below).
> >
>
> Will drop
>
> >> +       bus-width = <4>;
> >> +       no-sdio;
> >> +       no-mmc;
> >> +       broken-cd;
> >> +       cap-sd-highspeed;
> >> +       post-power-on-delay-ms = <200>;
> >> +       status = "okay";
> >> +};
> >> +
> >>  &gmac0_rmii_refin {
> >>         clock-frequency = <50000000>;
> >>  };
> >> diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> index c22e8f1d2640..08a780d2c0f4 100644
> >> --- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> +++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
> >> @@ -331,6 +331,11 @@ aoncrg: clock-controller@17000000 {
> >>                         #reset-cells = <1>;
> >>                 };
> >>
> >> +               syscon: syscon@13030000 {
> >> +                       compatible = "starfive,syscon", "syscon";
> >> +                       reg = <0x0 0x13030000 0x0 0x1000>;
> >> +               };
> >> +
> >>                 gpio: gpio@13040000 {
> >>                         compatible = "starfive,jh7110-sys-pinctrl";
> >>                         reg = <0x0 0x13040000 0x0 0x10000>;
> >> @@ -433,5 +438,38 @@ uart5: serial@12020000 {
> >>                         reg-shift = <2>;
> >>                         status = "disabled";
> >>                 };
> >> +
> >> +               /* unremovable emmc as mmcblk0 */
> >
> > Don't confuse the mmc0 node name with mmcblk0. There is no guarantee
> > that this is true, unless you also specify an alias.
> >
>
> Hi Ulf,
>
> Thank you for taking time to review and provide helpful comments for this patch.
> Actually we define mmc0 as eMMC, which is mmcblk0 in the kernel, and define mmc1 as SDIO,
> which is mmcblk1 in the kernel, so it's not confuse.
>

My point is, mmc0 from DT node perspective doesn't necessarily need to
map to mmc0, as that depends on the "probe" order of the devices. At
least for the Linux kernel, mmc0 from DT point of view, could end up
being mmc1.

To avoid confusion, please drop the "mmcblk*" here. It's anyway a
Linux specific thing. Don't get me wrong, feel free to keep the
information about eMMC and SDIO for the corresponding mmc controller
node.

Moreover, if you can't use PARTID/UUID to find the rootfs device -
then you may use an aliases node, to let mmc0 to be enumerated as
mmc0, for example. See below.

aliases {
     mmc0 = &mmc0;
}

Kind regards
Uffe
