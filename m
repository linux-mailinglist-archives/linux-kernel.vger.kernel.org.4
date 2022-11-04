Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B9561A3A6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbiKDVxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiKDVwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:52:44 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E024A51C37;
        Fri,  4 Nov 2022 14:52:39 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id k11-20020a4ab28b000000b0047659ccfc28so853777ooo.8;
        Fri, 04 Nov 2022 14:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gcaftyW/+TrxlNzLFepPQcr49mClWw57ztjikQx867c=;
        b=nig3msJ5Qc+ZPmGGNBJ4twy/GpywPdULXnh+JUTMUh2lYxHzmh4r7mHY9LlP0E4Xbx
         P5l6nu2UseD4KqS7pJWEaKLERc9cXwxAXPPTvKxtO3yh0zmqdA+VEdbLSb0n4GbMGFjq
         ldXwvHQq48tbbf4amtPeepDNyLeb42qurLLJKb3ynanqViJVPqDBsUKhcD2oNBu2/8us
         yLye9XrzFyyeAYUbwc1JjITrlrtFkZaj8ihi2nSE2PC9lvgNn2+2HNdn0X9lUHySsuKz
         Bp5vb/wJZSZFmdb7srPzoAxBhZCrjdYozrP0IFK9FN+MDKFg7aVtNHJQMB1odvoFPcpT
         dx+g==
X-Gm-Message-State: ACrzQf2OdxXUHGhRtQSBfQ74U+qzO3Kcdw+WfS8uo942GMY0Db+Si0mZ
        71tSX6sePffcjurKd99t/Q==
X-Google-Smtp-Source: AMsMyM4gGiFUX7wv5obU69nMFlLoibwDc4W5TMCdNLIk8IhFdrIWjLX+V4GKGPt8BstCU/5P/m7g1w==
X-Received: by 2002:a4a:94a6:0:b0:435:f61e:d7a1 with SMTP id k35-20020a4a94a6000000b00435f61ed7a1mr16021538ooi.82.1667598759132;
        Fri, 04 Nov 2022 14:52:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x7-20020a056870434700b0013c955f64dbsm74173oah.41.2022.11.04.14.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:52:38 -0700 (PDT)
Received: (nullmailer pid 2891709 invoked by uid 1000);
        Fri, 04 Nov 2022 21:52:40 -0000
Date:   Fri, 4 Nov 2022 16:52:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wenst@chromium.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH v2 4/8] ASoC: dt-bindings: rt5682: Add DBVDD and LDO1-IN
 supplies
Message-ID: <166759875979.2891653.11675024922325754885.robh@kernel.org>
References: <20221102182002.255282-1-nfraprado@collabora.com>
 <20221102182002.255282-5-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102182002.255282-5-nfraprado@collabora.com>
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


On Wed, 02 Nov 2022 14:19:58 -0400, Nícolas F. R. A. Prado wrote:
> The rt5682 codec has two additional power supply pins, DBVDD and
> LDO1_IN, that aren't currently described in the binding. Add them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Made names uppercase
> 
>  Documentation/devicetree/bindings/sound/rt5682.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
