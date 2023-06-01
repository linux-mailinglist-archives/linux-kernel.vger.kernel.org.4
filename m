Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813397195DC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjFAImx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjFAImu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 04:42:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E30F119
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 01:42:46 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-3f7fd59bb13so4824271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20221208.gappssmtp.com; s=20221208; t=1685608965; x=1688200965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOHClv3EmZ5BC3wC17xcl4hTpc6sk/oBTzMD5jV9A1U=;
        b=T+fEJ8MlR4KHrrWHZaVkuXopdtCLepCVfBAECMwZjmqdNEwNC6Bgag4lvkdnJttjqG
         kvPSAHJclDqCmk2FjFHQ8uyCRrJL2PaHeluGbzlQRi2NqgfZZVRdL0GQ0LwzKQ3jHmnZ
         v/AFlGwYnGklHBhYx7Fn/2CeFAkzTYucPr/j3zZXXc3msN9KyfKR3n1sZN09ALFhkdW8
         dVL8TVf7xu9Nohbt/DNVjnHEaW1Ys4IYv5QQBOnhZZBb/KSkKorVUDMf6CjnuKulVZvP
         cF7QiDngi14DRKbYW9qE4Ls9dcr33RkZHy8U8iT+bt0YF+2buWVR7Vqv3UeL86eGGN3M
         B2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608965; x=1688200965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOHClv3EmZ5BC3wC17xcl4hTpc6sk/oBTzMD5jV9A1U=;
        b=IThcn1SfW261eeoct8ms/39pZzM/n7E5O6a41Oxtc28ppzezrsaAQNj6AEQjHWUt74
         PQjc8qXyNojMZq6tkyjljySzpDRanPDFJ/Xucg1Nxh/G/QZ8pdkDn5I+qGVtAx0RRs4V
         IkIUMLZ94HZ6K6Ey0Yek32gdgeELPFmDaf0uzUrS9Tz7Bv1Y0KBxFn/hLM/S+5eTJtJs
         fpU+EbCX0bQn6wS+S4xq5N8mLPpYepHf85ISu5EAOj7sze4n4Li39ufY4UCbTzsqjN+c
         G5HEnkysk5GrfijaD8sLTtGhqGz3PV941iFWOUlz0+G+6xltQk1FyI8yGJ8VZYWz/v8c
         n7rQ==
X-Gm-Message-State: AC+VfDxyIrTr1lpp1HQyrezt6n8bZKUWXNleJGtlqlM7IoLep7NKczPt
        KNsK3WjZsikBAPrctB6z1UGFeTe0cSZiISJXs7bmrw==
X-Google-Smtp-Source: ACHHUZ64B9aPj3MnaxAoV1VqJcmNXpqutdESG4B/ynheLTITdb7rBWLgFOJzuXb75zVf3DoZRlJQepZrwBTnxNF+Mtc=
X-Received: by 2002:a05:622a:58a:b0:3f6:b151:7db1 with SMTP id
 c10-20020a05622a058a00b003f6b1517db1mr9299207qtb.62.1685608965598; Thu, 01
 Jun 2023 01:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230531-topic-8998_mmssclk-v1-0-2b5a8fc90991@linaro.org> <20230531-topic-8998_mmssclk-v1-1-2b5a8fc90991@linaro.org>
In-Reply-To: <20230531-topic-8998_mmssclk-v1-1-2b5a8fc90991@linaro.org>
From:   "Bryan O'Donoghue" <pure.logic@nexus-software.ie>
Date:   Thu, 1 Jun 2023 10:42:33 +0200
Message-ID: <CAJB8c076FOXDzCzYWmzfm_PF6UieYx-XMwAqUBHTc+UubjYu6g@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm64: dts: qcom: msm8998: Properly describe MMSS SMMU
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Imran Khan <kimran@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Joonwoo Park <joonwoop@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 11:01=E2=80=AFAM Konrad Dybcio <konrad.dybcio@linar=
o.org> wrote:
>
> The MMSS SMMU has been abusingly consuming the exposed RPM interconnect
> clock and not describing the power domain it needs. Put an end to that.
>
> Fixes: 05ce21b54423 ("arm64: dts: qcom: msm8998: Configure the multimedia=
 subsystem iommu")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8998.dtsi | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/=
qcom/msm8998.dtsi
> index f0e943ff0046..a4016085b750 100644
> --- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
> @@ -2737,10 +2737,10 @@ mmss_smmu: iommu@cd00000 {
>
>                         clocks =3D <&mmcc MNOC_AHB_CLK>,
>                                  <&mmcc BIMC_SMMU_AHB_CLK>,
> -                                <&rpmcc RPM_SMD_MMAXI_CLK>,
>                                  <&mmcc BIMC_SMMU_AXI_CLK>;
> -                       clock-names =3D "iface-mm", "iface-smmu",
> -                                     "bus-mm", "bus-smmu";
> +                       clock-names =3D "iface-mm",
> +                                     "iface-smmu",
> +                                     "bus-smmu";
>
>                         #global-interrupts =3D <0>;
>                         interrupts =3D
> @@ -2764,6 +2764,8 @@ mmss_smmu: iommu@cd00000 {
>                                 <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
>                                 <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
> +
> +                       power-domains =3D <&mmcc BIMC_SMMU_GDSC>;
>                 };
>
>                 remoteproc_adsp: remoteproc@17300000 {
>
> --
> 2.40.1
>

I think you should split this up.

This should be two patches. One to describe the power-domain and
another for the removal of interconnect clocks.

I guess none of the multi-media connected stuff on 8998 works ... no
venus, mdp, camera - which would surely fail without the multi-media
AXI clock being on..

Anyway please split this patch up !
