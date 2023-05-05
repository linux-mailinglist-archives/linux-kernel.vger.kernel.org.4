Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1466F7C27
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 06:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjEEE6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 00:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEEE6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 00:58:34 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B399011638;
        Thu,  4 May 2023 21:58:32 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3454wFa2048574;
        Thu, 4 May 2023 23:58:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1683262695;
        bh=WklG4pAnry6i1rLG4oYj44YgT06cgpUR3UuOjVY5N/0=;
        h=Date:From:Subject:To:CC:References:In-Reply-To;
        b=b6W/tgBlPfUlMEl19Hd9rkbx1Z6PwzTWGk+tIsDmDdPzQ7XD0cfcuiHhElujshZe8
         WJcRppl31MDgH+cNZfjYDnW5CJIn+cAl2iJJjO/hntwk2quVrnSnAt5E/BORWWhxWr
         FiGEmaQj+tuZDOTcxpewR+EP/9ayw2deqWUo3nF4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3454wF28012494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 4 May 2023 23:58:15 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 May 2023 23:58:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 May 2023 23:58:15 -0500
Received: from [172.24.216.248] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3454w9GG070183;
        Thu, 4 May 2023 23:58:10 -0500
Message-ID: <a5871d79-573d-df74-36ad-07ae9b3b8807@ti.com>
Date:   Fri, 5 May 2023 10:28:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
From:   "Kumar, Udit" <u-kumar1@ti.com>
Subject: Re: [PATCH 1/1] arm64: dts: ti: k3-j721s2: Add reserved status in
 msmc
To:     Nishanth Menon <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <afd@ti.com>, <u-boot@lists.denx.de>, <n-francis@ti.com>,
        <u-kumar1@ti.com>
References: <20230503144706.1265672-1-u-kumar1@ti.com>
 <20230503144706.1265672-2-u-kumar1@ti.com>
 <20230503145107.e447yxvn5e6fmz4g@patronize>
Content-Language: en-US
In-Reply-To: <20230503145107.e447yxvn5e6fmz4g@patronize>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/3/2023 8:21 PM, Nishanth Menon wrote:
> On 20:17-20230503, Udit Kumar wrote:
>> Mark atf, l3-cache and tifs node as reserved.
> why? (I am not reading the cover-letter for a 1 patch)


My bad , I should have description in patch itself.

Thanks


> [...]
>> 2.34.1
>>
