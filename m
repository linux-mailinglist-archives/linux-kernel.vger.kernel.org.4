Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B56941ED
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBMJvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBMJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:50:59 -0500
Received: from uho.ysoft.cz (uho.ysoft.cz [81.19.3.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5790740E2;
        Mon, 13 Feb 2023 01:50:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
        s=20160406-ysoft-com; t=1676281849;
        bh=8vZk1o9104c9ygPKABn2oFT7aZ535Ok/goSwVuDQz2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BTTDAd/JTl+j9H90ut96FrTV9XUJCiQzOB0c441VKtLUPuyoueyvrw5fyVEXPvC0C
         3UBuRFeTPAXmlUIvN3ACO42zhr7+M1H0TxOKXJ5eX8rxwpKCLHba43DVq+2+0+Bwgy
         hPZ3QA8JyXUletJFG8oRPlM7isBQOnMtd5DhsxeY=
Received: from [10.1.8.111] (unknown [10.1.8.111])
        by uho.ysoft.cz (Postfix) with ESMTP id A2AEBA0307;
        Mon, 13 Feb 2023 10:50:49 +0100 (CET)
Message-ID: <04c606f8-97d2-5eeb-17cd-0337563f19b3@ysoft.com>
Date:   Mon, 13 Feb 2023 10:50:49 +0100
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
 <d1655d90-3939-3029-8473-aa6dc1bfede2@ysoft.com>
 <c08a0b99-a024-62b3-da2f-d2952e9ae130@linaro.org>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
In-Reply-To: <c08a0b99-a024-62b3-da2f-d2952e9ae130@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13. 02. 23 10:18, Krzysztof Kozlowski wrote:
>>>
>>> I don't think we add per-board maintainers. Otherwise, I have 50 more
>>> entries to add...
>>
>> I have got drawn into it by the checkpatch.pl script saying:
>>
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>>
>> So I went through the MAINTAINERS file and its git log with .dts related
>> changes. I found some individual board entries and quite recent changes
>> adding new ones. Hence I decided this could be right.
> 
> They are not right, but solution to that took some time:
> https://lore.kernel.org/all/829b122da52482707b783dc3d93d3ff0179cb0ca.camel@perches.com/
> 
OK, thank you for pointing that out!
Michal
