Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18501697230
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjBNX45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbjBNX4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:56:48 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883A298E4;
        Tue, 14 Feb 2023 15:56:48 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id f10so6946427ilc.7;
        Tue, 14 Feb 2023 15:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNbUf4FzeMlGqHQbOghX36B1I+My6Cb4YZ8Dw7XMggA=;
        b=7kXhM073JZv2SuFOMePSghqQEmSI6bEesXUCsHngkYjTyaiy2Z7dy2uUWlRcdbXFUn
         wN2cwtpxSEMzb0YEzMzZdTchnD722NduDBCKSXYudsY6d/EJO29eLBaEtVN08tobeXOs
         qTvGYUvpr9LzeQ5oKs8KICwiHjqM7ov2TWS61jUre/5tCDtIs2eMWnwXqbZgNHH3X5Pc
         f0ZbUXKUT33NQarT1PMOO0ZtLRE9eSYFZzpZdRoIIAPybuRi046u3rHv4DW6lMbeNUhO
         0LY/HtFmV/99uJkTwr1qd0GaHl11p+KqWrUAvIhUPVnXBunZK+DSY7tkf7hrZxlgkQKT
         JqEg==
X-Gm-Message-State: AO0yUKWHz8aL2txZTIlq8TA+Jzauo4EZCmNhMWZ6EEY9Ni1RNUunp0xG
        klDus4ruLKwKavWYoJ+PUblf1l044Q==
X-Google-Smtp-Source: AK7set8oA758nqEvMNPSikkT2q5X0OAL6a5A903vZHrJvS4wsWRuVQ8xDVsJHPApoqUn56BYMDvCHg==
X-Received: by 2002:a92:c54c:0:b0:315:3d25:231b with SMTP id a12-20020a92c54c000000b003153d25231bmr518562ilj.9.1676419007285;
        Tue, 14 Feb 2023 15:56:47 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.3])
        by smtp.gmail.com with ESMTPSA id e5-20020a02a785000000b003a2cb2937cdsm496843jaj.31.2023.02.14.15.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:56:46 -0800 (PST)
Received: (nullmailer pid 54846 invoked by uid 1000);
        Tue, 14 Feb 2023 23:56:40 -0000
Date:   Tue, 14 Feb 2023 17:56:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        David Virag <virag.david003@gmail.com>,
        Chanho Park <chanho61.park@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH 1/6] dt-bindings: clock: exynos850: Add Exynos850 CMU_G3D
Message-ID: <167641899995.54792.18191186654068619440.robh@kernel.org>
References: <20230211064006.14981-1-semen.protsenko@linaro.org>
 <20230211064006.14981-2-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211064006.14981-2-semen.protsenko@linaro.org>
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 11 Feb 2023 00:40:01 -0600, Sam Protsenko wrote:
> CMU_G3D generates Gondul GPU and bus clocks for BLK_G3D.
> Add clock indices and binding documentation for CMU_G3D.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  .../clock/samsung,exynos850-clock.yaml        | 19 ++++++++++++++++++
>  include/dt-bindings/clock/exynos850.h         | 20 ++++++++++++++++++-
>  2 files changed, 38 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

