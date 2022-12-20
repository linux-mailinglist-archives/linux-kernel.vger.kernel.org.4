Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54A36527D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiLTUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbiLTUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:20:45 -0500
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DFE1EECA;
        Tue, 20 Dec 2022 12:20:06 -0800 (PST)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-1442977d77dso16790369fac.6;
        Tue, 20 Dec 2022 12:20:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JPeYdzc9FvSjQnwQpKOSlb+cwbou8KwWYdDez3Iw/jk=;
        b=ac16FejRi5ezIwBXIytL2pgdiFoPu06dHYcqG+asz2WeXRmORkIbp6Wzbwdz0wrLda
         kBJOnvWaJP/UOt8OIg+mPZ23OHWsmHSoAO3HPaMfejTLAgO+x/eA/G0yqLfxkDGqk/NW
         Ndg90FYh9tpJOK64iGK7SYJnzbc1q74JTWk76Bf8x2pBw66/pEYKWDY3njSmEoIZeIg2
         PNNtqlJH0Bde1plkg4jOwzwKJJaAAOf/e5L3AKTIvLJeNgg6vwH0/YYuR2ogGV9w1YG1
         YqhamHoBtoqAxpcLRYfg2jJNckQ5C/9fb36YQ5cGZS03p+R1rDN4QGTLdkLw5DuxdkkD
         uNmw==
X-Gm-Message-State: ANoB5pkQ3FGIpbNqt0u01vjGptZi+NbR8/5A+FauWzj+lT7gESBKPdI+
        Agkyu5djImGh//fZ037Cg/uNZNE4Zg==
X-Google-Smtp-Source: AA0mqf70kKieJ1VKljXtxAEVcFW7fnn2oFjoL/Mkx7cKi1a3tjrtimxtAdfm1Np75u++KaA0pF37FA==
X-Received: by 2002:a05:6870:9a16:b0:13b:a4fc:cd0 with SMTP id fo22-20020a0568709a1600b0013ba4fc0cd0mr23505636oab.19.1671567605661;
        Tue, 20 Dec 2022 12:20:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id kw8-20020a056870ac0800b001431bf4e5a0sm6442102oab.38.2022.12.20.12.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:20:05 -0800 (PST)
Received: (nullmailer pid 1019613 invoked by uid 1000);
        Tue, 20 Dec 2022 20:20:03 -0000
Date:   Tue, 20 Dec 2022 14:20:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: pinctrl: Add StarFive JH7110 aon
 pinctrl
Message-ID: <20221220202003.GA1018798-robh@kernel.org>
References: <20221220005529.34744-1-hal.feng@starfivetech.com>
 <20221220005529.34744-4-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220005529.34744-4-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 08:55:27AM +0800, Hal Feng wrote:
> From: Jianlong Huang <jianlong.huang@starfivetech.com>
> 
> Add pinctrl bindings for StarFive JH7110 SoC aon pinctrl controller.
> 
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../pinctrl/starfive,jh7110-aon-pinctrl.yaml  | 126 ++++++++++++++++++
>  .../pinctrl/starfive,jh7110-pinctrl.h         |  22 +++
>  2 files changed, 148 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/starfive,jh7110-aon-pinctrl.yaml

Same comments in this one.
