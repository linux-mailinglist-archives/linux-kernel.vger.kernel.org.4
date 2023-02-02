Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0904168784D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjBBJIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 04:08:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjBBJIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 04:08:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29C5FD3
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 01:08:21 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 719246602EDA;
        Thu,  2 Feb 2023 09:08:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675328899;
        bh=5IakbPPTAHlstWlMaParv0t58Oe6vt85g0wiRgRU03M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AhJLb6xZ/WrXG051Pd9hnZMFZididw3HEhWfNcyYmcyYlxZorcpLJ43/xX4lHOkHm
         T7an22q8EKxOvfoZaT7MzjEC3zZr25DQC5iiTGrr76VQ6TWTSUcrSI8UIJ41lFUSan
         87WsaiLeOOB0TOOBeIswrszW2PdYwP/UNQPE8qJI3xFMoBv/U8FYkfSPVA2fJrGlEW
         f2oNjJi9cIwRguMO7le/Y7krXBonv6PjymZWsVyRelhDZgHTiztw/2U7ySsoTarioO
         ojIUAPMIdNcjCMIZOsQoIgP+DRyZrZRXMyiar+6GKNyFavbySmPJv/j6R/+FLXz/Io
         IR8ovNuCfoRPA==
Message-ID: <4db8fb55-a02b-d98e-65f4-1a095c43104f@collabora.com>
Date:   Thu, 2 Feb 2023 10:08:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: Update entry for MediaTek SoC support
To:     matthias.bgg@kernel.org, arm@kernel.org, soc@kernel.org,
        arnd@arndb.de, olof@lixom.net
Cc:     matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230201152256.19514-1-matthias.bgg@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230201152256.19514-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 01/02/23 16:22, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> The linux-mediatek IRC channel has moved to liber.chat for quite some
> time. Apart from that, not all patches are also send to LKML, so add
> this ML explicitly.
> 
> And last but not least:
> Angelo does a wunderfull job in reviewing patches for all kind of
> devices from MediaTek.
> 
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>

Is a R-b tag appropriate here to say "yes, go on with setting me as a reviewer"?

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

P.S.: Thank you :-)

Cheers,
Angelo

