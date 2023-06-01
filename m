Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AA9719848
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjFAKFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233349AbjFAKFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:05:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB341FD2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:03:13 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1896A6602242;
        Thu,  1 Jun 2023 11:03:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685613792;
        bh=fBGL4bPqrWdlEx8OCDvLG0uYfi343SDPLIkWwU5ZiK0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=POcatlQ+8JMl+loYBG85HYHQ9cQPvs/hL3XzH0Zdbb2NGX2H7TnZkWYxaP61MAykd
         mI/bdIT+3WB+37YWTwrzPLYxg1mbUV+2AHZ+Y5gvvl6PZ+yJ0oulJ97HMcwPYZYGlr
         V/GmGNPh70TffnKo7CNx0K+UdTlBY/lnPodb6ykFTC79druf4Bqn/FD+atu1GpE0m8
         WQ87UbMG2dNpudyYJ1aQpPpoPw2LQA4Emk+5RRa44tzLZ/hocffZPJga5BV6x7MvmB
         K6kM5FJzu0cxBhZrcvxbyYNPgoyo3DlZTbJa+IxddVMK2YPGWikx/IVqaF5D6XXpDV
         KQjpImX8cbeFw==
Message-ID: <21719c2d-a465-35eb-8ce6-8ad3a376b883@collabora.com>
Date:   Thu, 1 Jun 2023 12:03:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 1/1] ASoC: SOF: mediatek: add adsp debug dump
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>,
        pierre-louis.bossart@linux.intel.com,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, lgirdwood@gmail.com,
        tiwai@suse.com, perex@perex.cz, matthias.bgg@gmail.com
Cc:     yc.hung@mediatek.com, tinghan.shen@mediatek.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601034939.15802-1-trevor.wu@mediatek.com>
 <20230601034939.15802-2-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230601034939.15802-2-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/06/23 05:49, Trevor Wu ha scritto:
> Add mt8188 and mt8186 .dbg_dump callback to print some information when
> DSP panic occurs.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Yaochun Hung <yc.hung@mediatek.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


