Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E688616738
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiKBQKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKBQKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:10:37 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0482B1AF;
        Wed,  2 Nov 2022 09:10:36 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id b124so7175274oia.4;
        Wed, 02 Nov 2022 09:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VJS1eRrGEpJHqFbLWtcQx5ZPGULvRnL+9bh/Twyl1k=;
        b=uEUlIqb1+B812jmbZqdTkOPQr8xOFbdCMZg99wqtoxovnBD5uHwc6NAzKpLfrib21o
         6D12LF8/+7SjlUmpSvdOCIbTDs/H+f5LerHVew5t27jfBzQ+XltLar4zNRf7nnvkN1qz
         8I+HOxzaLhvoJbdTBddx6ZDMWjJf4RX064uZRGMfu8oBRq4GTZgDs1OpjyhxPHrgdVea
         ilFZOVIncdCNQv4qex+qRNJ0rD8QJ48DL/ryWkvuOnOhRQKCVMkl3U1dlo6SOajwpoxD
         VBihi7CXjrZk3M7bsCEdrvl5SdY3G04kk/C26FOgRDHDviurF/Tv6af+EU0SXH57CZ1K
         2LCg==
X-Gm-Message-State: ACrzQf2UWuOoACna77pz7TqhJiOqbsfgu2P2ppBsrq/HUO7VaT8HAPQt
        sOO5qPkQFf4IMShFxxAbkA==
X-Google-Smtp-Source: AMsMyM6uvwcr+id62GI7restHplkU8LVzfDM4M4rB3BUnjN2xlN1CKN4Kar/50fuLvLckJshJYeTDw==
X-Received: by 2002:a05:6808:2009:b0:35a:1a52:2716 with SMTP id q9-20020a056808200900b0035a1a522716mr7585504oiw.211.1667405436161;
        Wed, 02 Nov 2022 09:10:36 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a25-20020a056870a19900b0012d6f3d370bsm6149597oaf.55.2022.11.02.09.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 09:10:35 -0700 (PDT)
Received: (nullmailer pid 3983046 invoked by uid 1000);
        Wed, 02 Nov 2022 16:10:37 -0000
Date:   Wed, 2 Nov 2022 11:10:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "chunxu . li" <chunxu.li@mediatek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?iso-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E?= Prado 
        <nfraprado@collabora.com>, alsa-devel@alsa-project.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 1/2] ASoC: mediatek: dt-bindings: modify machine
 bindings for two MICs case
Message-ID: <166740543691.3982990.2425692188339189211.robh@kernel.org>
References: <20221031122224.1846221-1-ajye_huang@compal.corp-partner.google.com>
 <20221031122224.1846221-2-ajye_huang@compal.corp-partner.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031122224.1846221-2-ajye_huang@compal.corp-partner.google.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Oct 2022 20:22:23 +0800, Ajye Huang wrote:
> Add a property "dmic-gpios" for switching between two MICs.
> 
> Signed-off-by: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
> ---
>  .../sound/mt8186-mt6366-rt1019-rt5682s.yaml        | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
