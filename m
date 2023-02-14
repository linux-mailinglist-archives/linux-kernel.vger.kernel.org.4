Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82973696353
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBNMS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjBNMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:18:56 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2CE25E2C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:18:55 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id u75so10096816pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mJF25grJEGbcmrR3blVtuGbf0zHzSa1eHqZOGdnJEao=;
        b=RvLdMEI0M9Y/FEc1QfjNc3t2QPnlRQp4LhYoK6aCFKM27Pgab6Wxr0vnSagxdIgnrx
         /8uFtlua7yNH+Juz/Ws8B61SAjU88QMZdyixJOFwkDf79eI8dbiQdiPmlu5G086QdqiK
         JKrpUHaFPxklQzGoOcswbTAF4kk7OjRXuXVV/cvp75gvzS+YnSibBAYYI1AEpyw4yxCZ
         v8eDSBhPnt89EHS2R57f2hQAG9hY34J8mjQsyjfmuIDrWGdFybV6gcwdtdGPD4dFGxMB
         H2RU3AdR28cmCqIj13B/7e7jwtrUdaA2eiPquNnGONYaEujF+/R+FLFAOwg3FPFIjvAk
         HaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mJF25grJEGbcmrR3blVtuGbf0zHzSa1eHqZOGdnJEao=;
        b=Uoa18N6W05AbMlPNm1Tn3K1cBioV0GiFq4mTLeLRt9U2IIiqg2ZjA1c9TEmjiLLJxz
         LHGJYe5d/cfdAb5csf8irYRcddIensc0GLI9kVqmw384YQ5VgToYcYdbhLqmuty/fU2D
         IiTrwFfa7jTyjIyzFzuRiW1aWH3BKPCYlsmvGlwHwrsmFVnKGTukBTFjvT+dhS4kG9tX
         oFv0hmPflnhlJV6PuyTw0MHD4wMtHjdx3THzyKZwLBXG9waTNKt/IYoSUWLSlwhOTYn5
         bPSxIOP4pJmH6M6brRyXlFO6IGd6O/OtD8n02J/SAaOOdpIF/wNPC6MHwjSXkkFQjSnp
         M8PQ==
X-Gm-Message-State: AO0yUKVo7EXi6VFPkQF0ekR4Lme5gX1Hki40H+j8OsgDulurPcouWMCm
        2x5DaNpvq5h4PVhiGwgUr38+0Pq2gcKu6YlJOCkTSw==
X-Google-Smtp-Source: AK7set9r6FA2oxfaL/Gdvw6T8lOPC0lfz9vEUH09Doy2PfK7K4PKN/y5UpizMnUOEyCW+zd+Iarf90OGN7ZCkpc06+s=
X-Received: by 2002:aa7:9e84:0:b0:5a8:925b:f68e with SMTP id
 p4-20020aa79e84000000b005a8925bf68emr369542pfq.28.1676377134742; Tue, 14 Feb
 2023 04:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20230203081913.81968-1-william.qiu@starfivetech.com>
In-Reply-To: <20230203081913.81968-1-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 14 Feb 2023 13:18:17 +0100
Message-ID: <CAPDyKFqei-GjKpBUQnDZUbYnSyn-JS5f_EnTLOuA1U4PdYTyVA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] StarFive's SDIO/eMMC driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 at 09:19, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Hi,
>
> This patchset adds initial rudimentary support for the StarFive
> designware mobile storage host controller driver. And this driver will
> be used in StarFive's VisionFive 2 board. The main purpose of adding
> this driver is to accommodate the ultra-high speed mode of eMMC.
>
> The last patch should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
>
> Changes since v2:
> - Wraped commit message according to Linux coding style.
> - Rephrased the description of the patches.
> - Changed the description of syscon regsiter.
> - Dropped redundant properties.
>
> The patch series is based on v6.1.
>
> William Qiu (3):
>   dt-bindings: mmc: Add StarFive MMC module
>   mmc: starfive: Add sdio/emmc driver support
>   riscv: dts: starfive: Add mmc node
>
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
>  MAINTAINERS                                   |   6 +
>  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  37 ++++
>  drivers/mmc/host/Kconfig                      |  10 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/dw_mmc-starfive.c            | 185 ++++++++++++++++++
>  7 files changed, 339 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>

Patch 1 and patch 2 applied for next, thanks!

Note that I fixed some checkpatch errors/warnings. Next time, please
run ./scripts/checkpatch.pl before you submit your patches.

Kind regards
Uffe
