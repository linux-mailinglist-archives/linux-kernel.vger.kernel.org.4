Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8163B665921
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 11:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjAKKgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 05:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjAKKgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 05:36:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F255FAE;
        Wed, 11 Jan 2023 02:36:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C29C56602CEE;
        Wed, 11 Jan 2023 10:36:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673433402;
        bh=H6zzHJpHQe1KvLuxZKBTil2t46+1H+8k2jz3su1ylJM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rx59Oac2V1EYhsjboFmG7hLyyIMkP+MOnbiyspABilPj681rqxLlV1XHg9GLsSgWs
         jsnxNcGF5hx2JB4OssIvba/es9sEMyyD9U1hPITXMBc5qXdk+Pfuw5NEpfeL1v9M5I
         lO3hH7ezSBT0nQ482mAIL8HT59w2s9Ipki4bD5REZcOwrhxXpbsMzvpEYzQDDmSVNF
         cHZSZ3EmBOZ2peeEEUwQs1ieAHRKWZl1lb2d2ojvVq0QfKl0GF/9jD8DZ63cpOW8AF
         BKuJ3QUxMBhrBUMa8BhzTudZgdOB0/Q5coLVnULtXZh6hbWAEi3GqaRM4qvWPpKZ4V
         0kylkWTLvW+KA==
Message-ID: <e263490c-8ff3-d19d-bcb8-8a81ab7f6245@collabora.com>
Date:   Wed, 11 Jan 2023 11:36:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 11/23] clk: mediatek: Switch to mtk_clk_simple_probe()
To:     Miles Chen <miles.chen@mediatek.com>, wenst@chromium.org
Cc:     chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        devicetree@vger.kernel.org, fparent@baylibre.com,
        ikjn@chromium.org, johnson.wang@mediatek.com,
        jose.exposito89@gmail.com, kernel@collabora.com,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, msp@baylibre.com, mturquette@baylibre.com,
        nfraprado@collabora.com, pablo.sun@mediatek.com,
        rex-bc.chen@mediatek.com, robh+dt@kernel.org, ryder.lee@kernel.org,
        sam.shih@mediatek.com, sboyd@kernel.org, weiyi.lu@mediatek.com,
        y.oudjana@protonmail.com, yangyingliang@huawei.com,
        mingming.su@mediatek.com
References: <Y74jNZbjpopT2rNY@google.com>
 <20230111085645.30683-1-miles.chen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230111085645.30683-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/23 09:56, Miles Chen ha scritto:
> cc Mingming
> 
>>>> Would this get cleaned up even more? I.e. have just one driver left and
>>>> we could have the nice *_platform_driver() macros.
>>>>
>>>
>>> In the future, yes - granted that I find someone that can help with the testing,
>>> as I don't have any MT2712 hardware here.
>>>
>>> Not in this series though (please!).
>>
>> Got it.
>>
>> Maybe Miles has access to some EVBs, or knows someone who does.
>>
>> ChenYu
> 
> I do not have any MT2712 board.
> Thanks for Mingming's help, Mingming will test v2 series on the MT2712 platform.
> 
> thanks,
> Miles
> 

I'll remember to add Mingming to the Cc's for the other series that I will send
after this one gets picked.
Many thanks for offering testing!

Cheers,
Angelo
