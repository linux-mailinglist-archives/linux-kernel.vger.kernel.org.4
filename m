Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6877289A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbjFHUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjFHUth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:49:37 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FE2D7C;
        Thu,  8 Jun 2023 13:49:35 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-77acb04309dso56265039f.2;
        Thu, 08 Jun 2023 13:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686257375; x=1688849375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oEVvsEJofbyF89JSmEJIs782G632G9KkRpVUkYg+xo=;
        b=NHoZt9tK62gRfRGCE1IRPoGhpMQkPzYRuL1IVNHgiBmHDtrFUDySiyCcZocm9KLA12
         fzTToBHSs4vzpRkfW0Mpud84KWU/w4Kzkcfi1pcSC6SpDRCYh3KnuD/f+NSTjmSX3x5t
         Cuv/eq3Z5CF1EVe+X8mNKhFhwW2yWZCOodUHKDaMqAg4wP1x3BL0CcZKx98de8QfvKXG
         KVJnBJjjPWx3jR3MosLUj5xT2Q71fpNT3fbfHyxKjdjgMX/0wI3kvALLQYZSdkyVnOV2
         2xq1YQdUQtLl3p2zTeYRNdl41JcQpRYm0hNOws1JUfyEvrUUjOECtbGCIY+yA7bI3zDq
         Rd2g==
X-Gm-Message-State: AC+VfDz59B+TEFQCg3Z3QwZ1Od1GCV63M/Lk8bUDqL/IjQfm+NiKnfqZ
        MoWoYx3eWsKuTrBBkRUFQw==
X-Google-Smtp-Source: ACHHUZ5qTQOnKA3U/k3iLhcQxsZOmMmBOzJY8yW4hZRaO8L1cjJlpPQFQrNM+JE4gDg96ik61eT3Rg==
X-Received: by 2002:a6b:d818:0:b0:777:b175:d11e with SMTP id y24-20020a6bd818000000b00777b175d11emr13776691iob.2.1686257375091;
        Thu, 08 Jun 2023 13:49:35 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm590724iol.38.2023.06.08.13.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:49:34 -0700 (PDT)
Received: (nullmailer pid 3424755 invoked by uid 1000);
        Thu, 08 Jun 2023 20:49:31 -0000
Date:   Thu, 8 Jun 2023 14:49:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-riscv@lists.infradead.org, linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Jack Zhu <jack.zhu@starfivetech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: phy: Add starfive,jh7110-dphy-rx
Message-ID: <168625737130.3424689.15583912932705671257.robh@kernel.org>
References: <20230529121503.3544-1-changhuang.liang@starfivetech.com>
 <20230529121503.3544-2-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529121503.3544-2-changhuang.liang@starfivetech.com>
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


On Mon, 29 May 2023 05:15:01 -0700, Changhuang Liang wrote:
> StarFive SoCs like the jh7110 use a MIPI D-PHY RX controller based on
> a M31 IP. Add a binding for it.
> 
> Signed-off-by: Changhuang Liang <changhuang.liang@starfivetech.com>
> ---
>  .../bindings/phy/starfive,jh7110-dphy-rx.yaml | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/starfive,jh7110-dphy-rx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

