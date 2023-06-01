Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAEAB719B1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjFALtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFALtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:49:18 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07CD129;
        Thu,  1 Jun 2023 04:49:16 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 351Bn0N7025725;
        Thu, 1 Jun 2023 06:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1685620140;
        bh=1AgyYwFTyh3L8MGDOaJ940Fe09PyF2HGWDtN+2rsesE=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=R0ncVuNx1mKz4Grfo3pZDdz5qPDgvellBY+AnwjIiWd3Ed9Zl1DDTqP8s22x2hUwt
         zFxUTZMInccJHpwg08fAe8yV9cRBYVTCnik7U4eQCqqCbDh+hQLEl/vM9JmrTGBhLC
         v86OZsYosmdYzVdCY5ate08XkMulzwNQ9l2Z1yGY=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 351Bn0Tp116576
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Jun 2023 06:49:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Jun 2023 06:49:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Jun 2023 06:49:00 -0500
Received: from [172.24.147.77] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 351Bmufi112293;
        Thu, 1 Jun 2023 06:48:57 -0500
Message-ID: <4aee3a8f-66ff-387b-73a1-31fc16eb7ffc@ti.com>
Date:   Thu, 1 Jun 2023 17:18:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and
 pinctrl node offsets
From:   Thejasvi Konduru <t-konduru@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis <afd@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Apurva Nandan <a-nandan@ti.com>, Udit Kumar <u-kumar1@ti.com>
References: <20230503083143.32369-1-t-konduru@ti.com>
 <20230503114625.gqnijd3bog5bwemz@parameter>
 <31b31af7-6c54-7d05-f7ef-fcceba48580e@ti.com>
 <20230504115207.h6trzy4mqjcbkcm3@comment>
 <67eccecb-f4a4-7f15-5316-27fd39e65b51@ti.com>
 <20230504142239.hqhni2c52k3a3asz@prune>
 <efab17de-aeb4-9fdb-6c97-ab2f2bc8c8f4@ti.com>
Content-Language: en-US
In-Reply-To: <efab17de-aeb4-9fdb-6c97-ab2f2bc8c8f4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SCC_BODY_URI_ONLY,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/23 15:19, Thejasvi Konduru wrote:
>
> On 04/05/23 19:52, Nishanth Menon wrote:
>> On 17:40-20230504, Thejasvi Konduru wrote:
>>> On 04/05/23 17:22, Nishanth Menon wrote:
>>>> On 14:36-20230504, Thejasvi Konduru wrote:
>>>>> On 03/05/23 17:16, Nishanth Menon wrote:
>>>>>> On 14:01-20230503, Thejasvi Konduru wrote:
>>>>>>> The wkup_pmx register region in j784s4 has multiple non-addressable
>>>>>>> regions, hence the existing wkup_pmx region is split as follows to
>>>>>>> avoid the non-addressable regions. The pinctrl node offsets are
>>>>>>> also corrected as per the newly split wkup_pmx* nodes.
>>>>>>>
>>>>>>> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
>>>>>>> wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
>>>>>>> wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
>>>>>>> wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
>>>>>>>
>>>>>>> Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for 
>>>>>>> J784S4 SoC")
>>>>>>> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
>>>>>>> ---
>>>>>> Could you provide a link to the output of:
>>>>>> $ cat /sys/kernel/debug/pinctrl/*/pins
>>>>> https://gist.github.com/thejasvikonduru/05b1a8e0fd8176116b7a3cc4e43b244a 
>>>>>
>>>> Was this failing prior to this patch? Trying to understand the "Fix"
>>>> aspect of this patch.
>>>>
>>> Yes,it was failing prior to this patch.
>>>
>> next time some asks this question - give summary AND give a log. Even
>> better, please don't make folks even ask the question in the first
>> place by including the logs in the diffstat of the patch.
>>
>> Please share the log to understand what kind of "failure" was occurring.
>
> Link to logs:
> Before Fix: 
> https://gist.github.com/thejasvikonduru/e217edf4839c348793a5671aa9331595
> After Fix : 
> https://gist.github.com/thejasvikonduru/05b1a8e0fd8176116b7a3cc4e43b244a
>
Are these logs fine and can we go forward with this patch?
