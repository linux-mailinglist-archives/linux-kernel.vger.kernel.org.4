Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1906E09F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDMJQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjDMJQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F4F93C8;
        Thu, 13 Apr 2023 02:16:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 38488660324E;
        Thu, 13 Apr 2023 10:16:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681377369;
        bh=a2I5H+WB1TxkrH1dm3ImGJqhxgziFp5hG0P83Gvt+Uc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Q18crtWI1odfN366x9o53ws3e+MnEQT6FIvedD5i+VWR2vewrdGKlf43dVcGqw04t
         XznBqqroiZ8YTSeaDFxRrXyyeKj2l/H4y36pduD2W1FtgBxd+W7/CO8aVoEYShCyRm
         BvOvsQUIiL9KiE+GhwtlXWBrWaSQSGQt7KCxERrPJ7XEwbDa5fOl3PSxo5vay2ETCX
         u0Trze7n+HKY78/tDkgeuG6wK8PdVACZnnzR2aha9NYcNJP7rQ+Vl1ullBDWQAFngZ
         Cp/EHk9Xzbgb59oXGVEYYucZK3NLHMLOzA7A0z6OQus8PnSYkQbIeomblE+hRBL3+B
         t3Rp8qUJKpBaw==
Message-ID: <c0ed53c9-0a52-f4e9-eb37-e4ebfda6e4ed@collabora.com>
Date:   Thu, 13 Apr 2023 11:16:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 05/13] media: verisilicon: Get bit depth for
 V4L2_PIX_FMT_NV15_4L4
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
 <20230412115652.403949-6-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115652.403949-6-benjamin.gaignard@collabora.com>
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
> Let's the driver knows that V4L2_PIX_FMT_NV15_4L4 is a 10bits
> pixel format.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


