Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBE367B3C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbjAYN7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 08:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbjAYN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:59:47 -0500
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADE54C0D3;
        Wed, 25 Jan 2023 05:59:44 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C47B085615;
        Wed, 25 Jan 2023 14:59:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1674655183;
        bh=hF1ni9xZEc4e87Ov1GWvFFjeHI102TRQGg1YSYLnp8E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=byG9OI4FWQ0AYExjY0RLv/IETk/frOjfBpVnevRdL9TuUfuPc+MHnMEYm40mBv3TQ
         8yhtlrZvmiNoIDB01H/bnyFpS6CpqLDqlJ9xE9FQ2jHswU/ltBJToYW/TvSE7Qe+kD
         Y9lrV2SKAtOOCoZ+OKpqM6i/yctx1voRqW7kaTn3Xho0UsiwU3yyDagn+AUOZLvcSF
         fRkRzg0C/p+CC0QXvzCm4fIk0UJd6AocR2wOR298b5IsfGH10NMOE9M4eYAGSGkE8O
         haHR701P1OeAp6RK5BH2n/yphxtjtfUYAzPJ8tAWsAPorHknyOXGcOBoCECK241sOw
         Y/4ZrXLdrov9g==
Message-ID: <d035621a-33a6-ca38-1bb3-726b3dd0eab4@denx.de>
Date:   Wed, 25 Jan 2023 14:56:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/6] drm: lcdif: Drop unnecessary NULL pointer check on
 lcdif->bridge
Content-Language: en-US
To:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     stefan@agner.ch, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        krzysztof.kozlowski@linaro.org, LW@KARO-electronics.de,
        alexander.stein@ew.tq-group.com
References: <20230125064030.1222121-1-victor.liu@nxp.com>
 <20230125064030.1222121-3-victor.liu@nxp.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230125064030.1222121-3-victor.liu@nxp.com>
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

On 1/25/23 07:40, Liu Ying wrote:
> A valid bridge is already found in lcdif_attach_bridge() and set
> to lcdif->bridge, so lcdif->bridge cannot be a NULL pointer. Drop
> the unnecessary NULL pointer check in KMS stage.

Is it possible that a panel (instead of a bridge) be attached to LCDIFv3 
e.g. in case of iMXRT ?

> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v1->v2:
> * Split from patch 2/2 in v1. (Marek, Alexander)

Much appreciated, thanks.

[...]
