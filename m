Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11F6E09EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDMJQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjDMJQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:38 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE27993ED;
        Thu, 13 Apr 2023 02:16:13 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 686856603214;
        Thu, 13 Apr 2023 10:16:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681377365;
        bh=qah/T196BBIHxHtwXK40dRiVKbEiqh7RkQIU3gbUUsM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jc1+AQBL2TvYa0Qw4gP+JH+WlYX8F85rIMRgmuIDaHiPogKRrsnjuzp+KDjghSt4W
         6Uo5CDIsoGkLwEeYUMxOBZF4CkGPt8v7/xe2zJ9y2ALgkGAQ3TyyOvFy1Jo6QCne+r
         FSDDWAj42ApXQq/Rfc3hlnf2Ku9ioOh1fBf/A7NznDr2EOcAXyXrHYTZ9DLU6N03mj
         egDDO8IJDViAzItFMFbrtOt02jUrknP9r6pw5h0dxsjy3uKHjo5sdoaC7n8KED3IOa
         zf/q3DpjWWwDVAFDRNb4FI0tPchaboIXvUFUKLYNyQCtg0S6nRX+n3Us+c0+Cvh/jt
         2x3Y3vH8HBcPg==
Message-ID: <a4811a5e-704f-6b66-9f1c-3e40f54a462b@collabora.com>
Date:   Thu, 13 Apr 2023 11:16:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 07/13] media: verisilicon: Check AV1 bitstreams bit
 depth
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
 <20230412115652.403949-8-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115652.403949-8-benjamin.gaignard@collabora.com>
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
> The driver supports 8 and 10 bits bitstreams, make sure to discard
> other cases.
> It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENCE
> exists without setting bit_depth field in this case use
> HANTRO_DEFAULT_BIT_DEPTH value.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


