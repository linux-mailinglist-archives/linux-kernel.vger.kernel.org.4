Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87B564F549
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 00:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLPXm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 18:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiLPXmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 18:42:25 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC2F4F640;
        Fri, 16 Dec 2022 15:42:22 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1322d768ba7so5151542fac.5;
        Fri, 16 Dec 2022 15:42:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QfSl+FX9JTy+jdpFFR1D1kGG2K/ycBgrvJ9W+hYCCRs=;
        b=Ed7TSS0tw0pezzPYyuTdCGmFpGBH0+dXNTJabcUsyhwPTUK8E2ltLASU+SHCkT5fEn
         v4wA4SK6YsnWvsyciiB1aQ0UiBt9NYF/XLFZh1hzYbcIy5hIuv1EAK67cqgJB3nypkFZ
         WnZWSC8EFA5y8qafZniPDUPsZrFRNp6q0h1xixg8TndYp+qTj7X8RmPipp8mhdW+I4E6
         T6R69tDOQX1SzbO6sv06XkiOgTLzq/Z396qe2cK5Gy9C/YrMPOxGxJZpzd3i3wqSPghR
         4XO3UaMg4K5dMjW3ePR5O6/nFwsH+kdulbhs43FeI0XDRfnUcUyxP90elThSSBTXY4rg
         NNuA==
X-Gm-Message-State: ANoB5pkKSJm9VCGsf/ybl+eZ5B4vS4oC6Rtt23wq02xQLHyZ6V4f54/8
        zsJXHV/eUsI0DYbIBYQe8g==
X-Google-Smtp-Source: AA0mqf5MYBGCni7xQDRAsLZ2V/eXQh5hzxi51tza1LPWdei/oEGQT80Vdt1JMaxgf+O6639iY/fivg==
X-Received: by 2002:a05:6870:9d83:b0:144:7061:112 with SMTP id pv3-20020a0568709d8300b0014470610112mr18616683oab.15.1671234141537;
        Fri, 16 Dec 2022 15:42:21 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r43-20020a05687108ab00b001428eb454e9sm1603705oaq.13.2022.12.16.15.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 15:42:21 -0800 (PST)
Received: (nullmailer pid 88182 invoked by uid 1000);
        Fri, 16 Dec 2022 23:42:20 -0000
Date:   Fri, 16 Dec 2022 17:42:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@microchip.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        luis.oliveira@synopsys.com
Subject: Re: [PATCH v5 2/4] dt-bindings: phy: Document the Synopsys MIPI DPHY
 Rx bindings
Message-ID: <20221216234220.GB80712-robh@kernel.org>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
 <20221216143717.1002015-3-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216143717.1002015-3-eugen.hristev@microchip.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 04:37:15PM +0200, Eugen Hristev wrote:
> From: Luis Oliveira <Luis.Oliveira@synopsys.com>
> 
> Add device-tree bindings documentation for SNPS DesignWare MIPI D-PHY in
> RX mode.
> 
> Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
> ---
>  .../bindings/phy/snps,dw-dphy-rx.txt          | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
> new file mode 100644
> index 000000000000..ffb64fe5cbd1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
> @@ -0,0 +1,29 @@
> +Synopsys DesignWare MIPI Rx D-PHY block details
> +
> +Description
> +-----------
> +
> +The Synopsys MIPI D-PHY controller supports MIPI-DPHY in receiver mode.
> +Please refer to phy-bindings.txt for more information.
> +
> +Required properties:
> +- compatible		: Shall be "snps,dw-dphy-rx".
> +- #phy-cells		: Must be 1.

There is more than 1 lane/phy for a single instance?

> +- bus-width		: Size of the test interface data bus (8 bits->8 or
> +			  12bits->12).

Do we need a test interface upstream?

If so, needs a vendor prefix.

> +- snps,dphy-frequency	: Frequency at which D-PHY should start, configurable.
> +			  Check Synopsys databook. (-kHz)

Is this frequency of the link? We have properties for that. Or this 
should somehow be using the clock binding.

And anything with units should have a unit suffix as defined in 
property-units.yaml.

> +- reg			: Test interface register. This correspondes to the
> +			  physical base address of the controller and size of
> +			  the device memory mapped registers; Check Synopsys
> +			  databook.
> +
> +Example:
> +
> +	mipi_dphy_rx1: dphy@d00003040 {
> +		compatible = "snps,dw-dphy-rx";
> +		#phy-cells = <1>;
> +		bus-width = <12>;
> +		snps,dphy-frequency = <300000>;
> +		reg = <0xd0003040 0x20>;
> +	};
> -- 
> 2.25.1
> 
> 
