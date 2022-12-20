Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0006651E24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 10:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiLTJ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 04:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiLTJ4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 04:56:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F07519014;
        Tue, 20 Dec 2022 01:53:24 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 491B86602CA7;
        Tue, 20 Dec 2022 09:53:22 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671530003;
        bh=X8hoapwEZc1dILsvgDGhhrYGjmxD0yFjqNZhtHPWXbc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YshjUpDyd0n3ET7nt4g7lY+C2qk+DkgXH4Tofsze0DDRRH8KZHTymjBrrHSPtahvt
         l9qbNMqSRjnHe+kEVgmGgJk+C2auUC94u9skCcKQm9H/wVe2Fsp7XDw4VaiVagD6CG
         CWB+YgiT5IqFN6aZbkDBJW4K+w5kbLoRxeZeWGLrnwpWWpuwpmv1oqjuWbM9VKeV1/
         I1Zrbf0sRT2gzodU9Jg5DLe6BZqUP50bYMLrIYAAaw67Y5OJpx5sgnD5MzBg5RcqZg
         GkvNe4KF21BviH+YmZCckqaZh7KuOWcHa46AOKXRwc9xv9dJaVwSnxidba2JcqnFBt
         VKPW9TYBNXTuA==
Message-ID: <4c198fb0-48a7-2e4d-3363-7eac47a0d5a7@collabora.com>
Date:   Tue, 20 Dec 2022 10:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [V2] media: jpeg: Fix multi-hw judgement
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        nicolas.dufresne@collabora.com, kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com
References: <20221216035247.18816-1-irui.wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221216035247.18816-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/12/22 04:52, Irui Wang ha scritto:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> some chips have multi-hw, but others have only one,
> modify the condition of multi-hw judgement
> 
> Fixs: 934e8bccac95 ("mtk-jpegenc: support jpegenc multi-hardware")

Typo. s/Fixs/Fixes/g

Fix that, please.

Regards,
Angelo

