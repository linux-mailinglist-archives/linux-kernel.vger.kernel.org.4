Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BF723758
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjFFGMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234614AbjFFGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:12:28 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA85187
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 23:12:26 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-6260e8a1424so40962726d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 23:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686031945; x=1688623945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g0yP0hKSoGNQHQJOAvhdyai2x0vVbUlOAYuNmq90NvQ=;
        b=Yf3zsxCn+XyD5apxlwhoKiYC23ySiy8noGTHklGgicBumpof4sFFDtlm5WGq/1VEbi
         QHLkJitYP34RslgpJ8xw23KeiiyvwSBE5dtBMv4pI0VG8RrDsgHxiugcEytaJ6JmLVj2
         jhzcvHVTd/51GPvdtnE7Qo5ubkS/xbsa7FjIXQX+Ne8d+8hVkdmoxJMuFV55OXd9LzwO
         fKlLasKIX+BXiJhQkT5H6CERLikY6SGhVCIsDjuPGlxW1H5JnrhWeQEFP0lYoy3NJw87
         fWhGK2FFTnXBnDFIW5facYxVc+vP5fw3ndYZaVaQgs5D+SxDrqAah8AQKcZMsXEROH9c
         ic5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686031945; x=1688623945;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0yP0hKSoGNQHQJOAvhdyai2x0vVbUlOAYuNmq90NvQ=;
        b=ljAmX7c67td+OAHotC+D+C5QTYc2G+aNA5XrpPhVaErRYmC4UiezgFYZE0uAmMA0wQ
         cHDGBMaT1OH5KAzn+FG1Us9N7uolKKqD1GrR2ocBpTXIG8ly/RvE5FDS2KLdReHsNaqQ
         f61rbCBhPADJB5lZnhtJ83d779ADLnGulVprdYvOSh5+VSbsq4BGr7q6sQLsXRNxs3R/
         tJYunuI83OsKT2mbAQRhMSayZzxRXmmP2ycwuzNAMX4seI9rM3uLpWNeyvL60rT1vfUM
         5EAeBRV5roWoYHzO2/Yj88NYRVhwncnz7S2oGs4V+CfizmcEHG5cE5gF/jqxfBPrdQX0
         Jw4w==
X-Gm-Message-State: AC+VfDyRFWmquyqbJ49jNemWo16SG/b4o4dnIv3Fkkd1tNaC5Hp811j6
        OTQAEgWs2/DkQVG4Z6bIYApCZgJQcdKuAAN9ZhN5/g==
X-Google-Smtp-Source: ACHHUZ4Pp6l6ZPzuoYCGnS7PtRbw4wsx5xYkRMJnsEhA2T8k0AyHRJhwMSIy2FzE78BXBY2HjCEywX3NOT6GL7Wkqug=
X-Received: by 2002:a05:6214:29ec:b0:625:aa49:19ed with SMTP id
 jv12-20020a05621429ec00b00625aa4919edmr1058826qvb.58.1686031945214; Mon, 05
 Jun 2023 23:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230605094710.2037879-1-amit.pundir@linaro.org> <cd71ee53-391a-90fd-27ca-c174f2b24a94@linaro.org>
In-Reply-To: <cd71ee53-391a-90fd-27ca-c174f2b24a94@linaro.org>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Tue, 6 Jun 2023 11:41:48 +0530
Message-ID: <CAMi1Hd0MhOyn1HHq5YYFxJwWrkMZbS9ZqksNDBLM9Ayx67rEOg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: Split sdm845-db845c to add headless support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2023 at 16:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/06/2023 11:47, Amit Pundir wrote:
> > This is a follow-up of the upstream discussion,
> > https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u,
> > around adding a reserved memory region in sdm845-db845c
> > for the framebuffer memory (the splash region set up by
> > the bootloader) but the general opinion was to avoid
> > adding that reserved memory for the headless DB845c
> > usecase.
> >
> > So this patch splits the sdm845-db845c into a common dtsi,
> > a new sdm845-db845-headless DT, which disables the mdss
> > display subsystem, and a new sdm845-db845c DT with an
> > additional reserved-memory region for the framebuffer.
> >
> > The default sdm845-db845c.dtb remains pretty much the same
> > (with an exception of additional reserved-memory region),
> > while others can use sdm845-db845c-headless.dtb for their
> > headless systems.
>
> You should describe the hardware in commit msg. What is "headless"? If
> no HDMI plugged in, then it is a NAK because plug or unplugged HDMI
> cable is not a property of a DTS.

Hi, my only intended goal [1] is to add a reserved-memory region
(specific to the framebuffer memory reserved by the bootloader for the
boot splash) in sdm45-db845c. But I have been told that reserving
these 30+ MBs for every DB845c is a waste in case we are not using
display at all (a headless system?). So I prepared this patch for RFC.
The definition of headless is ambiguous to me as well. It could be no
HDMI plugged in or no display drivers enabled at all. I believe it all
comes down to specific use cases.

As far as my use-case (vanilla AOSP) is concerned, display is a
critical component and device doesn't boot to completion unless it is
hooked to any kind of display. May I suggest we go back to my original
change [1] of adding a reserved-memory region for now and let the
users of a headless system, define or come up with their respective
use-case?

Regards,
Amit Pundir
[1] https://lore.kernel.org/linux-kernel/20230124182857.1524912-1-amit.pundir@linaro.org/T/#u

>
> >
> > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > ---
> > Please pick this after the lvs regulator nodes reordering patch
> > https://lore.kernel.org/lkml/20230602161246.1855448-1-amit.pundir@linaro.org/T/#u.
> > I'll rebase and resend this patch otherwise.
> >
> >  arch/arm64/boot/dts/qcom/Makefile             |    1 +
> >  .../boot/dts/qcom/sdm845-db845c-common.dtsi   | 1178 +++++++++++++++++
> >  .../boot/dts/qcom/sdm845-db845c-headless.dts  |    9 +
> >  arch/arm64/boot/dts/qcom/sdm845-db845c.dts    | 1172 +---------------
>
> A lot of duplication. Are you sure you generated the patches with
> correct -M/-C/-B arguments to rename or copy?
>
> >  4 files changed, 1194 insertions(+), 1166 deletions(-)
> >  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
> >  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-db845c-headless.dts
> >
> > diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> > index 4f9e81253e18..22876ea2e409 100644
> > --- a/arch/arm64/boot/dts/qcom/Makefile
> > +++ b/arch/arm64/boot/dts/qcom/Makefile
> > @@ -166,6 +166,7 @@ dtb-$(CONFIG_ARCH_QCOM)   += sdm845-cheza-r1.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-cheza-r2.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-cheza-r3.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-db845c.dtb
> > +dtb-$(CONFIG_ARCH_QCOM)      += sdm845-db845c-headless.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-db845c-navigation-mezzanine.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-lg-judyln.dtb
> >  dtb-$(CONFIG_ARCH_QCOM)      += sdm845-lg-judyp.dtb
> > diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
> > new file mode 100644
> > index 000000000000..ecc4a851e29c
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c-common.dtsi
> > @@ -0,0 +1,1178 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (c) 2019, Linaro Ltd.
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/leds/common.h>
> > +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> > +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> > +#include <dt-bindings/sound/qcom,q6afe.h>
> > +#include <dt-bindings/sound/qcom,q6asm.h>
> > +#include "sdm845.dtsi"
> > +#include "sdm845-wcd9340.dtsi"
> > +#include "pm8998.dtsi"
> > +#include "pmi8998.dtsi"
> > +
> > +/ {
> > +     model = "Thundercomm Dragonboard 845c";
> > +     compatible = "thundercomm,db845c", "qcom,sdm845";
>
> So it is the same hardware? Why compatible is in common part? I don't
> understand this change.
>
> Best regards,
> Krzysztof
>
