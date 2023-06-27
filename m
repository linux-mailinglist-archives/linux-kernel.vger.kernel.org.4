Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B80C73F650
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjF0ICV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjF0ICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B169DCC;
        Tue, 27 Jun 2023 01:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EFA960B3A;
        Tue, 27 Jun 2023 08:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB57DC433C8;
        Tue, 27 Jun 2023 08:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687852937;
        bh=+w1BiHn4pQ8jxPhDsNA4ylZezJIvF+eBePq/65dqlcU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Z7Omo7cH5I9mN6niRio3gP2uE+2pojLf1s2NLK7geTb6uLOioYMpH3ZVb72T+RcQG
         4mIxnhf+AqEwFePtemkUBwnnXnujtB7fpLx+8lC2iPTHBFTNZQwCKmOxlyQqACZSnI
         2fFsB5FCsfusBQf2uRnTltQ4dPspVkw+CzwYOBjOvGkXC3olTeCNYX0kzE0LMQhkHu
         OCPKzLV7v3HkEKAGQg3TpVqs6+Wr7487BppBqYyL34yyZGwUv5VmlR2GZCnZvnMnk4
         aWYdhD0PxGae+0+2b0T2maTQrFxQ6zSbElhD7zzDsoyQ0fzSBcLSx0mozLUb/5rYBn
         pD1sSXzd+1p3Q==
Message-ID: <73aa50fd-2028-c492-59cd-b740a827e90c@kernel.org>
Date:   Tue, 27 Jun 2023 17:02:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
Content-Language: en-US
To:     Runa Guo-oc <RunaGuo-oc@zhaoxin.com>, linux-kernel@vger.kernel.org,
        linux-ide@vger.kernel.org
Cc:     CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, TonyWWang@zhaoxin.com,
        LeoLiu@zhaoxin.com, RunaGuo@zhaoxin.com
References: <1686901766-4928-1-git-send-email-RunaGuo-oc@zhaoxin.com>
 <ccabf88b-2e2c-876d-e47a-8d142e27d638@kernel.org>
 <70853f13-f74e-d9bb-89f7-4c804f1fa8a4@zhaoxin.com>
 <330d93ee-b4b6-2397-2b7c-eb4d99676f87@kernel.org>
 <b330e18d-4fd3-2649-aafd-4f941c111803@zhaoxin.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <b330e18d-4fd3-2649-aafd-4f941c111803@zhaoxin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/23 16:17, Runa Guo-oc wrote:
> On 2023/6/26 20:40, Damien Le Moal wrote:
>> On 6/26/23 20:29, Runa Guo-oc wrote:
>>> On 2023/6/16 16:34, Damien Le Moal wrote:
>>>> On 6/16/23 16:49, Runa Guo-oc wrote:
>>>>> [PATCH] ata:sata_zhaoxin: Add support for ZhaoXin Serial ATA
>>>>
>>>> Broken patch: the email subject is your SoB instead of the above line, which
>>>> should not be part of the message (it should be the subject). Please reformat
>>>> and resend.
>>>>
>>>
>>> Okay.
>>>
>>>>>
>>>>> Add ZhaoXin Serial ATA support for ZhaoXin CUPs.
>>>>
>>>> What is "ZhaoXin" ?
>>>
>>> Zhaoxin is a Chinese company that has mastered the core technology
>>> of independent general-purpose processors and its system platform chips,
>>> and is committed to providing users with efficient, compatible and secure
>>> independent general-purpose processors, chipsets and other products.
>>> for more information, you can visit here: https://www.zhaoxin.com/.
>>
>> A company marketing message is not very informative, technically speaking. What
>> is this chipset and on what board/machine can it be found ? That is the more
>> relevant information we need in this commit message.
>>
> 
> The reason why it is called Zhaoxin SATA is actually to express that it
> applies
> to all Zhaoxin support of its separate chipset/SOC, for example,
> ZX-100S/ZX-200
> chipsets.

That is fine. I do not need a reason for the name. what I would like to see is
information about which product/board/soc this driver will be needed for. So
something like the above is actually fine (may be a little more details if you
have).

> 
>>>
>>>> And what is "CUPs" ? Please spell this out.
>>>>
>>>
>>> Yes, this is  a spelling error.
>>>
>>>>>
>>>>> Signed-off-by: Runa Guo-oc <RunaGuo-oc@zhaoxin.com>
>>>>> ---
>>>>>  drivers/ata/Kconfig        |   8 +
>>>>>  drivers/ata/Makefile       |   1 +
>>>>>  drivers/ata/sata_zhaoxin.c | 384 +++++++++++++++++++++++++++++++++++++++++++++
>>>>>  3 files changed, 393 insertions(+)
>>>>>  create mode 100644 drivers/ata/sata_zhaoxin.c
>>>>>
>>>>> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
>>>>> index 42b51c9..ae327f3 100644
>>>>> --- a/drivers/ata/Kconfig
>>>>> +++ b/drivers/ata/Kconfig
>>>>> @@ -553,6 +553,14 @@ config SATA_VITESSE
>>>>>  
>>>>>  	  If unsure, say N.
>>>>>  
>>>>> +config SATA_ZHAOXIN
>>>>> +	tristate "ZhaoXin SATA support"
>>
>> Same here. If ZhaoXin is only a company name, we need also a chipset model to be
>> informative regarding which HW this driver serves.
>>
> 
> As mentioned before, the chipset models this driver serves  are ZX-100S
> and ZX-200
> currently.

Fine. Just say so in the Kconfig entry then.
If in the future your company produces a different chipset model that needs a
different driver, then the entries can be clearly differentiated even if they
use the same company name (ZhaoXin). E.g. "ZhaoXin ZX-100S and ZX-200 chipset
support" vs "ZhaoXin XYZ-newgen chipset support". Adding entries should not
require modifying existing entries.



-- 
Damien Le Moal
Western Digital Research

