Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3385B54B1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 08:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiILGpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 02:45:43 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C2B95B8;
        Sun, 11 Sep 2022 23:45:43 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-12803ac8113so20908547fac.8;
        Sun, 11 Sep 2022 23:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/OqphlDthIJI2RqLUN/nxefOOpSEEaymfSm7D+IizKA=;
        b=nmZKbEBaPNiUzzDffjbekwxrmm6YC3LMNFQudNLnTg36FnsIMg046qGljB1fzjZQ/t
         +96qzAfsUOl+iNvMHcT3DMr0I1XXrUVx5NCbN2uFS7gcREfadXL7XRZLlPXoNVaSedO3
         NNoYlmTI4lO72poCR/PAwBTcmGq1AsB9MMYFgTzZ3O8fjKUTL+uM+G+88U33hXONVY9F
         JB5a5WuyBTRSXSH/NEsvurSJW0+mHmIqfaVwHxf0b4eqVXri9RMbliZjfH7PkGD8+2mo
         ZtkxTIYHD8f3/3HEwKIHxZf64oTYmh5czEsl3o+IuqZZ8UQ2yLcSueuRopLLWTFhhW2j
         tzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/OqphlDthIJI2RqLUN/nxefOOpSEEaymfSm7D+IizKA=;
        b=gSh9tUv/jKrted1uv3+MNPtkblwUuE+QE7Fx9WEYQPiSrMk1QSEkze90PBZiG7oPoe
         BNRiTRv47y0Qc1t+Thku5ESBRhhseniN6qUi5GLoI0RWGXzzs8P+gzKLedulTxQKCchJ
         5XPyraPKe16xoAokWstz9V7Gyiowlosg2DQrN2yknPpObYUyZUz9S8LrWGYDfTngm4Dd
         HG8bRojjCnhu5zMmMnEtK8rgd1T4qzgR/xHdd2zxCDxQ0CXhAMVY7mcie8BLDPYa4945
         8Y/Z5qwuC1j21AAHP56CJb1zDNrN2w3YBOQV8X4RHGT55szeOKbrgt4CGLUsc4n4vOQL
         /rSw==
X-Gm-Message-State: ACgBeo2m0ukaTvQmzw/5ZF88M71deflQnb8YJ+x6f79jEZXmmkxb+4Vk
        4OGxOCNBKqTYWUd7ErkX1xY=
X-Google-Smtp-Source: AA6agR79MxHLd1nO4blkqAXiLWq78Jw+XI914wdGfM5RU4KVUAOF1DjVrQmr49w7Os+y248v4WofRw==
X-Received: by 2002:a05:6870:438a:b0:127:ad56:b751 with SMTP id r10-20020a056870438a00b00127ad56b751mr11584429oah.200.1662965142289;
        Sun, 11 Sep 2022 23:45:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:b5d7:d916:de6d:55a0? ([2600:1700:2442:6db0:b5d7:d916:de6d:55a0])
        by smtp.gmail.com with ESMTPSA id p21-20020a9d6955000000b0063b31e8f457sm4140337oto.75.2022.09.11.23.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 23:45:41 -0700 (PDT)
Message-ID: <3fcea82c-f5cf-f066-67b9-08669c44a9c6@gmail.com>
Date:   Mon, 12 Sep 2022 01:45:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] driver: of: overlay: demote message to warning
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Daniel Walker <danielwa@cisco.com>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, xe-linux-external@cisco.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220907230709.271889-1-danielwa@cisco.com>
 <973f7127-8165-45f6-071f-04360046b7d7@gmail.com>
 <20220908003510.GE4320@zorba>
 <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
In-Reply-To: <c0c66918-f55e-83e4-edea-b2d32fdb27a7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/22 12:55, Frank Rowand wrote:
> On 9/7/22 19:35, Daniel Walker wrote:
>> On Wed, Sep 07, 2022 at 06:54:02PM -0500, Frank Rowand wrote:
>>> On 9/7/22 18:07, Daniel Walker wrote:
>>>> This warning message shows by default on the vast majority of overlays
>>>> applied. Despite the text identifying this as a warning it is marked
>>>> with the loglevel for error. At Cisco we filter the loglevels to only
>>>> show error messages. We end up seeing this message but it's not really
>>>> an error.
>>>>
>>>> For this reason it makes sense to demote the message to the warning
>>>> loglevel.
>>>>
>>>> Cc: xe-linux-external@cisco.com
>>>> Signed-off-by: Daniel Walker <danielwa@cisco.com>
>>>> ---
>>>>  drivers/of/overlay.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
>>>> index bd8ff4df723d..4ae276ed9a65 100644
>>>> --- a/drivers/of/overlay.c
>>>> +++ b/drivers/of/overlay.c
>>>> @@ -358,7 +358,7 @@ static int add_changeset_property(struct overlay_changeset *ovcs,
>>>>  	}
>>>>  
>>>>  	if (!of_node_check_flag(target->np, OF_OVERLAY))
>>>> -		pr_err("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>> +		pr_warn("WARNING: memory leak will occur if overlay removed, property: %pOF/%s\n",
>>>>  		       target->np, new_prop->name);
>>>>  
>>>>  	if (ret) {
>>>
>>> NACK
>>>
>>> This is showing a real problem with the overlay.
>>
>> What's the real problem ?
>>
>> Daniel
> 
> A memory leak when the overlay is removed.
> 
> I'll send a patch to update the overlay file in Documumentation/devicetree/ to provide
> more information about this.  If you don't see a patch by tomorrow, feel free to
> ping me.
> 
> -Frank

The good news is that your question prodded me to start improving the in kernel documentation
of overlays.  The promised patch is a rough start at:

   https://lore.kernel.org/all/20220912062615.3727029-1-frowand.list@gmail.com/

The bad news is that what I wrote doesn't explain the memory leak in any more detail.
If an overlay adds a property to a node in the base device tree then the memory
allocated to do the add will not be freed when the overlay is removed.  Since it is
possible to add and remove overlays multiple times, the ensuing size of the memory
leak is potentially unbounded.

-Frank
