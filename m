Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE6680751
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjA3IUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235409AbjA3IUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:20:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A0D180;
        Mon, 30 Jan 2023 00:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB3A6B80DF3;
        Mon, 30 Jan 2023 08:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0F5C433D2;
        Mon, 30 Jan 2023 08:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675066838;
        bh=Vl/j6mc1CDCgRSUfCSphWECoE2GmiM4hVfic/CU8lW4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZ/buxg0Jhg1JWgdSmyCy/y0JtN993BZqG1bVfA+8tgA3Qi9LiBuzCOznSqmY6d3k
         Tp4r2CBROYHRPqJY/l5YfrNvIxAVg5fltRDi9JI2JfRLFztnQFyOUbtfX573y0otLx
         nAaS6avGlS19OM2eUehwQqpGzhu2VlkyFdxNafPKgn0DIq8TT9abjfTJpsGkqzsny3
         aoQKAUH+uPPwaCAM4pxvdU3QCB6xv67BXdN33nTLoHOGKrGgt/S/1AR+/QoGFptV/M
         FU7Ky+V3WYA6e0USOpa/cR3seHjpMIvrbU2JrGlRECF9/j+V4JhB3vgLBgo6bgCSPO
         dfupS3fIDQ88w==
Date:   Mon, 30 Jan 2023 08:20:33 +0000
From:   Lee Jones <lee@kernel.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sm8450
Message-ID: <Y9d90TwyLKdhkj13@google.com>
References: <1673513697-30173-1-git-send-email-quic_mojha@quicinc.com>
 <3a4675f8-c182-a98c-38e8-be1b4480f612@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a4675f8-c182-a98c-38e8-be1b4480f612@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2023, Mukesh Ojha wrote:

> +Jones
> 
> Jones,
> 
> Can this patch be taken into your tree ?

If it is sent to me properly, then yes.

> On 1/12/2023 2:24 PM, Mukesh Ojha wrote:
> > Document the qcom,sm8450-tcsr compatible.
> > 
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> > ---
> > Change in v3:
> >    - Align with new format mentioned at
> >      Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > 
> > Change in v2:
> >    - Considering here it as v2 as this patch came out from comment
> >      made on its v1 https://lore.kernel.org/lkml/c5dc8042-717b-22eb-79f6-d18ab10d6685@linaro.org/
> > 
> > 
> >   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > index adcae6c..4290062 100644
> > --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> > @@ -26,6 +26,7 @@ properties:
> >             - qcom,sdm630-tcsr
> >             - qcom,sdm845-tcsr
> >             - qcom,sm8150-tcsr
> > +          - qcom,sm8450-tcsr
> >             - qcom,tcsr-apq8064
> >             - qcom,tcsr-apq8084
> >             - qcom,tcsr-ipq6018

-- 
Lee Jones [李琼斯]
