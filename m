Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFDD674FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 09:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjATIxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 03:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjATIxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 03:53:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E0E8B30C;
        Fri, 20 Jan 2023 00:53:25 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53BE6660087F;
        Fri, 20 Jan 2023 08:53:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674204804;
        bh=SSwbJApT+7gQSGJQ/b+H3IPkK4hbO5OL73lIyx5BgMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kcehd1Jq0FFH+HQ+lMBOMtNqdZL8spAJ9jdGNO+emTS4Z8FfWmjNxzsZ6z91dBcRS
         sk3QV21MV/sGyRubA2G1w7oKJC2Wiv3Ztqb+bmMgMgWnR7x5+1xolzymlS+lPXV3Yi
         EQUliJay9oJaIGofsVKJ+pWgYMgCZd3H9U3y/49ZpACz27d8LMhAjMGusTCQulCyuh
         c0nwhN2QoVqEshjdLoLyjdovy1IQsGbm6n4p3Wm4kCPq3RTeaNYw+tSV9BypiEZqFo
         lGlCzin0xwqbTBqu1r4SgWoyzV/GT4sjdJf9ggFebVJpoHNdy4ZsSjmtMB/Fs4nvuH
         Wj+8EvBtTSqLQ==
Message-ID: <23691243-303b-5f0a-df59-f272137e083b@collabora.com>
Date:   Fri, 20 Jan 2023 09:53:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 2/2] thermal: mediatek: add support for MT7986 and
 MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>,
        Chad Monroe <chad@monroe.io>, John Crispin <john@phrozen.org>
References: <cover.1674055882.git.daniel@makrotopia.org>
 <2d341fc45266217249586eb4bd3be3ac4ca83a12.1674055882.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2d341fc45266217249586eb4bd3be3ac4ca83a12.1674055882.git.daniel@makrotopia.org>
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

Il 18/01/23 16:40, Daniel Golle ha scritto:
> Add support for V3 generation thermal found in MT7986 and MT7981 SoCs.
> Brings code to assign values from efuse as well as new function to
> convert raw temperature to millidegree celsius, as found in MediaTek's
> SDK sources (but cleaned up and de-duplicated)
> 
> [1]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/baf36c7eef477aae1f8f2653b6c29e2caf48475b
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


