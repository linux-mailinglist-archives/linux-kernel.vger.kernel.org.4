Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536D17394E7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 03:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjFVBvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 21:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjFVBvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 21:51:40 -0400
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45E135;
        Wed, 21 Jun 2023 18:51:39 -0700 (PDT)
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3421aca52d7so22769875ab.0;
        Wed, 21 Jun 2023 18:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687398699; x=1689990699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqNAIzv/uNtsV9O6jc6Oz8TD3XgRRw0C3IYBOxeNxyo=;
        b=CuHZhhaDp7my17qI9mmKiMJO8RnL7WTmy6U9Kn/eQryDJIydo0YJZ3JeaLO7iMAV9S
         jeeoKijPe5ZWRZkEUDVtxDJzZoXzqCvbRJeYOF1Y6+0fZVfBYYjEW1a/+RwZG4Ae4PHy
         LRszepRtzL8Pxpp9E/978DUbwwBwApZlAh2bMpbyswmwsp6XWt2bveueLa6zdT1fX4Nc
         IVGqcGCHUUBItMeg3yymVvb8jTIomLI/ygQuyv3mHqzwvt6G7ZpC6k/Q4eJY3g32huA3
         s1PS4Mj7moVmiSLaTBs1Ra+NDS+/+cm82/9gRZUzv6ojiMbwE/+pcrifa8LV+/IaRW01
         DVhQ==
X-Gm-Message-State: AC+VfDxbKlpesO3dBiQMQ41wi2RfNX/eeMXPlzKtHqemCBnsXIQsgM0c
        xWWeiTjr5p3FOn2ffNAZtQ==
X-Google-Smtp-Source: ACHHUZ6ippvvmRX5lvNCZgnYpaMsLBRgyjicaYTC2g7GnCnVtty+Y+Qoll9Z1WNRrITfnOopVKrSPw==
X-Received: by 2002:a92:d6d2:0:b0:341:c8db:c8d6 with SMTP id z18-20020a92d6d2000000b00341c8dbc8d6mr7017214ilp.22.1687398698767;
        Wed, 21 Jun 2023 18:51:38 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z25-20020a02ceb9000000b00418af04e405sm1617696jaq.116.2023.06.21.18.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 18:51:38 -0700 (PDT)
Received: (nullmailer pid 42103 invoked by uid 1000);
        Thu, 22 Jun 2023 01:51:36 -0000
Date:   Wed, 21 Jun 2023 19:51:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tglx@linutronix.de, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: timer: add Ralink SoCs timer
Message-ID: <168739869603.42044.12383139966264039986.robh@kernel.org>
References: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620100231.1412582-1-sergio.paracuellos@gmail.com>
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


On Tue, 20 Jun 2023 12:02:31 +0200, Sergio Paracuellos wrote:
> Add YAML documentation for the timer which is present on Ralink SoCs.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
> Changes in v2:
> - Remove redundant 'documentation' word from subject.
> - Drop clock-names property.
> 
>  .../bindings/timer/ralink,rt2880-timer.yaml   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/timer/ralink,rt2880-timer.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

