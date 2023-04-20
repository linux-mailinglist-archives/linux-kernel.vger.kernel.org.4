Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977CA6E9727
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 16:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjDTOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjDTOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 10:32:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC914203;
        Thu, 20 Apr 2023 07:32:32 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E063E6603265;
        Thu, 20 Apr 2023 15:32:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682001151;
        bh=+TVWRubMAjRGPp7QPq7BCPc3y2bv7sKk2mvQp0XR9e4=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=DwKLq+3Ti4XpC+rjzkMoBCLlra80K/O3SeBpLyKMv9BjhtKOQI/v3FpKbuBdArkUV
         cEcJB9MxeHYiFZB/N2BxWCjYo0MxFw8mmnYCJ7B8rZbZ1VXlh/9ltVWT8ogR6rDkWb
         idFuTKbS8PxEY9IVyrYxYjTp9Mj+5jCulTz2arWXFIczoaUJMYqAH7Y4akXMXSG1P+
         Buz6Vtq2FgEYcZ5ChfS62icntVGqOTI4OXNVjbnR7P6/K08VPPycXhAVUWeYtNrs+y
         hT5c8SoYM6lMxwNdcnTqlrdAT9mNhF1SiSOaN8pGHNvKzphLgfiubSUDUKh7yhKkQy
         7kK1Og/YmAM2g==
Message-ID: <99c2ec7c-bff2-fa50-f267-d5ca383bd5ca@collabora.com>
Date:   Thu, 20 Apr 2023 16:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/2] pwm: mediatek: Add support for MT7981
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Crispin <john@phrozen.org>
References: <cover.1681992038.git.daniel@makrotopia.org>
 <7c6e31c844642c199f223f4229a04a37b57a34f3.1681992038.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <7c6e31c844642c199f223f4229a04a37b57a34f3.1681992038.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/04/23 14:36, Daniel Golle ha scritto:
> The PWM unit on MT7981 uses different register offsets than previous
> MediaTek PWM units. Add support for these new offsets and add support
> for PWM on MT7981 which has 3 PWM channels, one of them is typically
> used for a temperature controlled fan.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

The implementation is good now; there's only one nitpick: you're reordering
the platform data entries and I agree about doing that, as they should be
alphabetically sorted, but you didn't mention that in the commit message.

Please send a v3 that mentions that you're also reordering.

"...while at it, also reorder..."

After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
