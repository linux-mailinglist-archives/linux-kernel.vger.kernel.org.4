Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574865B9601
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiIOIN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIOINu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:13:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B1497B0A;
        Thu, 15 Sep 2022 01:13:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7170D6601FC3;
        Thu, 15 Sep 2022 09:13:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663229627;
        bh=VPuQR9Du4i9yIimRE+t5swTTL2W5uqbp9UKeIKGtM1c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I07YgfMNasLM3gjhtd54h1NIvUyoCDEvELWZaGhEK0/DPNQ0/hOS1QDd5rOLRSxCR
         z7fMWvGFjq2eqL5C9mvZ0VyZa/GSx6khdm61wFCC1p98sApkFPXcgf0MWHEi7mnQiA
         LylI970hRBodDUObasBfx4l0cHgoMENb/1YufqMWT/z+w4vWsInrLMFgF0EEr9wwCv
         EoHPUC1l9voinbdL16gSwY0Yt9pPpWVjA2AjIJlcq8DUXXXcL0fJmm+BEVB+Qlowq4
         ylb0Ni+YV1VXVHq3pPfI76DvSYS4lEJ6+x4w0LDG1kIYAG6+9JTBChjE6v55H8IXon
         jCNHkXmIr/Oxw==
Message-ID: <9e0bc249-73cf-90d8-02d4-e9bdf8f34056@collabora.com>
Date:   Thu, 15 Sep 2022 10:13:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 4/4] arm64: dts: mediatek: cherry: Add edptx and dptx
 support
Content-Language: en-US
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220915075849.1920-1-rex-bc.chen@mediatek.com>
 <20220915075849.1920-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220915075849.1920-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/09/22 09:58, Bo-Chen Chen ha scritto:
> - Add pinctrl for edptx and dptx.
> - Add port for edptx and dptx.
> 

The commit description is not great: explain why this board needs eDP/DP
(so, explain that eDP is connected to internal panel, DP for external display)

Thanks,
Angelo

> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>

