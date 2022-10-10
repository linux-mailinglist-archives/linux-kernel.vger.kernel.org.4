Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237E5F9F08
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiJJNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJNBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:01:55 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025FC558EB;
        Mon, 10 Oct 2022 06:01:55 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id m130so12608650oif.6;
        Mon, 10 Oct 2022 06:01:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfVkBTG8SNv9Tulxii1+DdNRE/eocOHXxVG3G/nIC5M=;
        b=IZe+ZYIWwmKXuLgRe/bjrnVuoLh89Hr7/571/WYRAF0dJxN/el0lmRcQllJVl8r/UI
         wtz1CqOIYKED99R/+FFXtelfVt6LzEo52RqI16lZgjr3Wlf07fhDUn1QnJW5tEg1sBzj
         h7uOfVQLA2g4qWJcuOTPgLvWCpNFmcd1bz78CzJbg7ZXtPtIxEfg0nbG0X/lgIQe7Dls
         rnry4ATxHsDgTBUDKw8OfC7vWKvdfnUrGogVnN4t/vzky0fqszbaUgSt69strmdtu5wM
         ytmj9SDlFWtU1XBofIoWXNPTM3spcYJS2aOFXd5/0sHsEu4lpkML5gaG55qeRYXrFa1P
         ijdw==
X-Gm-Message-State: ACrzQf3Ziq1qKfl2hzhukuPlMfVnuuXJ+/zMoAJvvKsZeIM839zlSkIY
        7ug7kQ4YoJ5JHn7vnKnvWw==
X-Google-Smtp-Source: AMsMyM5lgFvJ9fLliV+V4FcCSGJENE49rAo3hL62foOpnMFIQYg3mQbq65Qw1Gm/4qIDH33vBplIxw==
X-Received: by 2002:a05:6808:2118:b0:350:3c8e:404d with SMTP id r24-20020a056808211800b003503c8e404dmr9122517oiw.227.1665406914045;
        Mon, 10 Oct 2022 06:01:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a9d6381000000b006339b36127dsm4803925otk.3.2022.10.10.06.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 06:01:52 -0700 (PDT)
Received: (nullmailer pid 480632 invoked by uid 1000);
        Mon, 10 Oct 2022 13:01:53 -0000
Date:   Mon, 10 Oct 2022 08:01:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     devicetree@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add compatible for Mediatek MT7986
Message-ID: <166540691329.480578.14649778257492089320.robh@kernel.org>
References: <20221008165627.114782-1-linux@fw-web.de>
 <20221008165627.114782-2-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221008165627.114782-2-linux@fw-web.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 08 Oct 2022 18:56:26 +0200, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
> Platform.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
