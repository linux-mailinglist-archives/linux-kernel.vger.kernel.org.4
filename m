Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386D65B98E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiIOKeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiIOKeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:34:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43D298A4C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:34:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C68D96601AAA;
        Thu, 15 Sep 2022 11:34:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663238049;
        bh=J5mscqBjskoIJTmbE49fccjEFLGV2r8MvVioIABdkxI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dKPxgbQRShNmGL/b7jZx4PFKNG282zTyXxU+SfgKnAbV4J6/XFebgfvLrEn6pGQYt
         xgThBVrgkdLdLKlmjs+zn33eG57xjFbB2AOdRagNudkFEaGNghFNB80NPjvM5AqBGk
         I3FWJCRpuDyZUXbfoItND/0tPF/peiUJw3580L6T3aRZLuzP0Ust49x2AKczfZo2yP
         OVSJ5Jxa7tS4KXIpll+cEgFvlwh0FxosQUuV7q1gGC1E0PmMFp05tyTvIGGTjPztmb
         HdNUnD3thRUbkvjOwrWpG6TEJ5KEL4T2ZiDDunFB3MgKIZ709DdrmSXjJxibvI1jDr
         6saRbAzdJcLOQ==
Message-ID: <47c6f2a3-ad38-c9c6-544b-5b2d1a234593@collabora.com>
Date:   Thu, 15 Sep 2022 12:34:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/3] drm/mediatek: dp: Refactor drivers in
 mtk_dp_bdg_detect()
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie
Cc:     matthias.bgg@gmail.com, granquet@baylibre.com, daniel@ffwll.ch,
        jitao.shi@mediatek.com, ck.hu@mediatek.com,
        liangxu.xu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075028.644-1-rex-bc.chen@mediatek.com>
 <20220915075028.644-2-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915075028.644-2-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 09:50, Bo-Chen Chen ha scritto:
> It is more clear to modify this in mtk_dp_bdg_detect().

I agree with this commit. Since you anyway have to send a v2 of this series,
please clarify the commit description and title, something like:

drm/mediatek: dp: Reduce indentation in mtk_dp_bdg_detect()

In order to improve human readability, reduce the indentation by returning
early if the dp/edp cable is not plugged in.

Cheers,
Angelo


