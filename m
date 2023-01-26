Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690D67CE39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbjAZOd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbjAZOdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 09:33:51 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB0E37561;
        Thu, 26 Jan 2023 06:33:50 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w11so2083588edv.0;
        Thu, 26 Jan 2023 06:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbZYXU3CwClgETqhdjQoXodTSxGhorbUytRGaBvb6Pg=;
        b=jwl0p7p76KSN9woc2E/mq1oapHwh5qSFbh/wTvhvka2QqKfJ+5H0Tlmu/Fl9KQHjSt
         CPvoP1EpUY2N5f/yi1Tq/zSAZIbg+hNDw4P3c38hZ+SCllZ1RXj0hIR8MOikf1hkPlxv
         Zvv01k59aHHOxc0b4KorXn6yCPpg6JXWsNkq+C9nX39UoHj4SkyqJz70cIVQ12yXXTxj
         ayhEdz25nXGIPUuO6Bxrp3UrWzX5DFUv/say/qwvuxdgYV7AuyaWDsfgoIqC39aK5xtr
         r+15t6z1lb+khhb2Moo8ibebCdUf2xSDGHdZcjHaxMTnldrTK1PeenzmPedjV3XiOOvL
         l42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbZYXU3CwClgETqhdjQoXodTSxGhorbUytRGaBvb6Pg=;
        b=uJz3bsoWS/3rX+Vr2iXWMKHUml9zZ6YcnS3JCTaOq5BSuE9mx2C0QVNPzS1PmMets+
         UopXultHrH91qoCRu2deXHyxiij7DtNkq7IQZgHFnTOBxKgY49jKbq0FGfb8JL7Ynt6E
         A//LyJ9DJdXAMFJ1+Goa7z2U9Gyi+0d3U4ayLCl9/R8b5/mroy256LYk+eGPAGA/FOra
         ZIAfJvUA/NEaiemDmBOGw2uHyxtLvBCojQJM20c6AVvBy7IFb9zPPyS8+NsnkkblzVpb
         KwOZyqDc/6zX/29/+7qHsyqoaVXEEaYL7CUNW3AE67FN/tfu1AOX0qHQhgxM7euqLOtq
         fJgA==
X-Gm-Message-State: AFqh2kowUb/3m7UlqCZPm41v2JxJDDpuTAv3bPAoO22+GQ++ZG83brvE
        3WUiOlWaeIF+2H0I7lT2H0Q=
X-Google-Smtp-Source: AMrXdXtZYgaznh9SIO78EDuKzc5nLRuzdrpWmUh499yi8uTaCb+qB4kLDpHqls4b9zKXQZEMpuY+nA==
X-Received: by 2002:aa7:de95:0:b0:497:65e6:f6e4 with SMTP id j21-20020aa7de95000000b0049765e6f6e4mr35683968edv.14.1674743628939;
        Thu, 26 Jan 2023 06:33:48 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id d21-20020aa7ce15000000b0046267f8150csm828611edv.19.2023.01.26.06.33.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 06:33:48 -0800 (PST)
Message-ID: <8eab7134-9d1f-0101-509a-0d664b000a36@gmail.com>
Date:   Thu, 26 Jan 2023 15:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 1/4] dt-bindings: arm: mediatek: migrate MT8195
 vppsys0/1 to mtk-mmsys driver
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118031509.29834-1-moudy.ho@mediatek.com>
 <20230118031509.29834-2-moudy.ho@mediatek.com>
 <8ae4469e-ed2c-5019-605b-013a49af77ea@gmail.com>
 <124f081819a80482b3bffd8e12d747fc.sboyd@kernel.org>
 <c4633d6a-9aa5-5c43-bfcb-611cd96e1c5b@gmail.com>
In-Reply-To: <c4633d6a-9aa5-5c43-bfcb-611cd96e1c5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2023 15:32, Matthias Brugger wrote:
> 
> 
> On 26/01/2023 03:05, Stephen Boyd wrote:
>> Quoting Matthias Brugger (2023-01-19 08:08:48)
>>>
>>>
>>> On 18/01/2023 04:15, Moudy Ho wrote:
>>>> MT8195 VPPSYS 0/1 should be probed from mtk-mmsys driver to
>>>> populate device by platform_device_register_data then start
>>>> its own clock driver.
>>>>
>>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>>
>>> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> Stephen, if you want I can take 1/4 and 3/4 through my tree. 3/4 shouldn't be a
>>> problem, not sure about this patch. In any case if you want me to do so, I'd
>>> need a Acked-by from you.
>>
>> Do you need to take them? I'm picking up mediatek patches currently so I
>> can probably just take 1 and 3 if there isn't any build dependency.
> 
> No I don't need to, no build depencies. Ok, I'll take 1 and 3 then.

Argh, 2 and 4 of course. 1 and 3 will go through your tree. Sorry for the confusion.

Matthias
