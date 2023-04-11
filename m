Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0A66DD562
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjDKI1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjDKI1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:27:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFDC4C0A;
        Tue, 11 Apr 2023 01:26:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0A4E666031E2;
        Tue, 11 Apr 2023 09:26:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681201566;
        bh=XuOTH3cHEPlON9QnLhoyvLswIctTTjWgzKO4CZvmkes=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Edc9DbRKhBpaEXqrP8ICK2TJ3Y89+56BkJ8a1lCfkCbZpa9B0R9uYWVXktu8RLQDK
         X17rYU65MQHvone0pf9E2HEI9fxeasyxrS2wITpgxpDuVOOPYSLJj76Fwv7zqCcgyx
         HrmIU+Bd7nhVlQAJt5I8pNTQOVG1omkYnORVzx9bto6sGUaf++Rv4CTsiKtMn6LRXr
         MdbSOYlPHLFIhD8zvUNaBNOfAGMM0JrJ4AxRvdHCt4xzwHiJLH69OWDBvMYIpTJ6Bi
         AUUgSFLNqUa0Z3jMmOX6s+fcTIs1yVsCqmNpspKGhB+ZWWvhJJlb7mDjfmzcD14fJo
         5KzBrgxXllVbg==
Message-ID: <a62c279e-80be-9450-5891-74b4b3994dd8@collabora.com>
Date:   Tue, 11 Apr 2023 10:26:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 1/7] arm64: dts: mediatek: add mmsys support for mt8365
 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
 <20230207-iommu-support-v3-1-97e19ad4e85d@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230207-iommu-support-v3-1-97e19ad4e85d@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/04/23 11:34, Alexandre Mergnat ha scritto:
> Multimedia subsystem (MMsys) contains multimedia controller, Multimedia
> Data Path v2.0 (MDP 2.0) and Display (DISP). The multimedia controller
> includes bus fabric control, Smart Memory Interface (SMI) control,
> memory access second-level arbiter, and multimedia configuration. It
> plays the key role in handling different handshakings between infra
> subsystem, video subsystem, image subsystem and G3D subsystem.
> 
> For more detail, ask Mediatek for the MT8365 AIoT application processor
> functional specification.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

