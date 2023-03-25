Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1C76C8E56
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 14:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCYNDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 09:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYNDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 09:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518C340DE;
        Sat, 25 Mar 2023 06:03:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DB48B8075C;
        Sat, 25 Mar 2023 13:03:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F6EC433EF;
        Sat, 25 Mar 2023 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679749391;
        bh=RzQArc2DTEQ6mlQA7QJSmpoVuSxWh581ekX4emLqCXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WSDwwZQ8F1QY49fvJD1R4IRm6YWs2lPAxe15jtzXq3XWQLXJKEb8jkg2Sfsu8e1K4
         n9oRmUlU0mzK8WUAOVpkri6TguT7u0B7pDUBG0sePnScp5RdmWhNiBabz4LqCfEvJU
         y2P8vBwC5rAdrkdjik3t6zauGQ9Wvuvp0eMxuuLp4DeNXTjlRrJRjZCZHrY0uanGh1
         S44GqjyA+/mzl1VRN34TLuKPCDH9HTs0+13YYmQLYEGQNKNiD7BJ9fxXzboLzcYQyo
         JCtuTBFPzEWjbQ1P8YtCSSaFihHotl7MmNpqFIQVHUFakLkMwQSFX24n7nwD7/A6tM
         6q5FRb6bBq4eg==
Message-ID: <42bbac46-782b-e2ac-67f3-37489e3a2047@kernel.org>
Date:   Sat, 25 Mar 2023 15:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider
 property to usbss1
To:     Nishanth Menon <nm@ti.com>
Cc:     vigneshr@ti.com, kristo@kernel.org, srk@ti.com,
        r-gunasekaran@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Dhruva Gole <d-gole@ti.com>
References: <20230324133150.43224-1-rogerq@kernel.org>
 <20230324133150.43224-2-rogerq@kernel.org>
 <20230324181435.i2n2q6cvh6x4kabw@repeal>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230324181435.i2n2q6cvh6x4kabw@repeal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/03/2023 20:14, Nishanth Menon wrote:
> On 15:31-20230324, Roger Quadros wrote:
>> From: Dhruva Gole <d-gole@ti.com>
>>
>> The property "ti,vbus-divider" is needed for both usbss0 and usbss1 as
>> both USB0 and USB1 have the same external voltage divider circuit.
>>
>> Signed-off-by: Dhruva Gole <d-gole@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  arch/arm64/boot/dts/ti/k3-am625-sk.dts | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> index 67dc26fc23e4..be027fad5f61 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
>> @@ -482,6 +482,7 @@ &usbss0 {
>>  
>>  &usbss1 {
>>  	status = "okay";
>> +	ti,vbus-divider;
>>  };
>>  
> 
> 1. Does'nt this need a fixes tag?
> 2. lakml is missing in CC

Will fix both issues.

> 
>>  &usb0 {
>> -- 
>> 2.34.1
>>
> 

cheers,
-roger
