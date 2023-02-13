Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 286ED694061
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjBMJI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMJIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:08:54 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A1013D64;
        Mon, 13 Feb 2023 01:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676279329;
        bh=qdU/D2icOVYlplHPyGGi5hbnN1YkuKAfnCgDgcnmqvc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cJqMhMh106QjPnPFfBBHblUACC7baU7Wt39kApm+Fc2aBDAxpEsG27ZTEgyYpbgds
         K2EhFcdPiiM/6rCyxjZ7hvWVg7iawxxydq3cXrlnZEygezv+4BTttiCzPTeDxxYCwP
         DQic4DdyTPUczFCD1nNrP/6LqGnXVry6gyst490g=
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id EC3DFA01E0;
        Mon, 13 Feb 2023 10:08:48 +0100 (CET)
Message-ID: <d1655d90-3939-3029-8473-aa6dc1bfede2@ysoft.com>
Date:   Mon, 13 Feb 2023 10:08:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_6/6=5d_MAINTAINERS=3a_Add_Michal_Vok=c3=a1?=
 =?UTF-8?Q?=c4=8d_as_yapp4_boards_maintainer?=
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-7-michal.vokac@ysoft.com>
 <63e954f4-4e93-9211-9fb3-750976d8c4b6@linaro.org>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <63e954f4-4e93-9211-9fb3-750976d8c4b6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11. 02. 23 12:46, Krzysztof Kozlowski wrote:
> On 10/02/2023 16:48, Michal Vokáč wrote:
>> Number of the boards is continually growing and we expect more to come.
>> Add myself as a maintainer of the yapp4 (ysoft appliance v4) platform to
>> state that we do take care about all of these.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   MAINTAINERS | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fb1471cb5ed3..4d4d9ffc700c 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -23005,6 +23005,12 @@ S:	Maintained
>>   F:	Documentation/input/devices/yealink.rst
>>   F:	drivers/input/misc/yealink.*
>>   
>> +YSOFT IOTA BOARD SUPPORT
>> +M:	Michal Vokáč <michal.vokac@ysoft.com>
>> +L:	devicetree@vger.kernel.org
>> +S:	Supported
>> +F:	arch/arm/boot/dts/imx6*-yapp4*
> 
> I don't think we add per-board maintainers. Otherwise, I have 50 more
> entries to add...

I have got drawn into it by the checkpatch.pl script saying:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

So I went through the MAINTAINERS file and its git log with .dts related
changes. I found some individual board entries and quite recent changes
adding new ones. Hence I decided this could be right.

Never mind, I agree there is definitely not a maintainer entry for every
board supported by the kernel and this patch can be omitted.

Thank you and best regards,
Michal
