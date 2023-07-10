Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF09674DE4A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 21:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjGJTgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 15:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjGJTgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 15:36:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFE69E;
        Mon, 10 Jul 2023 12:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=G57jYXj1Ji0iT5iyYoY8A1yEd/HrN2vrlSnv00p329I=; b=1GhxJonC173IkB9jpEIY1dC/fp
        UpDhblN1/CL8Tnv7Lumuo8BHwoQjDzj/185aXuvHvTcS4q8Gi1DALtbrzqYhIhzFqyMrIuxzrSubh
        y2PDcOi2ZGjzrdchX5BRZuXmmkoWpA9PU7TwPFeDq5vMJGGanmt/2nCcfmoUdt/OsX73btmlQwMrN
        3pcCbHg7S0x0h7vNix8YN9lb/ylpDnUmHX2mPf7GqKyKQobNmxO0JrtUonC4T4iauv4QIpcm1qdZR
        CTXhHk/EXRdATlZthPocnKviLlmBtgCNo258QZHKHc0BkzSWlzLhdYEf4IrQhSQ8IeLXV+WwIBUbQ
        eD0IZ6Kw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qIwgh-00CZjw-2y;
        Mon, 10 Jul 2023 19:36:47 +0000
Message-ID: <54d4ec4c-09cb-57cc-cf9c-6b0374c96bec@infradead.org>
Date:   Mon, 10 Jul 2023 12:36:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230616181144.646500-1-pankaj.gupta@nxp.com>
 <20230616181144.646500-8-pankaj.gupta@nxp.com>
 <PAXPR04MB86384816166737DEE7FEE8EC9530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <PAXPR04MB86384816166737DEE7FEE8EC9530A@PAXPR04MB8638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/10/23 10:40, Pankaj Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Pankaj Gupta
>> Sent: Friday, June 16, 2023 6:13 PM
>> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
>> conor+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; dl-linux-imx <linux-
>> imx@nxp.com>; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; Gaurav Jain <gaurav.jain@nxp.com>; linux-
>> kernel@vger.kernel.org
>> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
>> Subject: [PATCH v3 7/7] MAINTAINERS: Added maintainer details
>>
>> MAINTAINERS: Added maintainer details for ele-mu driver.
>>
>> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
>> ---
>>  MAINTAINERS | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6992b7cc7095..21a7a5604436 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13536,6 +13536,15 @@ F:	mm/
>>  F:	tools/mm/
>>  F:	tools/testing/selftests/mm/
>>
>> +NXP Edgelock Enclave MU DRIVER
>> +M:	Pankaj Gupta <pankaj.gupta@nxp.com>
>> +R:	NXP Linux Team <linux-imx@nxp.com>
>> +L:	linux-kernel@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/arm/freescale/fsl,ele_mu.yaml
> 
> Accepted. Will correct in V4 patch.

Also please put it in the MAINTAINERS file in alphabetical order,
not where it is in this patch.
Thanks.

>> +F:	drivers/firmware/imx/ele*.*
>> +F:	include/linux/firmware/imx/ele*.*
>> +
>>  MEMORY TECHNOLOGY DEVICES (MTD)
>>  M:	Miquel Raynal <miquel.raynal@bootlin.com>
>>  M:	Richard Weinberger <richard@nod.at>
>> --
>> 2.34.1
> 

-- 
~Randy
