Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163161A37A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiKDVjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiKDVjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:39:17 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E90BA6;
        Fri,  4 Nov 2022 14:39:17 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id m204so6503422oib.6;
        Fri, 04 Nov 2022 14:39:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=newmcT3dWVHHi0k2AzKHxIAzbgauqUYBBbVo3BlPTgk=;
        b=f4+dyW7TELGKjc+Zhvih/azIl3SGW0aRYePcuUTXRargp3VWRzmoRwJDaUFPYTl8sO
         PvKA+IdIwaDUt4V0If4OLte6wYhiPg02iujkzI0bV1VCo/wD7BEAk3nRB+0MxJd2YtsQ
         +wBIuG15d0KtuiyyGBb/EAqeJ33hdhIErgaqy/F6h9n/Qu75fHcC7pC5LI/FCAaegILA
         LpiBUYZ9Nz1d+1P8pHk5CGC2/gM6D2q//TBhzBHrzTuIunwSwXEyP9j0CoDj2IxEduaV
         H9E3LvxY1rA2MEMdY9xFQktjRGdD4uyJtER6MO0ZhBHSaZ6nERr4KZ3qeWKGSuyGfXgp
         pEEg==
X-Gm-Message-State: ACrzQf1bkvJW7EcDsXh9tguWZiGLWcUvqZFnd8SJGKOj/KiNdUQzvzUd
        iZLYJf++I3OX9tULGem3EQ==
X-Google-Smtp-Source: AMsMyM6ECrXkT2/0pcWb+2yxaeQZEWevvl9EUUDRIk2D/iBgUdWBGzVwCL0SMNW/QXnmtgckjY5lqg==
X-Received: by 2002:a05:6808:3dc:b0:35a:c37:3309 with SMTP id o28-20020a05680803dc00b0035a0c373309mr15750204oie.199.1667597956330;
        Fri, 04 Nov 2022 14:39:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w2-20020a056808090200b0035763a9a36csm75651oih.44.2022.11.04.14.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:39:15 -0700 (PDT)
Received: (nullmailer pid 2876506 invoked by uid 1000);
        Fri, 04 Nov 2022 21:39:17 -0000
Date:   Fri, 4 Nov 2022 16:39:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
Message-ID: <166759787920.2873722.6503685794432759025.robh@kernel.org>
References: <20221102125936.2176748-1-ajye_huang@compal.corp-partner.google.com>
 <20221102125936.2176748-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102125936.2176748-2-ajye_huang@compal.corp-partner.google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 20:59:35 +0800, Ajye Huang wrote:
> Add a property "dmic-gpios" for switching between two MICs.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml        | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.

