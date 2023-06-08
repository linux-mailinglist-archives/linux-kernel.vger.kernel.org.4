Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861C97286F4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234624AbjFHSOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 14:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236358AbjFHSON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 14:14:13 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C5C1FE6;
        Thu,  8 Jun 2023 11:14:10 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33c1fb9f2ecso4332285ab.1;
        Thu, 08 Jun 2023 11:14:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248050; x=1688840050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ROm6Kfds9HJuliBxMVdmme+cQrchDPlJ9Aoxigq5c/8=;
        b=NZXWq2vpU/ElGvtaPKFM6ueNrYEAWII4PX5g7fWIK0aFiTia6kgbc86wkVDa8b7m83
         NILgku/v88+/af4PA9oFhY7aFs+v77ZmtERtxWjYv8v7OGAlclK/S0esPyGl64zh7GLu
         CNGIZF3l2yH2jvpEMN5ugBUtXmlU9ksq1p6o5HyiKKEsWibJRMLUSjB+1+QIHHJjlm/K
         J4UjwmlrmuXiuFeiQT3KBUrXIn6DcqQwYtJDwsyYeTSTIvVuoTFUp7kyOA1/Q5VAws76
         Ix6b4ApaqPEIQQkWJrylfZOTWoAlwtusZK5TnmG1Tr79cpJC7mRk4KHbMSbzCvO5BV8x
         mYNg==
X-Gm-Message-State: AC+VfDyEmz+8vYuszs5esj0ek5xjdy9eN0Xi4wQv5nPF1taJKn5gPumH
        dQe7QibMV2+1+6oLcOMQTw==
X-Google-Smtp-Source: ACHHUZ5Sh+0yG66TXI/UgP0NwHcRdSm2JkH2UgFVBAX51trKJGxPtKghatvIoV6X9YZoZx1Do573kQ==
X-Received: by 2002:a92:c087:0:b0:33e:6ab5:2f6b with SMTP id h7-20020a92c087000000b0033e6ab52f6bmr2881046ile.3.1686248049838;
        Thu, 08 Jun 2023 11:14:09 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id c5-20020a02c9c5000000b00418ba399842sm436340jap.13.2023.06.08.11.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 11:14:09 -0700 (PDT)
Received: (nullmailer pid 3182986 invoked by uid 1000);
        Thu, 08 Jun 2023 18:14:07 -0000
Date:   Thu, 8 Jun 2023 12:14:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: semtech,sx9310: reference common
 schema for label
Message-ID: <168624804666.3182913.5314319673282867266.robh@kernel.org>
References: <20230507173923.263741-1-krzysztof.kozlowski@linaro.org>
 <20230507173923.263741-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230507173923.263741-2-krzysztof.kozlowski@linaro.org>
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


On Sun, 07 May 2023 19:39:22 +0200, Krzysztof Kozlowski wrote:
> Reference iio.yaml schema from dtschema to allow already used
> label property:
> 
>   sc7180-trogdor-homestar-r4.dtb: proximity@28: 'label' does not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Patch for dtschema:
> https://lore.kernel.org/linux-devicetree/20230507171219.232216-1-krzk@kernel.org/T/#u
> ---
>  .../devicetree/bindings/iio/proximity/semtech,sx9310.yaml    | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

