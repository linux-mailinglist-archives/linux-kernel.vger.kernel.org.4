Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822EF6BF133
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 19:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCQSzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 14:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjCQSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 14:55:21 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9841085;
        Fri, 17 Mar 2023 11:54:51 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id b5so2747274iow.0;
        Fri, 17 Mar 2023 11:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679079290;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Doc53YY9w85GoKTOf4y1te4FfAV/Esjq/M9BTBRgpNQ=;
        b=p4gn3m61kGGWnUtMbMuJLNZgJ0X8yC6eD+UeP/0wZ1PUlZl7XXUdaJ6s9rcnXk5JQk
         j/a7gAE4cUsim2am56r4uqtWd525PrkaTwa2DVmMSEeNcSM8fZq0lSfbc99I9Q/zKL1B
         jQmaAXms2/NpN1R/sU7XEfSqxewcFC+1FjgIhxZ5nkl2OnPBoMUV9a9WLAm9qOB0/Ei7
         M4zS+q2hf5Qoq2bz67ZMrFjwSQTmsKEX1FX/S6rqxaQdAJt+SRehPyOjf2uAzg/H8mBs
         tfcVJAhNIPLdbAFvcpCt0hivtAoPj4prinoxmBkLmyueswphgxHpTOBHaQe7Ah9u528H
         gKuQ==
X-Gm-Message-State: AO0yUKUJqZDT+Hl7TIdN97YEReeQENFxsmNeafXbgpn3NZHUNSGZzrfq
        Q5lxCD31JoK0sQdfVFx2/w==
X-Google-Smtp-Source: AK7set9oG9FZ+7wK8abXco/Uea6/+giAGUXpq/rVnS7/Dgz3Y6Jwe2vN+GnlcMmSm6Ev8A8wbHzR+Q==
X-Received: by 2002:a5d:9591:0:b0:712:cf90:e3e with SMTP id a17-20020a5d9591000000b00712cf900e3emr425343ioo.2.1679079290675;
        Fri, 17 Mar 2023 11:54:50 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id h18-20020a5e8412000000b0073a658f7951sm753359ioj.48.2023.03.17.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 11:54:50 -0700 (PDT)
Received: (nullmailer pid 2619583 invoked by uid 1000);
        Fri, 17 Mar 2023 18:54:48 -0000
Date:   Fri, 17 Mar 2023 13:54:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        erkin.bozoglu@xeront.com, Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Andy Teng <andy.teng@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Sean Wang <sean.wang@kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        DENG Qingfang <dqfext@gmail.com>,
        Hui Liu <hui.liu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        William Dean <williamsukatube@gmail.com>,
        linux-mips@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2 08/21] dt-bindings: pinctrl: ralink: add new
 compatible strings
Message-ID: <167907928749.2619529.8312302785647038742.robh@kernel.org>
References: <20230313205921.35342-1-arinc.unal@arinc9.com>
 <20230313205921.35342-9-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230313205921.35342-9-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Mar 2023 23:59:08 +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
> properly document the pin muxing information of each SoC, or SoCs that use
> the same pinmux data.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml   | 4 +++-
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml   | 5 ++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

