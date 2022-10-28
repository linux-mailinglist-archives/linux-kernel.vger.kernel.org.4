Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D43D610B18
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ1HPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ1HPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:15:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392054C2D4;
        Fri, 28 Oct 2022 00:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A020B8289B;
        Fri, 28 Oct 2022 07:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B6AC4347C;
        Fri, 28 Oct 2022 07:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666941295;
        bh=MxQF7C6N2bgDc8qWPr3XWxr/QVgxtca4lSdN14fri4c=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=UxrMkmPhaRU39RMJpE85mPZncHpJoe0JLWh5T88Gz9ipg+/ZOVlWfpeSqMYc+CJf9
         Z4mTeQHN3VeoDZmyjLBEfz8O7t/cV6bWD/QQ724BpHQG7JLS1YgC3QMNMAR5VCGr90
         INfnmuJ/aWio5nFvsC5JKvbRcglnbVRvb2teMxMujAevv4haIppdWxY2XRtWdeyrPU
         W4bR6WtJD2YNc5DRVrwhnUQgAn0CL87cQnBUPjOaq83dEMaKXWZ8eLBrU9ZhLVTtL0
         G710llfcL/dHSQwbHP0I8jxdXBDUvgjNZ/vl6bvblF3aXvMU0OxhO/EjxseYhBrNlJ
         KWBxMTMRoPauA==
Message-ID: <d2600fef-0313-551e-b175-40edfbf1acd4@kernel.org>
Date:   Fri, 28 Oct 2022 10:14:49 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] dt-bindings: interconnect: qcom,msm8998-bwmon: Correct
 SC7280 CPU compatible
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20221011140744.29829-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.10.22 17:07, Krzysztof Kozlowski wrote:
> Two different compatibles for SC7280 CPU BWMON instance were used
> in DTS and bindings.  Correct the bindings to use the same one as in
> DTS, because it is more specific.
> 
> Fixes: b7c84ae757c2 ("dt-bindings: interconnect: qcom,msm8998-bwmon: Add support for sc7280 BWMONs")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I assume that this will be picked by Bjorn. Please let me know otherwise.

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
>   .../devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml    | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> index 2684562df4d9..be29e0b80995 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
> @@ -24,7 +24,7 @@ properties:
>       oneOf:
>         - items:
>             - enum:
> -              - qcom,sc7280-bwmon
> +              - qcom,sc7280-cpu-bwmon
>                 - qcom,sdm845-bwmon
>             - const: qcom,msm8998-bwmon
>         - const: qcom,msm8998-bwmon       # BWMON v4

