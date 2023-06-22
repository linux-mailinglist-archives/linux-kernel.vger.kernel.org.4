Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9700873A346
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjFVOlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbjFVOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:41:16 -0400
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659DD1BD5;
        Thu, 22 Jun 2023 07:41:13 -0700 (PDT)
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3427426f2ddso18904815ab.3;
        Thu, 22 Jun 2023 07:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687444872; x=1690036872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I0Dm+JFVARmVhZwudnoBM+gg0gtAk6DC5x886FY400M=;
        b=mF+XuIy6QZ4IhyP/58QG9PIVS0nANhZGAUodJ4cxakHf1hyddrmL/RUwNmPif0/B3u
         kLeyvW+AAGidRPayHG6/K5dV3KlltAg7t5a4hfreNXoDaHMVzKrme55EkIDWfx7eZk/M
         qSPpSxACxwrD0j21gHNAAKO5vmGuU4DZHByWjhgmdnVmZqDNsdQv5p0BLGolo2J8MBbY
         Elb4qtlI6CqN6/cAQTS5s8JR8uUbO+Hg3/DPmX94Ae6q+b1HK8o6Mz5b2e3QUr/iG8Yx
         IvHTvIDFlVDHCK/IJitzjD67yVsui1H23wMEVCfx9DFydQ7vg6zfPKRpqHf+sAuLfpbO
         C/zw==
X-Gm-Message-State: AC+VfDzxPbGU/7x93iB7JrJ/DvJPdxYQc3Kcb12qoKeoPXu1aMWeiG20
        rm9levPzbH03s7EltH9+Xw==
X-Google-Smtp-Source: ACHHUZ6dNoSOSgXACTvvo6YR8pCRo8iGN1NftBdmef+PZCJTdIlIaXgwj7E8HdIKz7A/lZTiAq5iLw==
X-Received: by 2002:a92:c989:0:b0:341:d9e7:9d94 with SMTP id y9-20020a92c989000000b00341d9e79d94mr13554737iln.25.1687444872430;
        Thu, 22 Jun 2023 07:41:12 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id l14-20020a92290e000000b003427601b77esm2035239ilg.21.2023.06.22.07.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 07:41:11 -0700 (PDT)
Received: (nullmailer pid 1671196 invoked by uid 1000);
        Thu, 22 Jun 2023 14:41:10 -0000
Date:   Thu, 22 Jun 2023 08:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/8] dt-bindings: qcom: Document msm8939,a7
Message-ID: <168744486970.1671157.15368487194326757412.robh@kernel.org>
References: <20230622020344.65745-1-linmengbo0689@protonmail.com>
 <20230622020419.65760-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622020419.65760-1-linmengbo0689@protonmail.com>
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


On Thu, 22 Jun 2023 02:04:30 +0000, Lin, Meng-Bo wrote:
> Document samsung,a7 bindings used in its device tree.
> 
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

