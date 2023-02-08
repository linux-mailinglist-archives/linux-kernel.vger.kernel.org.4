Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDB368FB70
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjBHXpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBHXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:45:44 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31831EBF5;
        Wed,  8 Feb 2023 15:45:20 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id cz14so241291oib.12;
        Wed, 08 Feb 2023 15:45:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FEDuDQhTbUvzrwdCHgeVaTGKWNza//o7siNKoCcENNM=;
        b=u8QxbIh/n5uS9mbDb2ZMLZ6q8PF5hVlOnWhIVzA1bxOGskv4qAxa7AyAXp0lz9A4eo
         4K4irt/Z4NFBTvEawp57pjGsABxRm8Jln1IQprwVdZL9rDlNbB1fD9HRUgi5Fzk0m47U
         Q8C2qCZGvM778odH4fgOVhy1Cn+8J6Bf0qH/8mcUVHmfU5Hh1SaLfPjIT56z69Wke9MD
         U6ktHz7zdPBcqYbv7z8sLE9PxzM2b1jByWuRRdayNnMketv9Et0naiUtlg/Yhbzew31+
         Hk2ExcjSPon/szIqFbEiM/AqmvLtnSRVpi9HZ9pyG3HBy4OQnIrdwchd0LnsPpqBQ8tP
         v03A==
X-Gm-Message-State: AO0yUKUjpE8FnNAF+TF4bjgoVrkgPO06jSOZHZkvP3Ui8IB3TA2QjXMt
        JWs7s5jALecNIE6h2cibICtefQtiuw==
X-Google-Smtp-Source: AK7set+Zy5NSdZV09guplxV+kma655ogdpZI2VW4E5mHSzeVJYjl5PioVhF+Pg0JqvxfEERiyMVR4Q==
X-Received: by 2002:a05:6808:1da:b0:378:9f53:b331 with SMTP id x26-20020a05680801da00b003789f53b331mr4038526oic.0.1675899919838;
        Wed, 08 Feb 2023 15:45:19 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q62-20020aca5c41000000b0037ac4a18acfsm27432oib.48.2023.02.08.15.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:45:19 -0800 (PST)
Received: (nullmailer pid 2933513 invoked by uid 1000);
        Wed, 08 Feb 2023 23:45:18 -0000
Date:   Wed, 8 Feb 2023 17:45:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Herve Codina <herve.codina@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Milan Stevanovic <milan.stevanovic@se.com>
Subject: Re: [PATCH 1/2] dt-bindings: soc: renesas: renesas.yaml: add
 renesas,rzn1d400-eb compatible
Message-ID: <167589990223.2933068.3125357540016259714.robh@kernel.org>
References: <20230207145444.166950-1-clement.leger@bootlin.com>
 <20230207145444.166950-2-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230207145444.166950-2-clement.leger@bootlin.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 07 Feb 2023 15:54:43 +0100, Clément Léger wrote:
> Add "renesas,rzn1d400-eb" which target the RZ/N1 EB board when a RZ/N1D-DB
> daughter board is plugged on it.
> 
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  Documentation/devicetree/bindings/soc/renesas/renesas.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

