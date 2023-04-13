Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF636E0C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjDMLcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjDMLbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:31:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39329EDE;
        Thu, 13 Apr 2023 04:31:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF1561515;
        Thu, 13 Apr 2023 11:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5E7C433EF;
        Thu, 13 Apr 2023 11:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681385509;
        bh=+kCqBuYlf/Kptktf9xAiEnZMG+m6PiC7fBrkkvhaGSM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HXR+6A3rfOYJkwGceEP1yXhHSj3XVyl1uF/VCXUx6zNVxLCrVHiyN3ReS6WnxuzCQ
         7gR4DLzfi1WQP+6mBZ7kPMhGNnEJJKnq7VjZqGwQw1y0UhGzobTdftvkpIpHlkUPEF
         qbGdurLMOMXRMY93PiEZh2/ZFLpnIfcfE00oulrtezl+Oez63ZE2RA5yQTYy3/PZBU
         LR7NUyiAXUI1erxChS/+XBeMG8JryJvYQC9m7yAqmlT+IWZx7rhQFXg+5pCoOFdg9D
         K6whkTI8in70R9C7GCCluFJdYMcHNb3LH76VCLGyhFpjWHp5+y9H0h8GBz4eImJDdG
         mZEkjOggpdUJQ==
Message-ID: <fdfe707e-7689-373a-3aa4-e81cfeac1562@kernel.org>
Date:   Thu, 13 Apr 2023 14:31:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 2/2] usb: dwc3: Support
 'snps,gadget-keep-connect-sys-sleep' feature
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com" <srk@ti.com>,
        "r-gunasekaran@ti.com" <r-gunasekaran@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230323021737.pv2nrb2md54a5pdg@synopsys.com>
 <624243b4-3fb5-6e60-e324-8df6b853205f@kernel.org>
 <20230323205139.4on6vx555ohdec7y@synopsys.com>
 <4d2f628e-6adc-5190-61b3-cc9d61f34a84@kernel.org>
 <20230403233652.2exkx2ikifuo4m6h@synopsys.com>
 <75db038b-ec7b-80e5-2652-8c5d2a9e317a@kernel.org>
 <20230404215317.44j2cl3uhzdk3aty@synopsys.com>
 <8884129b-8c73-df1e-e342-01defce0d407@kernel.org>
 <20230406013803.x2fp6c3wpvqtbues@synopsys.com>
 <a5993f55-36ea-a2b0-c715-652cdf6feef1@kernel.org>
 <20230412205927.win6wgv6yc4nqrzt@synopsys.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230412205927.win6wgv6yc4nqrzt@synopsys.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/2023 23:59, Thinh Nguyen wrote:
> On Wed, Apr 12, 2023, Roger Quadros wrote:
>>
>>
>> On 06/04/2023 04:38, Thinh Nguyen wrote:
>>> On Wed, Apr 05, 2023, Roger Quadros wrote:
>>>>
>>>>
>>>> On 05/04/2023 00:53, Thinh Nguyen wrote:
>>>>>
>>>>> I may have misunderstood your platform implementation. My understanding
>>>>> is that it can only detect VBUS and that it can only resume on VBUS
>>>>> valid.
>>>>>
>>>>> Does the "LINESTATE" here gets asserted if say there's a LFPS detection?
>>>>
>>>> Yes. The wake up logic on the SoC is snooping the UTMI lines from the PHY and on any
>>>> change it can detect and wake up the SoC.
>>>>
>>>
>>> Are you referring to the utmi_linestate signal? Isn't that for usb2
>>> speed only? Does your platform support usb3 speed?
>>
>> The wake-up on deepSleep feature is only supported for USB2 on this particular SoC.
>>
> 
> I mean can your platform operate in usb3 speed. If that's the case, then
> how do you plan to handle it here.

No, this SoC can only support up to USB2 speed.

> 
> Also, when you tested this in highspeed, did you observe successful
> resume? Or did the host have to perform a port reset?

I definitely didn't see a disconnect. Not sure about port reset.
I will check and get back.

cheers,
-roger
