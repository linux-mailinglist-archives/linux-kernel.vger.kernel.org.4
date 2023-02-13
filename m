Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1BA6948C0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBMOxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBMOwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:52:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC541C7CC;
        Mon, 13 Feb 2023 06:52:38 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 841D1660209A;
        Mon, 13 Feb 2023 14:52:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676299956;
        bh=FuwwZwXsBgBDZDXz+btVCJiK7TvAR9ew7WIV1Gkdg2o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YyX5CZuGsThkzfpQ65RDbFd3vWmv/GrIE8WEiVbRahgab7YS35IaHKNyz3YUywqHH
         Z41n+zz+5CrqFFBimmHUgwbfiRXO17hGEvZlic5g3bY5uawR3Og+s2vGS3mTNc8TWJ
         U6o+tVLlFNkTjQIWP+SqAdgExzxU9p2M7SK/7JBEqSxE2SxgUh2ZjBVi3+n45sm3YA
         4QVkIMtHJPOW+EUKNgRDcv2hspU43PwiLeXesSF/q5H5gssgzSIh6u1UZv6a68ZrSY
         Zvsnt5rXtGu5R1CHfwh+LP/oZDPx3G7o8CXV9QwpacfcE6LS8jnUNqOdaSO18HOmBu
         C4Yx8P+oN2L9w==
Message-ID: <200fafc1-04be-2464-b973-232d16a9bf8d@collabora.com>
Date:   Mon, 13 Feb 2023 15:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 05/12] remoteproc: mediatek: Add MT8195 SCP core 1
 operations
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230213033758.16681-1-tinghan.shen@mediatek.com>
 <20230213033758.16681-6-tinghan.shen@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230213033758.16681-6-tinghan.shen@mediatek.com>
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

Il 13/02/23 04:37, Tinghan Shen ha scritto:
> The SCP rproc driver has a set of chip dependent callbacks for
> boot sequence and IRQ handling. Implement these callbacks for MT8195
> SCP core 1.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


