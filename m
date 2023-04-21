Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68966EB38A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjDUVXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 17:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjDUVXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:23:41 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581F62114;
        Fri, 21 Apr 2023 14:23:35 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6a5f03551fdso2030469a34.0;
        Fri, 21 Apr 2023 14:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682112214; x=1684704214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiZAysz4ov1Zo3w4aiIbPH6bfC3DcMrmLLdA2KmkpxU=;
        b=P4L4vGsNZqsVL1qjg08y4CYETWXBQhAzRCxaJauadEYxqBCbZ+/zVBTMbuD+U7tQNB
         T9BRlBgzr2UgxNvdlRJt1110hzLdTJI84WKTGFMzWWDFZqzV2DFk4xBD5i9wUFgExZ7b
         +rGf0810TttFgygeBy1MYdh+ZPiSfOJdnNuMPQGSnoFuQN4c1eKN1uMiwJeSby372USC
         jhbw9w07WnwQTIOgE/Qx9d9/Wn7ZgNt9SHnQWbvDFAbzrKFH5cUVinxLT9yMpNDI5htW
         Wtblmixiyxoqs4iHCO+GKv/udyDmrw4Ic5hyzp/+a4uX5ZBe49+p51ehSPem3VQxIb7N
         mRKw==
X-Gm-Message-State: AAQBX9d3EFvnL5ykhG9L588augda0Ls5YrYEqQGGb0OI7poPMsZjrAl6
        EWhlQTbzbX6OWpzLk5p4Uw==
X-Google-Smtp-Source: AKy350b48ps3zAKjSmhTL/aO5JoB/ohjntfoX2X2sgxbq50ruT4HmBtX84TtuCMjpYZVvHALoQq4yg==
X-Received: by 2002:a05:6870:3383:b0:184:3081:66e6 with SMTP id w3-20020a056870338300b00184308166e6mr4226118oae.47.1682112214517;
        Fri, 21 Apr 2023 14:23:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u7-20020a056870440700b0017fea9c156esm2109418oah.18.2023.04.21.14.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 14:23:34 -0700 (PDT)
Received: (nullmailer pid 1784804 invoked by uid 1000);
        Fri, 21 Apr 2023 21:23:33 -0000
Date:   Fri, 21 Apr 2023 16:23:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Minda Chen <minda.chen@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Pawel Laszczak <pawell@cadence.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Roger Quadros <rogerq@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, Peter Chen <peter.chen@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Vinod Koul <vkoul@kernel.org>, Conor Dooley <conor@kernel.org>,
        linux-usb@vger.kernel.org, Mason Huo <mason.huo@starfivetech.com>
Subject: Re: [PATCH v5 1/7] dt-bindings: phy: Add StarFive JH7110 USB PHY
Message-ID: <168211221244.1784749.2647041758726658187.robh@kernel.org>
References: <20230420110052.3182-1-minda.chen@starfivetech.com>
 <20230420110052.3182-2-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420110052.3182-2-minda.chen@starfivetech.com>
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


On Thu, 20 Apr 2023 19:00:46 +0800, Minda Chen wrote:
> Add StarFive JH7110 SoC USB 2.0 PHY dt-binding.
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-usb-phy.yaml | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-usb-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

