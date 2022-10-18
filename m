Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67FB6028BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiJRJuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJRJue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:50:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942692B60D;
        Tue, 18 Oct 2022 02:50:32 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E41846602334;
        Tue, 18 Oct 2022 10:50:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666086630;
        bh=HfceC2aAwhgWtVVcIcG4NNLS5294fMdqXNStPSlbxDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RmxVfyxpOundxTRNDFpEJpaJSfO6XVh046emRYMEp/ytLA0guvbX8cXguC/jnRt+D
         IivPzC2SQlsUQorWcCdNL/xrwC0IG6g1BTMX2/wpOo0vJS4kOy5USqnnP20QOQ98YI
         EBf1/WatdRvRojOE4YzjC12SWNelM6Pvm0og/mEV8lQrRv11Oohqi3amLiHe1L9OVl
         3YMK7tbTk4N/akX0eHOGtV2ZmnHq5Rn/uu17aro73Rn6ktZ7xdu1pnahbem+KF9P4h
         H3vXYlu09s3LZg0wZhkmr1gF5IgPcstsvQs4mAyau21E6RWMaojzUgmdGnlIZPKAVT
         MGGe2qfFSxGZg==
Message-ID: <438bf06d-c4f4-74b2-8903-e89dc52196a7@collabora.com>
Date:   Tue, 18 Oct 2022 11:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 1/2] mmc: mtk-sd: add Inline Crypto Engine support
Content-Language: en-US
To:     Mengqi Zhang <mengqi.zhang@mediatek.com>,
        chaotian.jing@mediatek.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, wenbin.mei@mediatek.com
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221017142007.5408-1-mengqi.zhang@mediatek.com>
 <20221017142007.5408-2-mengqi.zhang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221017142007.5408-2-mengqi.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/10/22 16:20, Mengqi Zhang ha scritto:
> add crypto clock control and ungate it before CQHCI init.
> 
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>

Hello Mengqi,
I'm a bit surprised that enabling ICE only requires enabling a clock as
on downstream code I see some SMC calls to MTK_SIP_KERNEL_HW_FDE_MSDC_CTL.

Can you please explain why SMC calls are not needed here?

Thanks,
Angelo

