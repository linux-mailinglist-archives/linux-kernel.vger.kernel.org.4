Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C5865E988
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjAELIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjAELIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:08:14 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34850CE35;
        Thu,  5 Jan 2023 03:08:13 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D62196602D2B;
        Thu,  5 Jan 2023 11:08:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672916890;
        bh=1kiw+Nt5XgcB53KKtDr+R7gkEeVhhmQpgaGQMdBRJJw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=A/WUTsHeShksuISQG/AgxAzAP+CQx4dsDGsshFDwf7Y+EJ0M+6JbGDxb+WgGAJchO
         Xj52jqtomYFQt+1VcX+K067bieQDQhr8hVb51KtxInDykCrZcIGCpbEDRehVeLxXcE
         XOUlL1WrU9oxXh4Ys9JrxLrIeuCea1/Y0FQoKeGxc69WTO1Dx86RXQEE9+LqghwSBX
         GL0ylej9Xm8ktH+VG+nmrclvwLCjZSvP50ToR8fJC8YOhXxVDQ8t+Th4p5NCvzKHec
         FYEXPwDGwa2FmR62+v2CDROQUOQ3rOLY0zMEt0z6OjnfqXBPiuMTcFb+7FByrrKBJD
         vVwAqsGA0TwhA==
Message-ID: <710ca95e-bb57-a487-aaf9-1861b7dcb703@collabora.com>
Date:   Thu, 5 Jan 2023 12:08:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 05/13] ASoC: mediatek: mt8188: support etdm in platform
 driver
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230105081606.6582-1-trevor.wu@mediatek.com>
 <20230105081606.6582-6-trevor.wu@mediatek.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230105081606.6582-6-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/01/23 09:15, Trevor Wu ha scritto:
> Add mt8188 etdm dai driver support.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


