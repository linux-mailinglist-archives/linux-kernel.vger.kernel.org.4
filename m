Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6EC691EC6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 13:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjBJMB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 07:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbjBJMB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 07:01:27 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771FF34035
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 04:01:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DB29166020D7;
        Fri, 10 Feb 2023 12:01:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676030485;
        bh=pZ9qevw7fCReyRLFCyksKqNzLLJU+iQDcQl8RJbAtYk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IhcKxm3xRqksDbWYIraRfKY7UuJ6eeQ8a7ayIZqbiTGlEo/d2TpZeljFwOmGMasE3
         1lhEZo++OrjdEMcLcPxZL3rLCTwhJKoonmP+yLhRKaMe9go7+RRZw0lKOmq/IJ2CSV
         hOGsBsktArV6O80GQmmtqQnrjA6qAApJfnooYh/5jgWweKwI06u/e3pwgx7pxZwZNf
         H8kONoNgyjm9oRiueSGwPrkew8dgI4jUcKsr+O4IO/SjgaQglyF3yorrmoUHOoRB1f
         WtTdJVMKylfHK8QLn9b0kBVJ6bV0NwFGEEGFOHR9ANyxdsssy1AvrqMvtX0pHda5N3
         berTf+B7Bik3g==
Message-ID: <12ff7576-76d3-8cb6-4c8f-6c9417ac28c2@collabora.com>
Date:   Fri, 10 Feb 2023 13:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] soc: mediatek: mtk-svs: delete node name check
Content-Language: en-US
To:     matthias.bgg@kernel.org, matthias.bgg@gmail.com,
        roger.lu@mediatek.com
Cc:     nfraprado@collabora.com, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230209162403.21113-1-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230209162403.21113-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/02/23 17:24, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The function  svs_add_device_link is called only internally from the SoC
> specific probe functions. We don't need to check if the node_name is
> null because that would mean that we have a buggy SoC probe function in
> the first place.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


