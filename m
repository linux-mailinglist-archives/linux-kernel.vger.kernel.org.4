Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9FEC60F2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbiJ0I4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiJ0I4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:56:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBE1981DB;
        Thu, 27 Oct 2022 01:56:45 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 43D8366028C5;
        Thu, 27 Oct 2022 09:56:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666861004;
        bh=a6cv56mnR0Rt8cN4YKAatcPuhZ/rCh1tcmynK4XFuOg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BBuplJME/3Ry9esnd85HoFScshBaCRJ3gPCteMWzG5cHItSysPoYVvyTxm/ztzz5j
         Wds+Y58IPW17ZCZgy6GmiEDamt2BzaHBGx2IEK478u4jtpMgG43BrFEauMA3tZu/Ei
         DRA6ATGcfILQBfMyhPLBO+eqQ/oCMQlyXVlJuuPdtSv0E4KUqqIi2g/PPXIMYya+KH
         k/7XwwTo/ojIVEYTJwoy+rCxNBRR35O5RNtlPrGiheqky5MKtOIUm3eq4VBfdn/FMA
         gvw8IUQvmPi7ryZ5tZiY6MxinnS1cDRqmMG6e3fpPs5cpv4qIiP0jjxIODZL/4HFXH
         raqDX+y8f9VSg==
Message-ID: <54b9bf61-3db0-c2ca-9c30-f2434573be29@collabora.com>
Date:   Thu, 27 Oct 2022 10:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] dma-buf: cma_heap: Fix typo in comment
Content-Language: en-US
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     yj.chiang@mediatek.com, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221027072642.23787-1-mark-pk.tsai@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221027072642.23787-1-mark-pk.tsai@mediatek.com>
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

Il 27/10/22 09:26, Mark-PK Tsai ha scritto:
> Fix typo in comment.
> 
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


