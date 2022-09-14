Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694425B8D2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiINQe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiINQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:34:03 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56457625F;
        Wed, 14 Sep 2022 09:33:40 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1279948d93dso42391842fac.10;
        Wed, 14 Sep 2022 09:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=T3drauNo4474IH1JoGI0Vn3Xbi0rGq0VprM15Edh8TM=;
        b=MqWP3B+qzPNUYZdo08uWbtmAYh+z1ysYF+8GDFILqqYaaLLu4XUjvZo/8So3VG1epQ
         k/amT5UdrU2rHfHU9z/8umznWAVkaNGR0mFQIcwHxNpfln47UgvsFtzTWq3D5uaJzusA
         gSbp9bFQ4zQTVKnwmAmystWeWjc7gwpuWP5caJChnPwc2qF/ahRnfw/R1HcjhgcUAaZF
         vZVBgjYrFLw1G50DDdX/IOd9F3npcL5DjEm8pN6R00OVe6bUf55Lq1F667iLwR5//BqD
         BJLgyP1pr76P+PBgU+KovE8w1osWYl4cN8OZ29zZ2R6PD2X/cggYoK66RbU8ilM/PFLE
         C1tQ==
X-Gm-Message-State: ACgBeo0ta2rw2EudvY15UMjAb/aNGlKW55lOprW/NU+QfeOvGnLfVk08
        Qf3jDqyMLTEoXwu0coh9jg==
X-Google-Smtp-Source: AA6agR4eVxZknyBEVeZga8UrMOTrl7yQYSfSQLeC6YZzw2Wb9Qoc1A2M/mTT+P26xb9XO234lk0UIg==
X-Received: by 2002:a05:6808:2129:b0:34f:d098:d5bd with SMTP id r41-20020a056808212900b0034fd098d5bdmr2327082oiw.136.1663173219480;
        Wed, 14 Sep 2022 09:33:39 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x14-20020a056830114e00b0063a82e6f3f9sm7390367otq.14.2022.09.14.09.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:33:39 -0700 (PDT)
Received: (nullmailer pid 2540774 invoked by uid 1000);
        Wed, 14 Sep 2022 16:33:38 -0000
Date:   Wed, 14 Sep 2022 11:33:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, zhangqing@rock-chips.com,
        finley.xiao@rock-chips.com, shawn.lin@rock-chips.com,
        zhengxing@rock-chips.com, jeffy.chen@rock-chips.com,
        jay.xu@rock-chips.com, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: clock: rockchip: change
 SPDX-License-Identifier
Message-ID: <20220914163338.GA2503697-robh@kernel.org>
References: <d70fa056-608d-0c19-7948-c67b15a4246e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d70fa056-608d-0c19-7948-c67b15a4246e@gmail.com>
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

On Wed, Sep 14, 2022 at 12:50:45PM +0200, Johan Jonker wrote:
> Change SPDX-License-Identifier to (GPL-2.0-only OR BSD-2-Clause)
> for Rockchip clock bindings.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Request for copyright holder approval.

Who is that? Please add Cc entries above for who that is. It's authors 
of the files below and the original .txt files.

> ---
>  Documentation/devicetree/bindings/clock/rockchip,px30-cru.yaml  | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3036-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3188-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3228-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3288-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3308-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3368-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3399-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rk3568-cru.yaml          | 2 +-
>  .../devicetree/bindings/clock/rockchip,rv1108-cru.yaml          | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
