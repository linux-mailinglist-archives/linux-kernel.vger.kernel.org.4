Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E877179F3
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234487AbjEaIXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjEaIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:23:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5AE93;
        Wed, 31 May 2023 01:23:31 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6EE4A6605840;
        Wed, 31 May 2023 09:23:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685521409;
        bh=QJJfRgbF1c9dgsjXGl4uw2rELU2wPtTiuT9g7crBEQ8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KticNSratfrZh1EW/aI6qGYOize5LrGr7VLm10c2Gg7HPksNXOIKrYk99nXtlc8uL
         FKISYjA3PdQ/YJAzsfpzJagMzTH/SpeDtERqcEIxdCpm/jYse3TuXuTyv5RjpYS3B9
         DGUoUQxPl4OdyrYXcb9dD+ImXeYHYEQjTVyyrs4dTq23P4BeONPne/L8VuTAYds8In
         dF34hzB1YeuHaLALzFTUNPYjuJ+a4FnpibxL8wc9sexhjwfmkzeQX4NUhHbjOj2QvU
         /R3qy8KOpWUFQPVbrxX7prNipHKYdWtuk8BlKkx6VrUOBRCbt2nxY4gBkNmFV+jau9
         qTgn4fgWTXH7Q==
Message-ID: <3c2e384b-a6a0-25b6-5ea0-78ad24377bd6@collabora.com>
Date:   Wed, 31 May 2023 10:23:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH stable 6.3] arm64: dts: mediatek: mt8183: kukui: Add scp
 firmware-name
Content-Language: en-US
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230531074421.888652-1-hsinyi@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230531074421.888652-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 31/05/23 09:42, Hsin-Yi Wang ha scritto:
> The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Since I have suggested to backport this patch to relevant kernel versions,
and seen that this patch was already picked for -next:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but you haven't Cc'ed the stable list, please resend with

Cc: stable@vger.kernel.org

Thanks,
Angelo
