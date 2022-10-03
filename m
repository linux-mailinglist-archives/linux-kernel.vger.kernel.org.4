Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C75F34DC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJCRwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiJCRwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:52:20 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD385360B0;
        Mon,  3 Oct 2022 10:52:17 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso7239672ook.0;
        Mon, 03 Oct 2022 10:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=xvsdxEtnYkPfQLyO5cLOKwbi4UXuqIx2u55wTtOO8RA=;
        b=Nfy8Nw48bBbDGKwCiLUYA5ypPWktrBgO1Wn0vAdLJR/pHvmBBab7GthRNhlTRJVZUD
         n7wCgxU6uzsL7Nip2dJBrBj/NN90KrXXKLIwzUFoAQ05hhFnGLqGXr5/9dEjJnEx9Rrl
         OPcirkaI4FKGQHVJ1SCteKtttTqX6spPGtcC073MAdqGMwrGRu131wtPRrcB1VDPRc0v
         pennHHiuf6jTVK7PEGYUmYXDn7LBhLZ6d0JAK6tCeTF3kMHVodnTYYLs6fa8PuaoAe/1
         VyTybK19Q+ElVFtZpzK3KuyKLmt6NyaVdSOu19JfBfynwCI/iIzwOdRyxYaTMiu2Yx//
         ifBw==
X-Gm-Message-State: ACrzQf1g+S2tjDVYiF5xtiVpKIqouX6s8QMvdHs5dt8RHhSN3h3RPTdM
        qMF7nk4ZNFkV0F4XG9/DL6jxGZFD2A==
X-Google-Smtp-Source: AMsMyM4DDvuio5dvVe3dVnQDdky65TKGZdFB9jx3JkXpTO1eyscdyWrn9nxAsZXfqsK3VvOLN+2iKg==
X-Received: by 2002:a9d:774e:0:b0:65b:c11d:3776 with SMTP id t14-20020a9d774e000000b0065bc11d3776mr8220313otl.373.1664819536960;
        Mon, 03 Oct 2022 10:52:16 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c2-20020a4ad8c2000000b0046e8d284170sm2157914oov.41.2022.10.03.10.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:52:16 -0700 (PDT)
Received: (nullmailer pid 2504070 invoked by uid 1000);
        Mon, 03 Oct 2022 17:52:15 -0000
Date:   Mon, 3 Oct 2022 12:52:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julius Werner <jwerner@chromium.org>
Cc:     devicetree@vger.kernel.org, Jian-Jia Su <jjsu@google.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4 v5] dt-bindings: memory: Add jedec,lpddrX-channel
 binding
Message-ID: <166481953479.2504015.9253665477423699363.robh@kernel.org>
References: <20220930220606.303395-1-jwerner@chromium.org>
 <20220930220606.303395-4-jwerner@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930220606.303395-4-jwerner@chromium.org>
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

On Fri, 30 Sep 2022 15:06:06 -0700, Julius Werner wrote:
> This patch adds a new device tree binding for an LPDDR channel to serve
> as a top-level organizing node for LPDDR part nodes nested below it. An
> LPDDR channel needs to have an "io-width" property to describe its width
> (this is important because this width does not always match the io-width
> of the part number, indicating that multiple parts are wired in parallel
> on the same channel), as well as one or more nested "rank@X" nodes.
> Those represent information about the individual ranks of each LPDDR
> part connected on that channel and should match the existing
> "jedec,lpddrX" bindings for individual LPDDR parts.
> 
> New platforms should be using this node -- the existing practice of
> providing a raw, toplevel "jedec,lpddrX" node without indication of how
> many identical parts are in the system should be considered deprecated.
> 
> Signed-off-by: Julius Werner <jwerner@chromium.org>
> ---
>  .../ddr/jedec,lpddr-channel.yaml              | 146 ++++++++++++++++++
>  .../ddr/jedec,lpddr-props.yaml                |  10 +-
>  2 files changed, 155 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
> 
> Changelog:
> 
> - v2:
>   - changed $ref for rank subnode to specifically match LPDDR type in
>     compatible string
>   - moved `reg` up to be listed right below `compatible`
> - v3:
>   - no changes
> - v4:
>   - no changes
> - v5:
>   - no changes
> 

Reviewed-by: Rob Herring <robh@kernel.org>
