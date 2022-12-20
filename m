Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEB9F6527A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 21:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiLTUOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:14:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbiLTUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:14:12 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62961E721;
        Tue, 20 Dec 2022 12:14:11 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id c133so4608740oif.1;
        Tue, 20 Dec 2022 12:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnKxS9++m3VIKn4BrdHqH0OFOMVypdbQeiV0WBt+YU0=;
        b=Wl3u20CAf9TwgGE28lGQgvqCFpvmHSOsqApWXA82dWxzjc+/ek41xKBGSA9f5VxVuL
         5LduUoyf4e7ZZW1tJAxRm58hjbHFLI1SF4kIqgv13nCwMUuvIKPE7ZU6RhOKw/Yj4I68
         bCGgTe+8G7g6J46lccPCF6kHstwFyTwGSwnhv4JBCXPibBfV7pJku4Y/QhAHtZp9vj3j
         EdBs/mlCXDIMkvOYPT/gPGmRJMdh2RYg6K7AjyOqBm46X/Mj/nGKxGeO8AbO2MuAsE0q
         oCLYBTxY1vRhIxHa1vYGvM6OUfVNAft90Lycq+QmJ6dCy4YwQum+N3WeGsVUOReaukjF
         tLuw==
X-Gm-Message-State: AFqh2kp6UbOA7zRCpDpMbKByX4DCMV4CTYShfE8op87DaYpWMkMfwijl
        VLQpCJaYuVT8SdaruSpUHg==
X-Google-Smtp-Source: AMrXdXsMarBdy80fqc/N1EbfSl24Enyv6FsBTMobEKk2odxW9aKQmv48o3LiTIAsZ69hNotOG9ETdw==
X-Received: by 2002:a05:6808:dc5:b0:35f:5651:7850 with SMTP id g5-20020a0568080dc500b0035f56517850mr5247634oic.2.1671567250964;
        Tue, 20 Dec 2022 12:14:10 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id be4-20020a056808218400b0035418324b78sm5954236oib.11.2022.12.20.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 12:14:10 -0800 (PST)
Received: (nullmailer pid 1011832 invoked by uid 1000);
        Tue, 20 Dec 2022 20:14:09 -0000
Date:   Tue, 20 Dec 2022 14:14:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     Conor Dooley <conor@kernel.org>, linux-riscv@lists.infradead.org,
        Stephen Boyd <sboyd@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 08/11] dt-bindings: clock: Add StarFive JH7110
 always-on clock and reset generator
Message-ID: <167156724933.1011771.11780111815689299075.robh@kernel.org>
References: <20221220005054.34518-1-hal.feng@starfivetech.com>
 <20221220005054.34518-9-hal.feng@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221220005054.34518-9-hal.feng@starfivetech.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Dec 2022 08:50:51 +0800, Hal Feng wrote:
> From: Emil Renner Berthing <kernel@esmil.dk>
> 
> Add bindings for the always-on clock and reset generator (AONCRG) on the
> JH7110 RISC-V SoC by StarFive Ltd.
> 
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../clock/starfive,jh7110-aoncrg.yaml         | 76 +++++++++++++++++++
>  .../dt-bindings/clock/starfive,jh7110-crg.h   | 18 +++++
>  .../dt-bindings/reset/starfive,jh7110-crg.h   | 12 +++
>  3 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/starfive,jh7110-aoncrg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
