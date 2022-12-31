Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CA65A791
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbiLaWxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaWxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:53:16 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE8C110D;
        Sat, 31 Dec 2022 14:53:14 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 28B073EBDC;
        Sat, 31 Dec 2022 23:53:12 +0100 (CET)
Date:   Sat, 31 Dec 2022 23:53:06 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v5 1/6] dt-bindings: ufs: qcom: Add SM6125 compatible
 string
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <I82SNR.7YLHMAX9NHSF3@somainline.org>
In-Reply-To: <20221231222420.75233-2-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
        <20221231222420.75233-2-they@mint.lgbt>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_HTTP,
        RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, Dec 31 2022 at 07:24:15 PM -03:00:00, Lux Aliaga 
<they@mint.lgbt> wrote:
> Document the compatible for UFS found on the SM6125.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml 
> b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> index b517d76215e3..42422f3471b3 100644
> --- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> +++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
> @@ -29,6 +29,7 @@ properties:
>            - qcom,sc8280xp-ufshc
>            - qcom,sdm845-ufshc
>            - qcom,sm6115-ufshc
> +          - qcom,sm6125-ufshc
>            - qcom,sm6350-ufshc
>            - qcom,sm8150-ufshc
>            - qcom,sm8250-ufshc
> @@ -185,6 +186,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,sm6115-ufshc
> +              - qcom,sm6125-ufshc
>      then:
>        properties:
>          clocks:
> --
> 2.38.1
> 
Reviewed-by: Martin Botka <martin.botka@somainline.org>


