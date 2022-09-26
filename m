Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF31A5E9B46
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiIZHzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234779AbiIZHym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:54:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B2D3A152;
        Mon, 26 Sep 2022 00:50:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6F7E6187F;
        Mon, 26 Sep 2022 07:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978F3C433D6;
        Mon, 26 Sep 2022 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178538;
        bh=Ls0crOyKk+lkt5TTs2uBxIeihBWmZjPuhe4cTEvU2s8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EEFaMW2CEFbnuKtlIjOgMxeDsj9tyJuHJZaXMY/oHyOOw1vDBO9xDon1sV7Bcv6yp
         Cf/J5L/E8oxCvjn+C3Ptog6MkUAxyq33d95WzV0Zhm+xDLlW74loKvJrlNI5Ezewut
         u+K9x+IpZVsl9/RhCopjzTHMFrqMAur5ojhymucQmWb0Lgb1+nfvXduEjlXGHwTzIi
         AzXkxrCHpRdUTb/XmOxI/JVtrwEwVXE0fG5UrUDkqjyzMND5e2xd7mbHHXHLiw3t1W
         voh4mA8XMMKaLywuwJxgLJPEj8EEfxcy/d8DQoodT5Nm15AinVEOGP0wlsWUZFK4V6
         tVdZWA+WyCRig==
Date:   Mon, 26 Sep 2022 08:48:52 +0100
From:   Lee Jones <lee@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        hsinyi@chromium.org
Subject: Re: [PATCH 1/5] dt-bindings: mfd: mediatek: Add scpsys compatible
 for mt8186
Message-ID: <YzFZZErEDZLC9Cuu@google.com>
References: <20220923131148.6678-1-allen-kh.cheng@mediatek.com>
 <20220923131148.6678-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923131148.6678-2-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Allen-KH Cheng wrote:

> Add a new scpsys compatible for mt8186 SoC.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml          | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
