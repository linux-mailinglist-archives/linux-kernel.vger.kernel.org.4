Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2489A65AD03
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 05:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjABEGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 23:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABEG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 23:06:29 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B239C4F;
        Sun,  1 Jan 2023 20:06:28 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30246BC8033514;
        Sun, 1 Jan 2023 22:06:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672632371;
        bh=iXG6CpE0FyteKCqjf3jUE1+PPkoai/k/Qop8ovDpXFA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=JeAlxDcHTelQtJpdtkJ4pkO3cR/WW5YDRRX+P9khXZ9cM8gAY07o+CQWfGBq49iQZ
         AF5AUPASoughBhZkR996KBIoe3TSz6UuGAYmXsRvkFeesY4MewZfR/yKD3jqZno/iJ
         mxxskRWWPvzk+GweNbfWUYnHM+ssoWNQ2dosNItk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30246BDD115766
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 1 Jan 2023 22:06:11 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Sun, 1
 Jan 2023 22:06:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Sun, 1 Jan 2023 22:06:11 -0600
Received: from [172.24.145.182] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3024685N011388;
        Sun, 1 Jan 2023 22:06:09 -0600
Message-ID: <16827ba9-16d1-36f5-e98b-dc371d259035@ti.com>
Date:   Mon, 2 Jan 2023 09:36:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Content-Language: en-US
To:     Bryan Brattlof <bb@ti.com>, Dhruva Gole <d-gole@ti.com>
CC:     <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221227051208.158894-1-d-gole@ti.com>
 <20221230165511.7spk6cedrtm6nkv2@bryanbrattlof.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221230165511.7spk6cedrtm6nkv2@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dhruva

On 30/12/22 22:25, Bryan Brattlof wrote:
> On December 27, 2022 thus sayeth Dhruva Gole:
>> Fixes the clock Device ID's in the DT according to the tisci docs clock
>> identifiers for AM62x
>>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> ---
> 
> Good catch!
> 

Indeed

> Reviewed-by: Bryan Brattlof <bb@ti.com>
> 
> ~Bryan

This lacks Fixes: tag. Could you provide one?

-- 
Regards
Vignesh
