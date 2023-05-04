Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC136F6AE6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEDMKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjEDMKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:10:37 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A820619F;
        Thu,  4 May 2023 05:10:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 344CAPEf053045;
        Thu, 4 May 2023 07:10:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683202225;
        bh=Dbu5qyYWZQkEinvxkuN7EfgdmcEyIwFauHLsvIRwG7s=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PfeCetWo1Q3ZLzsGOt6/5TLLgE/Zh6EYfhSqYfy49jF6lhhMBxmx6okKvRzW9nKy+
         Cgt7fibslRxKWqvth/0qmVCb/B1aT8fsFava88Y3K4bbNee6lB5qwR7L4CCT2HRCpx
         +YKH3L7yxxXim/QN0I1DXRgsFbORHKfG2mKw4uN4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 344CAPto123332
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 07:10:25 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 07:10:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 07:10:25 -0500
Received: from [172.24.147.77] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 344CAMPH035120;
        Thu, 4 May 2023 07:10:22 -0500
Message-ID: <67eccecb-f4a4-7f15-5316-27fd39e65b51@ti.com>
Date:   Thu, 4 May 2023 17:40:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and
 pinctrl node offsets
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
Content-Language: en-US
From:   Thejasvi Konduru <t-konduru@ti.com>
In-Reply-To: <20230504115207.h6trzy4mqjcbkcm3@comment>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/05/23 17:22, Nishanth Menon wrote:
> On 14:36-20230504, Thejasvi Konduru wrote:
>> On 03/05/23 17:16, Nishanth Menon wrote:
>>> On 14:01-20230503, Thejasvi Konduru wrote:
>>>> The wkup_pmx register region in j784s4 has multiple non-addressable
>>>> regions, hence the existing wkup_pmx region is split as follows to
>>>> avoid the non-addressable regions. The pinctrl node offsets are
>>>> also corrected as per the newly split wkup_pmx* nodes.
>>>>
>>>> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
>>>> wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
>>>> wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
>>>> wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
>>>>
>>>> Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
>>>> Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
>>>> ---
>>> Could you provide a link to the output of:
>>> $ cat /sys/kernel/debug/pinctrl/*/pins
>> https://gist.github.com/thejasvikonduru/05b1a8e0fd8176116b7a3cc4e43b244a
> Was this failing prior to this patch? Trying to understand the "Fix"
> aspect of this patch.
>
Yes,it was failing prior to this patch.

