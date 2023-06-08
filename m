Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7017286EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236354AbjFHSOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232256AbjFHSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:13:59 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D631FDC;
        Thu,  8 Jun 2023 11:13:58 -0700 (PDT)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-33dae9244a1so9686755ab.0;
        Thu, 08 Jun 2023 11:13:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248037; x=1688840037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIoynuv6udOW5LekCqRmnqhuS9COOvOVP6mK1YqrbbY=;
        b=VYV6QBCjhAtjuwJW4rlVIab6s1g7BWTZkqVRHzF9tz8uYryliiX8o6A3/6iszkB3O3
         +CuIbTsjBi+wv0NuQc9GesCowcecfd9ahy0nQhvSvKuNl8N1DvN3jqfJ5OQdfCjXLS4P
         OFMI378FUP5blUc8SA1YTsZ7R3OS+7tA3qGfKYhccNemUDi6EVAZ1BDtpUMda29VQKZh
         ICAzpqqwzzfIkTsukHLQywrUCuHP8y2jhXiPs4JAxbK+Pmgn2liuObJz+W+G2ejp5dYn
         l2FwEaGSdQE/CmbViuvzmpuKRd6ZAEYSQeBAiCZd3iwMqnvUowSbsqlgSVouYM9jFdCO
         uqww==
X-Gm-Message-State: AC+VfDy2eCst5sk3V8OKLHP65OvXxphAIQiR9gDt6jwesnGYZ9m5L66F
        j5o66swfeLRh/aQdIldSMw==
X-Google-Smtp-Source: ACHHUZ4iP6csJ/GF+iB3FVST/z6ROywVESM1Yurn9hyif1K/ae0O1HCJlEceK2ccWaCvdUqsREVDDw==
X-Received: by 2002:a92:c008:0:b0:33e:c0b:9ff2 with SMTP id q8-20020a92c008000000b0033e0c0b9ff2mr1730555ild.1.1686248037353;
        Thu, 08 Jun 2023 11:13:57 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a056638000300b004163438fd4esm413711jao.92.2023.06.08.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:13:56 -0700 (PDT)
Received: (nullmailer pid 3182680 invoked by uid 1000);
        Thu, 08 Jun 2023 18:13:55 -0000
Date:   Thu, 8 Jun 2023 12:13:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [dt-schema PATCH] schemas: iio: add label
Message-ID: <168624795645.3178290.5235314768802159315.robh@kernel.org>
References: <20230507171219.232216-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507171219.232216-1-krzk@kernel.org>
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

On Sun, 07 May 2023 19:12:19 +0200, Krzysztof Kozlowski wrote:
> Linux IIO core code parses label property which is already used in
> several IIO devices.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  dtschema/schemas/iio/iio.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks!

