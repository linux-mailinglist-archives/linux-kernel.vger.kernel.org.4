Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F826A5B25
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 15:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1Ozs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 09:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjB1Ozq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 09:55:46 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F285CC3D;
        Tue, 28 Feb 2023 06:55:33 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i12so6417931ila.5;
        Tue, 28 Feb 2023 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677596133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5eTTfgqaqAQ3CFcC2lIe16x/qcJqi2p2PHjQUf8Jvw=;
        b=Q7xAlJQyRu5B7Cy83Q+sT2qzoqhrkVrBSrGXj4JcG5zoSL3Kbj9QszSrpZGLczlO3h
         eck2+fXID/edmLhozaZjTAtbLVRV5palbbPxUkLFNkRjha8Yu6rnnke+qdemzHeFekqm
         lOtL1XmXEGHtd8SDcd6f1fMgRvx5cJ3IDYj6I4KWqocDOcGlgcdTpRY/Co1s6CbWNhnY
         b05UeRVP3LzQPoB5V8jDDcfeHN7dUGLjcfNm+1Rtd0iucT2YrmV6eN6ii4k92SGaomN2
         Zx/Luw3CKLpsoTKfI9442yfXiLAHSxe2Uw6lHcFSt4wpiKfPfG+YLBUZiNJ6hX/m/Tc5
         80cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677596133;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5eTTfgqaqAQ3CFcC2lIe16x/qcJqi2p2PHjQUf8Jvw=;
        b=NgNiloE+w86C18vxfODa/MCyFG5kjdx8Ii/T2TywCfuiTeR3IC56A6y6U7pVveSe3t
         HMIZls4gkwOxFAL1dA75SgWZTPZ5Ty4vgSyUSDYu5WXvvYfGQxKuBJ2k4Oawm9KUmdT4
         8c9sjrihztQhLgZ0ntCDuUGB1q+BTg6XJaZdDpAmC+x7cxTREeX+8N43H4Gu/sTM4UGa
         kR6rV6L3Qxfa8MIwHGe3s4x129cpZNraorB2aN/w/Owe/keJnLByA2tl0AtfrkLi2sK3
         AZ5PfzOdKm6f3e+dQYiQyiGzHmVcKdO//I/yeYGyY+xz5Rcw3eYF+UN/sAG41IuEV50a
         JwUg==
X-Gm-Message-State: AO0yUKVSEfK/MJEGkx+6PU47GC7s93MJRlT8vk2byHkMWEqVfFsSj0gO
        VmpCfraf296oyZrr5PP4VsX0kpWNEMw=
X-Google-Smtp-Source: AK7set9shbJpReCH2WaoIyL8idU/N5JfWPZwcmqak7rP5Tjb+0Muq4sVw//bvSpOwHBJVZsI6P2Sbw==
X-Received: by 2002:a05:6e02:2142:b0:315:7fec:f1f0 with SMTP id d2-20020a056e02214200b003157fecf1f0mr2650247ilv.7.1677596132916;
        Tue, 28 Feb 2023 06:55:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o21-20020a02b815000000b003b8708902c0sm3084290jam.21.2023.02.28.06.55.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 06:55:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82659eef-528d-e421-aed4-21e1a7794bf5@roeck-us.net>
Date:   Tue, 28 Feb 2023 06:55:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v7 2/5] mips: dts: ralink: mt7621: rename watchdog node
 from 'wdt' into 'watchdog'
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-watchdog@vger.kernel.org, wim@linux-watchdog.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, arinc.unal@arinc9.com,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230214103936.1061078-1-sergio.paracuellos@gmail.com>
 <20230214103936.1061078-3-sergio.paracuellos@gmail.com>
 <20230214151101.GB742354@roeck-us.net>
 <CAMhs-H915iSR7TpuXdcg8NKLV8Scv9cwW36SZaXNK839kA4ybg@mail.gmail.com>
 <CAMhs-H_Ce-+MFi5zTMg8v8dSSg5ioaTy+Pw-0QMgK++PVtEViQ@mail.gmail.com>
 <20230228083920.GA5801@alpha.franken.de>
 <CAMhs-H8xGjGs0-qvxb5KgQ3YZw=2=scqaY15K3ZRp50jQcncSg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAMhs-H8xGjGs0-qvxb5KgQ3YZw=2=scqaY15K3ZRp50jQcncSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/23 00:51, Sergio Paracuellos wrote:
> On Tue, Feb 28, 2023 at 9:41 AM Thomas Bogendoerfer
> <tsbogend@alpha.franken.de> wrote:
>>
>> On Tue, Feb 28, 2023 at 05:44:21AM +0100, Sergio Paracuellos wrote:
>>> On Tue, Feb 14, 2023 at 4:12 PM Sergio Paracuellos
>>> <sergio.paracuellos@gmail.com> wrote:
>>>>
>>>> On Tue, Feb 14, 2023 at 4:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On Tue, Feb 14, 2023 at 11:39:33AM +0100, Sergio Paracuellos wrote:
>>>>>> Watchdog nodes must use 'watchdog' for node name. When a 'make dtbs_check'
>>>>>> is performed the following warning appears:
>>>>>>
>>>>>> wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'
>>>>>>
>>>>>> Fix this warning up properly renaming the node into 'watchdog'.
>>>>>>
>>>>>> Reviewed-by: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>>> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
>>>>>
>>>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>>>>
>>>>> Note that we can not apply this and the next patch of the series
>>>>> through the watchdog tree since it crosses a maintainer boundary.
>>>>
>>>> I was expecting Thomas to get these two arch/mips patches or get an
>>>> Acked-by from him in order for you to apply them.
>>>
>>> Hi Thomas,
>>>
>>> I think you have missed this series since you have started to apply
>>> newer stuff in mips-next. Are you ok with taking or Acking patches 2
>>> and 3 of this series?
>>
>> yes, I sort of missed it. If it's enough to take patch 2/3 I'll do that.
>> If it's better to keep the series, I'm also ok with acking them.
>> What's the best way forward ?
> 
> Both trees work for me. The rest of the patches of this series should
> go through the watchdog tree. Guenter, what is better for you?
> 

Wim is handling pull requests. He has queued the other three patches in his
tree. I would suggest to apply the two remaining patches through the mips
tree.

Guenter

> Thanks,
>      Sergio Paracuellos
> 
>>
>> Thomas.
>>
>> --
>> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
>> good idea.                                                [ RFC1925, 2.3 ]

