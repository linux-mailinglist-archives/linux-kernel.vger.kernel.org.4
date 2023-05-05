Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E0E6F8BB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 23:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbjEEV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 17:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjEEV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 17:56:51 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349131BD1;
        Fri,  5 May 2023 14:56:50 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1928ec49077so2030138fac.0;
        Fri, 05 May 2023 14:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683323809; x=1685915809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBjOBIORO1KbyqBXqpRnwf8ZpoSh5qNMZH1ZKmIB76I=;
        b=mIbnq0C4dms0HT6pluFzFyQC2TMv1aUHQjau4VtKqT9fnjCjjE4JTa6+CcA5C+ICJb
         I7jZeaKE1QyxgXt1FJKUeLvShHZDxKsxD9RMsf3DLTw3OtOguOMp9KZxnv/1TBS5GYfk
         2scEQRy3eswdqudS3aYyMEffO0OCOnDaJdzyBbZivjg5Gid2Fjv6OXGjt5cIMFEG0kaV
         T4kqZU+MelkflCy3grJelXwHXTmyS+jyyk+o4DwuM7qwqrRZ3dh8sFkuVn13IfacgVBu
         3c65ew4rylFSu8bNgnYwvPsx5b+QxxRXgZLAAcErd8mTXlBMgJheMO0hsAmCqlnuBuNs
         Dfbw==
X-Gm-Message-State: AC+VfDx8DwtlgdUF2+SRRXXtDL6U/9f2z/30As+mp5ZfkqajsNGl0MHs
        z7dgvKhcOGN8DmKJWewl0Q==
X-Google-Smtp-Source: ACHHUZ4wQJnWI6K7YGlPNJ4IufoyWs/7GFwjBTNQPjCq1DrWNVNXaCwWFe+KQE48n6jubw7xR1Wabw==
X-Received: by 2002:a05:6870:e14f:b0:177:b2ab:47d0 with SMTP id z15-20020a056870e14f00b00177b2ab47d0mr1460510oaa.41.1683323809417;
        Fri, 05 May 2023 14:56:49 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y7-20020a056870e3c700b001806f2ac9a6sm2310911oad.47.2023.05.05.14.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 14:56:48 -0700 (PDT)
Received: (nullmailer pid 3631334 invoked by uid 1000);
        Fri, 05 May 2023 21:56:47 -0000
Date:   Fri, 5 May 2023 16:56:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: pwm: Add R-Car V3U device tree bindings
Message-ID: <168332380724.3631274.7082474789909017459.robh@kernel.org>
References: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502165330.55769-1-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 02 May 2023 18:53:29 +0200, Wolfram Sang wrote:
> Tested-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

