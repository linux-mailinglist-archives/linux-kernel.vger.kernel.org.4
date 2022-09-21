Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E403A5BFDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiIUMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiIUMSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:18:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F384B96FD0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 05:18:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9416C6600010;
        Wed, 21 Sep 2022 13:18:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663762681;
        bh=ZqLHdcmZ3jM1WLgRQfy/dghDg8AblsWqEL1j75mDDJ4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JgLMbHtr14YD0NJw96u62HHbnIPkNyWHmQTWLMe2lDPiHzjbMPk6ds5swVfk8S1Q8
         SLXGwlaKhEetj1yy7nMHlZe95lbBiRNGeIoCnK3BSdL4PvcRy7F2YhtaAkmbMRHlFh
         QaHw5soZow7GVt9GZ4gL0acRAJSS5KmANMqZOa/wr2cRnFOghlk5J5LXClcV5pPKTB
         ic5alO6vUbtxg/hfHepE9R4foLLaZFl+AhRBovlvi6BDBBGFa7HUpxkd/u2Xrn4xL9
         CRrB5jRuHS0RqsHv7EG9A9QbKW3mKukzdLgGT8sj3G2qMyYJI8lG4n13Ox5kgsI6RN
         IiCOX4Z9m3Kog==
Message-ID: <dbe3f7fb-5fae-b147-f824-cd39ba3900ca@collabora.com>
Date:   Wed, 21 Sep 2022 14:17:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] ASoC: SOF: mediatek: add pcm_pointer callback for mt8186
Content-Language: en-US
To:     Chunxu Li <chunxu.li@mediatek.com>, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com,
        daniel.baluta@nxp.com
Cc:     matthias.bgg@gmail.com, yc.hung@mediatek.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        project_global_chrome_upstream_group@mediatek.com
References: <20220921120239.31934-1-chunxu.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220921120239.31934-1-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/09/22 14:02, Chunxu Li ha scritto:
> add pcm_pointer callback for mt8186 to support read
> host position from DSP
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Hello Chunxu,
Can you please also add this, along with the .pcm_hw_params callback to mt8195.c?

Anyway, for this one:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


