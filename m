Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3273F69E188
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 14:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbjBUNlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 08:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjBUNlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 08:41:32 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF067298D5;
        Tue, 21 Feb 2023 05:41:30 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 31LDfK8p064523;
        Tue, 21 Feb 2023 07:41:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1676986880;
        bh=BfsIZOIC/YfpvyPq0ogn3Gds2Miyyt1nc9Drj/TyLj8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=mZayAV4d2omFG9e4qWxnKDY6SdR5RYiuKrhaCmIGp8rhkDmI4hz4HZCH4EUqk4WkT
         WdKdw0zca4XOkge/NYJu0Xds2GKXCxVfQDl2eWOykc8N4JV0arJCBVrOwZSOgKE+be
         xnig5qVdpRJjd8D8MlTJJb+KZWGuFVsmb5qRJZpU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 31LDfKvi123012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Feb 2023 07:41:20 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Feb 2023 07:41:20 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Feb 2023 07:41:20 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 31LDfKBe119197;
        Tue, 21 Feb 2023 07:41:20 -0600
Date:   Tue, 21 Feb 2023 07:41:20 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Ravi Gunasekaran <r-gunasekaran@ti.com>
CC:     <afd@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <s-vadapalli@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 1/9] dt-bindings: mfd: ti,j721e-system-controller:
 Fix mux node regex
Message-ID: <20230221134120.hveyczujflmfjbsz@matted>
References: <20230221120612.27366-1-r-gunasekaran@ti.com>
 <20230221120612.27366-2-r-gunasekaran@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230221120612.27366-2-r-gunasekaran@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:36-20230221, Ravi Gunasekaran wrote:
> mux-controller nodes may not have "reg" property. Update the regex
> for such nodes to resolve the dtbs warnings
> 
> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
> ---
>  .../bindings/mfd/ti,j721e-system-controller.yaml          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)


Are you expecting for me to pick this up? Looks like something
Lee Jones needs to pick up? He is'nt in the CC either?

If Lee Jones is willing to give me an immutable tag, I can pick the same
up and pick up dependent patches. Else, please split the series for each
of the maintainers to pick up without dependency.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> index 76ef4352e13c..532bfa45e6a0 100644
> --- a/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> +++ b/Documentation/devicetree/bindings/mfd/ti,j721e-system-controller.yaml
> @@ -45,7 +45,7 @@ properties:
>  
>  patternProperties:
>    # Optional children
> -  "^mux-controller@[0-9a-f]+$":
> +  "^mux-controller(@|-)[0-9a-f]+$":
>      type: object
>      description:
>        This is the SERDES lane control mux.
> @@ -94,6 +94,12 @@ examples:
>                  /* SERDES4 lane0/1/2/3 select */
>          };
>  
> +        usb_serdes_mux: mux-controller-80 {
> +                compatible = "mmio-mux";
> +                #mux-control-cells = <1>;
> +                mux-reg-masks = <0x0 0x8000000>;
> +        };
> +
>          clock-controller@4140 {
>              compatible = "ti,am654-ehrpwm-tbclk", "syscon";
>              reg = <0x4140 0x18>;
> -- 
> 2.17.1
> 
