Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99096B1349
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCHUms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjCHUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:42:46 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D1B1F91A;
        Wed,  8 Mar 2023 12:42:45 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id m25-20020a05683026d900b006941a2838caso9701855otu.7;
        Wed, 08 Mar 2023 12:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678308165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx+D/aRg96Xv1xhHfuRNJtHE/XSALiBjprbVX5obgUQ=;
        b=rxQW0f5eIhURPWzSXRSyjSVNKFitYo26dPH05Kc188yNwXPVAsUJZVvrRE7yuFzWV7
         S+UpO7FEhOE9uUBeQivc0MbPtGnHXEoTg0KEgYDfWG+NT/5koebXSJmKyXS9QzIkMlus
         x0afi4fdLVzi3ivzvigR3TMiDqBhGDPaTFO02n0nv5B8ixGp4DMBQcHEHqhYPms5JhPh
         9Vy1Ypdf0lMsqSvUQo+wnxigZS0N/xc9hL7u7SoSGWbuskfMev8U1si9acd0ECpa0FS6
         rHEsBGJhT7NmuipiW9pRlvb3+OkdbZBZIodf6ruyAhYklaPIrmR+CMIQU6xjMV+GuP47
         Qtbw==
X-Gm-Message-State: AO0yUKV+TuoTbMDZ7wpJS2mvMQAEBVZkwQ/eCUjPmBnGoySCdWW4KIuO
        rPmejdI4isI8u41h+L6ySdcIHqMWsA==
X-Google-Smtp-Source: AK7set/6BsPdujjJq8G0YkPgYq2OeOO2li/rSi30P2jJIG98XFB0DpAns146xxM0NNpmfpFIsy83JQ==
X-Received: by 2002:a05:6830:565:b0:694:88f5:f5ed with SMTP id f5-20020a056830056500b0069488f5f5edmr2829378otc.24.1678308164741;
        Wed, 08 Mar 2023 12:42:44 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k3-20020a9d4b83000000b00690e6d56670sm6980752otf.25.2023.03.08.12.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:42:44 -0800 (PST)
Received: (nullmailer pid 3744004 invoked by uid 1000);
        Wed, 08 Mar 2023 20:42:43 -0000
Date:   Wed, 8 Mar 2023 14:42:43 -0600
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
Subject: Re: [PATCH 07/20] dt-bindings: pinctrl: ralink: improve bindings
Message-ID: <20230308204243.GA3735537-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-8-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-8-arinc.unal@arinc9.com>
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

On Fri, Mar 03, 2023 at 03:28:36AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Move additionalProperties to the top. It's easier to read than after a long
> indented section.
> 
> Drop the quotes from the referred schemas.

Not the greatest subject as every change improves something and bindings 
is stated twice. Hard to come up with something better since you've 
combined 2 different kinds of changes which you shouldn't do either. So 
I'd split this patch into 2.

> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml          | 9 ++++-----
>  .../bindings/pinctrl/ralink,mt7621-pinctrl.yaml          | 9 ++++-----
>  .../bindings/pinctrl/ralink,rt2880-pinctrl.yaml          | 9 ++++-----
>  .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml          | 9 ++++-----
>  .../bindings/pinctrl/ralink,rt3883-pinctrl.yaml          | 9 ++++-----
>  5 files changed, 20 insertions(+), 25 deletions(-)
