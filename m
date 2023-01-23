Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E399678A69
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjAWWLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjAWWLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:11:10 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432B30B2C;
        Mon, 23 Jan 2023 14:10:45 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id x15-20020a4ab90f000000b004e64a0a967fso2362446ooo.2;
        Mon, 23 Jan 2023 14:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Em4yLToJJ1hEYDhrB1K/Pnv5W/1yBPepHvqgVre0Rt8=;
        b=OXcHHHvtq56qVQlQWnmbrIkybd3m92ItUTOAxwjunR+YIZ/m/P1zxtu9XUYem7td1W
         7OPY3lLeqQirfYbMjJpdRwSbU7y0qzHXYD9CaR+yQTv089mp7wGE9ipH0zmF9n2TarHH
         q14//B5wXx0vJd0bvi1VZpX/n3us3k5jgqJQClyjUe6wt43S46/0Hq7AMLnMISuZHsVn
         yekcASGcUDbRotG5fU8V0tSfykHoifRqKMypbHxyhR+aWcVDWa3kLzfx7vjMAXGFZ3v9
         dS0A18/ROaJowyJvqRYMgbm6E6nf8VGOSjhmDtlDIHuV4czKLc4dhebZxQfbe5FZTPEM
         K2eQ==
X-Gm-Message-State: AFqh2kr3i9fzKZJT3tTWizGgghMuG1ZDRDHey+9mdiQeivte0ghukIBJ
        AFBZCdP9FBOd0HuH99cDJZ0OSm/D/w==
X-Google-Smtp-Source: AMrXdXsdzsqBqDlx8hokaDRzfDjWN/30A3SmqaMkdXTIv61SlrrT0+t5Vl11hrtfD7yMBBqcparY2w==
X-Received: by 2002:a4a:d198:0:b0:4f2:19c3:c3a8 with SMTP id j24-20020a4ad198000000b004f219c3c3a8mr21656804oor.0.1674511825410;
        Mon, 23 Jan 2023 14:10:25 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e13-20020a4ac3cd000000b004f28d09a880sm110495ooq.13.2023.01.23.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:10:25 -0800 (PST)
Received: (nullmailer pid 2727748 invoked by uid 1000);
        Mon, 23 Jan 2023 22:10:24 -0000
Date:   Mon, 23 Jan 2023 16:10:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: samsung,odroid: correct codec DAI
 phandles
Message-ID: <167451182407.2727709.11885849845114785735.robh@kernel.org>
References: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120153020.320270-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 20 Jan 2023 16:30:19 +0100, Krzysztof Kozlowski wrote:
> The order of codec DAI phandles is reversed - first comes HDMI (always
> present) and then codec (physically not present on Odroid XU4).
> 
> Fixes: 97709d365bbd ("ASoC: dt-bindings: Centralize the 'sound-dai' definition")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/samsung,odroid.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
