Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 240F266D8F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjAQI7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbjAQI7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:59:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0271A96A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:58:37 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C233B6602DEA;
        Tue, 17 Jan 2023 08:58:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673945916;
        bh=qZ+2xKymdUypitvlKKjz7KHoO9yPt9+lbG67OmfsHqw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ws4EqmRtAQMLebfZgqH0BFKZbXDC3qbakcrpV1Y9xK7bDCDxBKxbIarOq7A5GV09+
         muWw68KwYfHhH2YAe8yxQsVF46gGFMOHGCxlQ86/nhHtsQ93BVIFkHXg+k41LzvAc5
         lS8SePnxG1GXfOheZW17bXk8v5MM8XpObbYPQfWqwf8nQJsyr4JZaji0Bnqz6T6W6Y
         tRiUl1QVAr7kWZr/mEKr3DQCC2Z9dcpaylzr77xkWH8i4MUp2Q6BqosiP+q2GQLz4T
         CQPDJkTkLFxalrYEGP78d0fDILP6dHDPPcMvU4s8UgHZHME/iuCblv+mtRCVJT2W6z
         5gIuNnm9ExqzA==
Message-ID: <0588c60f-6f72-db6c-aff2-2921f89b4956@collabora.com>
Date:   Tue, 17 Jan 2023 09:58:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] soc: mediatek: pm-domains: Add buck isolation setting
 in power domain
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230117032640.13504-1-allen-kh.cheng@mediatek.com>
 <20230117032640.13504-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230117032640.13504-3-allen-kh.cheng@mediatek.com>
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

Il 17/01/23 04:26, Allen-KH Cheng ha scritto:
> In some chipsets, we need to disable EXT_BUCK_ISO before turning on the
> specific power pm-domains (mtcmos), such as ADSP in MT8192 and CAM_VCORE
> in MT8188.
> 
> Add the MTK_SCPD_EXT_BUCK_ISO flag to control the buck isolation setting
> in the mediatek power domain driver.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


