Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF962B5E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 10:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiKPJC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 04:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbiKPJBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 04:01:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3921AF33;
        Wed, 16 Nov 2022 01:00:59 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 176E26602A81;
        Wed, 16 Nov 2022 09:00:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668589258;
        bh=GuVy2p92QW9W2mJLHekEdzZ8JahojsK0Oac56TKj1HU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CXKCdNla+P8jvn7BrlpAFuFlr4aWU/rubMcEDE6lQ78vXLYnSbQhRUVbqYgagAS6n
         Ps0XyzQuavM0yLSNpKvlEm1Kdalv2t4TzYJe5fdFt3lsvSv0Aq0DSC8pkqoWGEHePW
         0+lemygkwEauNI6ATm/uWO5fXjB3FuZaVUQ7SYERjpK3VSZjJapV/OV63IrvEbR5eV
         XOSkFymt4UtY9OJ9NEqMGmYq1jSIYmkZQ6e4j0sLotYcsL+ZRfmuwsmwjDOZgFyC4N
         dl7LGj37drAlcyXM5c4eOaTYCUA5IGp0xifi+8FtUrx6MvvUEMEBap9XTq38A7tUNT
         U29nwQVQ2klnA==
Message-ID: <f60ccd79-9c82-0844-2c5f-21ec29c14dcf@collabora.com>
Date:   Wed, 16 Nov 2022 10:00:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 05/11] dt-bindings: mailbox: qcom: Allow syscon on
 qcom,msm8976-apcs-kpss-global
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jassisinghbrar@gmail.com,
        srinivas.kandagatla@linaro.org, jic23@kernel.org, lars@metafoo.de,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        evgreen@chromium.org, gregkh@linuxfoundation.org,
        a39.skl@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-hardening@vger.kernel.org,
        marijn.suijten@somainline.org, kernel@collabora.com, luca@z3ntu.xyz
References: <20221111120156.48040-1-angelogioacchino.delregno@collabora.com>
 <20221111120156.48040-6-angelogioacchino.delregno@collabora.com>
 <14947ae2-c8d4-de86-ce9e-29175e73cbb2@linaro.org>
 <9f3e88fa-0aaf-2edd-366e-c3f5b2269dba@collabora.com>
 <513a2dc3-d053-6e4b-a125-394cf1f6c81b@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <513a2dc3-d053-6e4b-a125-394cf1f6c81b@linaro.org>
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

Il 16/11/22 09:57, Krzysztof Kozlowski ha scritto:
> On 16/11/2022 09:52, AngeloGioacchino Del Regno wrote:
>> Il 15/11/22 17:44, Krzysztof Kozlowski ha scritto:
>>> On 11/11/2022 13:01, AngeloGioacchino Del Regno wrote:
>>>> MSM8976 supports SMSM, which needs this node to also be a syscon:
>>>> move the compatible to allow that.
>>>>
>>>> Fixes: bcc8d70f912d ("dt-bindings: mailbox: Add compatible for the MSM8976")
>>>
>>> I am not sure if this is still a bug. Maybe just a missing feature?
>>>
>>
>> This changes how you use this mailbox across the entire devicetree (as other
>> nodes will not use mboxes = xxxx, but qcom,ipc = xxxx as syscon), so I think
>> that this is not a missing feature?
> 
> Whether it is a bug depends on existing usage. If none of msm8976 DTSes
> use it the other way, then it is just incomplete or missing support. Not
> a bug. If existing DTSes use it as syscon, thus you need to add syscon
> to compatible, then it would be a bugfix.
> 

It's not a bugfix then. The Fixes tag shall be dropped.

Same question like the other commit, should I send a v3 or can it be dropped while
applying?


