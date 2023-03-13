Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72866B7D4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 17:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjCMQUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 12:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCMQUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 12:20:05 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A006F48B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:19:46 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32DGJd2O067895;
        Mon, 13 Mar 2023 11:19:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678724379;
        bh=Wwi66okJUkO1Rt0duQ0lKNZdTblEA/oDpv8WKt+0yAA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=S2ccUw69eHnMQmDsopmesJYAKQ12R5WTfhJfYeuHm8qYVm9/h4ydMTBBk5gd6gA4z
         XWfzrJuTOd2dNYBvkhkSZmzEm4IETKK8RI+8euJt/IyjsFuIQkAOyKvWGePJ3oXUN0
         1ILi1OTZwMKR1l9hEBIrmzB+aTG6rHpNB6KJUatc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32DGJdX8022073
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Mar 2023 11:19:39 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 13
 Mar 2023 11:19:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 13 Mar 2023 11:19:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32DGJdgQ022589;
        Mon, 13 Mar 2023 11:19:39 -0500
Date:   Mon, 13 Mar 2023 11:19:39 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <ssantosh@kernel.org>, <s-vadapalli@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J784S4 SOC
Message-ID: <20230313161939.ortphyo3ntu2dl3b@bully>
References: <20230313065025.185320-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230313065025.185320-1-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:20-20230313, Jayesh Choudhary wrote:
> J784S4 SoC's JTAG PARTNO is 0xBB80.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

^^ is that Co-developed-by ?

> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
>  drivers/soc/ti/k3-socinfo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> index d15764e19d96..ad97e08a25f6 100644
> --- a/drivers/soc/ti/k3-socinfo.c
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -43,6 +43,7 @@ static const struct k3_soc_id {
>  	{ 0xBB38, "AM64X" },
>  	{ 0xBB75, "J721S2"},
>  	{ 0xBB7E, "AM62X" },
> +	{ 0xBB80, "J784S4" },
>  	{ 0xBB8D, "AM62AX" },
>  };
>  
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
