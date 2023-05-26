Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0675A712C24
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbjEZSF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZSFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:05:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE621FB
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:05:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f6e68cc738so7593365e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685124352; x=1687716352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zmks5D9YzLuOgQ4o4KupF4PncTQfxa4rpPQLmrc2P4w=;
        b=hPKPdxoV2K/w95Ebq5q66gywMYlFfA8NeQwCFhVczUbR0q1zld0Uuw2gq9r1tdg24N
         L9pt6uoSIgbhaBWJDcST5j0HH1Ds4ixc1FUbQhxU1gT3ut/fYvElHROBhD50ASeUCwOZ
         hFjnV3Dl8nQl7I6RxUGaj0F1YMD+Ys5hyMuEmK1h1E/3JEJBjVqa5IdFIatn7gPTiNhs
         TNYduoeTYO/tzml7tD6SKxoZHAlMIjK3RX+TLccIHRG/owHVY6eQainp53qn4RAMemjQ
         GnyEY452tyr+8BRxDFjciPiXNo3tl7ddpfcAlFSLlDWZlJPHtIH2iRskDx7kyXDiWBeD
         3MTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685124352; x=1687716352;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zmks5D9YzLuOgQ4o4KupF4PncTQfxa4rpPQLmrc2P4w=;
        b=WNauY3aStUw8VtI9QM0O7SXqohqJhNPFLJJU5OJMxdYOD1oRsVuapHkXxcXBlj68uG
         0Dj+2coG9HIgQZWTj20noeuZHenzx5xFcKEtIbYANufDaRdBXTOZUOa5nrHJJVLJGW9q
         pEwrgtrmXTI2CLben/rctkyS7nq4Cw23Cf4lxYtCM8QfS6q9GQGmxFIzMT38c8tla2xq
         UOH+uNjrYlIANn05HULKQ7CUewHfFOmE8Bfk7Vn8982/PyjM7ucdVJw8CXQrRpZdRbag
         1smVkN5enJyLACtWWkSl+wloi50CBfRSeyeJifmKNrYUnyrI01uetsfXvr3pE1W+wDVB
         3Ayg==
X-Gm-Message-State: AC+VfDxd93QqVPJk4mHes583m5xI9yAxahM9dGTQAIfqVEhuHqKsrahC
        ip+bGHKWbEloiIlbKQu22GDw8xxSeZOXv8KaWYaakQ==
X-Google-Smtp-Source: ACHHUZ7vsAGjPlVGi85qcnin22UTF7YxET9BPyGVt/qqqwcG0G28PF3mJKcILgWDr6RoCFe6cYJbFQP4Oq0dxmQJ8lQ=
X-Received: by 2002:a05:600c:3653:b0:3f6:1e6:d5a2 with SMTP id
 y19-20020a05600c365300b003f601e6d5a2mr2172002wmq.4.1685124352120; Fri, 26 May
 2023 11:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230519214813.2593271-1-bhupesh.sharma@linaro.org>
 <20230519214813.2593271-8-bhupesh.sharma@linaro.org> <ZG5WBr4gz2mzPoT-@gerhold.net>
In-Reply-To: <ZG5WBr4gz2mzPoT-@gerhold.net>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 26 May 2023 23:35:27 +0530
Message-ID: <CAH=2Nty+72uA7yWyXzY+eVqJpMo_rNVm9YGd4GzZjF=1OP1yQg@mail.gmail.com>
Subject: Re: [PATCH v7 07/11] arm64: dts: qcom: sm6115: Add Crypto Engine support
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, konrad.dybcio@linaro.org,
        vladimir.zapolskiy@linaro.org, rfoss@kernel.org,
        neil.armstrong@linaro.org, djakov@kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux Kernel Functional Testing <lkft@linaro.org>
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

On Wed, 24 May 2023 at 23:53, Stephan Gerhold <stephan@gerhold.net> wrote:
>
> On Sat, May 20, 2023 at 03:18:09AM +0530, Bhupesh Sharma wrote:
> > Add crypto engine (CE) and CE BAM related nodes and definitions to
> > 'sm6115.dtsi'.
> >
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > Tested-by: Anders Roxell <anders.roxell@linaro.org>
> > Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 631ca327e064..27ff42cf6066 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -661,6 +661,31 @@ usb_hsphy: phy@1613000 {
> >                       status = "disabled";
> >               };
> >
> > +             cryptobam: dma-controller@1b04000 {
> > +                     compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> > +                     reg = <0x0 0x01b04000 0x0 0x24000>;
> > +                     interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> > +                     #dma-cells = <1>;
> > +                     qcom,ee = <0>;
> > +                     qcom,controlled-remotely;
> > +                     num-channels = <8>;
> > +                     qcom,num-ees = <2>;
>
> I would also add the RPM_SMD_CE1_CLK clock here and then omit
> "num-channels" and "qcom,num-ees" (with [1]). It's not strictly
> necessary but will guarantee that the clock is running whenever the BAM
> is accessed (potentially avoiding crashes). And it seems to be the
> typical approach so far, see e.g. sdm845. RPMH_CE_CLK is used on both
> &cryptobam and &crypto there.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?id=8975dd41a9dbca3b47f7b8dac5bc4dfb23011000

Sure, I have fixed this in v8 which I will post shortly.

Thanks,
Bhupesh
