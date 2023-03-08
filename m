Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FB96B13B7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:22:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCHVWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCHVWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:22:50 -0500
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9189041081;
        Wed,  8 Mar 2023 13:22:49 -0800 (PST)
Received: by mail-ot1-f52.google.com with SMTP id e9-20020a056830200900b00694651d19f6so6871991otp.12;
        Wed, 08 Mar 2023 13:22:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678310569;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I60t2b90wzss81s3fKq0o1a4IobvW8p+fvRrTeKfSkI=;
        b=gasjcAtAZMyLPjxnrIynvHWGwNQkSaJPsRjnsxczNHM5TbHH4PQGoSar+McgwiDUNC
         tRhZbZbiFIjNZ/PcrqJ6w13qMUKatUvb9dXV1YWobz6Bn90UICk7s+mktOd4Ay35yJB7
         xpAMhfgFTD4g+gkrTlc7QLxGmdWPR+dGvcleU0Zg5gsFH9TV3+S/O/fuy5zFourUjB0h
         2KRP6Y9qWxMO3Ayl2kahw2RsTP/RLYHiCnz58FuMzQckAk60gdN/ccysjsGaBs24cIvN
         qnZZ4qrJDhKjMcQuyRrhVnhAxbhXjFBucX3wT+8QLhIuIVbSU5d4sb1cXbErYBmU+VAl
         pkrg==
X-Gm-Message-State: AO0yUKXFKq4rfcmRQws0Psek3zmCb1EdVrzU3gzjIjt0hVJFBdC0+SNr
        WTTACz8n9UMNsJBZaavBFw==
X-Google-Smtp-Source: AK7set+PTfJOJQBTkd9lD5mgbdaKikQsLsBMNOdi9P+5Ho56tU02sSuQtD0n97ZBDotTbKjZTin1uw==
X-Received: by 2002:a9d:19e8:0:b0:694:7da5:d045 with SMTP id k95-20020a9d19e8000000b006947da5d045mr4325288otk.13.1678310568875;
        Wed, 08 Mar 2023 13:22:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a5-20020a9d4705000000b00684a10970adsm6860770otf.16.2023.03.08.13.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:22:48 -0800 (PST)
Received: (nullmailer pid 3865582 invoked by uid 1000);
        Wed, 08 Mar 2023 21:22:47 -0000
Date:   Wed, 8 Mar 2023 15:22:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [PATCH 19/20] dt-bindings: pinctrl: mediatek: mt7620: split
 binding
Message-ID: <20230308212247.GA3858368-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-20-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-20-arinc.unal@arinc9.com>
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

On Fri, Mar 03, 2023 at 03:28:48AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The MT7628 and MT7688 SoCs contain different pin muxing information,
> therefore, should be split. This can be done now that there are compatible
> strings to distinguish them from other SoCs.
> 
> Split the schema out to mediatek,mt76x8-pinctrl.yaml.
> 
> Remove mediatek,mt76x8-pinctrl from mt7620.
> 
> Deprecate ralink,mt7620-pinctrl. The reason is, the DTs for mt76x8 which
> use this string will incorrectly match the pin muxing information for
> mt7620. There's a new string, mediatek,mt7620-pinctrl, which makes the
> deprecation possible.

This should be 2 patches.

You aren't deprecating either. That means still documented and labeled 
with 'deprecated: true'. But again, just 'fixing' the vendor is not a 
reason to deprecate and for us to have to carry the old compatible. We 
deprecate when there is some advantage to it such as using common 
properties instead of vendor specific ones.

Rob
