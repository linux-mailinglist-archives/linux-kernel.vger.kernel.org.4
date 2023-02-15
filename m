Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C135697D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjBONWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBONW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:22:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4099EFE;
        Wed, 15 Feb 2023 05:22:26 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E47DE660218A;
        Wed, 15 Feb 2023 13:22:24 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676467345;
        bh=8H8mu9i21nD9T/tLzphFD5xIasNjV5ytwds1TrKkMF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AbxZjP977pQ/LXxUFxyMTCiOvBm/px39yNUb1Y3KW3ZAVWR6J68paW4DXlhBbKMWY
         J6vKmbagRTSzfYpSaBbPru77XJBbDx0AGbnMRH28c0C9GRGXts9kV9U9uYl+L4ap6L
         52DhYbhF4TlJ4ZcM5kGSL47eM++uQsoZ0xuJRCF90DzfA2NFQ/twU0Y1sYx4HJWRdb
         p/7QX1TPo9mNq58MfAuBeSu4SKnRxHwm5qb+yt5q3FSronItrUGvk17nst7lTtHyIk
         VaOUFyIG+5FstrwqYY/qO1AE/yJts4kMAD8VU918pE23VTcFkl7yKoHm72uTShhEpa
         5MnYDKNXfIYug==
Message-ID: <6ebab3c9-915d-0655-6ef9-6bf0ed2eeccd@collabora.com>
Date:   Wed, 15 Feb 2023 14:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH -next] thermal/drivers/mediatek: Remove unneeded semicolon
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, matthias.bgg@gmail.com
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Abaci Robot <abaci@linux.alibaba.com>
References: <20230215005457.21242-1-yang.lee@linux.alibaba.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230215005457.21242-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 15/02/23 01:54, Yang Li ha scritto:

Please fix the commit description:

Remove an unneeded semicolon to solve the following warning:
drivers/thermal/mediatek/lvts_thermal.c:520:2-3: Unneeded semicolon

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


