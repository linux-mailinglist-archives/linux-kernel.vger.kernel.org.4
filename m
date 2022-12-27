Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B79656842
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 09:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiL0IMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 03:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiL0IL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 03:11:58 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1BC659E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:11:26 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id j17so9154789lfr.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 00:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qkj8aEFFkBpChmdXKzDue2jjy9ZSevBCVHtk7F88fu0=;
        b=ZM6IDROX5udF97r+v+aEvdvURp7F1NB+l9EjwmPFs+YHEyz4ENb7dj/0kriZ4evhm9
         umgOOYTmNwFD9EaFmLWzuKCiIh2bdRlG3deAsbp4mqP7cnq0Pu4uHPpq3b752pgJnwZS
         BPeImarKcSMAAloBGbze1yOQtZuH2yQZHpJ8q+sxiprEJkHpNiNNos7bj1PUzzULfK9U
         5+64HUetbcT0JygJ6jqzJ/aCHPaxQFkH+8eW3KosC2HZo0bxM2DayWengbY3NPkMk/y3
         vxNCADGR76wellcV4uFdFGvueSxgdbS3GWpe035UhSeOc78zPP8lNtitaX5j2BQw3z7f
         3c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qkj8aEFFkBpChmdXKzDue2jjy9ZSevBCVHtk7F88fu0=;
        b=J975fgVjoFEXHRt0d4ydWFnwknuABSdpWeK0z4cHAdZpQMkNckVUrDz6zBkmMloqiI
         2mcdJFLBu2PKTvyZpU8Epft3/ZZOUUAScrEhKX8hY9yofthIbPgVGQIGg0fkuewO1YrI
         NHfs8mrIJUak9qyqck4E+aGF7O4X8Pq5MH2mrthRPA4S33ek+GBh1b2d4UTjcTih214B
         2ydYy5RY4czNrAoJQWd/i4tCuK+iJUgQSxcfv5NSD83b6iuHHsFgrybvKCy4sdj/h4IG
         DgPdBTKKkR7HGQ8IMr8I3TAnkO4xfIgmm1h5st6IUCVH+gba0ME5jBXMGqG940Ntt9b6
         6ctg==
X-Gm-Message-State: AFqh2krVPWqYWiSTFqiUOjsoYoquNoopSbeRP0tyjeZLB/0T4xvwXqHS
        whgei5yXS+2lT1zI4C9cbV5U8A==
X-Google-Smtp-Source: AMrXdXveZP3bad+mvSolMFsc+WANCI9MKWHUqqiValByx1O00Qm/Cj3EpKas3F/jeBVxYdyoL6pRxg==
X-Received: by 2002:ac2:46c7:0:b0:4b5:5384:aa3b with SMTP id p7-20020ac246c7000000b004b55384aa3bmr5051031lfo.50.1672128684444;
        Tue, 27 Dec 2022 00:11:24 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d2-20020ac241c2000000b004a05402c5c3sm2162336lfi.93.2022.12.27.00.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Dec 2022 00:11:24 -0800 (PST)
Message-ID: <ccd9fd29-9de5-aae7-09ff-4eafb42401c0@linaro.org>
Date:   Tue, 27 Dec 2022 09:11:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: pressure: bmp085: Add BMP580
 compatible string
Content-Language: en-US
To:     Angel Iglesias <ang.iglesiasg@gmail.com>, linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1672062380.git.ang.iglesiasg@gmail.com>
 <ec7500c211cd545391c0e55da4f8753e2c38dedc.1672062380.git.ang.iglesiasg@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ec7500c211cd545391c0e55da4f8753e2c38dedc.1672062380.git.ang.iglesiasg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/12/2022 15:29, Angel Iglesias wrote:
> Add bosch,bmp580 to compatible string for the new family of sensors.
> This family includes the BMP580 and BMP581 sensors. The register map
> in this family presents significant departures from previous generations.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof

