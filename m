Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61978681DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjA3WSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjA3WS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:18:28 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CD339B86;
        Mon, 30 Jan 2023 14:18:27 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id bx13so5556694oib.13;
        Mon, 30 Jan 2023 14:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LID14tcHsWtSZ9LFm5YfjNhAXe/nh21vFfsomug3z8s=;
        b=05SNX0diz4FVWUU6Lk+WHAeTaH9sLM+GjfrVdDOhP0YAOCGsczhH6AORYAXyScMiyW
         F4VllpAteEZP2//XIiBaUAF8IG1uGsRtGNsmAmUKFYUQ3a8pLI90ezljKnYdp3IzZae5
         AN0NfdFO7NGDZeaBS0Oj5vOlZcY3bodMtT4597c/ipHrp4xnBM1MfaLtq7fWkDivSsH4
         s7lDod2bgaHdw818rXWNF7y90gtb6aPR/0g/SnocfwkDwTiWypwOKJmlK77Co70wqYIL
         QlVF5jKjmZpGbfVs5SRpRgxsx/ezQFu4ZHipX7mnn1FYxO7sbNJCgSq7GtBmtUPJ7pm9
         lF/Q==
X-Gm-Message-State: AFqh2kqTKiInUkqcwDYYvPNo9TDT7bgBpU3Xw8RoVeFaFU3ZVBTJMKP4
        uhaQ49m6lk6zwO1ImutjDQ==
X-Google-Smtp-Source: AMrXdXs1NCrZT89FPFmv7XPBbmDuEkaZQo0WfboTzyNpNz1EHu4o+aPJq5h/fptkxAlCUhf8RDqyyQ==
X-Received: by 2002:a05:6808:2222:b0:364:5a39:ec53 with SMTP id bd34-20020a056808222200b003645a39ec53mr30220040oib.22.1675117107172;
        Mon, 30 Jan 2023 14:18:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd9-20020a056808220900b0037832d7f783sm2117850oib.58.2023.01.30.14.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:18:26 -0800 (PST)
Received: (nullmailer pid 3627302 invoked by uid 1000);
        Mon, 30 Jan 2023 22:18:26 -0000
Date:   Mon, 30 Jan 2023 16:18:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-mmc@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: Improve grammar and fix
 a typo
Message-ID: <167511710560.3627239.4258269481482064895.robh@kernel.org>
References: <20230129130059.1322858-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129130059.1322858-1-j.neuschaefer@gmx.net>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 29 Jan 2023 14:00:59 +0100, Jonathan Neuschäfer wrote:
> This makes the text read a little better.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
