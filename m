Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F58A6B22E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjCIL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjCIL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:26:53 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C065B89
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 03:25:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id s11so5529150edy.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 03:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678361120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kHoKqHI6vSk1Mft/kh5/2V5VXLK7X9hGPi2a8Fi/vXE=;
        b=BlHkjWGfkocJHGCmBTdqp9KACHE33ai0B6zCXVAhSzjV7cAjit2zJiuj11Ck3THyHc
         MNEnKgA85131bwOxu/fS6FKBR39LPDAsMn72duS67dw1D5rmQUvJXk+/tke9U+cZXCD5
         XW15/RMsdpjMjFFZ6a2/a58LEicD5u+G+odjZkiZskpHBfpos6HIPMIjZI/V/YUcYPqY
         EYyz0f2xd34MgUVn1G6oM5Sb8wY79Ml+9Vg8MZ2EmdjavTfvgzGiTZV0epJsCcfF7tFN
         /J44TnuNYegmzVa+cYd6C7pyLNP6SW667jgqw9Ic9ge2DhiDAUCx3nzs5JVEX6JnZNUk
         EpKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678361120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kHoKqHI6vSk1Mft/kh5/2V5VXLK7X9hGPi2a8Fi/vXE=;
        b=yjEOdwkDbGEa1u1T8Zv5h4RZBj8Zf2N71PXXyzyK+ojksQue7WwsNt+HqsDjgnkJf4
         bjCH+Zs5X4dmMy5iUZdGKLADC/xGr+eIMANPcnw9UVOh08ZrAufNwWbYyJ9VyVX0U3uK
         5Zjso8OHaK2hbyA0I7/qxj/sc8aa2jVnHOAVe4bJEWQPJVSLbhG9mGL3CSTNYl/hdBYm
         CDdkn+NG+qXKeAobvM1pHRUWzZX7doUnTIVdZQ2hL0qoEcePu5k2dr8gY2vPBa9BU3oZ
         hX0OvWD4q4EMJXRQcbR2xa9kYvDKSdGe0Tq62EviqE6Pd+d/T4iFKBHrosf0u9P0iJ29
         P/hg==
X-Gm-Message-State: AO0yUKXvicsJnp0xTvOy/ZUVuKoNScox914MqrYRSzcQVVat500SvfEL
        I9KY/OoTzYjO5bHjuSnY7OOHBg==
X-Google-Smtp-Source: AK7set/z3pqnO+9AdM/ge57IRgyQg62++w4otu5nyvrPvi6Ew2FKAd5Qht1vn4k24525gsLcNAP6TA==
X-Received: by 2002:a17:907:64c:b0:8ab:a378:5f96 with SMTP id wq12-20020a170907064c00b008aba3785f96mr24836033ejb.3.1678361120457;
        Thu, 09 Mar 2023 03:25:20 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id p24-20020a50cd98000000b004af6163f845sm9380578edi.28.2023.03.09.03.25.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 03:25:19 -0800 (PST)
Message-ID: <fea6e236-94da-68da-36b9-e8e21c037cfb@linaro.org>
Date:   Thu, 9 Mar 2023 12:25:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4] ASoC: cs35l41: Steam Deck Shared boost properties
 quirk
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai --cc=alsa-devel @ alsa-project . org" <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230309104133.537056-1-lucas.tanure@collabora.com>
 <2881f527-1673-3496-85a2-84a13f074248@linaro.org>
 <af2de8df-b20e-4bbc-9f00-90b50546c4fb@sirena.org.uk>
 <23cb7d3c-4cf8-8d9d-dbdb-4391384a5726@linaro.org>
 <d20cd40f-659c-4260-b47e-a0c5eee5437a@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d20cd40f-659c-4260-b47e-a0c5eee5437a@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 12:19, Mark Brown wrote:
> On Thu, Mar 09, 2023 at 12:17:35PM +0100, Krzysztof Kozlowski wrote:
>> On 09/03/2023 12:04, Mark Brown wrote:
>>> On Thu, Mar 09, 2023 at 11:42:42AM +0100, Krzysztof Kozlowski wrote:
> 
>>>> You are now changing ABI and adding undocumented properties.
> 
>>> This is newly added code, changes are fine.
> 
>> OK, for the ABI code, but not for the undocumented properties. Commit
>> does not explain that.
> 
> It does, it says that it's adding support for the properties used in the
> firmware on existing Steam Decks.  Those aren't even DT systems.

For some reason DT is cced...

The code unfortunately will allow to put them into DT and next time
people will use it as an argument to document in the binding ("because
driver already has them"). I heard this argument already many times.

Document then that these are not DT properties.

Best regards,
Krzysztof

