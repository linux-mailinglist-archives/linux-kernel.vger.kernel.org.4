Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A85EDE05
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbiI1Nnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiI1Nnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:43:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683DDA4855;
        Wed, 28 Sep 2022 06:43:39 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEBDC6601FFC;
        Wed, 28 Sep 2022 14:43:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664372617;
        bh=+RIOMcayb6puczD39TL+7nJiokkWKWlbI7Oy2aC8qbQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rivs3AOrVx6ktJZpOAaHnhTghpDRhU4a0d52a2eN6LBIcDUYZx8X/rbjXmAHJmICF
         OKmXUb4e9iRM/edZpbvxvsxyKqOHX+CfT5Bb4ClQLfrxSRKqteDT8H0MzG9KCIj4XO
         AzRJcmgBvCh4kcRvbHdvSvVt2ao/nq2rd7/RRSEsn5qDjD8HBEnDZ2F1yrmFl9ls7X
         6fONol+X6XW6JvmIWI8oTZeQe0cA/eGru3SSeXlyf/kuezeFLNVatkPLW6tLDU1eNn
         6Rnq/YmhH6+Cj1ErycVA6vgBt0QNLQItevQqMBTWkrXHObwuNRVZb/F8478P+MaDsm
         9d6zUA9xtIAFA==
Message-ID: <5c3765e1-6bfc-2a20-a647-0e651c40f48e@collabora.com>
Date:   Wed, 28 Sep 2022 15:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] usb: mtu3: fix failed runtime suspend in host only
 mode
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Min Guo <min.guo@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20220928091721.26112-1-chunfeng.yun@mediatek.com>
 <20220928091721.26112-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928091721.26112-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 11:17, Chunfeng Yun ha scritto:
> When the dr_mode is "host", after the host enter runtime suspend,
> the mtu3 can't do it, because the mtu3's device wakeup function is
> not enabled, instead it's enabled in gadget init function, to fix
> the issue, init wakeup early in mtu3's probe()
> 
> Fixes: 6b587394c65c ("usb: mtu3: support suspend/resume for dual-role mode")
> Reported-by: Tianping Fang <tianping.fang@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


