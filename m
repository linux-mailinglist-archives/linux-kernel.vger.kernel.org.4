Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4FB7243C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 15:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238062AbjFFNJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 09:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbjFFNJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:09:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5855810C0;
        Tue,  6 Jun 2023 06:08:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356D8EN6102247;
        Tue, 6 Jun 2023 08:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686056894;
        bh=br8C969Tk/Q3upf8dFCWCpzUM36C2jIPTueuAaa4o/c=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=LMg/8LauN8UGZLpxQBK5C1p/Nm9WnAWvcGLddSYkPk7bYcn4gUOJZqyIjmmgVuKPV
         F18PhjuqMgsRzNDXxaTP5ZXFB3UZfBJ2cg/IXUQXyBh0ek9syiwRGU8/DTJPlqcT5H
         449OBvDKKJreEusfMYYmDuBDpACFsTAOGHqzAy2M=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356D8EUQ019053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 08:08:14 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 08:08:14 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 08:08:14 -0500
Received: from [10.249.141.75] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356D8AhN006614;
        Tue, 6 Jun 2023 08:08:11 -0500
Message-ID: <97d14e4a-956c-790f-f3e3-ec8174a9f0b1@ti.com>
Date:   Tue, 6 Jun 2023 18:38:10 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH 4/7] arm64: dts: ti: k3-j7200-mcu: Add mcu_secproxy
To:     Nishanth Menon <nm@ti.com>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nitin Yadav <n-yadav@ti.com>, Andrew Davis <afd@ti.com>,
        <u-kumar1@ti.com>
References: <20230530165900.47502-1-nm@ti.com>
 <20230530165900.47502-5-nm@ti.com>
 <e25936b9-d85c-dfe8-0eb1-07b51fdfff1e@ti.com>
 <20230531173906.zznrzuxfytk5feun@spied>
Content-Language: en-US
In-Reply-To: <20230531173906.zznrzuxfytk5feun@spied>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/31/2023 11:09 PM, Nishanth Menon wrote:
> On 22:37-20230531, Kumar, Udit wrote:
> [...]
>>> +	secure_proxy_mcu: mailbox@2a480000 {
>> I think, we should start name as  mailbox@2a380000
>>> +		compatible = "ti,am654-secure-proxy";
>>> +		#mbox-cells = <1>;
>>> +		reg-names = "target_data", "rt", "scfg";
>>> +		reg = <0x0 0x2a480000 0x0 0x80000>,
>>> +		      <0x0 0x2a380000 0x0 0x80000>,
>>> +		      <0x0 0x2a400000 0x0 0x80000>;
>> I think, we should have increasing order for reg. Unless there is some
>> strong reason to keep in this way.
> Binding is defined this way - the items section in the binding
> enforces the order. As a result the first reg entry(target_data)
> address causes the node name.


Ok thanks, u boot defined in other way but i don't see problem post sync,

As u-boot driver is getting node address based upon name instead of index.


Reviewed-by: Udit Kumar <u-kumar1@ti.com>

