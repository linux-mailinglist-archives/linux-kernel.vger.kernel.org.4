Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB94656570
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 23:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLZWgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 17:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbiLZWgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 17:36:11 -0500
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A691122;
        Mon, 26 Dec 2022 14:36:03 -0800 (PST)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-14fb3809eaeso7875517fac.1;
        Mon, 26 Dec 2022 14:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E75KchBQqDtNUprgzL6WlYr5wAjCueagQYKGTYt0RGQ=;
        b=FNB0acv8vEbyGEBRknBYFJejFu/H+yVHbuMqlBoiJYiBGWj8CJlxYyMN6zlhQ0fYsq
         onMwkUScGr5ANpcZnm4GQAsegN16MEbcX4quBuGZ8IZFWHFw8QQTIK6emyC10tvgBmYq
         I0XsEZWRqbjFCfjY/Qgwv6DX/okazoWwgCEeSry3SQ/sMmXpD5YLIoisdhDbacTXmvhP
         mvxDmwic8K9eBQX4YENK76li3ShDcrhWWPTfiKrERbGtoc2nVLpfqoDjW9Q3sMhE/K8g
         Fvorpetha5R6+1u8fhCH1VnchVoct0/d6m3D0Pqh3+rs0ESd8G9bOCRQppbL4+IwU1W8
         tTSg==
X-Gm-Message-State: AFqh2ko4B/GhpuoJ8O+UVH9xKBrC2eJc7G2BV4jxpmdH0VAto/XAReMk
        7UhEH1FedNt4AWsZPggEGg==
X-Google-Smtp-Source: AMrXdXsbNGmzsOi/lM9QdNE9bSZnKRFOP5v+x+u1UpPXql/7Dhn/CWBkVyerVbVKZPShQ3fNqtEFew==
X-Received: by 2002:a05:6870:ec88:b0:144:e875:5a1b with SMTP id eo8-20020a056870ec8800b00144e8755a1bmr10864512oab.57.1672094162781;
        Mon, 26 Dec 2022 14:36:02 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80e8:2792:eb0e:539f:f657:547b])
        by smtp.gmail.com with ESMTPSA id cm8-20020a056830650800b0066d2fc495a4sm6007286otb.48.2022.12.26.14.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 14:36:02 -0800 (PST)
Received: (nullmailer pid 78411 invoked by uid 1000);
        Mon, 26 Dec 2022 22:03:08 -0000
Date:   Mon, 26 Dec 2022 16:03:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Linux Clock List <linux-clk@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Jai Luthra <j-luthra@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Samuel Holland <samuel@sholland.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Devarsh Thakkar <devarsht@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: clock: fixed-factor: Add TI AM62 SoC
 OLDI clock
Message-ID: <167209218816.78357.6777018705990998631.robh@kernel.org>
References: <20221226095745.19757-1-a-bhatia1@ti.com>
 <20221226095745.19757-2-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226095745.19757-2-a-bhatia1@ti.com>
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


On Mon, 26 Dec 2022 15:27:44 +0530, Aradhya Bhatia wrote:
> Add "ti,k3-am62-oldi-clk-div" to the fixed factor clock compatible enum
> list.
> 
> "ti,k3-am62-oldi-clk-div" is a fixed-factor clock that helps the TI
> display subsystem request a pixel clock for itself and a corresponding
> serial clock for its OLDI Transmitters. The serial clock is 7 times the
> pixel clock. This clock needs the clock set rate request to be
> propagated to the parent clock provider.
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  Documentation/devicetree/bindings/clock/fixed-factor-clock.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
