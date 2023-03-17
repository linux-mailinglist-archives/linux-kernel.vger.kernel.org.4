Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B506BF1FB
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 20:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCQTzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 15:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjCQTzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 15:55:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C285422C83;
        Fri, 17 Mar 2023 12:55:00 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C1AF066030C4;
        Fri, 17 Mar 2023 19:54:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679082898;
        bh=xUkcVXnyTuTsmAI0NLMHRHqskyN4MCp0kwSVC7VaIMY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1GA1r2CQzoOUARFqEqGeWG95yccuewWR/wmYs+KK6oUouC4k+KOCz+ZZzpTeKExy
         wRXD2cUWmenfH1PbHLYezgOmBy/fpYKgzCRxIhesaVKXnWCyYyGbMsqNDme2HYjYmX
         Oq7hYyr/jmpTiPwa09MFeg2U5icaF0MQn/1YHUp+2qmlY6wcHIJs1Qd1i5seHj02se
         PS9HTYyqLwVD3E+G+yO5Zlkbpveq39VAltdpcoLmBLMeza9Si0Ogn9fs0pCIUHv+6U
         qASBE6rjOmNuo6uaBt7LbNfPNdfGyXBzq5ZJnB7xxq0Vo1fBrXRhz7SQ1hArmBMvYx
         rb0oDKZxxgnig==
Date:   Fri, 17 Mar 2023 15:54:53 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3] arm64: dts: mediatek: Add cpufreq nodes for MT8192
Message-ID: <20230317195453.lpymxjk7oqvbxkq5@notapiano>
References: <20230317061944.15434-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230317061944.15434-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 02:19:44PM +0800, Allen-KH Cheng wrote:
> Add the cpufreq nodes for MT8192 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested on Asurada Spherion Chromebook as well. In particular, verified that
applying this commit makes suspend/resume work. Before, it would hang during
resume:

	Enabling non-boot CPUs ...
	Detected VIPT I-cache on CPU1
	GICv3: CPU1: found redistributor 100 region 0:0x000000000c060000
	CPU1: Booted secondary processor 0x0000000100 [0x412fd050]

But with this commit applied the machine is able to proceed bringing up the
secondary processors and complete resume.

Thanks,
Nícolas
