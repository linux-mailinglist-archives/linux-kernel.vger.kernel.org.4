Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BCB7281B5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236609AbjFHNtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 09:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbjFHNtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 09:49:13 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F031FD6;
        Thu,  8 Jun 2023 06:49:12 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-77ac30e95caso21842839f.2;
        Thu, 08 Jun 2023 06:49:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686232151; x=1688824151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6LipUg92nVI0lWt6WKtzlHRtu9dITcHtKh7R9Otq+U=;
        b=CbnOdmrsJpp+j2j+DW2K6aTBUYl8rd3LrALKRQnGqt7Ei5ZWhICqZqM9303lArQnZ+
         WWeavh0PmHd/o4hIgT5m6e+lCoIxxTDAqLLM9YyjAau/6/w/MvbU4D3XPCHVzfqMhbuq
         1FNQ/e7/cXdDs6hmL40S8xpS31bAJZwC4bz7QXO1VH0jNGkNstLe4SZs717FfexjLVFf
         bIAeoQ6TpWtovzmCXgfcCuBBNkqBM21ZbRnYybR8mVjVe5GTXzzuct04fMxbaJDdNhiR
         0cqnNfeSwCPJluKFbjY7S2f1tiMU/+xSYEZ/KDg8VO+SRc8TMI6hryP3DOHvwrdXW1kG
         0oWw==
X-Gm-Message-State: AC+VfDx4oOdEDUyc+DDRW1Ak0ZEHmRq/oDIYlP88XjU25PWyT5E5eNaZ
        xSmIL9ZmWDP+DQTBrDZewA==
X-Google-Smtp-Source: ACHHUZ5nOHAcbMwWIfFekipe5EvJXvai7cR/i6yNTIG5gTlkQTOFwBj2u3/RcAGVuQNZWItYWIHadQ==
X-Received: by 2002:a5e:c74d:0:b0:776:fc29:d965 with SMTP id g13-20020a5ec74d000000b00776fc29d965mr11721408iop.10.1686232151090;
        Thu, 08 Jun 2023 06:49:11 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id k4-20020a02a704000000b004168295d33esm294154jam.47.2023.06.08.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 06:49:10 -0700 (PDT)
Received: (nullmailer pid 2476705 invoked by uid 1000);
        Thu, 08 Jun 2023 13:49:08 -0000
Date:   Thu, 8 Jun 2023 07:49:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>, chunkuang.hu@kernel.org,
        linux-mediatek@lists.infradead.org,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "moderated list:ARM/Mediatek USB3 PHY DRIVER" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add mediatek mipi csi driver v
 0.5
Message-ID: <20230608134908.GA2463843-robh@kernel.org>
References: <ab9aa30f-82d7-1d14-5561-e19ff10af0b0@linaro.org>
 <4yppinkucchwnwtnnpbqdn4bejmntjq3q6mx6es55f2pwyce3c@qdhdks47lpyt>
 <1853f049-4f00-b7f0-973a-2c4e7b0b2634@linaro.org>
 <7h353w2oug.fsf@baylibre.com>
 <fbf1b0a6-f45d-69a0-5de6-8269567e15b3@linaro.org>
 <7hwn18yndq.fsf@baylibre.com>
 <c63ebd7e-8658-9cdd-4fc4-ade9c94dfa64@linaro.org>
 <7hcz2snpnw.fsf@baylibre.com>
 <10074d67-394b-3ddb-8bd1-fc051bdb7f79@linaro.org>
 <totyr5bsupdv6y6muvndnhywbw5fl5kezoxie2hyz4g53yi34m@6geccwkjvupc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <totyr5bsupdv6y6muvndnhywbw5fl5kezoxie2hyz4g53yi34m@6geccwkjvupc>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 10:44:22AM +0200, Julien Stephan wrote:
> On Tue, May 30, 2023 at 10:53:31AM +0200, Krzysztof Kozlowski wrote:
> > On 22/05/2023 21:15, Kevin Hilman wrote:
> > > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> > >
> > >> On 16/05/2023 23:31, Kevin Hilman wrote:
> > >>
> > >>>> Third is to use versioned IP blocks.
> > >>>>
> > >>>> The second case also would work, if it is applicable to you (you really
> > >>>> have fallback matching all devices). Third solution depends on your
> > >>>> versioning and Rob expressed dislike about it many times.
> > >>>>
> > >>>> We had many discussions on mailing lists, thus simplifying the review -
> > >>>> I recommend the first choice. For a better recommendation you should say
> > >>>> a bit more about the block in different SoCs.
> > >>>
> > >>> I'll try to say a bit more about the PHY block, but in fact, it's not
> > >>> just about differences between SoCs. On the same SoC, 2 different PHYs
> > >>> may have different features/capabilities.
> > >>>
> > >>> For example, on MT8365, There are 2 PHYs: CSI0 and CSI1.  CSI0 can
> > >>> function as a C-PHY or a D-PHY, but CSI1 can only function as D-PHY
> > >>> (used as the example in the binding patch[1].)  On another related SoC,
> > >>> there are 3 PHYs, where CSI0 is C-D but CSI1 & CSI2 are only D.
> > >>>
> > >>> So that's why it seems (at least to me) that while we need SoC
> > >>> compatible, it's not enough.  We also need properties to describe
> > >>> PHY-specific features (e.g. C-D PHY)
> > >>
> > >> I recall the same or very similar case... It bugs me now, but
> > >> unfortunately I cannot find it.
> > >>
> > >>>
> > >>> Of course, we could rely only on SoC-specific compatibles describe this.
> > >>> But then driver will need an SoC-specific table with the number of PHYs
> > >>> and per-PHY features for each SoC encoded in the driver.  Since the
> > >>> driver otherwise doesn't (and shouldn't, IMHO) need to know how many
> > >>> PHYs are on each SoC, I suggested to Julien that perhaps the additional
> > >>> propery was the better solution.
> > >>
> > >> Phys were modeled as separate device instances, so you would need
> > >> difference in compatible to figure out which phy is it.
> > >>
> > >> Other way could be to create device for all phys and use phy-cells=1.
> > >> Whether it makes sense, depends on the actual datasheet - maybe the
> > >> split phy per device is artificial? There is one PHY block with two
> > >> address ranges for each PHY - CSI0 and CSI1 - but it is actually one
> > >> block? You should carefully check this because once design is chosen,
> > >> you won't be able to go back to other and it might be a problem (e.g.
> > >> there is some top-level block for powering on all CSI instances).
> > >
> > > We're pretty sure these are multiple instances of the IP block as they
> > > can operate completely independently.
> > >
> > >>>
> > >>> To me it seems redundant to have the driver encode PHYs-per-SoC info,
> > >>> when the per-SoC DT is going to have the same info, so my suggestion was
> > >>> to simplify the driver and have this kind of hardware description in the
> > >>> DT, and keep the driver simple, but we are definitely open to learning
> > >>> the "right way" of doing this.
> > >>
> > >> The property then is reasonable. It should not be bool, though, because
> > >> it does not scale. There can be next block which supports only D-PHY on
> > >> CSI0 and C-PHY on CSI1? Maybe some enum or list, depending on possible
> > >> configurations.
> > >
> > > OK, looks like include/dt-bindings/phy/phy.y already has
> > >
> > >   #define PHY_TYPE_DPHY		10
> > >   #define PHY_TYPE_CPHY		11
> > >
> > > we'll add a PHY_TYPE_CDPHY and use that.   Sound reasonable?

No, because these defines are the 1 mode used for a specific connection, 
not the set of supported modes.

> >
> > Yes. Currently it is usually used as phy-cells argument (after the phy
> > number/lane/ID), but cdns,phy-type and intel,phy-mode use it directly as
> > property in provider. In both cases they have a bit different meaning
> > than yours. You want to list all supported modes or narrow/restrict
> > them. Maybe hisilicon,fixed-mode fits your purpose?

There is also 'phy-type' to set the mode/type in the provider.

If we need to list all possible modes, then you need to justify why 
that's needed and then define a property which is a mask of the 
existing type defines.

> >
> 
> Hi Krzysztof,
> 
> Thanks for the suggestion, using something like hisilicon,fixed-node
> looks like a good fit.
> With mediatek,fixed-node, by default CSI node will be considered as
> CD-PHY capable (unless the fixed-mode property is set.) so I won't need
> anymore the new define PHY_TYPE_CDPHY introduced in v3.
> 
> Also introducing mediatek,fixed-mode suggests that PHYs not declaring
> the fixed mode property support mode selection, so I suggest to add a
> phy argument (#phy-cells = <1>) to select the mode (D or C mode).
> Exactly what is done by the hsilicon driver.
> 
> How does that sound to you?

I don't follow the need for fixed-mode, but agree you should use a phy 
arg. Can't you just assume the D-PHY only instance will only have D-PHY 
for the arg?

Rob
