Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C10736594
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjFTIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjFTIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:01:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431371730;
        Tue, 20 Jun 2023 01:01:00 -0700 (PDT)
Received: from [IPV6:2a01:e0a:120:3210:6e77:5147:3eca:d8bb] (unknown [IPv6:2a01:e0a:120:3210:6e77:5147:3eca:d8bb])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 508876602121;
        Tue, 20 Jun 2023 09:00:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687248058;
        bh=7QcfFKjwwy3oIIB+optJvNNXQHWLLCPVIQa7o8GKpg0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oPBoKjsVECgNIICizc0K3KRL8pDEGtMWD6uDQ+v/UXXuwBMTVuSzaqBJDXY50eNnu
         uhIUE2jI27bbn2XTsQBEEfL1Lyz/Ut4vciK9Wu/zJT2NLLaYHwtUE0w70nYa+b7ONe
         FpqOloQJvxn8k7aRs6IWGxsDDf0UrRmgMftQVQxTKg7dAoztx7pZHtnpBtQjrFvHyg
         0KFRZR7lwXba2N0o/WArAKzkSVjWUPPsKFwWLm3FXtrDeyF4eCIVJHgCuO11AgLBHR
         74UYPvwq8ME5s0bD85U/AxgWFh2LwyKLqhZbida9cK3wN0tLWCSMzOJtquknmZF/jO
         7KnB/00teWKig==
Message-ID: <707b241b-c361-afde-c264-b3cd54f81f44@collabora.com>
Date:   Tue, 20 Jun 2023 10:00:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] media: verisilicon: change confusingly named relaxed
 register access
To:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230616144854.3818934-1-arnd@kernel.org>
 <20230616144854.3818934-2-arnd@kernel.org>
 <e264ac3a15e0f115aa7e941a77eb312429b8f65e.camel@collabora.com>
 <063a8886-fd31-425f-901c-fc830512eca3@app.fastmail.com>
 <d9f088d1d548c8735b393a15d5a16dbd914ddeca.camel@collabora.com>
 <300ecb3e-8747-4399-8452-77724f85330b@app.fastmail.com>
Content-Language: en-US
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <300ecb3e-8747-4399-8452-77724f85330b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 19/06/2023 à 21:26, Arnd Bergmann a écrit :
> On Mon, Jun 19, 2023, at 20:29, Nicolas Dufresne wrote:
>> Le lundi 19 juin 2023 à 16:49 +0200, Arnd Bergmann a écrit :
>>>> In this text you spoke about potential performance side effects of existing code
>>>> and your changes, but its left all very vague and theoretical. Have you done any
>>>> measurement ? Do you need help with the manner ?
>>> I don't have this hardware and have not done any measurements.
>>> Obviously the only point of using relaxed accessors is to
>>> improve performance in critical code paths, but from the way they
>>> are used here it seems that this was instead just an accident
>>> and nobody else did any comparisons either.
>>>
>>> My guess would be that if one wanted to speed up the register
>>> access, a better way would be to use a regmap cache to avoid
>>> reading registers when the contents are already known.
>> All I know is that for the majority of registers when programming stateless
>> codecs, each 32bit word of registers are fully written too, the read value is
>> not always meaningful (its a value from last time the HW has been triggered) and
>> should be ignored, so better to not do that. As for regmap, there is folks that
>> have reported regmap to be completely overkill for this type of hardware.
> Right, most likely neither the cache nor avoiding the readl() is necessary,
> and that was exactly my point to start with: don't add potentially dangerous
> microoptimizations like relaxed accessors unless the obvious optimizations
> are also needed and used.
>
> Obviously, testing my patch would still be a good idea before applying it.

I have test the patches on IMX8M (HEVC decoder) and RK3588 (AV1 decoder).
I notice not regression or problems, conformance tests scores remain identical.

For the both patches:
Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Thanks for the patches,
Benjamin

>
>         Arnd
