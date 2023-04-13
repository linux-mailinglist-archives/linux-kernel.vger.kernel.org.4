Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6976E09E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbjDMJQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjDMJQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:16:26 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADC39028;
        Thu, 13 Apr 2023 02:16:05 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D6D8660320A;
        Thu, 13 Apr 2023 10:16:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681377363;
        bh=LAwn6GIPy68/Ks2VLtbvBxgBI4vsmBbr8RULkvs3h1k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=a6ARSCDTK9AkZ2qRFLUBtbmCFuXGC/MNrRw5saYrulqSkZQBEZSs2FNh98heBoRIW
         jMkSD0ZyGU4Mm8tQgLdvhoMj/icqAm4H8hXEjIilP7v/QB5i6kt+sah+eMTNjWWSN1
         YLkU9HT8Ct1dXXjBUJ8Nzdqx77yhEVC7M4KpGXzT/jtJJytOTvpLI1eVmuirDqkV41
         Oef9+ZtbUD0eyS6yt6fDXOPe4Cd7n39BxEGIDMMA56jF6lgf6yKPKBLOrhwAg+PjEc
         1CxvExeA9g7lcxHNHnt2UNdi6GVcwE6L5IufxwYUWMI/zwYZTRm/iTBkWWKtiGOVOf
         xB9oqmFtN2KwQ==
Message-ID: <0a98a45d-5c5e-c438-2fb9-bd52782b56f1@collabora.com>
Date:   Thu, 13 Apr 2023 11:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v6 09/13] media: verisilicon: Add AV1 entropy helpers
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
 <20230412115652.403949-10-benjamin.gaignard@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230412115652.403949-10-benjamin.gaignard@collabora.com>
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
> AV1 hardware decoder needs entropy parameters to decode frames.
> They are computed from various arrays defined in AV1 section
> "9.4. Default CDF tables".
> 
> Add helpers functions to init, store and get these parameters.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

