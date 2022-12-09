Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7906489F6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 22:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiLIVTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 16:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiLIVTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 16:19:50 -0500
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA176820;
        Fri,  9 Dec 2022 13:19:49 -0800 (PST)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-14449b7814bso1256857fac.3;
        Fri, 09 Dec 2022 13:19:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0CYZRah3vA33u+LBDHXd4tqU7QpcDx+gj7c6+Nqhg8=;
        b=NPQDvYhdjVgYeDkR3VeB0FN3XM6Xx/0epIPNyhHHWlgAeIJLh25Sy7ITr4dAEJgJIh
         dZgRmUepglVDipp7uoxTohIuwjN7g7/aJU7tatlPQ2MjO2cEg+I7DUwU/4j/9vP+33Q7
         FPWW/4cLH+Ge2ob/0TUSoZSPmyB8+t1p7NVilxr4lQStqEQNfyd4nVivdNOL7UPoinWy
         E0o190d21ny7ev4av+HAzyX86xnBxfFtL/WXaVHaqShIem2Y3bCtY6gLp8r+YzyBWZRS
         b53oeD7Abg2JhrZs9VeuwdvUdfR/DaoVjRY3Rz6K55sKTwGVitHqGxzL1VRSOu514PfR
         Il/g==
X-Gm-Message-State: ANoB5plNH2BHRv4iYMbwQ4dXjb+bNdl3JIMe8XySu2u1AkJ6GaN3frK4
        xonhTb2KcpEszrdyA3HA+g==
X-Google-Smtp-Source: AA0mqf43jIF6owyVw8fXmCDLxV4J9uJfGEvsEYepOwcOJy5Jb6SjATH7PuTTBwQeSgbicD17+tx++g==
X-Received: by 2002:a05:6870:6b92:b0:148:9d1:5a0d with SMTP id ms18-20020a0568706b9200b0014809d15a0dmr1494114oab.21.1670620788613;
        Fri, 09 Dec 2022 13:19:48 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020a056870219200b00141e56210b2sm1341272oae.57.2022.12.09.13.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 13:19:48 -0800 (PST)
Received: (nullmailer pid 3865261 invoked by uid 1000);
        Fri, 09 Dec 2022 21:19:47 -0000
Date:   Fri, 9 Dec 2022 15:19:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH] media: dt-bindings: atmel,isc: Drop unneeded
 unevaluatedProperties
Message-ID: <167062078360.3865138.787316182218792810.robh@kernel.org>
References: <20221207204406.2810864-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207204406.2810864-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Dec 2022 14:44:06 -0600, Rob Herring wrote:
> The 'port' node scheam has both 'additionalProperties' and
> 'unevaluatedProperties', but only one is necessary.
> 'additionalProperties' works here, so drop 'unevaluatedProperties' and
> move 'additionalProperties' next to the $ref.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/media/atmel,isc.yaml | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Applied, thanks!
