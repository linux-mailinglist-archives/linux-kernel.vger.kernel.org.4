Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EA969657C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbjBNNz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjBNNz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:55:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37813CA02
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:55:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id rp23so40244261ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 05:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD9XmxwdpDc2jh4miP7TighcPFQqr+/oanR4Siz9kXg=;
        b=nG/QSzXlu0zWOe4nIpZQDCa/ukl1i/U04S07Y3jhT9FMsZkiRqvbQaYhjSKWoVLwi4
         exPorjckhX8wNsfgqQA9PqFQ7i8GS+ads2GT9Q99lOupJtbzBYtI1Gp6+8gATTpvb8U0
         PRhk8yaa1KmNkjYo9UCQJl6ycLsAFADI2PRCp40Noe16vafZzoFkSe7V4ZzxDO8ROqRQ
         zSlnyQ0yefzNLN+r/l4YgqQ2z2Lg1wa44DBvOSJ5UU0pjrHvhKB3Kxgr+2WubHBY7eIz
         ID1K2Y5gaSf8P6wTJWMoetJM//+RR3BZ3+DpfqeGt0BnXnetaEsUoS/sAYl0XE3HcZjv
         e8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD9XmxwdpDc2jh4miP7TighcPFQqr+/oanR4Siz9kXg=;
        b=vTE4HrO7yfQ6pqu/T05ZLfgnv5CSXE0QgIozff514W6d3jPzU8dUBet61WQFRGU/Ud
         MmMOUGudsTInMsAiWe7brTbwkiBG1yXpbWvBmfD7Y0wIm5jRld2YvN3zeVEoz+E14OOL
         4DZAH8/XOKZVsGwuBTlWzGJLFDQJcL9I3n66CVG2TKQQQDG7pO3gc0rEt9W5FSxal/Jr
         L2t8lyalmovk6NAjIysH72EOsW+YXB+rX1Ec1/jxTrOFEhSHujZWCUJSSJ+KV3DpkpkF
         +rPImnjtyYpHowPBhI9AveuYRbh58NDbKbCKnlLpWc9deCa44IQiCmG5nO3m7cCpxuJq
         34YQ==
X-Gm-Message-State: AO0yUKX/0GhB6zfgy4C2ajhBrkjZVNbwy6pSRCA8TZS3wgbdxeizQ1bH
        nrFK8irAwkA1WvUNMNcCvWdiJtBoJCUl9g==
X-Google-Smtp-Source: AK7set+ZJn7SXOy6FSwFbPNqbQeUuT8T5e+bobfo0l1w6nJ8E6AnFaXMXe3vDiRDuwDwcLDbtUqs3g==
X-Received: by 2002:a17:907:a40a:b0:889:5686:486a with SMTP id sg10-20020a170907a40a00b008895686486amr3893565ejc.30.1676382900735;
        Tue, 14 Feb 2023 05:55:00 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id gs4-20020a170906f18400b008a5cbd8f7d1sm8210895ejb.127.2023.02.14.05.54.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 05:55:00 -0800 (PST)
Message-ID: <1258b5b7-e8c8-cfb1-5bfb-c966dd4cfcf8@gmail.com>
Date:   Tue, 14 Feb 2023 14:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: mediatek: mtk-svs: delete node name check
Content-Language: en-US
To:     =?UTF-8?B?Um9nZXIgTHUgKOmZuOeRnuWCkSk=?= <Roger.Lu@mediatek.com>,
        "matthias.bgg@kernel.org" <matthias.bgg@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20230209162403.21113-1-matthias.bgg@kernel.org>
 <12ff7576-76d3-8cb6-4c8f-6c9417ac28c2@collabora.com>
 <65af4673ef79d8dd3404f4cfb773859410c85cc5.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <65af4673ef79d8dd3404f4cfb773859410c85cc5.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/02/2023 12:37, Roger Lu (陸瑞傑) wrote:
> On Fri, 2023-02-10 at 13:01 +0100, AngeloGioacchino Del Regno wrote:
>> Il 09/02/23 17:24, matthias.bgg@kernel.org ha scritto:
>>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> The function  svs_add_device_link is called only internally from the SoC
>>> specific probe functions. We don't need to check if the node_name is
>>> null because that would mean that we have a buggy SoC probe function in
>>> the first place.
>>>
>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <
>> angelogioacchino.delregno@collabora.com>
> 
> Reviewed-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks for the reviews.
Matthias
