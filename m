Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B6603194
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbiJRR3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRR3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:29:34 -0400
Received: from smtpcmd0987.aruba.it (smtpcmd0987.aruba.it [62.149.156.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DB6A38B0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:29:31 -0700 (PDT)
Received: from [192.168.50.220] ([146.241.87.206])
        by Aruba Outgoing Smtp  with ESMTPSA
        id kqP9orvJLaWj1kqPAoCbei; Tue, 18 Oct 2022 19:29:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1666114169; bh=2R1Qx2v5j+cUhKJyPReXeVM3kkRyNKVJuTVaauBdp9A=;
        h=Date:MIME-Version:Subject:To:From:Content-Type;
        b=JI8QiS5clsPeOZ5Z35oTXgw7oDw+y5B8RIJGwZD91qzm4CEX8dkaysJCHn6TICCxK
         gq//3IPx6dHZM1R9cr5N7U9oAufIXWpzabRrBxz721YhQ8PQiLgMQ8FSLjPgP2OSWK
         +DGBKtFgutA4A7IGvQL9mwJTcSsad8oB2ZvckT2LYqr65dZD7IXGANsZptU3rZxWc9
         mvdd1eSo7XjgIHjSAerDUyU52zrF4bACYvoQoOSNuL1LHYj3ztyHtLVdF41X96mpbJ
         KsPuxZbRQWfTrx/7TeMEyRY5uwuV0GwljDufLHWAtA/1ISmrb6kJE6nC8WwEEJOX+0
         a233rxHKTZDyQ==
Message-ID: <de1957b5-ef9c-1f78-d2e6-b97a6f678b26@benettiengineering.com>
Date:   Tue, 18 Oct 2022 19:29:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 4/5] ARM: dts: imxrt1050: remove mmc max-frequency
 property
To:     Bough Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20221017235602.86250-1-giulio.benetti@benettiengineering.com>
 <20221017235602.86250-4-giulio.benetti@benettiengineering.com>
 <DB7PR04MB40100794ED12BA4224CD6B1B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
In-Reply-To: <DB7PR04MB40100794ED12BA4224CD6B1B90289@DB7PR04MB4010.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEYXM2XHTtUBYOG3z6wAwj/H7EJCvinaFe/k/4O7VAg8rd3dOA3DFPlrEFst6KA5MxSfopjrt38ZI2rC8DZYHIxoExerTUxu2ika8uAbdR6Xfv94SZXH
 xIRquoGlNPWaD5lhn6BEi9RXtMASMeO2ZxZtiBzjGH0QThzIAYqAGDleWQ1t9G7MBRyOeNk7ABRxflYHfiRh6qZ84TLpdIlAZSIGfMO3ieSojW+vs/xpPB+x
 HonI+o/3AyiSxhG9hKj88qv9Y5+sfHRpvNBH2RjHRltsVWeUnMsXAIz8Qxc6CXbJ2/eqmJJiroXa+0b9miT7jRAszV2bjiq8vzpItyQsltdbiNsX/loe4hQh
 Ft4gceRDDjV/TCVo0QfUC0FbKIgKZl0lmLe/vEXOsF/FwMYOS6e40ZukyxIRV457CjEmYckIpMCv21W/6uU1kd3ztqcHESdVyntFWT3DQFHmXfDadNiYzH93
 gx5PiG5j44buLfV09vegssOEAKRwaZy1H7HPQVxkMtxVtOEDT8zbdFLkQw0=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haibo,

On 18/10/22 05:01, Bough Chen wrote:
>> -----Original Message-----
>> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> Sent: 2022年10月18日 7:56
>> To: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
>> linux-kernel@vger.kernel.org; linux-clk@vger.kernel.org;
>> linux-mmc@vger.kernel.org
>> Cc: Stephen Boyd <sboyd@kernel.org>; Bough Chen <haibo.chen@nxp.com>;
>> Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson
>> <ulf.hansson@linaro.org>; Giulio Benetti
>> <giulio.benetti@benettiengineering.com>
>> Subject: [PATCH 4/5] ARM: dts: imxrt1050: remove mmc max-frequency
>> property
>>
>> According to i.MXRT1050 Reference Manual usdhc supports up to 208Mhz clock
> 
> Please double check this. As I know, the i.MXRT1050 and i.MX6/7/8/9 series use the same usdhc IP, maybe include some small difference.
> For the usdhc in i.MX6/7/8/9, I confirmed with IC team, the card clock output from usdhc can't be upper than 
200MHz, otherwise maybe meet some stable related issue.

Thanks for poiting, I've double checked and you're right. RM states 
208Mhz but DS states 200Mhz and it makes sense because of HS200.

> So here I think should change to like this:
>   max-frequency = <200000000>;

Ok, I'll send a V2 for this. I wait for other comments on the other 
patches for a bit before.

Best regards
-- 
Giulio Benetti
CEO/CTO@Benetti Engineering sas

> 
> Best Regards
> Haibo Chen
> 
> 
>> so let's remove max-frequency property in the .dtsi base file and in case add
>> that property in the board specific .dts file for a specific device connected to it.
>>
>> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
>> ---
>>   arch/arm/boot/dts/imxrt1050.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/imxrt1050.dtsi
>> b/arch/arm/boot/dts/imxrt1050.dtsi
>> index 114465e4dde6..0b44cc4ce6ad 100644
>> --- a/arch/arm/boot/dts/imxrt1050.dtsi
>> +++ b/arch/arm/boot/dts/imxrt1050.dtsi
>> @@ -93,7 +93,6 @@ usdhc1: mmc@402c0000 {
>>   			bus-width = <4>;
>>   			fsl,wp-controller;
>>   			no-1-8-v;
>> -			max-frequency = <4000000>;
>>   			fsl,tuning-start-tap = <20>;
>>   			fsl,tuning-step = <2>;
>>   			status = "disabled";
>> --
>> 2.34.1
> 

