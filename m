Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807386DFB57
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjDLQ06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjDLQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:26:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AE3DC;
        Wed, 12 Apr 2023 09:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5077D62E8B;
        Wed, 12 Apr 2023 16:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAFFAC433D2;
        Wed, 12 Apr 2023 16:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681316815;
        bh=AmBsB2SaL2/nqORtPMIw+AC5nOY+5hArVvhxKihAVlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HpqLETwJGWpvpVscapsgzgCNberlHMLS7pXWQ3MzMO9FnXwsxZT2m8rX2I7fvpWzg
         8qPSwy7V+MqT4yKLXK+sU5JsmvyqGh9Ibr3WOIDgCtpcNWo5JleVRFXt3LCrt4ao0Q
         Qr5Nxz1e2PjsIQk3qXHcY6ImMlC95nlwQLENfnypTkJEnm2p77H+6MQ9ziQ+dULuf2
         ahGJH03k1XslFI3w+0Q0Ch9ccTMGoklsT9/NqKMc8/eqqboTDTUQ8NKe7phh/LTOK6
         Tb3LMA2pKxlWMUYejrIQARkySmeY8/k3Q1cbndSWcf4vDRfD2YajWqf5bgiJaDwo10
         XDVMiS1iv/DUQ==
Date:   Wed, 12 Apr 2023 21:56:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mac.shen@mediatek.com,
        stuart.lee@mediatek.com
Subject: Re: [PATCH v8 0/3] Add MT8195 HDMI phy support
Message-ID: <ZDbby+Tem2vcvhBn@matsya>
References: <20220919-v8-0-a84c80468fe9@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919-v8-0-a84c80468fe9@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-02-23, 17:02, Guillaume Ranquet wrote:
> Add support for HDMI phy on MT8195.
> 
> This is based on top of next-20230213

Applied, thanks

-- 
~Vinod
