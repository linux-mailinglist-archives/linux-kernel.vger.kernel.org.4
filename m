Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F686B1B4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCIGTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCIGTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:19:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B8585FA5D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 22:19:19 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id k10so2698839edk.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 22:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678342758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaH9HgCkr+9a67bT+ARgwdxkpOnUI9ns6L7TKcqObjA=;
        b=ITYlrvXAQLkr9QYr1uTCWBKzOrLNsyrcRMdCfQF2bEVm4JURTwpxCHksdjne9ihFco
         J5xoCX5SiafVXk7aSYW07LIEXekSkTvf2ApeU+LAEsBxjH013L3k+REjlBuG3qY18Hyg
         lp3rsilFOxYh2QWQr1V1zCydwIbkoKLRbWLhe12ba/ajHG6O37Du8mUT7kVeUZYMv6Uj
         z6i86Esqsj5exC/16OVSS27SGKn1LtIOin3fU20BtzHFtCcCTIibZaDY5eMF96fyZto/
         joVxPKzYuabMFvKftG26KNL5e0f3j7ClC4ZXqorP0+beQxg7iHTHhlUZgwXvEM5eFfIl
         3H+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678342758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaH9HgCkr+9a67bT+ARgwdxkpOnUI9ns6L7TKcqObjA=;
        b=cHDsfb+Cp+hyeJnaX7+ChGFln8lNV02pQ8om4vBgGYcFLKb6jAD/0Im1UAvXUK/zVs
         NvAqmmO9F4LNClDfiKRdqoWNVxSjgBAYtM/kUJrc7MmAfxmG/eFPSTopOzAfeT4BHxcd
         Bm5hKLecAs8xtFaS3RptyXGkyg34yFuLtwkypJtekLfCpXR9UfGQlwkf4MKXExWdcJ+G
         t+gQVlIdTI/gcC2eM4Nnuf2vgpiBdW3yYyG5kfE39/8vF8maAmgh3BLPz31df/wlAVGR
         417v3m7wyum/JSrHV1V+32fd3S0EOBj71Xz5IGSPPOwkoB/e01GxVxNprH7h4GJqkYPs
         4Qhg==
X-Gm-Message-State: AO0yUKWDsQY98cV3QQjmzC/dNb6nPMVwjrJt3Rso008JTqB8wEr7sJRQ
        350lYV1S6b+K0jMglBU4v5wDnn+eP/5igwoEMOM=
X-Google-Smtp-Source: AK7set++RSnbc8tC8rKkU11kVGIsuUGK4PI5hIF5Cgcmt0cLqiB0DIPHKMSe/Sjp2IIJN46+60HzYw==
X-Received: by 2002:aa7:c544:0:b0:4ab:cb8c:932b with SMTP id s4-20020aa7c544000000b004abcb8c932bmr16778604edr.40.1678342757997;
        Wed, 08 Mar 2023 22:19:17 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id 13-20020a508e0d000000b004af59c07495sm9118572edw.45.2023.03.08.22.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 22:19:17 -0800 (PST)
Message-ID: <49f21605-46f8-8a53-cde3-3d8270ea576a@linaro.org>
Date:   Thu, 9 Mar 2023 07:19:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 15/27] memory: tegra: remove MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
References: <20230224150811.80316-1-nick.alcock@oracle.com>
 <20230224150811.80316-16-nick.alcock@oracle.com>
 <c6f39365-e840-d782-8ec0-e34ec3681b98@linaro.org>
 <acc27e8f-73ce-39ee-3666-461f5c72d39d@linaro.org>
 <87h6ux7qhp.fsf@esperi.org.uk>
 <16bee433-0088-d651-9592-96a2bb827b7f@linaro.org>
 <87zg8n3s9m.fsf@esperi.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87zg8n3s9m.fsf@esperi.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 21:25, Nick Alcock wrote:
> On 6 Mar 2023, Krzysztof Kozlowski stated:
> 
>> On 06/03/2023 18:13, Nick Alcock wrote:
>>> On 6 Mar 2023, Krzysztof Kozlowski told this:
>>>
>>>> On 06/03/2023 15:30, Krzysztof Kozlowski wrote:
>>>>> On 24/02/2023 16:07, Nick Alcock wrote:
>>>>>> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
>>>>>> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
>>>>>> are used to identify modules. As a consequence, uses of the macro
>>>>>> in non-modules will cause modprobe to misidentify their containing
>>>>>> object file as a module when it is not (false positives), and modprobe
>>>>>> might succeed rather than failing with a suitable error message.
>>>>>>
>>>>>> So remove it in the files in this commit, none of which can be built as
>>>>>> modules.
>>>>>
>>>>> Applied as well. Squashed with next one. Same subject messes with b4, so
>>>>> prefix should be corrected if these were to stay as separate patches.
>>>>
>>>> And all dropped. Run checkpatch before sending patches.
>>>
>>> So... which of the 27 patches n this series is being dropped? It would
>>> also be nice to know what the checkpatch problems were, because all I
>>> can see from checkpatch is one error per patch, an apparent false
>>
>> The ones I responded that I applied - so the memory controller ones.
> 
> OK, resent those three (now two), checkpatch-clean and fused identical
> subjects together. (Not adjusted non-memory-controller patch commit
> logs, to avoid causing disruption with those that are already flowing
> into the tree.)
> 
> Hope this is better :)

If you send a new patch, mark it appropriately and include changelog.

Best regards,
Krzysztof

