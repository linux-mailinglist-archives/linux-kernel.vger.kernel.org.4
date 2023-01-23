Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC8C67807E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbjAWPuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbjAWPuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:50:51 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3225613D65;
        Mon, 23 Jan 2023 07:50:48 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 55C9280375;
        Mon, 23 Jan 2023 16:50:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674489046;
        bh=VTlv3YsP2wm7T9L1A08tQyNMzWRUjUZ90k0GT+bcFF8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rvq2PVwjbm9dwMsrydB/G1Eu/X2snK/6cK8A0hdqoHvHPowFKX+P8jKdYwlRGTh5E
         tVH14bwPJmxR3AXoLGcDvfKCRiUwsWW3gvdYph07ggiA6O0j+1qNL7N87XjKSvG/e3
         UE5aYLMJnLo+jgNnVu7ZJ4swq5QO2gteA0XDrnCUdowv/UYmzzxK6uuZvg8alS2zrE
         GhZCCCfJ3tirVBQaN/aoFkfp9DDe2NWrcWCFR5NqQ5JMumUKYosz42Jx0ec8Yv3mao
         wAAGI3206J70YwR4LCUAmsaEijyBHbRPtwjMiVnUeCmCkFQOM2TQ2FJ2sbqXKklbV8
         Rml3vl32reHJQ==
Message-ID: <43f3c323-4757-8fe5-415f-aa7fbea7bcab@denx.de>
Date:   Mon, 23 Jan 2023 16:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] dt-bindings: lcdif: Add i.MX93 LCDIF support
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com
References: <20230123072358.1060670-1-victor.liu@nxp.com>
 <20230123072358.1060670-2-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230123072358.1060670-2-victor.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 08:23, Liu Ying wrote:
> There is one LCDIF embedded in i.MX93 SoC to connect with
> MIPI DSI controller through LCDIF cross line pattern(controlled
> by mediamix blk-ctrl) or connect with LVDS display bridge(LDB)
> directly or connect with a parallel display through parallel
> display format(also controlled by mediamix blk-ctrl).  i.MX93
> LCDIF IP is essentially the same to i.MX8MP LCDIF IP.  Add device
> tree binding for i.MX93 LCDIF.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Reviewed-by: Marek Vasut <marex@denx.de>
