Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1BA69EC39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjBVBOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:14:10 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B9A4166CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:14:08 -0800 (PST)
Received: from [192.168.87.25] (unknown [50.35.78.176])
        by linux.microsoft.com (Postfix) with ESMTPSA id 33E7320B9C3D;
        Tue, 21 Feb 2023 17:14:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 33E7320B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677028447;
        bh=YTkfcoTrsyGUhPbAsJNW1hFtxJhcxATFUQJzQJ+E840=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=ksjWfUD7hL4lluKkN4pyotZAcfERPzfs3CXBvbcHi0Lo+wPjs33I5/pVstNjH2kls
         q0vfgIXT9nM0kXJiEpsfRXOeOPz9TtJ1UY3OuEK7kN2aV/k9BZrA2waNzRTCKhOztW
         1fe+pTK6b/qVT5wvs7gFyCbTFooPdzbctJdO2q/g=
Message-ID: <d0f8d17a-bdcb-7554-b96c-99226d013fe6@linux.microsoft.com>
Date:   Tue, 21 Feb 2023 17:14:07 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
 <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
 <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
 <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
 <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
 <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
In-Reply-To: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/2023 7:32 PM, Ryan Chen wrote:
>>>>> +  timeout:
>>>>> +    type: boolean
>>>>> +    description: Enable i2c bus timeout for master/slave (35ms)
>>>>> +
>>>>> +  byte-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use byte mode transmit
>>>>> +
>>>>> +  buff-mode:
>>>>> +    type: boolean
>>>>> +    description: Force i2c driver use buffer mode transmit
>>>>
>>>> These three aren't really a property of the hardware, more of the
>>>> intended driver configuration. Do they really belong in the DT?
>>>>
>>> Sorry, I am confused.
>>> This is hardware controller mode setting for each i2c transfer.
>>> So I add it in property for change different i2c transfer mode.
>>> Is my mis-understand the property setting?
>>
>> It depends what this is configuration is for.
>>
>> Would you set the transfer mode based on the design of the board? Is there
>> something about the physical i2c bus wiring (or some other hardware design
>> choice) that would mean you use one setting over another?
>>
> No, it not depend on board design. It is only for register control for controller transfer behave.
> The controller support 3 different trigger mode for transfer.
> Byte mode: it means step by step to issue transfer.
> Example i2c read, each step will issue interrupt then driver need trigger for next step.
> Sr (start read) | D | D | D | P
> Buffer mode: it means, the data can prepare into buffer register, then Trigger transfer. So Sr D D D P, only have only 1 interrupt handling.
> The DMA mode most like with buffer mode, The differ is data prepare in DRAM, than trigger transfer.
> 
> 

Unless these settings like xfer mode are per i2c bus, it could be just a
module parameter? Not sure anything other than default mode would be
used if DMA mode works for all master/slave transactions.

Regards,
Dhananjay


