Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F33678A25
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjAWWDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbjAWWDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:03:16 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4309A2CC77;
        Mon, 23 Jan 2023 14:03:12 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id d188so11687880oia.3;
        Mon, 23 Jan 2023 14:03:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPNj7OZk5vDM7dcSD5WQmTFPQ+usJZRT3VG70Ynf0co=;
        b=v3S6YBqAIJnliwuzR7iu3D2Gv/e7vedg7GEaJcK+ijxa5YeyVpz4nP8pa4xBFSOCKh
         fKjn38c40socUzN1BAkgjzUQIp9GzaUGaQEpycMIv4VxGg17TNSDPvx4CDpsqm5Dvdmg
         DlYkeNeaHoVVK4nvjaJOvCqiHHR6xPrMnbvMmGcaCS9b5qI8IdSNLJ8JA3TysEqyrYda
         QDC4k6Mk4d9gKoeNCDVYoFUHkzYyBvElO9r8VLLX7ktAHhtzYZfHBviL+W7CEhAYiRJS
         2Io2wy6j2gJc3/IRcm2SeP0ypYQGhX9yutTHvtQIIMqNcSriq+Msse4p9rIKpRfM5ND/
         MOSg==
X-Gm-Message-State: AFqh2kpxeDQiuh+RajrmGrEsqfO0dXuia3NNw+plf52W5baW7/DDTDxG
        qfBmKux3cjjeYBdRLIDRZR5niSD09A==
X-Google-Smtp-Source: AMrXdXvm5Y3yUIET6W50U0XDoN98Wwbm2xAsCOrNU6iS3xxSy2PgYFLdqEbza2noM4aXvfi+/44h1Q==
X-Received: by 2002:aca:5a0b:0:b0:35e:d1f9:d6e8 with SMTP id o11-20020aca5a0b000000b0035ed1f9d6e8mr10922232oib.13.1674511392061;
        Mon, 23 Jan 2023 14:03:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l74-20020a9d1b50000000b0068668e2e08bsm171697otl.58.2023.01.23.14.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:03:11 -0800 (PST)
Received: (nullmailer pid 2717520 invoked by uid 1000);
        Mon, 23 Jan 2023 22:03:11 -0000
Date:   Mon, 23 Jan 2023 16:03:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: vendor-prefixes: document
 lineartechnology
Message-ID: <167451138997.2717416.2941670202673662358.robh@kernel.org>
References: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120075618.153664-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 08:56:17 +0100, Krzysztof Kozlowski wrote:
> Document lineartechnology vendor prefix, already used in SPI dev.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!
