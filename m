Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EDD6A852B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 16:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCBPcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 10:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjCBPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 10:32:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CAA199C7;
        Thu,  2 Mar 2023 07:32:32 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1FD76602F90;
        Thu,  2 Mar 2023 15:32:30 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677771151;
        bh=1f/oX2S4XQLn2VKQigkcWoRHEZPUsJtOVJNHPLo3jIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LdKMV36r4oIJvm8klCfUdNbkFj8uuY4Kr2bS3kYTEZwUOTQZHO+REiLSaXfXRZIAb
         xZlFc5xXX4RuZvxW8tSH8gSC7WlScnFbo8nAEOgnmDgttftKZpkbLgsyvL1TPqUhCZ
         D3a2CfXtOfzMuujSJuZJjlW0XnEkTqwT0YH6QTZF0uyQVThXT6J1iIXncNhoepphAO
         waxlTYUCqm3eyc2yVhpD3h8zPTE7QftOO20XEFtNJtOToN0K2AUeFPe1dlytO7t6tf
         AlSSRJcb7cRgPw4A404XBZ2NcHc8fEjTorcou4yoM2acIVdCG44sPwByUj63CB7CFb
         wK7hImM6+tO0g==
Message-ID: <c15c9766-4a46-04fc-ab42-2396d0a6750f@collabora.com>
Date:   Thu, 2 Mar 2023 16:32:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/2] soc: mediatek: pm-domains: Add support for MT6735
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230302122708.73848-1-y.oudjana@protonmail.com>
 <20230302122708.73848-3-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230302122708.73848-3-y.oudjana@protonmail.com>
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

Il 02/03/23 13:27, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add support for SCPSYS power domains of MT6735. All non-CPU power domains

For the CPU power domains, I was cooking something locally.... but then I
stopped for some other higher priority stuff.

I'll make sure to ping you when ready, as I think you'll be interested to that.

> are added except for MD2 (C2K modem), which is left out due to issues
> with powering it on.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


