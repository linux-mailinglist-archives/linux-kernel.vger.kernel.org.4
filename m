Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CFD6E2115
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDNKiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbjDNKiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:38:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EBF7DB6;
        Fri, 14 Apr 2023 03:37:59 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 700026603222;
        Fri, 14 Apr 2023 11:37:57 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681468678;
        bh=BUuGaSkZM2nCpFU3QyykMjfVSkXvIL1wWXGYo3FGrgw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aaQRE84z8irPODJ03rRb32DA02APcoi4S2lmY6kpI8sCSWhhS2EJmqmrLn7MRQBSB
         2Ixia+BLNrJhPEGKM/1Thg6/qpbqr/T0YtFfMr24rZpJ20AOxKAOB0+EJkYDfB0XuE
         B/F8MSKt9KR3sUZHW8FD07zJT+2TOWdXY2Z8rKZoMjLHWkX9BKNajyENFC7mbNi2tM
         T08NxTeTC7+q5V5S1mwgLGDNY0aw3twwbJYDp8cP+V4/ygsLctsBtDOsD/OFJLLEla
         VbCD7U1LKFe6ziaA7WsZu62S3JUVLpLa0mP39Sge4c/os2FoV2EhWcJtJ7t8V6Ho6u
         5mSu2S+P/rf4A==
Message-ID: <27eb4047-636b-6460-fd48-ae4b606956f0@collabora.com>
Date:   Fri, 14 Apr 2023 12:37:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 12:47, Benjamin Gaignard ha scritto:
> ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
> so assigne it to vpu_fmt led to crash the kernel.
> Like for decoder case use 'fmt' as format for encoder and clean up
> the code.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst formats in reset functions")

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


