Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAFF6BDFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 05:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCQEIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 00:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCQEIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 00:08:48 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518A22278E;
        Thu, 16 Mar 2023 21:08:45 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32H48O5C025320;
        Thu, 16 Mar 2023 23:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679026104;
        bh=hTnCLwzT7E/jUr8nrf+BIIZqCannDfxi+O/YjyW82n0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=K+4+TSTYFK6JfARcyJI0kc9asINmKkFlRokxTmtHz46gP6HxXOzu2F5+bi2S0zXyW
         8zroPzjIpexxesYzusJD5HnGBMULMadJwAYPMN1nAj3qPmgFxWJbNLozn/L/kp5cEO
         UgjWe622xhb4eNQynJrhpQP1Q5lvq1Y98cQ6kCnU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32H48O59007269
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Mar 2023 23:08:24 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 16
 Mar 2023 23:08:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 16 Mar 2023 23:08:23 -0500
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32H48K8T130014;
        Thu, 16 Mar 2023 23:08:20 -0500
Message-ID: <11b83885-ff64-df78-e14c-137fffb5f7ce@ti.com>
Date:   Fri, 17 Mar 2023 09:38:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3] PCI: cadence: Clear the ARI Capability Next Function
 Number of the last function
Content-Language: en-US
To:     Achal Verma <a-verma1@ti.com>, Tom Joseph <tjoseph@cadence.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Wilczy_ski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Milind Parab <mparab@cadence.com>,
        <wojciech.jasko-EXT@continental-corporation.com>
References: <20230316071156.200888-1-a-verma1@ti.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20230316071156.200888-1-a-verma1@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/03/23 12:41, Achal Verma wrote:
> From: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> 
> Next Function Number field in ARI Capability Register for last function
> must be zero by default as per the PCIe specification, indicating there
> is no next higher number function but that's not happening in our case,
> so this patch clears the Next Function Number field for last function used.
> 
> Signed-off-by: Jasko-EXT Wojciech <wojciech.jasko-EXT@continental-corporation.com>
> Signed-off-by: Achal Verma <a-verma1@ti.com>
> ---
> Changes from v1:
> * Fix commments in the code.
> 
> Changes from v2:
> * Rework the commit message.
> 
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 14 +++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h    |  6 ++++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index b8b655d4047e..8742b2f594fd 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -565,7 +565,8 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	struct cdns_pcie *pcie = &ep->pcie;
>  	struct device *dev = pcie->dev;
>  	int max_epfs = sizeof(epc->function_num_map) * 8;
> -	int ret, value, epf;
> +	int ret, epf, last_fn;
> +	u32 reg, value;
>  
>  	/*
>  	 * BIT(0) is hardwired to 1, hence function 0 is always enabled
> @@ -573,6 +574,17 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  	 */
>  	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, epc->function_num_map);
>  
> +	/*
> +	 * Next function field in ARI_CAP_AND_CTR register for last function
> +	 * should be 0.
> +	 * Clearing Next Function Number field for the last function used.
> +	 */
> +	last_fn = find_last_bit(&epc->function_num_map, BITS_PER_LONG);
> +	reg     = CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(last_fn);
> +	value  = cdns_pcie_readl(pcie, reg);
> +	value &= ~CDNS_PCIE_ARI_CAP_NFN_MASK;
> +	cdns_pcie_writel(pcie, reg, value);
> +
>  	if (ep->quirk_disable_flr) {
>  		for (epf = 0; epf < max_epfs; epf++) {
>  			if (!(epc->function_num_map & BIT(epf)))
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 190786e47df9..68c4c7878111 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -130,6 +130,12 @@
>  #define CDNS_PCIE_EP_FUNC_DEV_CAP_OFFSET	0xc0
>  #define CDNS_PCIE_EP_FUNC_SRIOV_CAP_OFFSET	0x200
>  
> +/*
> + * Endpoint PF Registers
> + */
> +#define CDNS_PCIE_CORE_PF_I_ARI_CAP_AND_CTRL(fn)	(0x144 + (fn) * 0x1000)
> +#define CDNS_PCIE_ARI_CAP_NFN_MASK	GENMASK(15, 8)
> +
>  /*
>   * Root Port Registers (PCI configuration space for the root port function)
>   */



Reviewed-by: Vignesh Raghavendra <vigneshr@ti.com>

FYI, there seems to be a duplicate patch [1], you may want to clarify
which one to look at


[1] https://lore.kernel.org/all/20230316065455.191785-1-a-verma1@ti.com/

-- 
Regards
Vignesh
