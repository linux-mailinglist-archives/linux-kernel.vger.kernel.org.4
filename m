Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2B6EF63A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241342AbjDZOT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241324AbjDZOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:19:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D57296;
        Wed, 26 Apr 2023 07:19:51 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33QEJiuM103529;
        Wed, 26 Apr 2023 09:19:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1682518784;
        bh=dPVgJKakw7a8dri1Y4NHYX7wzPJAx/833GrqYV5p7BI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=U3XdtGdTyMsIN10O9ra8UeEmzsSRyZ5WEWRLGPIKUz5nDqgXfGQZs44fnXXAwWIe4
         unPl6ZedfUwbSB7GQhEo62x/qNRr5G9YBJwYh8AEVhJutNtydfzNoKGJ4EdhO95DcP
         f6x/R5nVskPxA9web3Fzv8h+FjNvKcseLQo8EfRQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33QEJisI121180
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Apr 2023 09:19:44 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 26
 Apr 2023 09:19:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 26 Apr 2023 09:19:43 -0500
Received: from [10.249.130.34] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33QEJelk026091;
        Wed, 26 Apr 2023 09:19:41 -0500
Message-ID: <4c7361cf-5570-6a19-86a1-a2bc6c14c28c@ti.com>
Date:   Wed, 26 Apr 2023 19:49:39 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5/5] arm64: dts: ti: k3-j7200: Add bootph-pre-ram for
 u-boot
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <m-chawdhry@ti.com>, <n-francis@ti.com>
References: <20230426103219.1565266-1-u-kumar1@ti.com>
 <20230426103219.1565266-6-u-kumar1@ti.com>
 <20230426124848.2af7ombywlsqkbva@autistic>
From:   "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20230426124848.2af7ombywlsqkbva@autistic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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

Thanks Nishanth,

Thanks for review

On 4/26/2023 6:18 PM, Nishanth Menon wrote:
> On 16:02-20230426, Udit Kumar wrote:
>> Adding bootph-pre-ram property for pin mux needed by
>> uboot.
>>
>> [..]
>>   &main_pmx0 {
>>   	main_i2c0_pins_default: main-i2c0-pins-default {
>> +		bootph-pre-ram;
>>   		pinctrl-single,pins = <
>>   			J721E_IOPAD(0xd4, PIN_INPUT_PULLUP, 0) /* (V3) I2C0_SCL */
>>   			J721E_IOPAD(0xd8, PIN_INPUT_PULLUP, 0) /* (W2) I2C0_SDA */
>> -- 
>> 2.34.1
>>
> There are a bunch of other nodes that neeed bootph-pre-ram -> lets first
> ensure all the nodes needed for u-boot is present (esm is still in
> discussion) then add bootph-pre-ram and related ones in a follow on series.

sure, let's get esm and i2c (pmic one) get concluded,

after that will revisit this.


