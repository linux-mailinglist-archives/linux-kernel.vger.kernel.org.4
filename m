Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA76697244
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 00:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjBNX6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 18:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbjBNX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 18:57:30 -0500
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BA625E2B;
        Tue, 14 Feb 2023 15:57:30 -0800 (PST)
Received: by mail-il1-f170.google.com with SMTP id i26so560181ila.11;
        Tue, 14 Feb 2023 15:57:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gr6HZKX7pjiuziPVOneWNF06CjtvUt+mOQvGio5Mzq4=;
        b=h+okRSBj7GE/h/jmgOGmrp6vpSlm6U/7kVSsm/0qxwx1bDwI8Bg0G6GPHVaNGFgy/8
         Eg+tVHYaJMkikVPctNSg8qDYJemlHXuuN5Lsx9A/GT+LtAlU02Ff2Ej3hDYZ7zYAI9GX
         6TGf/6FOFJV41+EMiqKsM+tEVBSNbi7mgaam1U222m0HpgmV2WwWYxywRA187e9QnJX0
         uS+R8w/8wLDd0OZws9gZuAHOaf/9XLWMzRqNUOgAzPzChQ2VE9ECLzFsU1tx7CktT25h
         4Qzk8mJyQ/4u0dD/zwgE7by0AZW+h9DLSpQEKv578LxxdDQhsu0qNOklyjDXdD+hCLsE
         I7cQ==
X-Gm-Message-State: AO0yUKX3wXE54AGaxyKLFLkvViGvQy3I/CcrpYHseYdsCYsRQqCvvyil
        HDIThevJ5aaenjbOZlnXZQ==
X-Google-Smtp-Source: AK7set9lck2hHxTIM5TfDtimi7UFcfyNl7Vv33Ckn5Za5ontwwdQnwe8lgIAVfz8/w29KcKEYxmHug==
X-Received: by 2002:a05:6e02:b2f:b0:313:ee3f:2b2b with SMTP id e15-20020a056e020b2f00b00313ee3f2b2bmr529025ilu.8.1676419049253;
        Tue, 14 Feb 2023 15:57:29 -0800 (PST)
Received: from robh_at_kernel.org ([65.158.198.3])
        by smtp.gmail.com with ESMTPSA id n1-20020a92d9c1000000b003139668e844sm5140215ilq.13.2023.02.14.15.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:57:28 -0800 (PST)
Received: (nullmailer pid 55945 invoked by uid 1000);
        Tue, 14 Feb 2023 23:57:26 -0000
Date:   Tue, 14 Feb 2023 17:57:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Tomasz Figa <tomasz.figa@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        devicetree@vger.kernel.org, David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: Re: [PATCH 2/6] dt-bindings: clock: exynos850: Add AUD and HSI main
 gate clocks
Message-ID: <167641902471.55444.5418510814778598189.robh@kernel.org>
References: <20230211064006.14981-1-semen.protsenko@linaro.org>
 <20230211064006.14981-3-semen.protsenko@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211064006.14981-3-semen.protsenko@linaro.org>
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


On Sat, 11 Feb 2023 00:40:02 -0600, Sam Protsenko wrote:
> Add main gate clocks for controlling AUD and HSI CMUs:
>   - gout_aud_cmu_aud_pclk
>   - gout_hsi_cmu_hsi_pclk
> 
> While at it, add missing PPMU (Performance Profiling Monitor Unit)
> clocks for CMU_HSI.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
>  include/dt-bindings/clock/exynos850.h | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

