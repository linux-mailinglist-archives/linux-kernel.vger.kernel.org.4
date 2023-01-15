Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C266B0EF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjAOMTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 07:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjAOMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 07:19:21 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F29EC6D;
        Sun, 15 Jan 2023 04:19:19 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30FCIvbc093084;
        Sun, 15 Jan 2023 06:18:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1673785137;
        bh=WwiyspyFAhYKeru234W+8COC3zKMA+SPlcgEVmFVMf0=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=AvzXOi4JIHD1q7TVK83vvlBQVOT0c7eaR2oMoxCZdEzPHfbmB4/vy8UH5Cru6L3YV
         fT3DcXBSDKujapy7mWvFxqAKZVkJ83l72zJrFn3hsMgMcFMnixQGYwotMrb8aVDTgD
         74jUE36gr+EuHmV0HD8R2Uytkzh29yYPuLxImA/Q=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30FCIvwS049538
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 15 Jan 2023 06:18:57 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 15
 Jan 2023 06:18:57 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 15 Jan 2023 06:18:57 -0600
Received: from [10.250.234.92] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30FCIrn9032045;
        Sun, 15 Jan 2023 06:18:54 -0600
Message-ID: <e06a7758-1245-4353-7d62-fd6dc40b3164@ti.com>
Date:   Sun, 15 Jan 2023 17:48:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RESEND PATCH V3 2/3] arm64: dts: ti: Add initial support for
 AM68 SK System on Module
Content-Language: en-US
To:     Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230110110052.14851-1-sinthu.raja@ti.com>
 <20230110110052.14851-3-sinthu.raja@ti.com>
 <d109dbf8-ba51-7322-34e7-f688c5a18908@ti.com>
 <CAEd-yTQ9eEz_Q6ncNP3vc9oerqiXfhrGK7DvsAnm21OZzYUe2w@mail.gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <CAEd-yTQ9eEz_Q6ncNP3vc9oerqiXfhrGK7DvsAnm21OZzYUe2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sinthu,

On 13/01/23 5:56 pm, Sinthu Raja M wrote:
>>> +     reserved_memory: reserved-memory {
>>> +             #address-cells = <2>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +
>>> +             secure_ddr: optee@9e800000 {
>>> +                     reg = <0x00 0x9e800000 0x00 0x01800000>;
>>> +                     alignment = <0x1000>;
>> Is alignment needed here?
> This is used to mention the address boundary. Removing this will
> affect memory allocation. Isn't so?

No memory is allocated out of this region. This is reserved region where
OPTEE runs and thus ought not to be touched by Linux. Please drop the
property.

>>
>> Please see https://lore.kernel.org/lkml/cd5dbbb0-2d9f-8d7d-b051-f8d01d710c62@ti.com/
>>
>>> +                     no-map;
>>> +             };
>>> +     };
>>> +};
>> --
>> Regards,
>> Vaishnav

Regards
Vignesh
