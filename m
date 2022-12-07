Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD684645ABB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:22:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiLGNWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 08:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiLGNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:22:05 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7C313E92;
        Wed,  7 Dec 2022 05:22:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 842456602BB7;
        Wed,  7 Dec 2022 13:22:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670419321;
        bh=5IvuM0VxRR2WGFZC4WAyEDPJdPLpL4jxxdvYzPTnkAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NVdEgp8g1QR/7fKNyrRd+8VM11louL3qmrQWF4rrKPMSGk7HKAOuP2MkyZARtLztG
         f5gaXhnkZu5m1vvoUzl3bHH2Ld0qa1TXPxzmAkyKJtfsYaRoPLZL6/c5wxKazv7hMC
         YlFuTgp3dUhZns+ssFjO3xgwnQWct076Cvo+1iUSJgpI6GRs9JfjJrLMeaOX2QZV+S
         qa3at/oDoCqiOLoeuIOB17hDkJnAA1v/43PBHidZzq/hYY48+6CKgs9iKDy/0bUxMU
         Gd/3RafdctTZrVARA/SJEvGLglKmlCoaSIh6BHv8L3p+6gsBgQDlYRJoSN6zbmqlhU
         l62MoP3834h7Q==
Message-ID: <8bec1bdb-2e22-d2bd-18bf-505f6dc75024@collabora.com>
Date:   Wed, 7 Dec 2022 14:21:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] spi: spi-mtk-nor: Add recovery mechanism for dma read
 timeout
Content-Language: en-US
To:     Bayi Cheng <bayi.cheng@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuanhong Guo <gch981213@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221207055435.30557-1-bayi.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221207055435.30557-1-bayi.cheng@mediatek.com>
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

Il 07/12/22 06:54, Bayi Cheng ha scritto:
> From: bayi cheng <bayi.cheng@mediatek.com>
> 
> The state machine of MTK spi nor controller may be disturbed by some
> glitch signals from the relevant BUS during dma read, Although the
> possibility of causing the dma read to fail is next to nothing,
> However, if error-handling is not implemented, which makes the feature
> somewhat risky.
> 
> Add an error-handling mechanism here, reset the state machine and
> re-read the data when an error occurs.
> 
> Signed-off-by: bayi cheng <bayi.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



