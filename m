Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C868C63CAA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 22:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiK2VsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 16:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbiK2VsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:48:06 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D2E65E50
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 13:48:05 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 8A9ED80431;
        Tue, 29 Nov 2022 22:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1669758482;
        bh=mANR0UVrLcSrd9Dn90ATJVmgqbNIRPSwBxDgu+wIe9M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=vL7xA2LWjrg3HdMONbIhy33xgvY5WxeAeBhVY+o+WgYQ2Knxt/aHvV1a241kQcGtN
         JxOUI7i1vk0bfJyeuNZDFFbBz0XLteCtdYqRt1t5Pczq3jfyUU75zSanOgodfD2pec
         BMCeRskb62vn18mchScNmFDNTW8T17aJZ+maITMLzARcGsE2yjHs/UlwjcvfxoCz8S
         iJQny+Qls8GYDzYHEwEfCz2RxSVkQ9IQwvoLWO6t7mWZwnZBakQPi/OzZv+Ywftl8X
         sazTSCXDi60pAd/cxRUVb2lk/KeI4uWokSOFE1s+L5ej9l9aVWKdhb5RMNX68IeCGv
         5Q67ZaXlv6W5w==
Message-ID: <bcfa5a05-892d-3a18-e5f3-a77ed74a62a9@denx.de>
Date:   Tue, 29 Nov 2022 22:48:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 07/26] drm: mxsfb: Define and use generic PM ops
To:     Paul Cercueil <paul@crapouillou.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221129191733.137897-1-paul@crapouillou.net>
 <20221129191733.137897-8-paul@crapouillou.net>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20221129191733.137897-8-paul@crapouillou.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 20:17, Paul Cercueil wrote:
> Use the new DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro to create a
> "struct dev_pm_ops" that can be used by this driver, instead of using
> custom PM callbacks with the same behaviour.
> 
> v2: Use the DEFINE_DRM_MODE_CONFIG_HELPER_PM_OPS() macro instead of an
>      exported dev_pm_ops.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

[...]

Reviewed-by: Marek Vasut <marex@denx.de>
