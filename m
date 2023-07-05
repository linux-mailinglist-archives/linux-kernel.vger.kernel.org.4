Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519EF747CAA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 07:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjGEFtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 01:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbjGEFts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 01:49:48 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521F110C9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 22:49:40 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bd61dd9a346so7012442276.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688536179; x=1691128179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5W58Fzb9Zl7oTLDX7IAWaHheZcu9ErUxDNxhsLQpU2I=;
        b=sWbZXd9JcMPymfQeV+xlUdkWQqIjrQfCgHWB+bSaWHKy/EOgJp0HOXg9gCg2DH7WLD
         wYs/Aans8cJIps7j99rPxc0EglgQAbRwzvL9nPw//VC1mozgdmweoXD7U66zSoeGo13Q
         RN0Et5hyonkj4jE3dfXm2zt1lfBKTdYACw9a604i5O82LpFgny+WpPbNPf8KrpdrxiCc
         KlgXYB1kVufEqXW9OVnElPk7VUVaQtSQkYCu0Y+rnJlL8WXKmIYko5fczlvyIP1Pbr4e
         CGz43r1Iht+GnoyK7uPoVIgciGP4lO9Rf08U2RnyWx96nfWuvmaD5T88IL1qWq0wSeFH
         5UIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688536179; x=1691128179;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5W58Fzb9Zl7oTLDX7IAWaHheZcu9ErUxDNxhsLQpU2I=;
        b=IFXpd+PI0/0Y0sAyZywN4izp8c3pObTAhlXWoLM7Unr9OTLggpEHk77vlCoVhPk9eY
         KSM6r+u+JKjbCpskH5gyVaefnef6rdr4nJbPykJeeae3lKNCSLCL7ldwnbzViLQuCZBl
         4tAc/fjYTr0F4VTZ5gmSU+vPRmLNbDpJwZ//CCg7sZbel5YsdJkj+oo3wx/BLpf4tMe6
         n6Dz1SPpyCx+33obdRLxl5diprEl+itKc8iTXoxQLBO1OUCf/adv6a45u89YQ1tThKs9
         fJd4oRsOB6SRiMy35urCcoCE8QxF/shZx49gAQUDoHkcoryJdYMUsPdaW7weeo+VyKe4
         g5Pg==
X-Gm-Message-State: ABy/qLbDiFPj+eB4fmqPwJOHdrFrLvqJQ6W18NwhBw0Z2raX9N1m1nrf
        WNwyMSlhNYKW4MFi8xAKLv1JOcHdLP2W8GtWxdciWA==
X-Google-Smtp-Source: APBJJlEM6AOC9/Ew+OkPk9MgTVFm1ma9xNbW/8FDcQ1U+aQtiCG+kURvCEd8zQrSZ3EpR2MApxz+U8IXVL9oVp26on8=
X-Received: by 2002:a25:b911:0:b0:c5c:c18f:c2bf with SMTP id
 x17-20020a25b911000000b00c5cc18fc2bfmr3487414ybj.11.1688536179552; Tue, 04
 Jul 2023 22:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230705053914.9759-1-quic_kbajaj@quicinc.com> <20230705053914.9759-2-quic_kbajaj@quicinc.com>
In-Reply-To: <20230705053914.9759-2-quic_kbajaj@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 5 Jul 2023 08:49:28 +0300
Message-ID: <CAA8EJpo406gV-5H8+y4SJbbRqnWFRo5wrR6a9KJ2arbN61tS2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] arm64: dts: qcom: qdu1000-idp: Update reserved memory region
To:     Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jul 2023 at 08:40, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>
> Add missing reserved regions as described in QDU1000 memory map.
>
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 26 ++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> index 1d22f87fd238..3f5512ec0a90 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
> @@ -448,6 +448,32 @@ &qupv3_id_0 {
>         status = "okay";
>  };
>
> +&reserved_memory{
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +       ranges;
> +
> +       ecc_meta_data_reserved_mem:ecc_meta_data_reserved_region@e0000000{

no_underscores_in_node_names. Ever.

Also, if you have checked other platforms, you'd have seen that other
platforms use a much more generic node name for 'memory' nodes (which
you should have used too).

> +               no-map;
> +               reg = <0x0 0xe0000000 0x0 0x20000000>;
> +       };
> +
> +       harq_buffer_mem:harq_buffer_region@800000000{
> +               no-map;
> +               reg = <0x8 0x0 0x0 0x80000000>;
> +       };
> +
> +       tenx_sp_buffer_mem:tenx_sp_buffer_region@880000000{
> +               no-map;
> +               reg = <0x8 0x80000000 0x0 0x50000000>;
> +       };
> +
> +       fapi_buffer_mem:fapi_buffer_region@8d0000000{
> +               no-map;
> +               reg = <0x8 0xd0000000 0x0 0x20000000>;
> +       };
> +};
> +
>  &sdhc {
>         pinctrl-0 = <&sdc_on_state>;
>         pinctrl-1 = <&sdc_off_state>;
> --
> 2.40.1
>


-- 
With best wishes
Dmitry
