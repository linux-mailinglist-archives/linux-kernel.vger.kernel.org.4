Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008C664CD97
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238572AbiLNQAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238500AbiLNP7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 10:59:32 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A3B24091;
        Wed, 14 Dec 2022 07:58:16 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id s186so2960333oia.5;
        Wed, 14 Dec 2022 07:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohnzc1o66yIs2LOA/u0EnDBRAn8LEk4Wj9WsU7EuZSQ=;
        b=MBlbyhZz0+evddHsQw1ARWYFOhVghEJCJE894cySRyRiSVKLTbr8v4RWUJ9cZsrBbG
         ZSqC5IQr2NAkMey9aQlp6ezZSVyGbLC+Nk6CSL+4v4dHeerXm/9OF3qQYC7j9VORsevH
         0uZbR6TZ1uN/dWzspsTlqf5vU5UvwXDm4iUKeHJ2imrTwJ5x2uzJtztg4DtfGXsGyeAZ
         ojfn3afYykHs4/gd/F7SRzz62MUTYnferRE7LksugwL9yhCJH3Wks7AIoMjWRtEjoW9Z
         xYlq/l/M6VNwS62MNse//x3OU4nai1VSipieQWPimtiS0LaCoYdoEdmL5VNx4iMsRobA
         wxvQ==
X-Gm-Message-State: ANoB5pnNC8EO3lco8ofD5CY+G1XibLd03MqEpr6DsvQGoaFukAetabJC
        VVUf8l0Z42j0tGvBT1p40g==
X-Google-Smtp-Source: AA0mqf5TAyAdXyKadPxASJjHqEwdmxYBxeu/KaNYrnJMRivzzFdvwgNTG0cS41y0oM000qVruUFJ0g==
X-Received: by 2002:aca:b756:0:b0:35c:29d3:9379 with SMTP id h83-20020acab756000000b0035c29d39379mr10270832oif.35.1671033496077;
        Wed, 14 Dec 2022 07:58:16 -0800 (PST)
Received: from robh_at_kernel.org (rrcs-98-6-157-194.sw.biz.rr.com. [98.6.157.194])
        by smtp.gmail.com with ESMTPSA id z6-20020a056808028600b0035b7002af8csm9291oic.56.2022.12.14.07.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 07:58:15 -0800 (PST)
Received: (nullmailer pid 1135240 invoked by uid 1000);
        Wed, 14 Dec 2022 15:58:14 -0000
Date:   Wed, 14 Dec 2022 09:58:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: usb: add the Renesas RZ/N1 USBF
 controller
Message-ID: <167103349424.1135180.17746497216489018146.robh@kernel.org>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
 <20221213133302.218955-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213133302.218955-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Dec 2022 14:32:58 +0100, Herve Codina wrote:
> The Renesas RZ/N1 USBF controller is an USB2.0 device controller
> (UDC) available in the Renesas r9a06g032 SoC (RZ/N1 family).
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/usb/renesas,rzn1-usbf.yaml       | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/renesas,rzn1-usbf.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
