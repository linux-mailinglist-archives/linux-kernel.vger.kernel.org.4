Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF0B671D05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjARNI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbjARNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:07:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A69D5258
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:29:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A1856602E0A;
        Wed, 18 Jan 2023 12:29:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674044996;
        bh=H1zVPKEUhT12KA+z/uL5nxzOq/6vUtEisSOkrk4sRng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PBM15/5Vdko7sJkmjzn5UvO5R/i6DsAxS/gdop6RrtvbvYZXNbdOKvKjPfmqlyfIB
         NLmPQYdMn+coV4Mna13TpjHq7bSSedDsiAgLVA1LHzj1mpfMtapHOUo3NJBkyc9tTE
         SxOsW9mWOR1g7iPrLoEPvDlijfVXRaq7VyInxsKqqnl0jzqVCh8/5AAzpMT+idd6d+
         YmbCfYNdwSuXugiLHA8Nzjq95RuikIN08x4tI2gGo8EbzEuEzBWoMefyteKaVj0C3x
         qXJkmmiq2Ajr1CNHKZoqk2qKKZnxEnFrpi12WP0Oh3wL+aUH8HGD3fVPhYCym8VgfJ
         JdmwnX+URYbQg==
Message-ID: <f48c29ed-9154-0936-64c9-d5aa8dc9cae3@collabora.com>
Date:   Wed, 18 Jan 2023 13:29:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v7 3/3] phy: mediatek: tphy: add debugfs files
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20230118084343.26913-1-chunfeng.yun@mediatek.com>
 <20230118084343.26913-3-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230118084343.26913-3-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/01/23 09:43, Chunfeng Yun ha scritto:
> These debugfs files are mainly used to make eye diagram test easier,
> especially helpful to do HQA test for a new IC without efuse enabled.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

