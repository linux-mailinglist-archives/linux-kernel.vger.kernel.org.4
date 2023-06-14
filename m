Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD572FAE0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbjFNK3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbjFNK3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:29:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C82C49F0;
        Wed, 14 Jun 2023 03:27:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88C7F61190;
        Wed, 14 Jun 2023 10:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C02C433C8;
        Wed, 14 Jun 2023 10:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686738374;
        bh=rHhi//0DexlG3Dm2fQiKBaAn5pi9D6uWskgBFUDstuw=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=rM+vkk+TMffotpfcTthxxQ1AOJC1i8LWvIP1X6jT5ed3HHqh+84p3rWQcOjGARKgd
         CzsZqxFf4NZ05GPzfvlemRE3p9/XGLWpm80pD7aMpMnIOgIQAqgAbFDFf0IgKtSrv8
         F9mEGMEVC6aAeUGxklqueGyVsBXHvf8G/jUleHAxHvNUHLCieJ3CL3DelfzfweqGlY
         a0nfZsuVJZ8qWHnOjcf8iPQSU1z5dScOobfbj28Se8XTaF62ydb38C1ulKeIEmPLnF
         Tv1i1Z34CutsWL4SLQhPYezKEx9CW0MYg3b8VQtRphMVE8/TvZoyyRVO4+nsFcgmyy
         FkUQ4Z+/7aasA==
Message-ID: <645989de-7a61-29e7-9cf8-f473b9b384fe@kernel.org>
Date:   Wed, 14 Jun 2023 12:26:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 7/7] ASoC: dt-bindings: mediatek,mt79xx-afe: add audio afe
 document
Content-Language: en-US
To:     =?UTF-8?B?TWFzbyBIdWFuZyAo6buD5Yqg56u5KQ==?= 
        <Maso.Huang@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?VHJldm9yIFd1ICjlkLPmlofoia8p?= <Trevor.Wu@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "renzhijie2@huawei.com" <renzhijie2@huawei.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "perex@perex.cz" <perex@perex.cz>,
        =?UTF-8?B?SmlheGluIFl1ICjkv57lrrbpkasp?= <Jiaxin.Yu@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
 <20230612105250.15441-8-maso.huang@mediatek.com>
 <d9cd1ff3-b537-1481-9453-5b3683d30fed@kernel.org>
 <14913cbb87981eed6f8b72f9e659ed3e25958320.camel@mediatek.com>
 <d6289232-6276-a2d3-c059-1edcef6a1b6f@kernel.org>
 <a338bf978dfa0af84a6728ab66dc51e45a20c7c4.camel@mediatek.com>
 <4305b7f0-bbc8-f913-d9b1-d7b492df7ef4@kernel.org>
 <0977c72a4f63132104736b9de8aa8246abb34894.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <0977c72a4f63132104736b9de8aa8246abb34894.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/2023 11:19, Maso Huang (黃加竹) wrote:
> On Wed, 2023-06-14 at 10:21 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 14/06/2023 09:37, Maso Huang (黃加竹) wrote:
>>>>>> I already saw AFE, why it cannot be part of existing bindings?
>>>>
>>>> Can you answer this?
>>>>
>>>
>>> Did you mean mtk-afe-pcm.txt?
>>> If yes, I'll modify mtk-afe-pcm.txt to yaml format, and add mt7986
>> to
>>> its compatible list.
>>>
>>
>> No, I meant mediatek,mt8188-afe.yaml.
>>
>> Aren't you working on some old tree? If so, please don't...
>>
>> Best regards,
>> Krzysztof
>>
> 
> Hi Krzysztof,
> AFE is common name for our audio hardware, and the design might be
> different for soc, like clock.
> 
> And the design is the same for mt7981/mt7986/mt7988.
> Is it better to create a new dtbinding file mediatk,mt7986-afe.yaml?

Is it different? That was my question whether it can be part of existing
bindings.

Best regards,
Krzysztof

