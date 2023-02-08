Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15668ED35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjBHKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBHKpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:45:19 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47DA93F6;
        Wed,  8 Feb 2023 02:45:18 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id eq11so19821927edb.6;
        Wed, 08 Feb 2023 02:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RfQJVoDpp53Spswv7FcdMIifhn6yPvTxoUHHpA992iU=;
        b=fOB79nWDRKyjTj6hwehY0vyJ6SzLwPUCH3HNwrVxMCaWpaLrUksVVdTTqe9AOu/Y8K
         /acwY1GbCwQASaSnaEn6fgli9/FZrjaVZVE9BXf+IhIRoEDBaBI6D9v5TK/PmGbam+qy
         pbGHjMdxu0TNxiXX0ShlyERy3JuPCHZi/MXa4VAa5pKSUG/Zqc0aKlquILlPf/35Ph97
         rHBRYdH4PdMEuiSqq2QdOWUU1BFatvI6B92xD0Ol/nnP5Gzbtj1VdchsSg6ym4oty7mT
         NritxWoSHHMvRpeVIIN4ikKG4LDxMVwLsFt9H2i7jQ1qATTlGVS4v0Yom6ysB1YM3dZ5
         f0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RfQJVoDpp53Spswv7FcdMIifhn6yPvTxoUHHpA992iU=;
        b=xZO2zTjdnnggV8v8J1koDWJbBwLfyS8UjO18BIGMwTjolLeCUS0RAAvDU/YfSwkV49
         BSlk+gejaIwe6jez0p4TsHnuVZka8uTb9MrglsdE/zHSnyCgclIapg855TLW1i6Anh2Z
         s3GeIKiTOCoUdyKf34sWamUKFRkp7+hn0Tc3Q/DvlyK854av8LuHw09QrA/lij+cwZ6z
         8DXDHwnphZMRLgyIUbla0cjX4cbJPIAU/mI//ZPNj8Q7rd/jH6GlLMXeVbxqKSED626b
         qB+gTXSWzi4wdHzt86aQzAyloQeuVoQ9/moC2ciiBnxOrnLvr3k96tCcC+HSv5kgrWYM
         /QHg==
X-Gm-Message-State: AO0yUKVKX+1gWU6bI47X5BMwq4l6AZy341upNCVkAcTqZHQEia2JAPgh
        Zer14w5AkKvhl5fh6sB8BJU=
X-Google-Smtp-Source: AK7set9/vnzvUmJrUGg6dhm7bt4UYcIMTdZ896Tssshddyq3Xq5FaSCqufz7wVdpJMFmXO3rtC8Mgg==
X-Received: by 2002:a50:d55d:0:b0:497:233d:3ef5 with SMTP id f29-20020a50d55d000000b00497233d3ef5mr7334716edj.23.1675853117362;
        Wed, 08 Feb 2023 02:45:17 -0800 (PST)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id x91-20020a50bae4000000b0049b58744f93sm5935024ede.81.2023.02.08.02.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:45:16 -0800 (PST)
Message-ID: <e3ee64da-e8d9-ba8d-f4d4-f166b7ca825f@gmail.com>
Date:   Wed, 8 Feb 2023 11:45:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [PATCH v3 2/2] nvmem: brcm_nvram: use bcm47xx buffered data
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Willem-Jan de Hoog <wdehoog@exalondelft.nl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1675717472.git.wdehoog@exalondelft.nl>
 <e179c12f73a6035690e814b842f677bbb38f5c96.1675717472.git.wdehoog@exalondelft.nl>
 <0496ff17-0a02-1192-3c9a-412656a38b6a@gmail.com>
 <2e2ff1ec-34a9-db77-64d2-c088e5f1a13d@arinc9.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <2e2ff1ec-34a9-db77-64d2-c088e5f1a13d@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.02.2023 11:29, Arınç ÜNAL wrote:
> On 8.02.2023 13:25, Rafał Miłecki wrote:
>> On 7.02.2023 09:42, Willem-Jan de Hoog wrote:
>>> From: Willem-Jan de Hoog <wdehoog@exalondelft.nl>
>>>
>>> The bcm47xx module has a copy of the NVRAM data in ram. When available, use
>>> this one instead of reading from io memory since it causes mtd/ubi to fail.
>>
>> This doesn't explain anything. Why do we need that? If anything we
>> should rather get rid of that NVRAM firmware driver. It was needed
>> before we had all NVMEM stuff in place. Finally how can reading
>> iomem break mtd/ubi?!
> 
> Did you take a look at the bootlog on this post on the thread, I've mentioned your user handle a few times but received no response on the forum.
> 
> https://forum.openwrt.org/t/asus-rt-ac88u-hw-a6-broken-in-22-03-3/147882/6?u=arinc9

Well, it doesn't really matter *in context* of getting this patch
accepted for mainline. It needs to be properly described on its own so
people can review it without looking through dozens of forum posts.

Sorry for not following that closely, I lagged behind due to my work on
other Broadcom topics. Broken LZMA, broken Linksys device support,
broken BCM5358. I'll see if I can figure out sth from that thread.
