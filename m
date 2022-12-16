Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F8E64EC25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiLPNdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLPNdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:33:41 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064218373
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:33:37 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o5so2532453wrm.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zoNlcl5EdrvBU+HSJMxnrCA5HD90xdYfTEFQLwtn1Z4=;
        b=dYbJm2vLGzYTl1SR6lTyIyZDstx1WHy/Pa1BkvMtNfVWOJJWSBtNqOMr7KvD60tTH1
         FUs79ciy/klSi6Ca989XP7UcPfqMDJNa7mMv+e7QspU4A+yXs9uWaK20MybNg5SNzUFv
         YemAjT3GurkQ3xmcvrNMR86uWiCyrwE/bmuSF8Bt3XQum+X2RppVB5fl+bs1t/p+/w9x
         PacwAi/dZhqMs4dImvBd9KpF3OseST3sSw3R2NIHu3GAnj+MdAbjja76JJJnnww6fNuA
         1nve9xSjYmBo50fZEgbXo3owRD0Z0up36hjZJ4fvcyMMBxRwy84c3oOdJSrtvffgMrcr
         9iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zoNlcl5EdrvBU+HSJMxnrCA5HD90xdYfTEFQLwtn1Z4=;
        b=zYdFqdTBIbp1orVXqCpTfLDNPasA6k3YqsudYVpQ9dAckFiSsitjYM5ZJf+ib3Tq6R
         UFClt++C1JJU+EdF4IaR3az/HQtYmNrP3ierZn1oiJbrFgLP4+sR4n/axlsVwC7Kg9pB
         unngW/BYpHOAKHg36z+vhCoXcZcq3nF12CvU/g8PjINQCKftreeI2LPyhGalxaoQbcDk
         Ffi3hLoxX+WQn/QzUZ6QrQLh9rMkNiS+EiEppq7E6sjrYu80T6dW3BVafoD7mbVpfvBj
         BC0Dcr0vqkqepwla9FQrpDwZVROjO1WQ+GxEZFc8DpKgDvmDrGik23U5lXHV+IRksdvl
         VL/Q==
X-Gm-Message-State: ANoB5pkjGaoo760Ne2cvS6+Jq43GhgEX3BNO8lLvRfJNAl0gMNF45JM5
        Wc58ShTEUheLGShTLWEKBCo=
X-Google-Smtp-Source: AA0mqf7GsK+9KF+6xYlMmd/WNxVKsNSXdi9DxwopLYeC+l+LHjQC8M38gOSFU/By16MxGtlZGjC2uA==
X-Received: by 2002:a05:6000:156c:b0:241:fbef:29b5 with SMTP id 12-20020a056000156c00b00241fbef29b5mr43444027wrz.13.1671197615729;
        Fri, 16 Dec 2022 05:33:35 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y6-20020adfe6c6000000b00241e8d00b79sm2624307wrm.54.2022.12.16.05.33.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:33:34 -0800 (PST)
Message-ID: <dd474515-4a4f-3925-cc96-068f9818a2f4@gmail.com>
Date:   Fri, 16 Dec 2022 14:33:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@kernel.org
Cc:     nancy.lin@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
 <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
 <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5FORS=iGe55StxR_1E3sdtk9cvitfvNa1SydqCjWGcubg@mail.gmail.com>
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



On 01/12/2022 12:20, Chen-Yu Tsai wrote:
> On Mon, Nov 14, 2022 at 7:59 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> wrote:
>>
>> Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
>>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>>
>>> For backward compatibility we add the deprecated compatible.
>>>
>>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> ...And tested on MT8195 Cherry Chromebook.
> 
> This now seems like a bad idea. In the dtsi we have two nodes (vdosys0 and
> vdosys1) that both currently use the -mmsys compatible, which in the driver
> maps to vdosys0. So not only do we have vdosys1 incorrectly probing as
> vdosys0, we also have duplicate clks being registered and duplicate DRM
> pipelines. On my device vdosys1 ends up winning the duplicate clock race.
> 

That's true, we should fix the DTS deleting vdosys1 node as it's not 
implemented. While at it we should also fix the compatible for vdosys0 as 
"mediatek,mt8195-mmsys" is now deprecated.

Would you mind to send a patch?

Regards,
Matthias

> I suggest just reverting this. The display stuff won't be useful unless
> the drivers are able to distinguish themselves from one another.
> 
