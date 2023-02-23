Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A4A6A06E7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233880AbjBWLBX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Feb 2023 06:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233767AbjBWLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:01:18 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901A52DE8;
        Thu, 23 Feb 2023 03:01:10 -0800 (PST)
X-QQ-mid: bizesmtp91t1677150009tl48xxbe
Received: from [192.168.3.2] ( [111.196.135.79])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Feb 2023 19:00:05 +0800 (CST)
X-QQ-SSF: 01200000000000C0E000000A0000000
X-QQ-FEAT: uGhnJwy6xZLF01U1t+tFV9zPAyRY0eXljRPN2ey2sbDXH52lPbRzrCAGz4oVU
        qxcrrmc16EfqtarwuNQFItaXMsIJMgPr/C6Yw3K4BJTSLJOYqGiS5uQyYBbGWDyBpW+MiKm
        +p9JwoMPgOekqeMveePon8ZY84gjtlov48nQOlGWYURF8RFrlSiDMw4hOcqguT7DhrDRjoB
        nTFM3SU6lbgHrxH1VmmesFi79iO8ley7MoykT6DL+PkQh/86WHUp+RHHrl6aQQuqG2eF67Q
        rx1XpCglAwzJD2ifDzwvk6YhoomEKwM4u9m5t6Mq8SpuWj1AtA2jQbeu7SajGr8giouAj18
        vVoNtHDrQLcZh0YHtlJQjqm/npf2jLl874XGnGMF6vXwTq0follZg/5wa3iFw==
X-QQ-GoodBg: 0
From:   "Bin Meng" <bmeng@tinylab.org>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm: Drop CONFIG_MTD_M25P80 in various defconfig files
Cc:     andrew <andrew@lunn.ch>, agross <agross@kernel.org>,
        arnd <arnd@arndb.de>, andersson <andersson@kernel.org>,
        "chuck.lever" <chuck.lever@oracle.com>,
        dinguyen <dinguyen@kernel.org>, festevam <festevam@gmail.com>,
        "gregory.clement" <gregory.clement@bootlin.com>,
        "jernej.skrabec" <jernej.skrabec@gmail.com>,
        "konrad.dybcio" <konrad.dybcio@linaro.org>,
        linux-imx <linux-imx@nxp.com>,
        "neil.armstrong" <neil.armstrong@linaro.org>,
        kernel <kernel@pengutronix.de>, elliott <elliott@hpe.com>,
        linux <linux@armlinux.org.uk>,
        "s.hauer" <s.hauer@pengutronix.de>,
        "sebastian.hesselbarth" <sebastian.hesselbarth@gmail.com>,
        shawnguo <shawnguo@kernel.org>,
        newbie13xd <newbie13xd@gmail.com>,
        "sudeep.holla" <sudeep.holla@arm.com>, ziy <ziy@nvidia.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Date:   Thu, 23 Feb 2023 11:00:05 +0000
Message-Id: <em4f9482cc-1919-4f29-92a5-41ba5f6c3bb3@1adcb789.com>
In-Reply-To: <e6d97e34-0c63-019d-93b6-c39e722d1d8c@linaro.org>
References: <20230210093224.689990-1-bmeng@tinylab.org>
 <em4fed7efe-b8aa-4a34-86d4-655b0a96fec0@1adcb789.com>
 <e6d97e34-0c63-019d-93b6-c39e722d1d8c@linaro.org>
Reply-To: "Bin Meng" <bmeng@tinylab.org>
User-Agent: eM_Client/9.2.1577.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvr:qybglogicsvr3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/2/23 18:50:36, "Krzysztof Kozlowski" 
<krzysztof.kozlowski@linaro.org> wrote:

>On 23/02/2023 11:46, Bin Meng wrote:
>>  On 2023/2/10 17:32:24, "Bin Meng" <bmeng@tinylab.org> wrote:
>>
>>>  Drop CONFIG_MTD_M25P80 that was removed in
>>>  commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>>>
>>>  Signed-off-by: Bin Meng <bmeng@tinylab.org>
>>>
>>>  ---
>>>
>>>   arch/arm/configs/axm55xx_defconfig     | 2 +-
>>>   arch/arm/configs/davinci_all_defconfig | 1 -
>>>   arch/arm/configs/dove_defconfig        | 1 -
>>>   arch/arm/configs/keystone_defconfig    | 1 -
>>>   arch/arm/configs/mvebu_v5_defconfig    | 1 -
>>>   arch/arm/configs/mxs_defconfig         | 1 -
>>>   arch/arm/configs/pxa_defconfig         | 1 -
>>>   arch/arm/configs/qcom_defconfig        | 1 -
>>>   arch/arm/configs/socfpga_defconfig     | 1 -
>>>   9 files changed, 1 insertion(+), 9 deletions(-)
>>>
>>>
>>
>>  Ping?
>
>No need for pinging, but you need to send to soc folks. Otherwise no one
>will pick it up. You will get the address from get_maintainer.pl -f
>arch/arm/boot/dts/Makefile (yes, it is quite hidden on purpose).

Yeah I used the script to generate the cc list.

Let me know if I need to split this patch into several ones (per-soc a 
patch) so that each soc maintainer only picks up their own?

Regards,
Bin
