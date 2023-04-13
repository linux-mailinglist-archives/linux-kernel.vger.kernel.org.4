Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548586E09F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjDMJQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDMJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8799752;
        Thu, 13 Apr 2023 02:16:16 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4AFFE660321E;
        Thu, 13 Apr 2023 10:16:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681377367;
        bh=n7y1cE2MUgJTJW2qjt7n2PuEhypkBndzpVE2ASPTfwM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CHZFVKk2Ag9o/l+eJFxejpb0qa8QgiH/1y3ABkzTXOFsmNU582JqqZnNqJ3aqj2q0
         KrLAR6lT+bWNpQ2aoV7iChYaM0Z+u6OiN59/f5+p1/DkM+tY2jsuHFLojfGKOArYx6
         0+qD7Alv5mbDl/S+IXz5ZtLUzrn1PEa/XHrrxN9f8asYbrrR6x1qdsJs0/1M9x3XhT
         52SK8o1qzpHz5nc4a+HtDsNYP1ZDJYCZvxP6W1AYQTQ/C96Xt7DooBL2+BdPVnIX6r
         8IjcdAL2CNvGKLzDcwvLwqhmrpxLjG/TM9oJXbdbTCGnGFD/0640Z34LRWUY80m7oo
         3JDU58wO/JZDQ==
Message-ID: <156c1295-a288-3263-7d3b-416cae3147d2@collabora.com>
Date:   Thu, 13 Apr 2023 11:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 06/13] media: verisilicon: Add AV1 decoder mode and
 controls
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230412115652.403949-1-benjamin.gaignard@collabora.com>
 <20230412115652.403949-7-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115652.403949-7-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/04/23 13:56, Benjamin Gaignard ha scritto:
> Add AV1 decoder as new decoder mode to Hantro driver.
> Register needed AV1 controls for the decoder.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


