Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874C46007CD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 09:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJQHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 03:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJQHjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 03:39:00 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C35A89D;
        Mon, 17 Oct 2022 00:38:56 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29H7cbBG109981;
        Mon, 17 Oct 2022 02:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1665992317;
        bh=Pk+UEjoRsY3xQuFSEm9AvyFiq8RjjDxydn/Swb0yV7U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=XY/loqNFT4igBwPXj2W9qOXEVkgEOTXXUQGlatlHpoUPpO0ygm008oB6Ou0vT7kC9
         sG3s4IoayFpDQwu71nPBrc3665U/v2fbnG+goSoaYOjxo+lyuOL2DVZOY0YWR+Hgks
         KYzHL2UkFEVwtD1dqUs9bpnJXK0SFqViQBMiCqUY=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29H7cbBe100077
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Oct 2022 02:38:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Mon, 17
 Oct 2022 02:38:36 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Mon, 17 Oct 2022 02:38:36 -0500
Received: from [10.250.232.228] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29H7cYOC045523;
        Mon, 17 Oct 2022 02:38:35 -0500
Message-ID: <aed3cf8e-62d2-febe-8de9-24cec1eeafaf@ti.com>
Date:   Mon, 17 Oct 2022 13:08:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: Fix the debug print message
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <amitk@kernel.org>
CC:     <bb@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20221010034126.3550-1-j-keerthy@ti.com>
 <a1eaa937-dcfe-52d0-954b-3aaecedc1aa6@linaro.org>
From:   "J, KEERTHY" <j-keerthy@ti.com>
In-Reply-To: <a1eaa937-dcfe-52d0-954b-3aaecedc1aa6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/17/2022 1:02 PM, Daniel Lezcano wrote:
> On 10/10/2022 05:41, Keerthy wrote:
>> The debug print message to check the workaround applicability is 
>> inverted.
>> Fix the same.
>>
>> Fixes: ffcb2fc86eb7 ("thermal: k3_j72xx_bandgap: Add the bandgap 
>> driver support")
>> Reported-by: Bryan Brattlof <bb@ti.com>
>> Signed-off-by: Keerthy <j-keerthy@ti.com>
>> ---
> 
> Applied, thanks
> 
> BTW, Kheerty, if you have time is it possible to convert the 
> k3_bandgap.c with the pre-computed factors like the k3_j72xx_bandgap.c, 
> so both can be merged ?

Okay. I will try that out in a couple of weeks time.

Thanks,
Keerthy

> 
> 
> 
> 
