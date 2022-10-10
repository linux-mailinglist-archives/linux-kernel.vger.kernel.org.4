Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FEE5F9ACE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiJJIQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbiJJIQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:16:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04446580B6;
        Mon, 10 Oct 2022 01:16:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 28F1366022BF;
        Mon, 10 Oct 2022 09:16:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665389779;
        bh=Q9eAREEHziP8nHQElTxzJ8wlawGSUGr+M4Z+PjHuEcg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l6d7M/CqNsJ+afzGm150hXhd+/y9B+f98iadTxGubmrSRlEri38Ue3RzLcuqAFjU3
         a8mGkeUqPucq8MRl+NPkvd7/irygiyVxmLe3np0ATdNhRB1AJIS5dutIQfmMSJTta4
         i4X+AhQC89zmkRSB8uOBINRt0U7qrXs36YvTl4gsy+AvMeBqeZ+ClvacZDyWjFwXBG
         fZD56zihuLAhQStbJ/9hX76TZ22iZS+lrNS51AvlAY/fbKmcJlQSnT5dHPZ7xiBT9C
         SKaGnnzLJ2Ujk6urujJQFVd9+sQ5+A7zXjbjXgAe67vNLVoyHFjRhzTboGGKrjyzCS
         Ji/kaX3enBg0A==
Message-ID: <2ccaa072-a224-241a-ff2d-c38a5cd07dc8@collabora.com>
Date:   Mon, 10 Oct 2022 10:16:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 04/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6797
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-5-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221007125904.55371-5-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/10/22 14:58, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Combine MT6797 pin controller document into MT6779 one. reg and
> reg-names property constraints are set using conditionals.
> A conditional is also used to make interrupt-related properties
> required on the MT6779 pin controller only, since the MT6797
> controller doesn't support interrupts (or not yet, at least).
> drive-strength and slew-rate properties which weren't described
> in the MT6779 document before are brought in from the MT6797 one.
> Both pin controllers share a common driver core so they should
> both support these properties.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


