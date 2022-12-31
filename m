Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F11FC65A78D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiLaWur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:50:44 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D24213F;
        Sat, 31 Dec 2022 14:50:43 -0800 (PST)
Received: from [192.168.2.144] (adsl-d248.84-47-10.t-com.sk [84.47.10.248])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 673543ED5A;
        Sat, 31 Dec 2022 23:50:40 +0100 (CET)
Date:   Sat, 31 Dec 2022 23:50:33 +0100
From:   Martin Botka <martin.botka@somainline.org>
Subject: Re: [PATCH v5 5/6] dt-bindings: arm: qcom: Document
 xiaomi,laurel-sprout board
To:     Lux Aliaga <they@mint.lgbt>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        marijn.suijten@somainline.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <942SNR.IMR405HRPE6J@somainline.org>
In-Reply-To: <20221231222420.75233-6-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
        <20221231222420.75233-6-they@mint.lgbt>
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



On Sat, Dec 31 2022 at 07:24:19 PM -03:00:00, Lux Aliaga 
<they@mint.lgbt> wrote:
> Document the Xiaomi Mi A3 (xiaomi-laurel-sprout) smartphone which is
> based on the Snapdragon 665 SoC.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml 
> b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 27063a045bd0..4923dafb5d7a 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -793,6 +793,7 @@ properties:
>        - items:
>            - enum:
>                - sony,pdx201
> +              - xiaomi,laurel-sprout
 From what i can see laurel_sprout is the correct and official codename 
for the device.

Not sure here at all but should we maybe use that as it is the official 
codename ?

-Martin
>            - const: qcom,sm6125
> 
>        - items:
> --
> 2.38.1
> 


