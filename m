Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A801678A89
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbjAWWOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjAWWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:13:31 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0461353B;
        Mon, 23 Jan 2023 14:13:00 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso2363254ooo.2;
        Mon, 23 Jan 2023 14:13:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMLmkmo9lGN+fi5ZC+ygOUrkVG9Zx/Ga/8bzeJa5ryE=;
        b=5ot/QDNaUhp3zPLxhQER4ZOQojo5XuIaJOrGRnhDyTCadQijOteOlCGROHV22voDqP
         6zG3NnNnc6WA+awnxZoUuX3QyQxIuAfnNr+7TRK8OHatmKhehYLbEmf1Dg/ady9tkvWv
         /+r7qu6E93zOl19bc7usnKhAfOjHy49FBNJCimPvU5QtGZkPvomqVH7CTyyboiax8SqL
         +ZTLB56ocGpdRZWC9e8TZwXJYiu3W+mirNPwyCBTsDwCZvceD/yeJA6MVelJ42+MlQJo
         grhn6MqYz9ERpFjN82irWyqj1Olj9irA2tlp8Z/3+VAPHVeoyVll+xNFYQZnxsFPoJ7N
         jezw==
X-Gm-Message-State: AFqh2kot/BXXMldrJZt5mapcEccwptt0/9h+FcKPzGgEzkZ7MQCxOZ32
        jDBeU4Pxt7qQCddShSPsGw==
X-Google-Smtp-Source: AMrXdXsj+dUOjJFBkC70kkkAxResHBLRpkv9hhX1dQNQHd6hyWvltfjJ+pcOubXVLewz71LmQgzdHQ==
X-Received: by 2002:a4a:de98:0:b0:4a3:f27d:f319 with SMTP id v24-20020a4ade98000000b004a3f27df319mr20184987oou.8.1674511959046;
        Mon, 23 Jan 2023 14:12:39 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a056820016200b004fd878ef510sm103490ood.21.2023.01.23.14.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:12:38 -0800 (PST)
Received: (nullmailer pid 2730757 invoked by uid 1000);
        Mon, 23 Jan 2023 22:12:38 -0000
Date:   Mon, 23 Jan 2023 16:12:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: samsung-i2s: drop unneeded
 assigned-clock*
Message-ID: <167451195757.2730699.17818991615433078771.robh@kernel.org>
References: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
 <20230120153020.320270-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120153020.320270-2-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 16:30:20 +0100, Krzysztof Kozlowski wrote:
> assigned-clock-parents and assigned-clocks are coming from dtschema, so
> there is no need anymore to keep them in bindings.  Their presence were
> also causing false positives:
> 
>   exynos5422-odroidxu3.dtb: i2s@3830000: Unevaluated properties are not allowed ('assigned-clock-rates' was unexpected)
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/samsung-i2s.yaml | 3 ---
>  1 file changed, 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
