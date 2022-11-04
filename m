Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2BF61A3A1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiKDVwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiKDVw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:52:28 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E2350F09;
        Fri,  4 Nov 2022 14:52:25 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id k59-20020a9d19c1000000b0066c45cdfca5so3394441otk.10;
        Fri, 04 Nov 2022 14:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/H9wv3Ry105hn9YPLlG4cTqcOFeFDcAOOAhrcWbf4J8=;
        b=c73bwXhfRt2/5JJrZaHJxzYo/0IsOD7C6KjRKgKsmpzvR9bmCnLEUNiEBSK0agMssC
         Ppub83BPOxF4sNSmLmmOtHnkiJyX5CSgm7sVN82gejyqhURGmg9bODznlvpC7+P+9bet
         SR9Mz3Otw2m7wegiHZN8iX4kAPfy07FGXmvD5Ud8t3yEtKslmFD4BnWN6Z4yvC7FtRD7
         c8173GAfuOVqtVIcLlwD/68GvpLeHawVj/h4dVJEKQ+aiszV0lAL4JE6dQMYDa5tbaXL
         b4H9IpXfyE3TRnYvCrHkcDvisOKE/dEtq/YLISyXZGon0OSq2uouJ8aQhWVuCYrdvdzb
         k1xw==
X-Gm-Message-State: ACrzQf0eW2LKkCftH7ZapViPEiO7EmK0MSYLOz5c6w2AO8NaTs7F5pL0
        DujFQ3GGu8rgeyzBt2v+SQ==
X-Google-Smtp-Source: AMsMyM7jSo5RKk0XtK1mVgQ4Jr3vEOaeiYkklWLwczNXNwPiyNPJOwKeAFrRRyOdu3Ms/hkoidtIXg==
X-Received: by 2002:a05:6830:54b:b0:66c:794e:f8c6 with SMTP id l11-20020a056830054b00b0066c794ef8c6mr138138otb.343.1667598744812;
        Fri, 04 Nov 2022 14:52:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i128-20020acab886000000b00354932bae03sm115271oif.10.2022.11.04.14.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:52:24 -0700 (PDT)
Received: (nullmailer pid 2891341 invoked by uid 1000);
        Fri, 04 Nov 2022 21:52:25 -0000
Date:   Fri, 4 Nov 2022 16:52:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Derek Fang <derek.fang@realtek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com
Subject: Re: [PATCH v2 2/8] ASoC: dt-bindings: realtek,rt5682s: Add DBVDD and
 LDO1-IN supplies
Message-ID: <166759874551.2891287.15709130108810995782.robh@kernel.org>
References: <20221102182002.255282-1-nfraprado@collabora.com>
 <20221102182002.255282-3-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102182002.255282-3-nfraprado@collabora.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2022 14:19:56 -0400, Nícolas F. R. A. Prado wrote:
> The rt5682s codec has two additional power supply pins, DBVDD and
> LDO1_IN, that aren't currently described in the binding. Add them.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Made names uppercase
> 
>  .../devicetree/bindings/sound/realtek,rt5682s.yaml    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
