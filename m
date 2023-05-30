Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E62715E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbjE3MMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjE3MMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:12:53 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CA990;
        Tue, 30 May 2023 05:12:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 34UCCWYe012129;
        Tue, 30 May 2023 07:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685448752;
        bh=8uqI9y6tq0REB+5JFQV7GN5M4AZAgicKtOkyYMyBmOY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dTRo7E14io9pq8vizJKlq5+cwRdBdvvxuKtXwdT3cjN5f2cxgUjFLNRgay/cyEA6J
         h8+6tu/Epdsyo78hIdTe3qXBoKhGjarTzx3WpGeq6NizneI4DHhOyRix1WybnRLHdE
         PeEoy86MjHyMATPh0rM6+hbSjleFHVaPZI1f4Pn0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 34UCCVcE050750
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 May 2023 07:12:32 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 30
 May 2023 07:12:31 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 30 May 2023 07:12:31 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 34UCCV4I126937;
        Tue, 30 May 2023 07:12:31 -0500
Date:   Tue, 30 May 2023 07:12:31 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Francesco Dolcini <francesco@dolcini.it>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <20230530121231.fnfqhkfliysrv2pr@engross>
References: <20230524143631.42471-1-francesco@dolcini.it>
 <20230524143631.42471-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230524143631.42471-2-francesco@dolcini.it>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16:36-20230524, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> nonwifi and wifi variants and the carrier boards (Dahlia,
> Verdin Development Board and Yavia) they may be mated in.
> 
> Link: https://developer.toradex.com/hardware/verdin-som-family/modules/verdin-am62/
> Link: https://www.toradex.com/computer-on-modules/verdin-arm-family/ti-am62
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/arm/ti/k3.yaml        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.yaml b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> index e1183f90bb06..e3aee191d403 100644
> --- a/Documentation/devicetree/bindings/arm/ti/k3.yaml
> +++ b/Documentation/devicetree/bindings/arm/ti/k3.yaml
> @@ -33,6 +33,26 @@ properties:
>                - ti,am62-lp-sk
>            - const: ti,am625
>  
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-nonwifi-dahlia # Verdin AM62 Module on Dahlia
> +              - toradex,verdin-am62-nonwifi-dev    # Verdin AM62 Module on Verdin Development Board
> +              - toradex,verdin-am62-nonwifi-yavia  # Verdin AM62 Module on Yavia

Does'nt one of these indicate the rest?

> +          - const: toradex,verdin-am62-nonwifi     # Verdin AM62 Module without Wi-Fi / BT
> +          - const: toradex,verdin-am62             # Verdin AM62 Module
> +          - const: ti,am625
> +
> +      - description: K3 AM62x SoC Toradex Verdin Modules and Carrier Boards with Wi-Fi / BT
> +        items:
> +          - enum:
> +              - toradex,verdin-am62-wifi-dahlia # Verdin AM62 Wi-Fi / BT Module on Dahlia
> +              - toradex,verdin-am62-wifi-dev    # Verdin AM62 Wi-Fi / BT M. on Verdin Development B.
> +              - toradex,verdin-am62-wifi-yavia  # Verdin AM62 Wi-Fi / BT Module on Yavia

Same?

> +          - const: toradex,verdin-am62-wifi     # Verdin AM62 Wi-Fi / BT Module
> +          - const: toradex,verdin-am62          # Verdin AM62 Module
> +          - const: ti,am625
> +
>        - description: K3 AM642 SoC
>          items:
>            - enum:
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
