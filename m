Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8F25E9BE9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbiIZIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiIZIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:23:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2F91B782
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:23:50 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6D343660205E;
        Mon, 26 Sep 2022 09:23:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664180628;
        bh=JkMCzYNBMwFiR1kr8tzIGWnW7VICz8110t19kZ3Se+k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e7+EbbsdVJBfK95qRkg/rFlUgtL4cqB8HYCQ/OHRDRhQoz37iOjuSLFglNKU4sPDR
         wygiqD60y0wpHT0eeraZLqT4M74hvRAt0ZNg6JmwODfQMo5YS8bZYsFif5Z9HUEVM3
         JYE5+ptfrELe1Y8UOxGaByeE1Q1mycIpUlMRCFcBaorZ7Wj7u2ZydGuxegVSQFxjOF
         8qR3P+ykX6wjt+xlh52kRvhOSCUuIJ+lnKG3xMn3DBfMD/aLsMOFwnqaEYY9LAWTTL
         4SFnnDXFRhd/VemzqSeYjs7ROj8sGsg0ny7C30TlhUAJUKJDpSxRZ98H/wtkXu/COs
         5sIrvtFfqD26A==
Message-ID: <2b8c3749-0e3b-7460-82c8-b2c21ff5db8a@collabora.com>
Date:   Mon, 26 Sep 2022 10:23:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/2] ASoC: SOF: mediatek: mt8195: Add pcm_pointer callback
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
References: <20220924033559.26599-1-chunxu.li@mediatek.com>
 <20220924033559.26599-3-chunxu.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220924033559.26599-3-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/09/22 05:35, Chunxu Li ha scritto:
> Add pcm_pointer callback for mt8195 to support read
> host position from DSP
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


