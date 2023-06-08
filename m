Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C744728281
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236996AbjFHOTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 10:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236998AbjFHOTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 10:19:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2102D57;
        Thu,  8 Jun 2023 07:19:09 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab] (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC1666606F1C;
        Thu,  8 Jun 2023 15:19:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686233948;
        bh=3Ay9KItCvB4tjPS0pabV6VBP6LlYMUrgGWWA7iE/XeY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=j+N3fGagIxl8zeYXgk4PexHnCzGUlfxskwHxuFYKZd6VGEzqsZu3h4HwG1mkPFCyZ
         yGu8HwkyNDwr3IGDeZKLAlcD4HCEpbXznnpbZhUxATX66L4JOv2gN1YK9j1puHQC9s
         YP8/p2g5d+9G1cCVIDpWYYIiToSjYHkjyXkCMfCqLqIZjcWYjNBbnnv0SGofo3Jlzj
         rzp/0l27dtERWbNvAFGG60Ywn19j72J0FIJDx4qdkqWWPMZAWSdDfFhlxz/55QmfLr
         fSgidUGj3R0OPtW63ObSdD0sN73dJcpO0lV0H/dP0j/0Z0JS1ZxwleV//44oVvgZ4Y
         J73EKXqBT9eww==
Message-ID: <10daa0d3-951a-72b8-f8f4-48defbc42586@collabora.com>
Date:   Thu, 8 Jun 2023 16:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] arm64: dts: mediatek: mt8186: Add GPU speed bin NVMEM
 cells
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230607090653.2468317-1-wenst@chromium.org>
 <20230607090653.2468317-4-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230607090653.2468317-4-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/06/23 11:06, Chen-Yu Tsai ha scritto:
> On the MT8186, the chip is binned for different GPU voltages at the
> highest OPPs. The binning value is stored in the efuse.
> 
> Add the NVMEM cell, and tie it to the GPU.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


