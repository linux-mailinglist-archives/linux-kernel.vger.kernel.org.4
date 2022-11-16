Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D66C62B35C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbiKPGfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiKPGfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:35:12 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46499F599;
        Tue, 15 Nov 2022 22:35:11 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2AG6Ywqp008932;
        Wed, 16 Nov 2022 00:34:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1668580498;
        bh=TMq2Zg7xGsqnRqLN7tOz5WB3RI0L2+bFG3U6rxb2x/E=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=r2PJEdIUFQfMLSvFp7KuTk2j/tJro/7eBdHyeTBE43JGA1Pf+vUsZwVknhDgXCXJd
         ydC0ubMxTziGLRQfXvKVGzdK7HPpt732J7JNqZEvz+kaUZ4Cxxmfwpkkot5ag2nzHs
         ae9R4One7auahTs77CQLeEK8ZI6wAETYnh8Aov4o=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2AG6YweF090091
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Nov 2022 00:34:58 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 16
 Nov 2022 00:34:58 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 16 Nov 2022 00:34:58 -0600
Received: from [172.24.145.60] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2AG6YsKu050961;
        Wed, 16 Nov 2022 00:34:55 -0600
Message-ID: <952988dc-471b-ba2a-cad4-cf65d7290700@ti.com>
Date:   Wed, 16 Nov 2022 12:04:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arm64: dts: ti: j721e-common-proc-board: Fix sound
 node-name
Content-Language: en-US
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20220928122509.143342-1-j-choudhary@ti.com>
From:   Jai Luthra <j-luthra@ti.com>
In-Reply-To: <20220928122509.143342-1-j-choudhary@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/22 17:55, Jayesh Choudhary wrote:
> If root-node has no reg property, the unit-address should not
> be appended at the end of node-name. sound node has no 'reg'
> property, so remove the unit-address.
> 
> Fixes: ed3aad5b8268 ('arm64: dts: ti: j721e-common-proc-board: Analog audio support')
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>

Reviewed-by: Jai Luthra <j-luthra@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index b1691ac3442d..4da3fcdc28e5 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -96,7 +96,7 @@ vdd_sd_dv_alt: gpio-regulator-TLV71033 {
>   			 <3300000 0x1>;
>   	};
>   
> -	sound0: sound@0 {
> +	sound0: sound-0 {
>   		compatible = "ti,j721e-cpb-audio";
>   		model = "j721e-cpb";
>   

Thanks,
Jai
