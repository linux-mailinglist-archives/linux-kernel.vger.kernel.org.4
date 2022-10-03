Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D435F3238
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbiJCO6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiJCO6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:58:21 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665AE27FDD;
        Mon,  3 Oct 2022 07:58:20 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1327ba38599so2557655fac.11;
        Mon, 03 Oct 2022 07:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5cbLfqZI3Q8R3SGXiA37ed3O2MwBVAUrjqH+O7vBBxM=;
        b=X+5T1mC+lcUtggfXw1+kRz8JcCfMYvCcqndpb9FBaIfAKMDmmn6Yl+VFjnafX17Y0O
         KRXjlyZvb578sLl6bAdHcPMWvC2WndutLeYblk6XI4PqdLtpa5k7W58vr7ntdQY6yFzg
         doGKh6O1tqSIE1EtC4dBHJZmhfEiV0hwBahPbqEL9sV1lxMEy1KoDvkkZbUo70mKhG4I
         hhwredDKB9fo3b1F6A51/lfmh3g43BySv4JhnqNNrXpL4Dfr1dhrhlGcfZ+tn8n+d41x
         nt64AeBkS7f4tu61C39fjXhrJ4nqj1AGYVQzw5AYxd8LMq1YTdlpBonmIrsAMASqFHqC
         mlnQ==
X-Gm-Message-State: ACrzQf2VSJL6NwK/s5BbXGKEXsQn33PbecDwcmnOys8d3Y2g1lXov9xN
        BAOvqkgFpCVVbD2HDAT+PA==
X-Google-Smtp-Source: AMsMyM4NsYhk/PTE/9yjhHOaP5R9tw0lmISIvFKVVGKWethMJ7ua6fEfnSkoc/gMkL45Seg9UfwCQA==
X-Received: by 2002:a05:6871:783:b0:12d:4b84:352d with SMTP id o3-20020a056871078300b0012d4b84352dmr5484225oap.179.1664809099630;
        Mon, 03 Oct 2022 07:58:19 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o24-20020a05680803d800b0035179b87ba5sm2501593oie.20.2022.10.03.07.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 07:58:19 -0700 (PDT)
Received: (nullmailer pid 2249263 invoked by uid 1000);
        Mon, 03 Oct 2022 14:58:18 -0000
Date:   Mon, 3 Oct 2022 09:58:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     houlong.wei@mediatek.com, linux-kernel@vger.kernel.org,
        jassisinghbrar@gmail.com, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4] dt-bindings: mailbox: Convert mtk-gce to DT schema
Message-ID: <166480909049.2249063.7109234696871106188.robh@kernel.org>
References: <20220921090006.37642-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921090006.37642-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 11:00:06 +0200, AngeloGioacchino Del Regno wrote:
> Convert the mtk-gce mailbox binding to DT schema format.
> 
> During the conversion, the examples for client device/mutex nodes
> were removed, as these are found in their respective bindings:
> arm/mediatek/mediatek,mmsys.yaml for "mediatek,mt8173-mmsys"
> soc/mediatek/mediatek,mutex.yaml for "mediatek,mt8173-disp-mutex"
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Changes in v4:
>  - Removed deprecated examples comment
>  - Fixed address for gce example
>  - clock-names variation is now in allOf block
>  - Added soc bus node with two address/size cells, as to
>    provide a more practical example for the gce node
> 
> Changes in v3:
>  - Removed '|' from description
>  - Removed mbox client examples
>  - Squashed patch dt-bindings: arm: mediatek:
>    mmsys: Reference to mediatek,gce-mailbox.yaml
> 
> Changes in v2:
>  - Changed mtk-gce.txt references to new yaml file
> 
> 
> A previous attempt for this was made at [1], but it was changing
> the way of getting clocks (by name for all).
> Keeping clock-names not required for the multi-gce case makes this
> binding simpler, hence I chose to abandon the change at [1] and go
> for this one instead.
> 
> Any Reviewed-by or Acked-by tag was dropped, as this conversion was
> completely redone from scratch and differs from [1] for the
> aforementioned reasons.
> 
> [1]: https://lore.kernel.org/all/20220524151512.247435-1-angelogioacchino.delregno@collabora.com/
> 
>  .../bindings/arm/mediatek/mediatek,mmsys.yaml |  3 +-
>  .../mailbox/mediatek,gce-mailbox.yaml         | 85 +++++++++++++++++++
>  .../devicetree/bindings/mailbox/mtk-gce.txt   | 82 ------------------
>  3 files changed, 87 insertions(+), 83 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
> 

Applied, thanks!
