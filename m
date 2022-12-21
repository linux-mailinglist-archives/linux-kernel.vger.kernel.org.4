Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C186532A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 15:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiLUOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 09:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLUOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 09:50:08 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07BFA45E;
        Wed, 21 Dec 2022 06:50:07 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BLEnjlI003482;
        Wed, 21 Dec 2022 08:49:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671634185;
        bh=Qy6nAhVmWuLn4p6S2HpHuobM2pcieOmiAbQ2FsESWHU=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PGgJPQeRGgQDHdX/B5h+sjXYDMBwdSS4x4GhEtiFa9tm0De0rcCaVFdoZ6WUWVi9y
         dIpnNz38dzsCXtmv1Qc+HuSfc+m4LlUo63Xkasq9Dz69Lr9yE263jsikg0G0RhtH2E
         MSxDjtEnukpky4u6x4pILdUYNay7EDhNQy0Io+Iw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BLEnjt9016463
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Dec 2022 08:49:45 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 21
 Dec 2022 08:49:45 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 21 Dec 2022 08:49:45 -0600
Received: from [10.250.235.211] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BLEnfNg068702;
        Wed, 21 Dec 2022 08:49:42 -0600
Message-ID: <37fa237a-1115-e476-2a50-70a09d89d877@ti.com>
Date:   Wed, 21 Dec 2022 20:19:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] Improve K3-am625-sk support (USB, MMC)
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <martyn.welch@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221216143624.23708-1-sjoerd@collabora.com>
 <d882df13-33e6-db53-e59e-53419db4255d@ti.com>
 <8d874a1bb2ba974cdaed5fe47c1b92c76ac3e364.camel@collabora.com>
From:   "Raghavendra, Vignesh" <vigneshr@ti.com>
In-Reply-To: <8d874a1bb2ba974cdaed5fe47c1b92c76ac3e364.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sjoerd

On 12/20/2022 6:11 PM, Sjoerd Simons wrote:
> Hey Vignesh,
> 
> On Tue, 2022-12-20 at 17:02 +0530, Vignesh Raghavendra wrote:
>> Hi,
>>
>> On 16/12/22 8:06 pm, Sjoerd Simons wrote:
>>>
>>> This series picks up a few patches from the TI BSP tree that
>>> unfortunately didn't make it upstream thusfar.
> ...
>>> 0:
>>> https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/
>>>
>>>
>> Really appreciate porting and posting these patches to mainline!
>> Wondering what tree are these patches based on?
>> I cannot apply cleanly on linux-next.
> 
> These are against Linux 6.1 ; I'll happy rebase agains next for the
> next round or is there a specific tree you prefer to base against?
> 

TI K3 patch queue is at:
https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git ti-next

This is part of linux-next. So, yes, I would like all patches to be
based on -next or above tree.

I see you have already done that in v2.. Thanks!

Regards
Vignesh
