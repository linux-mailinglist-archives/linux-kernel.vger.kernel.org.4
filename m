Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104336391A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 23:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYWzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 17:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKYWzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 17:55:17 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D73C6D7;
        Fri, 25 Nov 2022 14:55:16 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id bj12so13059086ejb.13;
        Fri, 25 Nov 2022 14:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r8n7cTPNZg+gBSjW3LwUxqp6QcotcNdrtpswWKit6NQ=;
        b=QsjwIiL2BKGfbrsY6iWFH3OeV9uUQl+VFQ1BL5HfO86NuuAIbUlAbesa/Pt2nw0oKR
         BqowAmt0Nlt0PxhYXl8aLfYr0M0V4owkPDTOQuZ2TVG89WfD9LFfEsAB/p2T9sAycinE
         FsSxJMo8v9MrTnkLZFMoLGEhNCMEXLnhASamLwb4F/tJkKvx0Kmj/8P3bKGjB7R7Ojgu
         NWt0QGr9f2lnvIBOx6T7qmwQEvKjlaiITm1Bnxkzq81YJXv00hpfbnEhyp5+/OFZCB65
         MlkO3VS/WOxz3rELIQksXxtJsTf4AI2qSrmXsey3LQPE19A7qp46SXs6JvTM0kDnrC0I
         XknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r8n7cTPNZg+gBSjW3LwUxqp6QcotcNdrtpswWKit6NQ=;
        b=o/Cu1bSHbK6+NBw7WNVMk+QcaBGJIWK+KxVUjCXJcsdMTS8+lHhpJUuFPMls0ULQ9W
         v7xFzEPuwYW/pMJw3IH8St+AdjuFruWKhfwS/ai6cb26rvJQNaD4iJqTcDLDWPAJnS0n
         5HymTwoG/N1dgVNR31YboSnAZZdIdnBKzmpQJiCokPkgbr1OS9BJFtsqc+5pfLvVvy9E
         qAEGu9sk8ppRQONGn0KlsbZbAhu4i4g34jb+aBHmwkv+nnTHce+OVMkMv47EHqhgf32S
         /8GPAzn9CtbdWS82RF7nV1QThiRmOx3AYSpNAJEMyHCGpqn0g1ePphM4+/ZXPgO7gMj3
         uBGg==
X-Gm-Message-State: ANoB5plOH43tGGjre62jwtVSfBQzKDu5FT7QV3xaDqBAdqEAGE1Fg+KT
        wd2BmJmxIBGp2VvYawy9OG20l0GFj6u6T37YLWE=
X-Google-Smtp-Source: AA0mqf7rDupHIfq5Tr1gc/4+5fP9g3XcKelMvrs7nNr+BWKZQ9m5y1L0sEKlG1FfvRuY97ZSi1hyufQKetoBfSLHjQU=
X-Received: by 2002:a17:906:6bd8:b0:78b:a8d:e76a with SMTP id
 t24-20020a1709066bd800b0078b0a8de76amr35145152ejs.725.1669416915294; Fri, 25
 Nov 2022 14:55:15 -0800 (PST)
MIME-Version: 1.0
References: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221125144120.476933-1-krzysztof.kozlowski@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 25 Nov 2022 23:55:04 +0100
Message-ID: <CAFBinCCD5pTUre_QpMqW0KY8PLLhgBbaRkx9XSZq-8b5etpRHA@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: meson: align LED node names with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 3:41 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The node names should be generic and DT schema expects certain pattern:
>
>   meson8-minix-neo-x8.dtb: gpio-leds: 'blue' does not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Thank you for this patch! It's:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
