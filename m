Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF426F0A55
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244226AbjD0Q5N convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 27 Apr 2023 12:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244313AbjD0Q5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:57:10 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DDB1FC7;
        Thu, 27 Apr 2023 09:57:08 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-94f161ee14fso244940966b.0;
        Thu, 27 Apr 2023 09:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614627; x=1685206627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUS+HutUGhCD5WILnDN1bs+B+UekIA4GvcKqZcPks/Q=;
        b=hnZSmk8X7ai+huGUBCX37u/2zqihzrJXgCAKJxEI90JMx3BqbyOYKv0HjjEJhFoELD
         BQ9CG0CJufR1f+2VubmIWYkYuko/pH3GnB+PvyZCo4OLqkBTQ0grPNR2V5rxDt0qvJ0m
         gpaM53WAxyMN1v4tvPUDsFWLavzlBjuuM2tPKPA58pm0pRB6JB7QqS8OzHRAUmO0nx0d
         2jJfP9+wCDEl4ZlaYPRQt8kv8vptM69uj76rVxT6HbgkXy4gKJd/1MJl7BUYOMK2/phx
         i/BHqMXqAZfnUyIXJNpklfrPBV3uY7qvQB8R+C0HWDrRGGVEGhMIpjWYRMnUGdtsxvkz
         +sUg==
X-Gm-Message-State: AC+VfDxyC6VixTZ/NGmE+DEtOqWAbxxcuEh1jcW6nXig3OAm+J7b2b3l
        45BduxY90hGZV1MjuGmcnz6fN4+wutuMiwKkeQo=
X-Google-Smtp-Source: ACHHUZ7pKPK6nq3DXDG+Me5MgIoROMJvFauFck9JjGPJlzmUTkt/DUQb7geHMFy3PF0s+Yu+6fxmBrWA/tM2Rb9wdVo=
X-Received: by 2002:a17:906:77cd:b0:959:37cc:190e with SMTP id
 m13-20020a17090677cd00b0095937cc190emr2232082ejn.3.1682614627425; Thu, 27 Apr
 2023 09:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <36983e07-832a-868d-6b8d-3656f0a4d873@linaro.org>
In-Reply-To: <36983e07-832a-868d-6b8d-3656f0a4d873@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 27 Apr 2023 18:56:56 +0200
Message-ID: <CAJZ5v0hJviWQS2jFVYnLBPjOhOddxUU1-U2OURDRWQVS4tRu=w@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1 #3
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Kang Chen <void0red@hust.edu.cn>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 11:27 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
>
> Hi Rafael,
>
> can you consider pulling these changes ? They have been in linux-next
> since several days and they fix some minor issues, except one of them
> which is an urgent one for Mediatek.
>
> The following changes since commit 5bc6b1df65c87f8dd7d0afe494a2c0b9d5c73140:
>
>    thermal: intel: int340x: Add DLVR support for RFIM control
> (2023-04-18 15:24:40 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.4-rc1-3
>
> for you to fetch changes up to 2afa82d1fc648c8d4c2ef9e876626abb1089f9ab:
>
>    dt-bindings: thermal: qcom-tsens: Correct unit address (2023-04-26
> 10:38:35 +0200)
>
> ----------------------------------------------------------------
> - Add compatible strings DT bindings for imx6sll and imx6ul to fix
>    dtbs check warning (Stefan Wahren)
>
> - Update the example in the DT bindings to reflect changes with the
>    ADC node name for QCom TM and TM5 (Marijn Suijten)
>
> - Fix the comments for the cpuidle_cooling_register() function to
>    match the function prototype (Chenggang Wang)
>
> - Fix inconsistent temperature read and some Mediatek variant board
>    reboot by reverting a change and handling the temperature
>    differently (AngeloGioacchino Del Regno)
>
> - Fix a memory leak in the initialization error path for the Mediatek
>    driver (Kang Chen)
>
> - Use of_address_to_resource() in the Mediatek driver (Rob Herring)
>
> - Fix unit address in the QCom tsens driver DT bindings (Krzysztof
>    Kozlowski)
>
> ----------------------------------------------------------------
> AngeloGioacchino Del Regno (2):
>        Revert "thermal/drivers/mediatek: Add delay after thermal banks
> initialization"
>        thermal/drivers/mediatek: Add temperature constraints to validate
> read
>
> Chenggang Wang (1):
>        thermal/drivers/cpuidle_cooling: Delete unmatched comments
>
> Kang Chen (2):
>        thermal/drivers/mediatek: Use devm_of_iomap to avoid resource
> leak in mtk_thermal_probe
>        thermal/drivers/mediatek: Change clk_prepare_enable to
> devm_clk_get_enabled in mtk_thermal_probe
>
> Krzysztof Kozlowski (1):
>        dt-bindings: thermal: qcom-tsens: Correct unit address
>
> Marijn Suijten (1):
>        dt-bindings: thermal: Use generic ADC node name in examples
>
> Rob Herring (1):
>        thermal/drivers/mediatek: Use of_address_to_resource()
>
> Stefan Wahren (1):
>        dt-bindings: imx-thermal: Add imx6sll and imx6ul compatible
>
>   Documentation/devicetree/bindings/thermal/imx-thermal.yaml         |
> 14 ++++++++++----
>   Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm-hc.yaml |
> 4 ++--
>   Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml   |
> 9 ++++++---
>   Documentation/devicetree/bindings/thermal/qcom-tsens.yaml          |
> 4 ++--
>   drivers/thermal/cpuidle_cooling.c                                  |
> 3 ---
>   drivers/thermal/mediatek/auxadc_thermal.c                          |
> 89
> ++++++++++++++++++++++++++++++++++++++++++++---------------------------------------------
>   6 files changed, 64 insertions(+), 59 deletions(-)

Pulled, thanks!
