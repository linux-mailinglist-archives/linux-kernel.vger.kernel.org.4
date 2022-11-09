Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB84622A70
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbiKILZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiKILZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:25:36 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684451A068;
        Wed,  9 Nov 2022 03:25:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id z14so25281928wrn.7;
        Wed, 09 Nov 2022 03:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yVfcpsRQhZ+K1eDUGm/hT79865gqKPGqp1NWWMzmywA=;
        b=QYl+yjjJGwob7l4O1fw3+oiBMl/GAN8a/Tzrcirxu+K51wcXU1Tk02WMEgePKIKx2x
         CRzaFVSCpQYyr4Jr9nO+rr9BltzAyt4y3PhHd3qwidEqPikm8OZGzn+alPWjkYV/Sacz
         /5/1+eyo4xMg/gr7O/PoXrfZu/DW1a82+xYgZAxBpZ83Y/uG6dLLriPz/Mp28FGuLKpz
         vhUFGpWrQbxGGa7T9Bk/iD1N2h/QsgMJNEoUrsxioP9kxLQv5WSWMXvvKgSWpbKCkQjz
         j72DKYn1Zytrw9JrSiS+QdeUQNi16sX8VGrRaX71sCZuaB24lT8gGAGChEOq6FohMZTS
         qepg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yVfcpsRQhZ+K1eDUGm/hT79865gqKPGqp1NWWMzmywA=;
        b=6UqsdwNBZTzXg7/qTSpAkXDkT750AUkza7jGaiYqHpuQGVCTDL8c8EgCoBlKXjh8s0
         tyEC8c+JLN6gTjabxiFJXgRyHycdIuYPL6Nptjf9w+GznIWYEAkm/jEFdL1j17ETF85w
         XaZi7DzV7AL7dFohBW5XaYElt0t9LDamAcLhauDdHvRMyLk0MfkCjPe3PADo/5AEtS94
         DrgZPCCQPY+V+oaKvP+4z3gQBEEzqlBAobBtXZ9KNFr+SHhz5gLveVKboRRWMT4hFzQk
         LkywIhxpFzEt/zoBTr4b7Y5jeQkyI439mj8TAJdZSMeVU9mftWCIHHwEgVz1ZUoKaFFI
         Axuw==
X-Gm-Message-State: ACrzQf2YCCAbR69Zn4xaQ8CCgk3IUsMSMCSDHNRV9FJ7EhAMsJzaZsRT
        yFVBnWcANl3EME6SP597gnZJGOu4364=
X-Google-Smtp-Source: AMsMyM4iaCUXPelD5JPs3GwdxrrcdP1EVcbyNAKOCSt0mIJomogbed+Y7iZa1JRJyZ3hoqj23+CxWw==
X-Received: by 2002:a05:6000:1566:b0:236:6a6f:6c27 with SMTP id 6-20020a056000156600b002366a6f6c27mr38530858wrz.553.1667993133963;
        Wed, 09 Nov 2022 03:25:33 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0022eafed36ebsm12791671wrr.73.2022.11.09.03.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 03:25:32 -0800 (PST)
Message-ID: <a0b61872-12bb-0ed2-a1b4-75cb5609c1c3@gmail.com>
Date:   Wed, 9 Nov 2022 12:25:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v5 3/6] soc: mediatek: add mtk-mmsys support for mt8195
 vdosys0
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220927152704.12018-1-jason-jh.lin@mediatek.com>
 <20220927152704.12018-4-jason-jh.lin@mediatek.com>
 <0e67041f-a61d-1e34-2ce4-6a199c2c9f8e@collabora.com>
 <ac0a8cadf18291575d5fc798f0d6b99f5c3a4258.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ac0a8cadf18291575d5fc798f0d6b99f5c3a4258.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2022 09:08, Jason-JH.Lin wrote:
> Hi Matthias,
> 
> Do you have any comment for this binding?
> 
> Can you help us review the soc/mediatek related patches?
> 

Patches 1-3 applied now. Sorry for the late answer.

Matthias

> Regards,
> Jason-JH.Lin
> 
> On Wed, 2022-09-28 at 10:14 +0200, AngeloGioacchino Del Regno wrote:
>> Il 27/09/22 17:27, Jason-JH.Lin ha scritto:
>>> 1. Add mt8195 driver data with compatible "mediatek-mt8195-
>>> vdosys0".
>>> 2. Add mt8195 routing table settings of vdosys0.
>>>
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
>>
>>
>>
