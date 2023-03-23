Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166956C6281
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjCWI6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCWI6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:58:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C6F3C39;
        Thu, 23 Mar 2023 01:58:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D616A66030B7;
        Thu, 23 Mar 2023 08:58:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679561891;
        bh=e/oqoIOkUG0wo3orInZZuihofftZH8U+TexqRWVw3pQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VszBHvgC50OVPmQY4vR7n0kKNyEbylf0+xDIfH6R+Rsz3jU5CN32pjYVMHEtWnQoK
         R1Jwjq5UYYebPuQH4xMCB8UCdZhUiGzf/ksWmKY7u9eI7EGTEg6l3KWE5U6HGsL/eB
         t2fY2wlNj1iW6ZDzstPZU3WZkBaYQ7GlzdAey4duj5sCluTbvX5qb0CNS/cfxJcgyw
         6WnX6q+SU5H1v0W5qYFlmfDJ1y8TKSRoYOywpIokF1Omjl/4kWNQ7R2kH1txPNUtbD
         nTfUMXCklPGMqIjyvwd1Mr73pFTDWBIfYDxiZa0/aOberevX3KD4Ycs2ZALNakDdLz
         H88dCNP0P/V/w==
Message-ID: <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
Date:   Thu, 23 Mar 2023 09:58:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
Content-Language: en-US
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        CK Hu <ck.hu@mediatek.com>, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        singo.chang@mediatek.com
References: <20230321121859.2355-1-nancy.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230321121859.2355-1-nancy.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/03/23 13:18, Nancy.Lin ha scritto:
> The hardware path of vdosys1 with DPTx output need to go through by several modules, such as, OVL_ADAPTOR and MERGE.
> 
> Add DRM and these modules support by the patches below:
> 

I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks.
Green light from me.

Chun-Kuang, can you please pick it?

Thanks!
Angelo

