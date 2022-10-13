Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691565FD61E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJMIXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJMIXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:23:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2452A14D8C8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:23:34 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8025E6602363;
        Thu, 13 Oct 2022 09:23:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665649412;
        bh=fVC6xnbgLiAnAIsdaBvW8gzPF3wVy5bvHElOxonsk4k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=asdM2MqNK8Ejwj0MJSRCzLK8nUyQkQ5R9oDmp7oQhVersM4qBWSHsqNBbNlxjAKXy
         Uqi6aN1Z/m7jsUL2hrEdBSgL114dAWw/gX+PzD1r+J77heTnfoVS4SezhCMArc5O1C
         f6mm+1aMwiCEgTPf3NJeOhTha7ItmRtwI1vRWwI0m+aG0my5OGyI02HnXfSE5P7Ctl
         CyJ+WK0EPx62TfgHnQ5/FWcjf5MVjsUNy8E1oOErhmfRMt0hFuuirHqCCw+qbjOYkJ
         2IQ71FDgwG2qUmg5jlAKt9d23kqrB1CX+hk7AMcC+uUIoj4TxocRf6jxj0R47B7f4F
         tl7W+ER8VfVPQ==
Message-ID: <512c0be9-3315-1763-8053-835285fb18cc@collabora.com>
Date:   Thu, 13 Oct 2022 10:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     allen-kh.cheng@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221012075434.30009-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/10/22 09:54, Tinghan Shen ha scritto:
> In the use case of configuring the access permissions of the ADSP core,
> the mt8186 SoC ADSP power will be switched on in the bootloader because
> the permission control registers are located in the ADSP subsys.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


