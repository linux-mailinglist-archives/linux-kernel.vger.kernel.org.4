Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09266940B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjBMJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjBMJSa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:18:30 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01256144BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:18:21 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id bu23so11367763wrb.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:18:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rw3yM/szOw/a3KA8gGCW3Q7ogoGf9YnFkxpevgNujAk=;
        b=Ppz2HA3/vAmCK9kHhgM2Wfr+rBkRq2dSP+5stc7+CY/ydgB3SSE7QBARDCd+evDO03
         ksAioEDaIzxoXLOaDo07GV8orEKvNb+wf7Pzo4tNXkLUEeupEhE0Zh7kFevihfwgzMws
         FwIFr8aNpjPxLIeBxHYZOYZtJGX+j9JdLhDFCrhst+Jl+jCMDrm51oGqOzwTNXzBobck
         DIXCCvpGKqbxSx2iY9mFaq34WkpBKbgiHaRsU2rq1eaFW8yFQOnV8MVDEP/kcRRGh6w0
         gcpnrlcGikhA/oIbIBZlb9c6I4DWfDW5XsUKBiWAlxvUhR3xE9d5tqfa7rnFkG61sO2Q
         45aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rw3yM/szOw/a3KA8gGCW3Q7ogoGf9YnFkxpevgNujAk=;
        b=FpLY3EVJy4lz+d9avLPfSETImHrz3/8DCoftTSTjwr/0fNIw4NLL/W+X7p2RyI4OCT
         QXFBiNsvbsLBUW+5eeA83PoMX9OMspbvK3rXQpPAv16lPlA2WWZnfQn9riW0n1hdCINt
         xL2zmH+bBaeos8Di1i7nTqPuxmaK+MT5GNGLNIwSUa+x/AkXLEpY8A1S6FAlu92/PCXB
         QYnuNcR3hR1A6R1YNzUW6Yy39H701Is9nGq/jttInxfab3hW95Ti9F21y2agz0+pj+Yr
         a0aww/oIAlC/4tjseWlHS+1a9d6d4cllw/ID2NYmOECe5hwaTOjo0jDau7eSvVVsZmUs
         cWLw==
X-Gm-Message-State: AO0yUKWj/WHdHaMnAMZfktSkupuTnIl3AiR86PEsFx0EcyDejPPUoBMy
        04R7WavA6Tc0+twjdkSCZB2JPw==
X-Google-Smtp-Source: AK7set+mbms7Sfrm5IC13dc1FsrrrbuPKWPMHnaga0s9yOvgGWUErFhVJYZOKqvucdSFplL2f/xVwQ==
X-Received: by 2002:adf:db4f:0:b0:2c5:4f41:d1c1 with SMTP id f15-20020adfdb4f000000b002c54f41d1c1mr5376057wrj.38.1676279900601;
        Mon, 13 Feb 2023 01:18:20 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dc4480df80sm18305710wms.34.2023.02.13.01.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:18:20 -0800 (PST)
Message-ID: <c08a0b99-a024-62b3-da2f-d2952e9ae130@linaro.org>
Date:   Mon, 13 Feb 2023 10:18:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_6/6=5d_MAINTAINERS=3a_Add_Michal_Vok=c3=a1?=
 =?UTF-8?Q?=c4=8d_as_yapp4_boards_maintainer?=
Content-Language: en-US
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
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
 <d1655d90-3939-3029-8473-aa6dc1bfede2@ysoft.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d1655d90-3939-3029-8473-aa6dc1bfede2@ysoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 10:08, Michal Vokáč wrote:
> On 11. 02. 23 12:46, Krzysztof Kozlowski wrote:
>> On 10/02/2023 16:48, Michal Vokáč wrote:
>>> Number of the boards is continually growing and we expect more to come.
>>> Add myself as a maintainer of the yapp4 (ysoft appliance v4) platform to
>>> state that we do take care about all of these.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>>   MAINTAINERS | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index fb1471cb5ed3..4d4d9ffc700c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -23005,6 +23005,12 @@ S:	Maintained
>>>   F:	Documentation/input/devices/yealink.rst
>>>   F:	drivers/input/misc/yealink.*
>>>   
>>> +YSOFT IOTA BOARD SUPPORT
>>> +M:	Michal Vokáč <michal.vokac@ysoft.com>
>>> +L:	devicetree@vger.kernel.org
>>> +S:	Supported
>>> +F:	arch/arm/boot/dts/imx6*-yapp4*
>>
>> I don't think we add per-board maintainers. Otherwise, I have 50 more
>> entries to add...
> 
> I have got drawn into it by the checkpatch.pl script saying:
> 
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> So I went through the MAINTAINERS file and its git log with .dts related
> changes. I found some individual board entries and quite recent changes
> adding new ones. Hence I decided this could be right.

They are not right, but solution to that took some time:
https://lore.kernel.org/all/829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com/

> 
> Never mind, I agree there is definitely not a maintainer entry for every
> board supported by the kernel and this patch can be omitted.


Best regards,
Krzysztof

