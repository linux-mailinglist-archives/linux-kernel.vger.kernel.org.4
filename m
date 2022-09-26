Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1325E5EAA78
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236436AbiIZPV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236247AbiIZPUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:20:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9727083BE2;
        Mon, 26 Sep 2022 07:07:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3256B60DEE;
        Mon, 26 Sep 2022 14:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E362BC433C1;
        Mon, 26 Sep 2022 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664201232;
        bh=ySnah8bvB+A3n/zCRB87xWDZuvHSaOZd/TpqYUZjtnA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aeS8lkLOd6ACEAGMd5VNRciESUfEdDm0v1dPZkJm5OJHNr6VcAvBUXdLDesLKdIH/
         gRfMnSlfZAWqkz5W/yj68CkKsSxcBX+KsmS1Ay8qzAFxyRKjWZBpRtwKoYRa+dc/Bk
         JIlpD2q8bO9TuXBGDeQ6txlPY8wwSWSloR/rmvNKJ7rCfuw3jDM78SIyvk8QkYs6IM
         OHPyQMEN3RuAHr6owKFOrUGRRihacoI03GbtXM/fp8bkYt9FZ2MQM/K1t70khR0pqZ
         UWfUy5SV95xpQITIihLrcE5Dwgv8K09zH/Zlf19IbudwsReXxTOjzxN/PwIshBRF5x
         QDMtMvX5e0hhg==
Message-ID: <b9874b8f-b40f-f48d-856a-c5fc91384042@kernel.org>
Date:   Mon, 26 Sep 2022 16:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [V15,01/15] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        kyrie wu <kyrie.wu@mediatek.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, Rob Herring <robh@kernel.org>
References: <20220926091433.18633-1-irui.wang@mediatek.com>
 <20220926091433.18633-2-irui.wang@mediatek.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220926091433.18633-2-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 11:14, Irui Wang wrote:

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/memory/mt8195-memory-port.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/clock/mt8195-clk.h>
> +    #include <dt-bindings/power/mt8195-power.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        jpgenc-master {
> +                compatible = "mediatek,mt8195-jpgenc";

Use 4 spaces for example indentation. You have it quite inconsistent.

Best regards,
Krzysztof

