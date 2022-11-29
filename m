Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98E663C353
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiK2PJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:09:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiK2PJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:09:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36582286F1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:09:04 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC0ED660165C;
        Tue, 29 Nov 2022 15:09:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669734542;
        bh=dcuFXuyUO4u2FBDicBX43KEncCSh9cUMs/11eeCUzvE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oRMCZegNrpohvspElhK3dFjkl2MLJhdHERN+KOOENUn1PFF53MgBppv674WTAuEvx
         QDA+e6aiZoab1UgigopWThqHrLYkmK8Gno5V3KfTGMN3zyx0A5tp9L/+GgU0YxYZCF
         bJNf9Hv58eG07SYbbSrTI5/3aNIPc2Fr6EvyVg9wvQJh3Mc9bKGMooE5vzkaiYxPd+
         p331lpCfejTFCnrLV/4zrm7z74g4EkiClCwmTHBhNsmtTTYgwF99uAv5EzEdsvE7ur
         nW1qe0FzC6GZPmZz0nFmeDEskx9aq/fsSHI/q9EBS8PdsCd1Pg+WHv+5jji1HDQn4+
         ebZJPlzFVL05g==
Message-ID: <c2c32931-1fec-fcd1-8120-2d66b55d3f1f@collabora.com>
Date:   Tue, 29 Nov 2022 16:08:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2] iommu/mediatek: Fix crash on isr after kexec()
Content-Language: en-US
To:     Ricardo Ribalda <ribalda@chromium.org>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yong Wu <yong.wu@mediatek.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221125-mtk-iommu-v2-0-e168dff7d43e@chromium.org>
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

Il 28/11/22 23:16, Ricardo Ribalda ha scritto:
> If the system is rebooted via isr(), the IRQ handler might be triggerd
> before the domain is initialized. Resulting on an invalid memory access
> error.
> 
> Fix:
> [    0.500930] Unable to handle kernel read from unreadable memory at virtual address 0000000000000070
> [    0.501166] Call trace:
> [    0.501174]  report_iommu_fault+0x28/0xfc
> [    0.501180]  mtk_iommu_isr+0x10c/0x1c0
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


