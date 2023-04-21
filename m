Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B856EB393
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjDUVYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbjDUVX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:23:57 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E6E26AF;
        Fri, 21 Apr 2023 14:23:55 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5424b046c6bso764691eaf.1;
        Fri, 21 Apr 2023 14:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112235; x=1684704235;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbaXCpUXe4iUKhx65n7G15ksj7GhXIVMeVUGx6UoeCY=;
        b=In6hZNOab0GghfXCBOxQF56pTX2Jmm5XdpCn8LYHDbhjeBoSP9PQvqQvip9cG9wfHQ
         yeU1g2oc+C92Uwq3Qw7VTKcsgE8MuwH2avldG4NZ/3HvA2v2p+AiplGPvSVqGDq7RfKR
         sJfwmuF3o7qkO8OV+3waHgAXlRgEIfpsFKyi6lhwo4irZ4Kqx3v1A/Pl0JH4BPqI8r6L
         PxgcajL66m2L7DG7yNy1u9Bsk4F60hpJmglSbSdsx4Jy0Fcw8wFkx32keSrZBnpZXVhh
         jnwqY2qsx0P9bQABbe5PN399/k0ONk3buHFV6bIfy8D3CRoFhno3bhXElGGeKCyUpgbZ
         1hAw==
X-Gm-Message-State: AAQBX9f4uAl0FHckPRXNs0PwhjKt03FDQOqaYy8u1uzw8ibk4t30DsIs
        bihuLpFUUIshvzoGBpih1A==
X-Google-Smtp-Source: AKy350bHXXS6OurY5nmMtPS/MaZh5XGH97e5KRD0bzQucEfG8t+AZTkCzTlqn5WIELiRv7gofzvDNA==
X-Received: by 2002:a4a:cb1a:0:b0:547:6879:e9aa with SMTP id r26-20020a4acb1a000000b005476879e9aamr549944ooq.5.1682112234455;
        Fri, 21 Apr 2023 14:23:54 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q123-20020a4a4b81000000b00546daaf33cfsm2156853ooa.14.2023.04.21.14.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:23:54 -0700 (PDT)
Received: (nullmailer pid 1785271 invoked by uid 1000);
        Fri, 21 Apr 2023 21:23:53 -0000
Date:   Fri, 21 Apr 2023 16:23:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mason Huo <mason.huo@starfivetech.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Roger Quadros <rogerq@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Peter Chen <peter.chen@kernel.org>, linux-usb@vger.kernel.org,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        devicetree@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] dt-bindings: phy: Add StarFive JH7110 PCIe PHY
Message-ID: <168211223285.1785232.7377797349982243568.robh@kernel.org>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-3-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420110052.3182-3-minda.chen@starfivetech.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 20 Apr 2023 19:00:47 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC PCIe 2.0 PHY dt-binding.
> PCIe PHY0 (phy@10210000) can be used as USB 3.0 PHY.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../phy/starfive,jh7110-pcie-phy.yaml         | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-pcie-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

