Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85C863D3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbiK3LA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiK3LAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:00:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11202748D6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:00:22 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 35FC36602B30;
        Wed, 30 Nov 2022 11:00:21 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669806021;
        bh=u9Hf8fb2wkuZTn14GmxwJyRB86szK4ksntM7PiVG0SY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HRvIXJ1/iWohl8AyG5Zl/CkNVTrdyazzQ8aBH2BDVYoLG8sc1lTF8H/bVqxUtwB4R
         nZQVd9bQosAo2rgf4J2uyAX9iSzGwFwj0R5Bs11GlXijpbKnFi/NR/SNXLN4FZH4wi
         WHreNcd95chi4SzQv5H3tO+RB+fThoYR6PAUfdAy2sw8XRWLZC/qBBdYiJj6D9TCfw
         RzBjgpHsMiIPsSaO/JDKwq3wmKKWS6OsK61wjvpvJw9XSJAtKVvRrPpQ1z2J0tA3Al
         +7cuBycU5FNNQlv5OUqYOhJfx0iX6awXthFgF6xgwSf6qnPuca2/C9AzS3oZXXgvpW
         oGxUK8RXsJndQ==
Message-ID: <d683a2e7-b886-9bf6-27df-d8c67cedbbdd@collabora.com>
Date:   Wed, 30 Nov 2022 12:00:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] soc: mediatek: mtk-svs: Enable the IRQ later
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221127-mtk-svs-v1-0-7a5819595838@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 27/11/22 21:22, Ricardo Ribalda ha scritto:
> If the system does not come from reset (like when is booted via
> kexec()), the peripheral might triger an IRQ before the data structures
> are initialised.
> 
> Fixes:
> 
> [    0.227710] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000f08
> [    0.227913] Call trace:
> [    0.227918]  svs_isr+0x8c/0x538
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


