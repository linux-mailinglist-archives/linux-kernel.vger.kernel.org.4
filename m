Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7204A6F68CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 12:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEDKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjEDKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 06:04:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E532D66
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 03:04:32 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1puVp0-0000Sz-0m; Thu, 04 May 2023 12:04:22 +0200
Message-ID: <7e585791-ed7b-80de-d1d7-7df54b7da442@pengutronix.de>
Date:   Thu, 4 May 2023 12:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module parameter
Content-Language: en-US
To:     Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg KH <greg@kroah.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "sboyd@kernel.org" <sboyd@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "abelvesa@kernel.org" <abelvesa@kernel.org>
References: <20230504085506.504474-1-peng.fan@oss.nxp.com>
 <2023050410-rejoin-vocation-8560@gregkh>
 <DU0PR04MB9417F9CBB5C9EE1FC85B10A2886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <b09998bc-9ff7-3a18-89af-9778521ab127@linaro.org>
 <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU0PR04MB941792F2EF3DB5ADB0B1A75A886D9@DU0PR04MB9417.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peng,

On 04.05.23 11:34, Peng Fan wrote:
 >> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年5月4日 17:31
>> To: Peng Fan <peng.fan@nxp.com>; Greg KH <greg@kroah.com>; Peng Fan
>> (OSS) <peng.fan@oss.nxp.com>; Rob Herring <robh+dt@kernel.org>;
>> krzysztof.kozlowski+dt@linaro.org
>> Cc: abelvesa@kernel.org; mturquette@baylibre.com; sboyd@kernel.org;
>> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
>> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>; linux-
>> clk@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>> parameter
>>
>> On 04/05/2023 11:17, Peng Fan wrote:
>>> + DT maintainers.
>>>
>>>> Subject: Re: [PATCH] clk: imx: imx93: introduce clk_bypassed module
>>>> parameter
>>>>
>>>> On Thu, May 04, 2023 at 04:55:06PM +0800, Peng Fan (OSS) wrote:
>>>>> From: Peng Fan <peng.fan@nxp.com>
>>>>>
>>>>> With the clk names specified in clk_bypassed module parameter, give
>>>>> user an option to bypass the clk from managing them by Linux kernel.
>>>>
>>>> As I said on another email, no, please do not add new module
>>>> parameters for drivers, this is not the 1990s
>>>
>>> ok, but this is for boot, so only DT could be considered.
>>>
>>> But DT is to describe hardware, here I just wanna give user an option
>>> to bypass some clocks. Is it ok to add a DT property saying
>>> "fsl,imx93-bypass-clks = <IMX93_CLK_X>, <IMX93_CLK_Y>" ?
>>>
>>
>> I don't know what it is to "bypass some clocks". This does not look like
>> parameter for system at all.
> 
> Currently the linux clk driver registers all the clocks and manage them.
> But when M33 is running, M33 may not wanna linux to manage
> some clocks M33 is using. So I wanna linux not register those clocks
> that M33 will use.

Describe the M33 in the DT, assign it the clocks it depends on and have
a driver bind to it that just claims the clocks in question to ensure
nothing else messes with it?

Cheers,
Ahmad

> 
> Thanks,
> Peng.
> 
>>
>> Best regards,
>> Krzysztof
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

