Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0A5627D3B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbiKNMBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:01:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236973AbiKNMAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:00:51 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E290320197
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:58:55 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5800A660231C;
        Mon, 14 Nov 2022 11:58:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668427134;
        bh=7cfvQwecvCp1TEqF//QrQMv/w1uD2ZumJgbzfvJ4Xd8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S2LYLaqUAWRVibS90bE/PO8KElQdQQyWN98Ep/6TiwhwnmdlNZRKS2o4DrHQM9hLs
         je9Tzxra63NpHp6dzV6tlawpt/17IJyJ8ZZlhjq0NREXHjy65pL99yHRqG1h13aKRo
         f3NOJiQRv4B0kOLAcdkHXPdXELI+QbsXpjVSWxE1p/aQIa5Wum4KYdCd0FpTq9Z7jL
         Zou8nZbGDEbL01UcWUbGmqX2c2roRsIxgxhcgHypWkObMMsBhsiUjjHYh5FtzReSvo
         TAhT8EVGh0T71LI7hs7Hdzgpzjx6gZlGOYcGUE5lON9lqkRfAYvXsA15HLT/eWP6Vf
         QXOZ69+UnaNxg==
Message-ID: <46c17d4b-d130-86a7-b5f8-73c30d7fdfdd@collabora.com>
Date:   Mon, 14 Nov 2022 12:58:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2] soc: mediatek: Add deprecated compatible to mmsys
Content-Language: en-US
To:     matthias.bgg@kernel.org, matthias.bgg@gmail.com,
        nancy.lin@mediatek.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221111082912.14557-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221111082912.14557-1-matthias.bgg@kernel.org>
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

Il 11/11/22 09:29, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> For backward compatibility we add the deprecated compatible.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...And tested on MT8195 Cherry Chromebook.

Cheers,
Angelo
