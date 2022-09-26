Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C25EB3A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 23:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbiIZVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiIZVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 17:54:43 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16D74B0D4;
        Mon, 26 Sep 2022 14:54:42 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id cm7-20020a056830650700b006587fe87d1aso5298917otb.10;
        Mon, 26 Sep 2022 14:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=w2QQwnQgmCoCtfJGgTC/b/2B1KxxxneV73oIJQj+vXs=;
        b=JY5L2qEb3tkXIEiWWz7HsEUvlHhLQVVL74D/ONXI9WL+PHKGU0oNDKVi4g73yK3fdg
         KOTB7ZS2ygtErTBW72X2ErinJxmZBvyGBYm8BWjIff+jI5pLdnxuHHpPR328pcSTQdwV
         7w2qNkvOpmSvXNZmynWhHLLjhDG9gKyXyiWepyps7UERA3YngQ6fRfslEW/63ySq5osH
         AunvsDvQ9Nu/vct8Lw4rPG0j1+rgL503JkTTn2FKy8HvbduETkoU/bdsxqzZqhruEiKx
         10BFI3Dn5jrI5azTmwU7g/1z9Ocm/QdoQC7wahZ0ewFW0NDGOzDnuoDTHscgiMm+mlHg
         ZJGA==
X-Gm-Message-State: ACrzQf2/zGNWMeQMGLSVdBGEnFlUsQSwqWE5+uAR5yhHb44fEpf1ySVR
        qocDawkEVyTd1v6ldT0UgBMW7sG2Hw==
X-Google-Smtp-Source: AMsMyM6bmE7R0bTAstFX4jVboHAVQz30IQaE1gTw1Ch1FS7J/e50TEWed28r2+CwdBjQaLYnUzf7RA==
X-Received: by 2002:a9d:6e0f:0:b0:655:f372:f18b with SMTP id e15-20020a9d6e0f000000b00655f372f18bmr11294695otr.206.1664229281970;
        Mon, 26 Sep 2022 14:54:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bm43-20020a0568081aab00b0034d14c6ce3dsm7615607oib.16.2022.09.26.14.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 14:54:41 -0700 (PDT)
Received: (nullmailer pid 2894496 invoked by uid 1000);
        Mon, 26 Sep 2022 21:54:40 -0000
Date:   Mon, 26 Sep 2022 16:54:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     "liangxu.xu" <liangxu.xu@mediatek.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        chunkuang.hu@kernel.org, p.zabel@pengutronix.de, airlied@linux.ie,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: display: mediatek: dp: Add compatible for
 MediaTek MT8188
Message-ID: <20220926215440.GA2888681-robh@kernel.org>
References: <20220923013953.5043-1-liangxu.xu@mediatek.com>
 <f6e669dd-f2cf-6e3f-18bb-25b21e5eab0c@linaro.org>
 <2afb5b7f761c7931eaf93f2f8a0fd268a39e1b02.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2afb5b7f761c7931eaf93f2f8a0fd268a39e1b02.camel@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 10:52:04AM +0800, liangxu.xu wrote:
> On Fri, 2022-09-23 at 13:16 +0200, Krzysztof Kozlowski wrote:
> > On 23/09/2022 03:39, liangxu.xu@mediatek.com wrote:
> > > From: liangxu xu <liangxu.xu@mediatek.com>
> > > 
> > > Add dt-binding documentation of dp for MediaTek MT8188 SoC.
> > > 
> > > Signed-off-by: liangxu xu <liangxu.xu@mediatek.com>
> > > ---
> > 
> > Where is the DTS? Where are driver changes?
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Hi Krzysztof:
> 
> If you want to see the synchronous changes of dts and binding files,
> then I will attach this binding file changes when sending dts later.
> 
> The driver change of mt8188 reuses that of mt8195. The driver link is
> as follows:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/gpu/drm/mediatek/mtk_dp.c?id=48f4230642ee32a97ddf4be492838ce96089f040

So the 8188 block is backwards compatible with the 8195 block? 
That's good, but not what your schema says because you have not defined 
a fallback compatible for the driver to use.

Rob
