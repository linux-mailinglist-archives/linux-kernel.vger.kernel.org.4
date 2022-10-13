Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07965FD610
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJMISH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiJMISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:18:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017A211B2F5;
        Thu, 13 Oct 2022 01:18:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E567A6600371;
        Thu, 13 Oct 2022 09:18:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665649081;
        bh=Uu5rbmrfroLdLSqOR0v0a9UJfb8k7vbHXqzMAJmPRYE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CyJfw0tT3OoEdHdBd6mo1gu16SOMZHEBKGmV2FdEYLjlbrkXgZ/4MaDZlDIGKJMi0
         BW12aVDG2Hh/1DBNtaJzRhmNIX2ojPHOB0xkGlNQpXlVvB0TK5DnOuLHN0UQ5V35rP
         45OwgZ/8wdmGHZbVqRe0lGBAvkV5lP2mL6dGay0iS44qkOWf6cvTSXs8c7nRQLX59R
         eJXJl8uj4qN9VYOBvAaWNu0fPPS1tpJbCbq7SVmgoQtVtqmU+U6GBp2mLAPvvkixkz
         lmZ37jNw2J2/kcLxY52b0gWFLjf5I9W9XA+ODtUY548kk95FRt/ww/Vos2LCWhw9yB
         aHHjPVAloiz/g==
Message-ID: <14228ff6-f2de-6d85-d0ee-41983941659a@collabora.com>
Date:   Thu, 13 Oct 2022 10:17:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 4/8] arm64: dts: mediatek: mt8195: add MUTEX
 configuration for VPPSYS
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20221013020329.8800-1-moudy.ho@mediatek.com>
 <20221013020329.8800-5-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221013020329.8800-5-moudy.ho@mediatek.com>
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

Il 13/10/22 04:03, Moudy Ho ha scritto:
> In MT8195, the MMSYS has two Video Processor Pipepline Subsystems
> named VPPSYS0 and VPPSYS1, each with specific MUTEX to control
> Start of Frame(SOF) and End of Frame (EOF) signals.
> Before working with them, the addresses, interrupts, clocks and power
> domains need to be set up in dts.
> 
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


