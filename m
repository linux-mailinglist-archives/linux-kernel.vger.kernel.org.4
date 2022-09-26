Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C9C5E9BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiIZIXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiIZIXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:23:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CF222BE9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:23:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AB697660222F;
        Mon, 26 Sep 2022 09:23:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664180630;
        bh=mQyvu1ScEHkd61hzAOnaU61WIDBcOrPXfYxLmQ5wJ7Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KfDYT4icIc/2yq/2SgtoNp8u+hOtidbqB4DY8R2vieQGKH9O/XW8Wl1+dV3BX1JDK
         GqyBAcQR0o8gfDZVNKCuIOA7p3Ng8KSWljWGiVNEXloXkcWaDA1vpk6w3UHI89eDKf
         Lq9I52r3BzFvIaFytSheCH42Z5usCmK2zKcWYMuMBVnwzIM73JMJQxWhUO0xHFO7uD
         ouGE1KjFJ/gwk5csTMjM147jBqaKOdijSw/cpbSBdvz1j00EC1ugqfUq/1RjYoIEZb
         PIsyohUn6z7yDv8EM/qbDzuiNkLzVCCpjwFyeftKZVIjR45epVf97YGWHxFO9/np0g
         TUGy3xQ7Z3IWw==
Message-ID: <7e752eda-2851-b13b-9a57-920ade4bacfd@collabora.com>
Date:   Mon, 26 Sep 2022 10:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/2] ASoC: SOF: mediatek: mt8195: Add pcm_hw_params
 callback
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
 <20220924033559.26599-2-chunxu.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220924033559.26599-2-chunxu.li@mediatek.com>
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
> Add pcm_hw_params callback for mt8195 to support continue
> update dma host position
> 
> Signed-off-by: Chunxu Li <chunxu.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


