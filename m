Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0219D6F5755
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjECLsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjECLsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:48:36 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE7198E;
        Wed,  3 May 2023 04:48:35 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 343BmS4R075804;
        Wed, 3 May 2023 06:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683114508;
        bh=wPB8y/TzSnjaGViF/6c6Y1Y9FXqSPyD31+joFudUKTA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GVPkXy2hKTRnuVmgR3piUz0QE5AkCjDavTIhMuPg5jTW8kJp5+besz8zjVIMFc0C8
         qiEApOmmCHAoJKqI5PQ5QdbEZ3rs4KO4k57fx/UO9jHeDBXsV9NvbStC6As8V1toc5
         E7pNIKC5K2HpRLq1fb8dp3hkXWXELSoLTC4VV7Zc=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 343BmS1J122719
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 3 May 2023 06:48:28 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 May 2023 06:48:27 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 May 2023 06:48:27 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 343BmRSd083672;
        Wed, 3 May 2023 06:48:27 -0500
Date:   Wed, 3 May 2023 06:48:27 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Neha Malcom Francis <n-francis@ti.com>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <u-kumar1@ti.com>
Subject: Re: [PATCH v4 2/3] arm64: dts: ti: k3-j721e: Add ESM support
Message-ID: <20230503114827.lutd2ebygxczvali@argue>
References: <20230503093310.85779-1-n-francis@ti.com>
 <20230503093310.85779-3-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230503093310.85779-3-n-francis@ti.com>
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

On 15:03-20230503, Neha Malcom Francis wrote:
> Add address entry mapping ESM on J721E.
> 
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>  arch/arm64/boot/dts/ti/k3-j721e.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> index b912143b6a11..52bcde601eb8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi

Why is'nt esm node introduced here?

> @@ -131,6 +131,7 @@ cbass_main: bus@100000 {
>  		#size-cells = <2>;
>  		ranges = <0x00 0x00100000 0x00 0x00100000 0x00 0x00020000>, /* ctrl mmr */
>  			 <0x00 0x00600000 0x00 0x00600000 0x00 0x00031100>, /* GPIO */
> +			 <0x00 0x00700000 0x00 0x00700000 0x00 0x00001000>, /* ESM */
>  			 <0x00 0x00900000 0x00 0x00900000 0x00 0x00012000>, /* serdes */
>  			 <0x00 0x00a40000 0x00 0x00a40000 0x00 0x00000800>, /* timesync router */
>  			 <0x00 0x06000000 0x00 0x06000000 0x00 0x00400000>, /* USBSS0 */
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
