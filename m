Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FEA670B6E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 23:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbjAQWLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 17:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjAQWKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 17:10:24 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48C0808A9;
        Tue, 17 Jan 2023 12:43:32 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1433ef3b61fso33291008fac.10;
        Tue, 17 Jan 2023 12:43:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZGj9wZiCGLkJ0ydeVLb/l9fPBQUxrb09VH4URhu4hc=;
        b=gpqjAiCNUQNqRn8v+9dCKgju3etSJyuCzYL+K4Sso8MMDFVGIVnwNEJ1B/LxqAarIj
         SmBG8MXrr++Eigzx+GkltDIt/RrnRa0K+FnHclCN/AVnIzURUI+96IJMl7MPD3Whb0Ro
         9I0plKoKYCaw/uyWD+w8ohqv88nUEtKMkvU+jOuIVWS5DvFLwj6gXDD6HvBLMnBBI0ig
         aSHymhiyWepwIzm25B+fSBoD8t6WSmxcyF/rlWuAhe32A62l7OOFfbPqfqvF09JGkEpy
         4E6K0j6FeMtETOT9JyVnVY0og3CwpD5qgFQ1mm49HTn/wHR+syGs3YOtN2iteKYyAhsP
         2aJw==
X-Gm-Message-State: AFqh2kr7WNbWVW2zF6ruS9Vt8RA1DqLQlVInabzk8qiSTtqcoqmQGAXv
        FX/S3td6UZqLzyz8ZXV5ug==
X-Google-Smtp-Source: AMrXdXv/JIYevjTeM1oKBF2aHkrWFOaYTPYFb+fUVpkAyIqmdqpbn2HD2jqSq7+NzdhudPanLyjvsw==
X-Received: by 2002:a05:6870:6787:b0:15f:3bb9:3975 with SMTP id gc7-20020a056870678700b0015f3bb93975mr2556603oab.59.1673988210360;
        Tue, 17 Jan 2023 12:43:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a056870f20900b0015f193c86d2sm5307394oao.6.2023.01.17.12.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 12:43:29 -0800 (PST)
Received: (nullmailer pid 3673617 invoked by uid 1000);
        Tue, 17 Jan 2023 20:43:29 -0000
Date:   Tue, 17 Jan 2023 14:43:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Andrew Jeffery <andrew@aj.id.au>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        devicetree@vger.kernel.org, Stephen Warren <swarren@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH v3] dt-binding: gpio: publish binding IDs under dual
 license
Message-ID: <167398813319.3671721.12591580449817050495.robh@kernel.org>
References: <20220905145555.674800-1-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220905145555.674800-1-etienne.carriere@linaro.org>
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

On Mon, 05 Sep 2022 16:55:55 +0200, Etienne Carriere wrote:
> Changes gpio.h DT binding header file to be published under GPLv2 or
> BSD-2-Clause license terms. This change allows this GPIO generic
> bindings header file to be used in software components as bootloaders
> and OSes that are not published under GPLv2 terms.
> 
> All contributors to gpio.h file in copy.
> 
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Andrew Jeffery <andrew@aj.id.au>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Nuno Sá <nuno.sa@analog.com>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
> Changes since v2:
> - Fix commit log.
> 
> Changes since v1:
> - Publish under BSD-2-Clause instead of BSD-3-Clause.
> - Remove Charles Keepax from CC list.
> 
> ---
>  include/dt-bindings/gpio/gpio.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
