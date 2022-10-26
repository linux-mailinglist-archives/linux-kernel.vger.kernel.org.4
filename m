Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34F660D8BC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiJZBJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJZBJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:09:46 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5304E1B796;
        Tue, 25 Oct 2022 18:09:45 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id i7so3433907oif.4;
        Tue, 25 Oct 2022 18:09:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HG4VVkS24N9P28wqi2fW2XTbUe425KORd603IoTp6S0=;
        b=dIdwHT/FVqJhsyGNVUSbfd25nmnmOCNARATqU8YczBM7DQAtbARGCKrQc+6IYIT2nR
         cjGPuERbPS2SkhNk1gShUSIyRL1FsP8ACycnW47nVdAn47068cIRPkbiJq5ffCucgMr5
         0tXc74oDTZxDVYPJoLO9+9JAly3vTwj65uYRw5qGxJendXViFpBZoFdXIO88NPp0Be3q
         EkLxeoSPlpIwXhofNtam3xrdkx77oe+Y3/17EjHfTnB8riF1cx1fjEx781NjxLCQicKh
         RV5BZ5BkzXH7YVff2NLPgLp1xYbjXwKRTSzV6kMZASEM8SL8SSzdBoTHWw65rY+v7rm3
         LSyQ==
X-Gm-Message-State: ACrzQf1WLmUNigYIdN+FasYA8Iqk9uFBIEPsSegjOGDk5TXKHo9r3wUx
        LOmEEZCJ8stfFJNUFH93fw==
X-Google-Smtp-Source: AMsMyM6ZtYFMnBkpqKM2x3pzwsH/yh/j7SGFOypJpp0NROCfS3lVPoCuxyWMxk5quff+xl9pBCy9rw==
X-Received: by 2002:a05:6808:1893:b0:354:b5bc:cd0d with SMTP id bi19-20020a056808189300b00354b5bccd0dmr598596oib.244.1666746584580;
        Tue, 25 Oct 2022 18:09:44 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i25-20020a9d6259000000b006619533d1ddsm1603477otk.76.2022.10.25.18.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:09:44 -0700 (PDT)
Received: (nullmailer pid 3525382 invoked by uid 1000);
        Wed, 26 Oct 2022 01:09:45 -0000
Date:   Tue, 25 Oct 2022 20:09:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        kernel@collabora.com, Rob Herring <robh+dt@kernel.org>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Shane Chien <shane.chien@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH] ASoC: dt-bindings: mt8192-mt6359: Set maxItems, not
 type, for sound-dai
Message-ID: <166674658480.3525343.6807644531936287296.robh@kernel.org>
References: <20221024230658.1772907-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221024230658.1772907-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 19:06:57 -0400, Nícolas F. R. A. Prado wrote:
> sound-dai is a standard property whose type is already set to
> phandle-array by sound-dai.yaml, so there's no need to set it (and
> wrongly so for headset-codec) in this binding. What should be set
> however is the maximum number of items, which for headset-codec should
> be 1.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
>  .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
