Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E5666B419
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 22:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjAOVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 16:15:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjAOVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 16:15:44 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA861448B
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:15:41 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id b3so40261424lfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 13:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zFqZ94jhBu9TEDhGMEYZfxEiXZaLiJaRdTAncDTybw0=;
        b=cff6Sv35XPwmV9YN3Tdr28aPm4YngtLJ625r36qT1Kxp9bSy1dEuknd9t5shlPcHgk
         E9ceVL5HrvpBPmCqjmVcNdhiD/2mt1UBieLEm2xs3Ovd7NvOgkMOHOZocIxFn4dzSpgH
         yWcgCS8YUmdKcpvzwWpOMrzWHxY2WFAIyEr9Q10a6UtuGTcFtYS5l1pATP1VitpKy6Ht
         Ziyepao5a0PqbeH/SMP28btUl+t/cNzyTTzhvVpiBaFVmfIrKWr6P6USflK7WOitbs0N
         Dw5D4uVQcMBBT10g9B1N6v+9brn1j5SuVysDRvpjuoM4uSzNhsTIwmFHpHpXxV/3xelS
         uEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFqZ94jhBu9TEDhGMEYZfxEiXZaLiJaRdTAncDTybw0=;
        b=lFpSF7GQzknA29hHZucaKT2DwavdMbb8Z1fkdof34tMwEa269SuwVSxpPSuFSEJJWP
         cfGCaoPExan3VUz+SfesyAhjLyZ+zjUe11mQpaLHd3NKLn4yQdrdHApEXjdZ9V03x8T4
         1dgvGHjvRGIsSq13H1o47NwL788FdoSMvndOImyTu7J7hs4h40jafWXzKzNnssB8zO1d
         pBUlMFKCjGbiTNjsEdl1DWDxjWHU41lg+09z7z+yf5jtM9kbgFsVi64nXNIcvtbii3yg
         cadsJRcmCjMx6e+WkXrQW4kQ2PBR0h3bOhmhpfteILhB7FES189Ej0L1j6vQnMZiKWOM
         QlNw==
X-Gm-Message-State: AFqh2krw/4804yE76A2/8GDvY0WEpsDO2V3p7aXIJRid4DL30n1azKVz
        EMpHBqJANWoqruISDR2T28DmN6bX5AIJtcylMY3kFA==
X-Google-Smtp-Source: AMrXdXuHdcEy1zmxMgb4P7R9UPmHf9S1Bx7iw2bcX01aM64PsM5DL3JdifJdDY9cFNQhG+OjAyv+0g2I6rnyRJCPnPY=
X-Received: by 2002:a05:6512:b28:b0:4ca:f4e8:3a45 with SMTP id
 w40-20020a0565120b2800b004caf4e83a45mr3099414lfu.464.1673817339840; Sun, 15
 Jan 2023 13:15:39 -0800 (PST)
MIME-Version: 1.0
References: <20230114210754.353912-1-bhupesh.sharma@linaro.org> <323b9519-38e4-a7ca-f45d-96cef06fd9bf@linaro.org>
In-Reply-To: <323b9519-38e4-a7ca-f45d-96cef06fd9bf@linaro.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Mon, 16 Jan 2023 02:45:28 +0530
Message-ID: <CAH=2NtwQWAdp_+BOmaqMMebrqFWsh0GqxMtxx-X47=SLpor8WA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: sm6115: Add debug related nodes
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2023 at 02:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 14.01.2023 22:07, Bhupesh Sharma wrote:
> > Add dtsi nodes related to coresight debug units such
> > as cti, etm, etr, funnel(s), replicator(s), etc. for
> > Qualcomm sm6115 SoC.
> >
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm6115.dtsi | 612 +++++++++++++++++++++++++++
> >  1 file changed, 612 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > index 478c5d009272..5067910b18ab 100644
> > --- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
> > @@ -1237,6 +1237,618 @@ dispcc: clock-controller@5f00000 {
> >                       #power-domain-cells = <1>;
> >               };
> >
> > +             cti0: cti@8010000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08010000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti1: cti@8011000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08011000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti2: cti@8012000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08012000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti3: cti@8013000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08013000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti4: cti@8014000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08014000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti5: cti@8015000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08015000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti6: cti@8016000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08016000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti7: cti@8017000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08017000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti8: cti@8018000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08018000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti9: cti@8019000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x08019000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti10: cti@801a000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801a000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti11: cti@801b000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801b000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti12: cti@801c000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801c000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti13: cti@801d000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801d000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti14: cti@801e000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801e000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             cti15: cti@801f000 {
> > +                     compatible = "arm,coresight-cti", "arm,primecell";
> > +                     reg = <0x0801f000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +             };
> > +
> > +             replicator@8046000 {
> > +                     compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
> > +                     reg = <0x08046000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     replicator_out: endpoint {
> > +                                             remote-endpoint = <&etr_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     replicator_in: endpoint {
> > +                                             remote-endpoint = <&etf_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etf@8047000 {
> > +                     compatible = "arm,coresight-tmc", "arm,primecell";
> > +                     reg = <0x08047000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     etf_in: endpoint {
> > +                                             remote-endpoint = <&merge_funnel_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etf_out: endpoint {
> > +                                             remote-endpoint = <&replicator_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etr@8048000 {
> > +                     compatible = "arm,coresight-tmc", "arm,primecell";
> > +                     reg = <0x08048000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     etr_in: endpoint {
> > +                                             remote-endpoint = <&replicator_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             stm@8002000 {
> This one node is out of order
>
> I *think* the rest looks good overall... so:
>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Ok, let me send a fixed v2.

Thanks,
Bhupesh

> > +                     compatible = "arm,coresight-stm", "arm,primecell";
> > +                     reg = <0x08002000 0x1000>,
> > +                           <0x0e280000 0x180000>;
> > +                     reg-names = "stm-base", "stm-stimulus-base";
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     stm_out: endpoint {
> > +                                             remote-endpoint = <&funnel_in0_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@8041000 {
> > +                     compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +                     reg = <0x08041000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_in0_out: endpoint {
> > +                                             remote-endpoint = <&merge_funnel_in0>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     funnel_in0_in: endpoint {
> > +                                             remote-endpoint = <&stm_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@8042000 {
> > +                     compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +                     reg = <0x08042000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_in1_out: endpoint {
> > +                                             remote-endpoint = <&merge_funnel_in1>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     funnel_in1_in: endpoint {
> > +                                             remote-endpoint = <&funnel_apss1_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@8045000 {
> > +                     compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +                     reg = <0x08045000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     merge_funnel_out: endpoint {
> > +                                             remote-endpoint = <&etf_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +
> > +                             port@0 {
> > +                                     reg = <0>;
> > +                                     merge_funnel_in0: endpoint {
> > +                                             remote-endpoint = <&funnel_in0_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg = <1>;
> > +                                     merge_funnel_in1: endpoint {
> > +                                             remote-endpoint = <&funnel_in1_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9040000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09040000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU0>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm0_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in0>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9140000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09140000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU1>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm1_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in1>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9240000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09240000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU2>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm2_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in2>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9340000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09340000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU3>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm3_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in3>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9440000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09440000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU4>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm4_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in4>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9540000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09540000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU5>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm5_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in5>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9640000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09640000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU6>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm6_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in6>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             etm@9740000 {
> > +                     compatible = "arm,coresight-etm4x", "arm,primecell";
> > +                     reg = <0x09740000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +                     arm,coresight-loses-context-with-cpu;
> > +
> > +                     cpu = <&CPU7>;
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     etm7_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_in7>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@9800000 {
> > +                     compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +                     reg = <0x09800000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_apss0_out: endpoint {
> > +                                             remote-endpoint = <&funnel_apss1_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +
> > +                             port@0 {
> > +                                     reg = <0>;
> > +                                     funnel_apss0_in0: endpoint {
> > +                                             remote-endpoint = <&etm0_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@1 {
> > +                                     reg = <1>;
> > +                                     funnel_apss0_in1: endpoint {
> > +                                             remote-endpoint = <&etm1_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@2 {
> > +                                     reg = <2>;
> > +                                     funnel_apss0_in2: endpoint {
> > +                                             remote-endpoint = <&etm2_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@3 {
> > +                                     reg = <3>;
> > +                                     funnel_apss0_in3: endpoint {
> > +                                             remote-endpoint = <&etm3_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@4 {
> > +                                     reg = <4>;
> > +                                     funnel_apss0_in4: endpoint {
> > +                                             remote-endpoint = <&etm4_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@5 {
> > +                                     reg = <5>;
> > +                                     funnel_apss0_in5: endpoint {
> > +                                             remote-endpoint = <&etm5_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@6 {
> > +                                     reg = <6>;
> > +                                     funnel_apss0_in6: endpoint {
> > +                                             remote-endpoint = <&etm6_out>;
> > +                                     };
> > +                             };
> > +
> > +                             port@7 {
> > +                                     reg = <7>;
> > +                                     funnel_apss0_in7: endpoint {
> > +                                             remote-endpoint = <&etm7_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> > +             funnel@9810000 {
> > +                     compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
> > +                     reg = <0x09810000 0x1000>;
> > +
> > +                     clocks = <&rpmcc RPM_SMD_QDSS_CLK>;
> > +                     clock-names = "apb_pclk";
> > +
> > +                     status = "disabled";
> > +
> > +                     out-ports {
> > +                             port {
> > +                                     funnel_apss1_out: endpoint {
> > +                                             remote-endpoint = <&funnel_in1_in>;
> > +                                     };
> > +                             };
> > +                     };
> > +
> > +                     in-ports {
> > +                             port {
> > +                                     funnel_apss1_in: endpoint {
> > +                                             remote-endpoint = <&funnel_apss0_out>;
> > +                                     };
> > +                             };
> > +                     };
> > +             };
> > +
> >               apps_smmu: iommu@c600000 {
> >                       compatible = "qcom,sm6115-smmu-500", "qcom,smmu-500", "arm,mmu-500";
> >                       reg = <0x0c600000 0x80000>;
