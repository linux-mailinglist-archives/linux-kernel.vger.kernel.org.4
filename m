Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6876D6543
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235228AbjDDO0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjDDO0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:26:00 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628564EEF;
        Tue,  4 Apr 2023 07:25:41 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id f14so10763318oiw.10;
        Tue, 04 Apr 2023 07:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680618340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FngVgR0kh2xmJeYD62PuGFfghT3iglIWxN9KNtdB6gU=;
        b=ewTeen3mgGHN6CJ31rC51naGMbf0jHeeNZx5OQgL2OUWraNedeZuGjzwHO55VH3Kb5
         wlHDg8/zVsYccngPUtEWR4KZwViWsP9xrQZtibP8nsMZVa46NfU7HwLJ1PRotcjEji/v
         ysZkaXK156j4ckqWxpExMtQTH0g2NZZkeP7omCtYgfOssGfADZmSSUwbNal/kXHkxNdT
         78xnSHJsZb3hLaEN09MTVzk+Zq7ujtt93bmQ3+SwFXg/tpBE09LCj0TlvHAOep4OxFm3
         nGSLwENqwQKoLxzoDO+txR9vJcX3Z5EDitzeTBPOPqp3Gf3dMDWJPEXCv5Omg/l5lRsy
         +9cw==
X-Gm-Message-State: AAQBX9cdvb89u/A7z2w7lGr9knNUnIID3htGBqh/rZ5/rQpTJNNdIPJj
        l2BbUkUEhztUETZU0uoGmwtEIhHUDQ==
X-Google-Smtp-Source: AKy350ZV9CpqJhfEfjk+DmFTyAXO0oUmZ0qmOSthzq1gdjn+7THkuZ/x/QsxqP2i6BOETqhS06XA8A==
X-Received: by 2002:a05:6808:3a99:b0:378:9c1:514e with SMTP id fb25-20020a0568083a9900b0037809c1514emr1108299oib.42.1680618339120;
        Tue, 04 Apr 2023 07:25:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s25-20020a056808209900b00383b371f2a7sm5111928oiw.42.2023.04.04.07.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:25:38 -0700 (PDT)
Received: (nullmailer pid 3833881 invoked by uid 1000);
        Tue, 04 Apr 2023 14:25:37 -0000
Date:   Tue, 4 Apr 2023 09:25:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@kernel.org>, linux-usb@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 2/3] dt-bindings: usb: ti,j721e-usb: drop assigned-clocks
Message-ID: <168061833734.3833823.7201049539877639304.robh@kernel.org>
References: <20230403191850.374839-1-krzysztof.kozlowski@linaro.org>
 <20230403191850.374839-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230403191850.374839-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 03 Apr 2023 21:18:49 +0200, Krzysztof Kozlowski wrote:
> The meta schema from DT schema already defines assigned-clocks, so there
> is no need for device schema to mention it at all.  There are also no
> benefits of having it here.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ti,j721e-usb.yaml | 6 ------
>  1 file changed, 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

