Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF044657613
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiL1Lxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbiL1Lxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:53:34 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29ED1055D
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:53:30 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so8769486wms.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIc8aJi8QrQvoJC03xAlMGnXDQaBLi9+Xeuw2xbs1CY=;
        b=IqTlpr+kOSYALPPG9hyn3C9MlIclYXZ7rmvtGH7avBSeuw0UUodYrtkyEnyOdeAAo8
         i0fBxxV8jK97PO6KBukzq5ruUVd4+WlrDQubGUOmyxTAXnlc5mpPzO1a773G8VfRjrpt
         5nwas47xCB6lLvtRpTpV01nuBknkPnkZ6yTrHfALUdCkJpVfeTqWcY7qB8CzRU/3AYX3
         z7sUolaxeNYwAhmsjgplLToOE4xYZmtxU6fLSiXulUS/87GBU6Iok8fSHwwUXLp6u38j
         D0xKba8YxPKtTDorV053vnH+vcRZ89rq1wnFuWMpMLDSDtADRQkxmUhRrUmDiM16Sw38
         qQ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jIc8aJi8QrQvoJC03xAlMGnXDQaBLi9+Xeuw2xbs1CY=;
        b=TOowWq4E6N6zuaWGGHPTGp2QTSOcgDTxdfiNHByYJ2ac4B8oKD1vzCT/kR65Tt+9qZ
         LP76gApAq/+pZoQoK0uqsNoO0FqRTIuUFNljQg/pxWWuvP+Y2avNUmXuVLwZn/cp0miC
         dYf8Vt2VR9PpQ3qhpcrn/uV+jXE/qbC6aIn9GBkFDEc0quSrDBGG+Hx9Jtn6aY+TlLRo
         K4mpoalwYX1Xsl6eN8O06reF7yAbotewD8U7AaDDFFA8keIhaxqQiUUtQ1u6zZun/Yxc
         yh8ZXI+/0JR2nKhZF6d2275DbszPqb65FAawp+ty0M2rGOvxmAgarGVeF0GtoFrLhwUt
         JMOw==
X-Gm-Message-State: AFqh2ko3t0H2J4PnuMa4ObQ/14/OkWJIXlFy6RrOso+pxGAxC5jHvYi8
        yZCrS3Qg/KbqrOblTMfRRuo/Gw==
X-Google-Smtp-Source: AMrXdXsHsKXYzrbgvBev4TqUTsvmYSdXTIKLuvACYlZVNAx/xPx9eOVDrIVvKi9OWOpGnsegvvTAow==
X-Received: by 2002:a05:600c:34ce:b0:3cf:614e:b587 with SMTP id d14-20020a05600c34ce00b003cf614eb587mr18312059wmq.26.1672228409224;
        Wed, 28 Dec 2022 03:53:29 -0800 (PST)
Received: from localhost (2a02-8388-6582-fe80-0000-0000-0000-0006.cable.dynamic.v6.surfer.at. [2a02:8388:6582:fe80::6])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003d969a595fbsm20730799wmk.10.2022.12.28.03.53.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:53:28 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 28 Dec 2022 12:53:27 +0100
Message-Id: <CPDFHXBPSP76.5CWNQK4N1KGI@otso>
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        "Avri Altman" <avri.altman@wdc.com>,
        "Bart Van Assche" <bvanassche@acm.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Cc:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
X-Mailer: aerc 0.13.0
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <c4109766-22f1-7227-47bb-9273a027bb0c@linaro.org>
In-Reply-To: <c4109766-22f1-7227-47bb-9273a027bb0c@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed Dec 28, 2022 at 12:50 PM CET, Krzysztof Kozlowski wrote:
> On 09/12/2022 15:29, Luca Weiss wrote:
> > The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add thi=
s
> > in the bindings so the existing dts can validate successfully.
> >=20
> > Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
> > sm8450: add Inline Crypto Engine registers and clock") so move the
> > compatible to the correct if.
> >=20
> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> > ---
> > (no cover subject)
> >=20
> > The only remaining validation issues I see is the following on sc8280xp=
-crd.dtb
> > and sa8540p-ride.dtb:
> >=20
>
> Any plans on fixing the patch (after testing it) and resending?

I wasn't quite sure how to fix the comments, but re-reading them this
comment from you is how you expect it to be in v2?

> Just add it to top-level with minItems: 1 and per variant customize:
> 1. maxItems: 1
> 2. minItems: 2 + required

If so I can spin v2 maybe today still.

Regards
Luca

>
> Best regards,
> Krzysztof

