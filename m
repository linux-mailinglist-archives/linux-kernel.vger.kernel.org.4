Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7C756E51F0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 22:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDQUhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 16:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjDQUhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 16:37:19 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7DD49EE;
        Mon, 17 Apr 2023 13:37:18 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id q33-20020a056830442100b006a419d3fd20so8420241otv.7;
        Mon, 17 Apr 2023 13:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681763838; x=1684355838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7K6w8N+4yFsxz5r0OgTNWCI92V9EYta831Qdn5G1Wk=;
        b=Wtr/YitaibMVMpY1XJaeCQj0P71G9Yi7Q0XZUJXE/OVAkZuHH6lBErDQ+OWbZSrrz6
         4KMSC30eIwP9RDREJUZ+LH4DsByCUvqYOldgvoCwe0HY7lSYb60cFzSOc2Av8q73ovTn
         8l5y1STm4or9K4nUz1d/oGQ4KXwZZWjarLzZyFl/ronMNFIGFTrbRqj7cPASpAeZ+wSi
         Lt+obEgMpOkVCuFkG4327r/zhwok/JDS/6sX15xZCRT2qLrrdAKmKRg6jDN0LOVosxa6
         F8ByhxkLeW+o/DfSgNe7BfjPfXFSEPUctU9O9+YX0l+2G7cmTFhx/fSJOQjTn01VAYlY
         7zVA==
X-Gm-Message-State: AAQBX9cDAU+Mp5dmcWOvzH45v9K3Ogbl2iFWAx92rqyLzcyHPW/vsmcp
        wIXA/a0+jftstxU2ixE4zw==
X-Google-Smtp-Source: AKy350ZSHvCTM5I55QfWpHLncSSzBNmF/jwP8c/i+62gJguXKk4sRPO02ecUbtNpycoowLqEuS/oiw==
X-Received: by 2002:a9d:5614:0:b0:6a5:ee4e:e3fa with SMTP id e20-20020a9d5614000000b006a5ee4ee3famr1619791oti.15.1681763837629;
        Mon, 17 Apr 2023 13:37:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h24-20020a9d6418000000b006a44338c8efsm1985727otl.44.2023.04.17.13.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:37:17 -0700 (PDT)
Received: (nullmailer pid 3328454 invoked by uid 1000);
        Mon, 17 Apr 2023 20:37:16 -0000
Date:   Mon, 17 Apr 2023 15:37:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        William Qiu <william.qiu@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>
Subject: Re: [PATCH v3 5/7] dt-bindings: soc: starfive: Add StarFive syscon
 module
Message-ID: <168176383573.3328400.3537476032397551479.robh@kernel.org>
References: <20230414024157.53203-1-xingyu.wu@starfivetech.com>
 <20230414024157.53203-6-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414024157.53203-6-xingyu.wu@starfivetech.com>
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


On Fri, 14 Apr 2023 10:41:55 +0800, Xingyu Wu wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add documentation to describe StarFive System Controller Registers.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  .../soc/starfive/starfive,jh7110-syscon.yaml  | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/starfive,jh7110-syscon.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

