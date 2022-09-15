Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6D5B94C2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 08:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiIOGx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 02:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIOGxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 02:53:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF475244F;
        Wed, 14 Sep 2022 23:53:52 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 26F0A6601FC1;
        Thu, 15 Sep 2022 07:53:50 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663224831;
        bh=6Txn5ld1tzrx/X57koJu/K1mXgPUdkwF0i1XHNrA1gQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e8WvwMMrjKXPwdLdAjhOKDvsTih9xWtESCNoUcWtVg+mXFDDvL+AEDD0nfFO06Qt/
         Nod8KqB3sCSIIa9tZqx9f1nXeWIAdSSL3M8mWmie3LJs/bMY9Uv2foY9tITP+vv/k3
         u8irgrtUdZye8EN/tagemfqDKV+rDROqOWnaXYlfv9CdlJ5kTAy5KniPciyJ2B62Zt
         LvoNBlrOBalU66W7TCVtPWByMZ/gO70zR+2VsDfKSghBj/Ingzrg+aT8b2VG+sWXLT
         zaG9y5+nPeZJsal+YkFKRL9I+2//DEAE8baepUun4yWd0X6QA4omgkqmbCmuhSsD2Z
         nkPtjp5w1z/yQ==
Message-ID: <0391732c-9ea7-19c8-0f06-4707611a5bf9@collabora.com>
Date:   Thu, 15 Sep 2022 08:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [V14,0/15] Enable jpeg enc & dec multi-hardwares for MT8195
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20220915064337.2686-1-irui.wang@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915064337.2686-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 08:43, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> This series adds support for multi hardwares jpeg enc & dec,
> by first adding use of_platform_populate to manage each hardware
> information:interrupt, clock, register bases and power.
> Secondly add jpeg enc & dec work queue to deal with the encoding
> or decoding requests of multi-hardwares at the same time.
> Lastly, add output picture reorder function interface to
> eliminate the out of order images.
> 
> This series has been tested with MT8195 Gstreamer.
> Encoding and decoding worked for this chip.
> 

Hello Irui,

I may have lost some piece of conversation on v13, but as far as I can see,
both series, jpeg ENC+DEC were picked by Hans [1].

If you have further improvements to that, you should make new commits and
not a new version for the series. Please look at Hans' media tree at [1].

Regards,
Angelo

[1]: https://git.linuxtv.org/hverkuil/media_tree.git/log/?h=for-v6.1n


