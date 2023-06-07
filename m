Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFEB72729B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjFGXAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjFGXAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:00:07 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2A7E4A;
        Wed,  7 Jun 2023 16:00:06 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-33b4b70693eso10094315ab.1;
        Wed, 07 Jun 2023 16:00:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686178805; x=1688770805;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NlONoXmbAqzEpekRPJhtmbZIlf4yXIja9vsOSA5b5Fk=;
        b=duKj9AZ9VY9lnoNfIiCrsMAI4z0mF9Pv7kH3LeTiln5cHMJiDBz1Y4Yn5sz06bFTaa
         Q164Ukx/ONf5FSvMx42erKm2ohi7pRh4cV7Dzbz6NM19decIAWToTPS5aTw3qsMA4Bhd
         e8HiPIPMS8+G46DAwi8qSxT8liPuT2Ew1LHUcer284seTBpt2EEtRK4ASFSYzXgjDVrA
         Rr7jRQyDchPtSaP8c893oCigMROvNfKiB4XvSo4FIjt2TkC/XI8inx9RNZyVx4w1Yfx1
         kUni4zBjY+8XGQexpXr/UykrkHyz1DFCEtCwWJuVb1d6TxwsgzteWSOZsQO7Du8VUzHZ
         9t6w==
X-Gm-Message-State: AC+VfDzmLd1GSSHTE7txiN4rRELSAiDisDwad/gHLG73H3eDrT2hUCwb
        diflcLnQwUIPCvGxBXkQ890bbtqBhw==
X-Google-Smtp-Source: ACHHUZ5XLGT5D0LNOOpdM+A2ktKD23DvK+8Pd9h0qT0PM3ZSd2vUjHuHYKrVV2oicPsU+kmTe/2MfA==
X-Received: by 2002:a92:d5c2:0:b0:33a:a518:653f with SMTP id d2-20020a92d5c2000000b0033aa518653fmr11105782ilq.15.1686178805332;
        Wed, 07 Jun 2023 16:00:05 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a92bf03000000b0032b72b5c1c3sm33498ilh.9.2023.06.07.16.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:00:04 -0700 (PDT)
Received: (nullmailer pid 141320 invoked by uid 1000);
        Wed, 07 Jun 2023 22:59:58 -0000
Date:   Wed, 7 Jun 2023 16:59:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Sam Ravnborg <sam@ravnborg.org>, devicetree@vger.kernel.org,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        kernel@pengutronix.de, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v1 2/8] dt-bindings: display: panel: mipi-dbi-spi: add
 spi-3wire property
Message-ID: <168617879603.141215.16607194482665688976.robh@kernel.org>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-2-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607115508.2964574-2-l.goehrs@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 07 Jun 2023 13:55:01 +0200, Leonard Göhrs wrote:
> Some MIPI DBI panels support a three wire mode (clock, chip select,
> bidirectional data) that can be used to ask the panel if it is already set
> up by e.g. the bootloader and can thus skip the initialization.
> This enables a flicker-free boot.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

