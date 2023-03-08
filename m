Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFE76B13A4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjCHVRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCHVRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:17:09 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4791D1AC6;
        Wed,  8 Mar 2023 13:17:08 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-176e43eb199so156348fac.7;
        Wed, 08 Mar 2023 13:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310228;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFMrPDdfxqpyd5M0MFhyXhLRTCbXShwPMfjjHKdui1k=;
        b=OmNAE38nBqRCSpD8EgZ+yBp8hAmjh9yrA5/TU2Kpv9Wi0FyPxZDk0mmsi7/IQLIZlI
         jkc4IOSRb56Dv36tglPA41Ukr1x1BrZ205iknyD+06NolX+8UaCIjJ2zsIyHs39q/8/5
         UEBieFRrpcewD3stZLLzvZD8P43ARf3tdQ/62B5lzTvUu7YLhhxxtMSRNvOqCX/zzSaw
         U+lQxdc8+bZ1HqDdh8rTYA9EEprgYhAk0ljO04b9/wFz+ZG9vC3siJyxnKxmmuISxwke
         FN88vxc9RjjWAUyRwHrK4XxddB77751fKMbrvQlf4tOv/8IYTTJKq6X7bGJFcHYz9tkL
         DfkA==
X-Gm-Message-State: AO0yUKWHiiUpeqtSHQC9h4lwT5+3e5SgT8Rpqihj2+rvO3i6iDCCyJIP
        P8mTDrBW9SVyzTKi2P9x9g==
X-Google-Smtp-Source: AK7set/7xk8grsaUoItOT2zuhVY8yeSb4zRNZBFmcFxRvaK1MclzUcTjoY+J1wTX6sQa1dIgiagbXw==
X-Received: by 2002:a05:6870:8293:b0:176:770b:5e8 with SMTP id q19-20020a056870829300b00176770b05e8mr9332124oae.3.1678310227940;
        Wed, 08 Mar 2023 13:17:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dv23-20020a056870d89700b001728669a604sm6705945oab.5.2023.03.08.13.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:17:07 -0800 (PST)
Received: (nullmailer pid 3858258 invoked by uid 1000);
        Wed, 08 Mar 2023 21:17:06 -0000
Date:   Wed, 8 Mar 2023 15:17:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-gpio@vger.kernel.org, DENG Qingfang <dqfext@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        erkin.bozoglu@xeront.com, Daniel Santos <daniel.santos@pobox.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH 18/20] dt-bindings: pinctrl: ralink: rt305x: split binding
Message-ID: <167831022612.3858198.10046631784617358105.robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-19-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-19-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Mar 2023 03:28:47 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The RT3352 and RT5350 SoCs each contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to ralink,rt3352-pinctrl.yaml and
> ralink,rt5350-pinctrl.yaml.
> 
> Remove ralink,rt3352-pinctrl and ralink,rt5350-pinctrl from rt305x.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../pinctrl/ralink,rt305x-pinctrl.yaml        |  83 +-----
>  .../pinctrl/ralink,rt3352-pinctrl.yaml        | 243 ++++++++++++++++++
>  .../pinctrl/ralink,rt5350-pinctrl.yaml        | 206 +++++++++++++++
>  3 files changed, 455 insertions(+), 77 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt3352-pinctrl.yaml
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/ralink,rt5350-pinctrl.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

