Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0424167EF62
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjA0UNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjA0UM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:12:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22875CC1C;
        Fri, 27 Jan 2023 12:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A16AB61DA0;
        Fri, 27 Jan 2023 20:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B61C433A0;
        Fri, 27 Jan 2023 20:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674850373;
        bh=ESp4ivxCGFPFObDgvtxKFzxjuSZPqA+13GuDHfzNnKQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hLlshlrWA11JQFyx8kJctNNRBypOFsY1qHeYDQKv6HpkS8kU67Zo4QJmFalWo5iiw
         sefVI2xlwVULeio3nc7RFNX1AKusGR+9TKdNnMyZ2G3O7/CWzkdqtqLJNiikp6Z+IU
         7XezxAy4X9QNH7L8bO9ZJgJixSGwI4rCaUO+sfAHS1mgMi8AxzybVx4Wxpdi718yGE
         DgyaIkVNfv3i6iyaq+bBTSkKGTZHiyFRYN3HgbFvMu0wEUFKztLpJHVAQhg3REMIzQ
         KriDVATMAK0dBYLY26nEkNIHH6fjq0sTTMLItEPoXXQ0QG5Ze6AzlpqLtfhGr5gnTF
         GpN9OEQbmACuA==
Received: by mail-vs1-f44.google.com with SMTP id h19so4703474vsv.13;
        Fri, 27 Jan 2023 12:12:53 -0800 (PST)
X-Gm-Message-State: AO0yUKWBXPLG9ZOMbCrEsxQYfNXRV4Ua9j955BzZFBDn1xaIUmjaMA+d
        RaVToPNQSPKUUxtPIkb0xcw46ZE5RCXfu76IGg==
X-Google-Smtp-Source: AK7set8wQJdZmsM8dWkryhTXCAqQig8VcqnjonDtkAIpepzNG8FdkE5HSko39Te2boXO0fc2vqvdvVcFtGldT10mXgY=
X-Received: by 2002:a67:fe41:0:b0:3ea:c8c:48a5 with SMTP id
 m1-20020a67fe41000000b003ea0c8c48a5mr1321838vsr.53.1674850372847; Fri, 27 Jan
 2023 12:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-5-quic_devipriy@quicinc.com> <20230117183835.GA3427325-robh@kernel.org>
 <11a5fa34-c438-a567-6364-4bf1d0d369e3@quicinc.com>
In-Reply-To: <11a5fa34-c438-a567-6364-4bf1d0d369e3@quicinc.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 27 Jan 2023 14:12:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKMpW7O_sQ4j+ZBfjGZdJUDosM-kVhcFjaUmXvXCC4L8A@mail.gmail.com>
Message-ID: <CAL_JsqKMpW7O_sQ4j+ZBfjGZdJUDosM-kVhcFjaUmXvXCC4L8A@mail.gmail.com>
Subject: Re: [PATCH 4/6] regulator: qcom_smd: Add PMIC compatible for IPQ9574
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 10:05 AM Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 1/18/2023 12:08 AM, Rob Herring wrote:
> > On Fri, Jan 13, 2023 at 08:33:08PM +0530, devi priya wrote:
> >> Add mp5496 PMIC compatible string for IPQ9574 SoC
> >>
> >> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> >> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> >> ---
> >>   .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml  | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> >> index 8c45f53212b1..7907d9385583 100644
> >> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
> >> @@ -22,7 +22,7 @@ description:
> >>     Each sub-node is identified using the node's name, with valid values listed
> >>     for each of the pmics below.
> >>
> >> -  For mp5496, s2
> >> +  For mp5496, s1, s2
> >>
> >>     For pm2250, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
> >>     l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22
> >> @@ -84,6 +84,7 @@ properties:
> >>     compatible:
> >>       enum:
> >>         - qcom,rpm-mp5496-regulators
> >> +      - qcom,rpm-ipq9574-mp5496-regulators
> >
> > Is this a different part than just mp5496? Or used in a different,
> > incompatible way?
> IPQ6018 and IPQ9574 platforms use the same PMIC MP5496 but they have a
> different power layout.So, we plan to update the compatible:
> qcom,rpm-mp5496-regulators to
> qcom,rpm-ipq6018-mp5496-regulators(target-specific) in the next patchset
> as the regulators serve different purposes

You can't just change compatibles. It is an ABI.

This still doesn't make sense to me. The PMIC hasn't changed, so the
binding shouldn't. It should be flexible enough to be hooked up to
different platforms. That's why we have all the per regulator
configuration. What are you missing?

Rob
