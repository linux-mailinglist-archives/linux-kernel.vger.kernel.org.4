Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633625F0B77
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 14:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiI3MO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 08:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiI3MOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 08:14:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA2B17A5FB;
        Fri, 30 Sep 2022 05:14:22 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 95B4066022CB;
        Fri, 30 Sep 2022 13:14:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664540061;
        bh=8tHGfCw+vp0FbI3nyOeiRtXInzXUqDHc4IFqsrunjAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LPSdUI4KWdjHB68Y6tW7m60Moc8tHqLmw9cOcww6sglB9r43oXpRCPAVFDC175qBv
         0lrXfjQhaywhC+anRphKC7hWmdVu7tD4ZeeoC/RCwnrtGcQK/h0FZudXwdLbkaA+ml
         pD3y9wXGiwDyQRgpCi34+Md6zAdSwAuxqgXnhiBHkn6bl4erLM4FB9RYfeBmTPAlLH
         FYm7Cx5JOsxJad+5NtqQDfVZEofK6OCQ6kCsRntBKFBBUCI8oqzBVUunaB3D28ipS/
         VmSeCbv+0R+dIKVSzR/M0PIhn9/gohjqrPth9jwzPzdPGuH2vgpDokWzdtAjyRt9uo
         3M/5r1lLCo1JA==
Message-ID: <6eab4410-0284-0b09-e810-f979b8ad1d57@collabora.com>
Date:   Fri, 30 Sep 2022 14:14:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 1/2] media: platform: mtk-mdp3: fix error handling in
 mdp_cmdq_send()
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220930102306.13201-1-moudy.ho@mediatek.com>
 <20220930102306.13201-2-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220930102306.13201-2-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 30/09/22 12:23, Moudy Ho ha scritto:
> Increase and refine the goto label in mdp_cmdq_send() to avoid
> double free and facilitate traceability.
> Also, remove redundant work queue event in blocking function
> mdp_cmdq_send().
> 
> Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


