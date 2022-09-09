Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A855B31D3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIIIfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiIIIfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:35:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DB84BA42;
        Fri,  9 Sep 2022 01:35:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D95116601FB3;
        Fri,  9 Sep 2022 09:35:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662712539;
        bh=e5h4NsyYx1mTUec4+K2kbOsmzRKmrL5mll5JoXOlGyY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kEKqaNRAPl/lBJ29lA0IzL5j3kq8u1IlWhNBE9frxkoh7xb3DNQMBigx2woIWLOZj
         cZfnVTdHX4mAWms/tT0faWhkGgzYw9ivAHwx4EkKWWvaIePo1asQO1Kt232JT5/tBQ
         ut8Ox4WqW+gIOR0l16ZUvQ5JjX/2le4C6UT9RVpgIb5UpvP0/aYFZlc9WfSMOhuo0e
         cqDVgYK/M42huWhOSoWzDiYocT2V5IcKwW/cm8cB2Y7uZxtoGb699OVJ0nXhrcv+IR
         LO1qTxMWUe2xHA2EExlhI9tgXR8ruJ7TkCqHazWy/4u2p3XEF9HBkl4lfeaKbiWxli
         HXMibrGS7/tzQ==
Message-ID: <92c5a7bc-62ce-eeb4-f78d-8ccb39f03c7e@collabora.com>
Date:   Fri, 9 Sep 2022 10:35:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4 2/4] thermal: mediatek: control buffer enablement
 tweaks
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        matthias.bgg@gmail.com
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>, rafael@kernel.org,
        fparent@baylibre.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        robh+dt@kernel.org, rui.zhang@intel.com
References: <20220909073726.32423-1-aouledameur@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220909073726.32423-1-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/09/22 09:37, Amjad Ouled-Ameur ha scritto:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> Add logic in order to be able to turn on the control buffer on MT8365.
> This change now allows to have control buffer support for MTK_THERMAL_V1,
> and it allows to define the register offset, and mask used to enable it.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Hello Amjad,

I agree with these changes, but I can't give you my R-b tag: this driver
has been moved to drivers/thermal/mediatek/soc_temp.c and, as a result,
this series cannot be applied.

Please rebase.

Regards,
Angelo

