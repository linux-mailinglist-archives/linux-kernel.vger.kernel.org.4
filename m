Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88BA681DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbjA3WQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjA3WQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:16:29 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF5428D21;
        Mon, 30 Jan 2023 14:16:28 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-15ff0a1f735so17067019fac.5;
        Mon, 30 Jan 2023 14:16:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1gAy2MsPL1mgeMVyNEjNqoU5MoZko0cfwbJx1Ivk1cU=;
        b=mVUEGd8+iGJJVtEmJeQDoCZSbEHJfFS6KoApsYP2/jH8gfZuMFy4IMvTTKJ8fYJRj9
         C/KeCtQ72Bb3w2FuLV6X5llgr4SAEsjt66svyuglhYIyRXxYVkUOtxWn0MOxNVR2U1Ao
         S8zN91p+69xTZ6V3B7A01AHLei22ndxzcmIvmK6ppfg96jAJgOgKekMrv6FoCslMsnyD
         QRoSgngGyLLfbYtYBD3MxModGXmqvtTtqBIIqNAkZEcgcpn8gPTtpgnWp/we1/zvFBG3
         fov0tuKfGah0pA83xYdrC70eesrAcfBRMAxjuq7AwTd4Jkh2VGb79kus83rNXzWnfE0I
         /bpw==
X-Gm-Message-State: AO0yUKW0s3GB2tkoaCj2iTzBruCJ9kqFoDbT77JKcnU359BxPpOj1WdC
        7Ydx/RWoeACufKEayowCtw==
X-Google-Smtp-Source: AK7set/xrtAWmQ7TIWn6uKPbZVhxNrg/+u+ntuu4cMuNwq8xXSrcZXbauq2QJnggWgmLNxDOx0VppQ==
X-Received: by 2002:a05:6870:9607:b0:163:416e:a549 with SMTP id d7-20020a056870960700b00163416ea549mr11486315oaq.51.1675116987671;
        Mon, 30 Jan 2023 14:16:27 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id pa13-20020a0568701d0d00b0015f9cc16ef7sm5724355oab.46.2023.01.30.14.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:16:27 -0800 (PST)
Received: (nullmailer pid 3624482 invoked by uid 1000);
        Mon, 30 Jan 2023 22:16:26 -0000
Date:   Mon, 30 Jan 2023 16:16:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     devicetree@vger.kernel.org,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: bus: moxtet: Fix reference to SPI
 peripheral DT properties
Message-ID: <20230130221626.GA3618337-robh@kernel.org>
References: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129123553.1284503-1-j.neuschaefer@gmx.net>
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

On Sun, Jan 29, 2023 at 01:35:53PM +0100, Jonathan Neuschäfer wrote:
> spi-bus.txt has been converted to YAML and the peripheral properties
> have been moved to spi-controller.yaml.
> 
> Fixes: 0a1b929356830 ("spi: Add YAML schemas for the generic SPI options")
> Fixes: 8762b07c95c18 ("spi: dt-bindings: add schema listing peripheral-specific properties")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/bus/moxtet.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not really interested in fixes to .txt bindings. Fix it by 
converting to schema if you want to. By my count, there's 37 other 
cases, why just this one?

Rob
