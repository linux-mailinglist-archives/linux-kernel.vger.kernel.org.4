Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A856BCE6F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjCPLhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCPLhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:37:20 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E3BC5AE1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:37:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id x13so6403497edd.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678966619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfGhbI5w3WuDswJbCQtfkPCMptbW1heMaZynDig3b6o=;
        b=WdZEAyLcSkyP3jHiliNzzURVyP5bg0AhOJ/n1KD+xejldEkacpeekFFOUFx+zld37q
         U9EEZKk6uTvjNmm3UZZSpWL2MlXnABLnKMcCOdnPawFhuhCC3VMOuegNF1qvL6zd9WgM
         V507GkNiQG30Fj5zDyS0pi8sdPl1/sBVbh14SQGRObgzt6vNOd+8zSrqqi4sGKTuuPXC
         TTVujg0DzKVp4ZIAjD/8lFnLO+i8MHz/q/sl3QRwK002rNkmNRflt1cK5NEOLpUMlgkR
         POjrdhmPwHciq4cFWboHsEjP6oZ1SqATu6+yc9l5zY2xKj6TZ3Q7o+RkI0RAfcNjN4I8
         l8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfGhbI5w3WuDswJbCQtfkPCMptbW1heMaZynDig3b6o=;
        b=ACXP/gWJhx3IzW+0Ip7i5kMsdJOer+HWhRq7kiBTHnnBbDeDEHJzZMSJhQEVyUcu6n
         iOgnMOpUw5VKL97wnzOyQ83p5NAfJImAY6dTbODMtS/HWGqOyq8mohohapMIBzFuUY4S
         vZ8K6ourrjQ/twTz2Qf1j9FWhGaAPNtq8aKDZz8VlRKEr94a0ZaUKVG6WC7agpDzKYa3
         +cOSu3lTdgcZwU+yxgaDX8UIVr295be7P+WQcpbVgdEvVaqL4qI+ECET9xvLSXuNQsoi
         8m6jV/lULevJFCHjxiwt3wM0/fsKjiVwG+0WRG5Pz1rQWV3GQqYzCGvYsv2cnilpcyhd
         Y6+Q==
X-Gm-Message-State: AO0yUKX7yNFY1RPRXYp+lKcQ7xNDW1R2bj6uMSGCvWKVISvtM+u/TQut
        M7uJ1RA0EzThVmBERHlGZy8sQw==
X-Google-Smtp-Source: AK7set80wKzIShLBKFRFwgznGN61cTEyjNtx9HtLBiDrk9zBalX963QlSRikXu3lp1lrDTbm0tt4Fg==
X-Received: by 2002:a05:6402:418:b0:4fc:52c0:df10 with SMTP id q24-20020a056402041800b004fc52c0df10mr6125485edv.26.1678966619655;
        Thu, 16 Mar 2023 04:36:59 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id si2-20020a170906cec200b008e68d2c11d8sm3728845ejb.218.2023.03.16.04.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 04:36:59 -0700 (PDT)
Message-ID: <0ebf187d-972e-4228-d8a0-8c0ce02f642d@linaro.org>
Date:   Thu, 16 Mar 2023 12:36:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v29 1/7] dt-bindings: mediatek: add ethdr definition for
 mt8195
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        =?UTF-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
References: <20221227081011.6426-1-nancy.lin@mediatek.com>
 <20221227081011.6426-2-nancy.lin@mediatek.com>
 <4aff6a7a3b606f26ec793192d9c75774276935e0.camel@mediatek.com>
 <2700bd6c-f00d-fa99-b730-2fcdf89089fa@linaro.org>
 <1d65e8b2de708db18b5f7a0faaa53834e1002d9f.camel@mediatek.com>
 <b04eb48e-c9aa-0404-33ec-bef623b8282f@linaro.org>
 <e5ceec9e-d51b-2aeb-1db7-b79b151bd44c@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e5ceec9e-d51b-2aeb-1db7-b79b151bd44c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 10:53, AngeloGioacchino Del Regno wrote:

> Hello Krzysztof, Nancy,
> 
> Since this series has reached v29, can we please reach an agreement on the bindings
> to use here, so that we can get this finally upstreamed?
> 
> I will put some examples to try to get this issue resolved.
> 
> ### Example 1: Constrain the number of GCE entries to *seven* array elements (7x4!)
> 
>    mediatek,gce-client-reg:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>      description: The register of display function block to be set by gce.
>        There are 4 arguments in this property, gce node, subsys id, offset and
>        register size. The subsys id is defined in the gce header of each chips
>        include/dt-bindings/gce/<chip>-gce.h, mapping to the register of display
>        function block.
>      items:
>        minItems: 28
>        maxItems: 28
>        items:                     <----- this block doesn't seem to get checked :\
>          - description: phandle of GCE
>          - description: GCE subsys id
>          - description: register offset
>          - description: register size

This is what we would like to have but it requires exception in
dtschema. Thus:

> 
> 
> ### Example 2: Don't care about constraining the number of arguments
> 
>    mediatek,gce-client-reg:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
>      maxItems: 1
>      description: The register of display function block to be set by gce.
>        There are 4 arguments in this property, gce node, subsys id, offset and
>        register size. The subsys id is defined in the gce header of each chips
>        include/dt-bindings/gce/<chip>-gce.h, mapping to the register of display
>        function block.

use this.

Best regards,
Krzysztof

