Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D14E68C27C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjBFQHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjBFQHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:07:18 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759822D146;
        Mon,  6 Feb 2023 08:07:17 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16332831ed0so15605574fac.10;
        Mon, 06 Feb 2023 08:07:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XUYFUHd6K0M2VRLqa+pQ0iy4AsAh6s44qKhPHJX0uIM=;
        b=AFbl5FDQSL4ZxtxDvZOoQLfqhPvSr2nqzTV1MyShV4bOw6pqhND0EHKd8IwrLgeEs6
         5g4E8wTT7C0SI0PyQpL9PJ+1gy6ORUcUrqgKilO0zpkqvTb60XwnkpXlc5CjG2JczhKd
         5/+dMnEFFu+iyf+mgE4cn8ix2akuYejpgrC3aCybfOTueDD2m5HGgL5bjXwqgsUVCNIf
         +7Osm3mfcJY2ndLLER2Cp2//zCgIt9sHxGL5lIAxEY6mWTiRMrJRp4v10ENCxevLnHVj
         0O+PQsuNgmLHPTqMghs2Eysal0oF6NgXPLPSBeOUcc7Kzf3DZzFDJMmvdET8sXcPCCb8
         XVlQ==
X-Gm-Message-State: AO0yUKX97AWCYotqQ2U50OqamMmBaSRlRduYLotDaZpxsh+LEazAMAev
        76WTaCjVkkdBxGmwyo3PcQ==
X-Google-Smtp-Source: AK7set8FTeOCEtJ39OQ7PP71M+KY8FxvIZVQjRY913T0OytVnPbTdf3sQqmUTHhKJlvWoDl2eSck+w==
X-Received: by 2002:a05:6870:9706:b0:163:3283:f366 with SMTP id n6-20020a056870970600b001633283f366mr11056442oaq.24.1675699635269;
        Mon, 06 Feb 2023 08:07:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t22-20020a056871055600b001600797d1b5sm4241889oal.41.2023.02.06.08.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:07:14 -0800 (PST)
Received: (nullmailer pid 156485 invoked by uid 1000);
        Mon, 06 Feb 2023 16:07:13 -0000
Date:   Mon, 6 Feb 2023 10:07:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] dt-bindings: pinctrl: Add StarFive JH7110 sys
 pinctrl
Message-ID: <167569963291.156426.9284511556590253143.robh@kernel.org>
References: <20230203141801.59083-1-hal.feng@starfivetech.com>
 <20230203141801.59083-2-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203141801.59083-2-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 03 Feb 2023 22:17:58 +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC sys pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-sys-pinctrl.yaml  | 141 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +-
>  .../pinctrl/starfive,jh7110-pinctrl.h         | 115 ++++++++++++++
>  3 files changed, 260 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-sys-pinctrl.yaml
>  create mode 100644 include/dt-bindings/pinctrl/starfive,jh7110-pinctrl.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

