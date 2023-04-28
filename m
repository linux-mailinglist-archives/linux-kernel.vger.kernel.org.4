Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A906F1D8A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbjD1RmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjD1RmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:42:07 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6F1BE9;
        Fri, 28 Apr 2023 10:42:03 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33SHfgsv008889;
        Fri, 28 Apr 2023 12:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682703702;
        bh=fUQ0pH9+4PPXc0BGMj5rgXw9c/D5Gojx2+2bBBzLoLM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PHQEMjm+otPHmq+OGUKCOIDNdF3BL0HRoBMYcv41BCWd3eJ8cDzI4EKNcKJ/AL3fk
         B8OE43WlOEV+V2c27iBXvQe6IxC4O8uq9i2RBTXt1eIIEYhJKlpYyWwEjdK87PSjta
         DGg1X+6DsVR+GgssCmEKv13g18gIMld/l+ZvxWBA=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33SHfgOn035292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Apr 2023 12:41:42 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Apr 2023 12:41:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Apr 2023 12:41:42 -0500
Received: from [10.249.133.214] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33SHfdWw014488;
        Fri, 28 Apr 2023 12:41:40 -0500
Message-ID: <ac648da3-f782-0b01-145f-a767afcf0427@ti.com>
Date:   Fri, 28 Apr 2023 23:11:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Add pinmux information
 for ADC
Content-Language: en-US
To:     Bhavya Kapoor <b-kapoor@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
References: <20230412100949.850513-1-b-kapoor@ti.com>
 <20230412100949.850513-3-b-kapoor@ti.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <20230412100949.850513-3-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 3:39 PM, Bhavya Kapoor wrote:
> +
> +&tscadc0 {
> +	pinctrl-0 = <&mcu_adc0_pins_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	adc {
> +			ti,adc-channels = <0 1 2 3 4 5 6 7>;

Excessive indentation

> +	};
> +};
> +
> +&tscadc1 {
> +	pinctrl-0 = <&mcu_adc1_pins_default>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	adc {
> +			ti,adc-channels = <0 1 2 3 4 5 6 7>;

Same here

> +	};
> +};
