Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C965F0006
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiI2WWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiI2WWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:22:03 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265E012BD90;
        Thu, 29 Sep 2022 15:22:02 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id g130so2994086oia.13;
        Thu, 29 Sep 2022 15:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=nwi21MnQaHdJlPOmY1nF+KNwtNvxXho+DAnFATZDOD4=;
        b=Xehx9YGEDTMH4HrSnMXMf4xRTjKBl5qqraHg+dXQ5+oU9ZKlkob4B44hgZajOaE13+
         FgDBTeOS4+QxpXcwLz1Wx+ksv8KdXCaycysgG5G1pTL3dvyRgM5x3soCJqihQ3nUd5k4
         spnBO/USUHGEbpxhHkZEr9SNPvgw+ciW8d1BG/S/I8HNdWUVJI/zlOu7E5ZAQ/F+4uZx
         Qz7O798wETbnDcph23j55Iv3P9x3B6DoCM6zXcFyxBJ592rYuUjonag48PmiRhuLVzcA
         N9v4HN0xAqpuuoCHDo4+htuU/YLXmXE9sXq0KR9nfkAPO3Giible1IVXPt6YQWhcMHNj
         xXAw==
X-Gm-Message-State: ACrzQf28Z0amfJUR9MKOVKPSr/x5ZszEb5DZzQBMo1prhTKqXnRF342d
        K19RId3zCpIOeD1xcLBhxw==
X-Google-Smtp-Source: AMsMyM6ttsnbqtjCf/yyPwWQ3A2P5X4CWOUFq8T28o5HSGv5OQpUDuRKiY8sdc69vpKUuop47sDOlA==
X-Received: by 2002:a05:6808:1b2a:b0:34f:f989:99c1 with SMTP id bx42-20020a0568081b2a00b0034ff98999c1mr7786648oib.173.1664490121352;
        Thu, 29 Sep 2022 15:22:01 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m5-20020a9d7ac5000000b00655c6b2655esm203513otn.68.2022.09.29.15.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Sep 2022 15:22:00 -0700 (PDT)
Received: (nullmailer pid 2870767 invoked by uid 1000);
        Thu, 29 Sep 2022 22:21:59 -0000
Date:   Thu, 29 Sep 2022 17:21:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bert Vermeulen <bert@biot.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Crispin <john@phrozen.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benjamin Larsson <benjamin.larsson@iopsys.eu>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: airoha: Add documentation for
 Airoha SPI controller
Message-ID: <166449011940.2870705.14660966610426590404.robh@kernel.org>
References: <20220927113229.1214224-1-bert@biot.com>
 <20220927113229.1214224-2-bert@biot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927113229.1214224-2-bert@biot.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 13:32:27 +0200, Bert Vermeulen wrote:
> Create documentation for accessing the Airoha EN7523 SPI controller.
> 
> Signed-off-by: Bert Vermeulen <bert@biot.com>
> ---
>  .../bindings/spi/airoha,en7523-spi.yaml       | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/airoha,en7523-spi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
