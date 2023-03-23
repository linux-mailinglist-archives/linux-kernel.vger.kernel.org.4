Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF116C67E1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 13:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCWMPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 08:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjCWMO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 08:14:29 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269AA2473C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-541a05e4124so391659317b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 05:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679573640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6r3XVRqIULYm4CGKu7hP4tgnIXEFH+P3K6MMzZmDA6Y=;
        b=poaqupKGqOdpI+XuLb3+5WiJSKB91AHjkpbRvzeNSCauU7DKUnMk4sf/P3ZHQQmbAP
         ARbOcThfNJU0Hn4clq72ZdyXd/r3F0ab6foRIfOKMiFqcMvuat9WQxOPr35VpEdjfkbA
         cO4S/t4jJyo8Fk5AcTDpoQRJ1qCQ2NkmBTKLSaXCW1FJYpmY4YqRb7hSl6XTBmkF7hzH
         XTr9UdEk0wlxjE86JvwxdevqOcThn8EJrgsozLsudhW107AE7NEo3w8eoQNNHQZjOo2O
         MVi4Dda1p8sYdktausdj3pklzzceXec49Yr1kLB1f0hDmHCZCDiGZ6gtOjU35z4NSTGs
         kpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679573640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6r3XVRqIULYm4CGKu7hP4tgnIXEFH+P3K6MMzZmDA6Y=;
        b=Afy2psMFuT8XtaONboCA+tmufN7GcR+u4qAct3xqQeRXM93UDOvp1qonCNneiWJSfl
         sLyJpfOKInVg2v6/MnrUABwCuvgkmxR0qvQDPzKfeIXg9qr1laQVe14VQfkYDS+4tQwT
         Rg/rbeZOyeOiSUT+0ZxrU2pDZFm2l2mQyFWtXhpbyJW8SOxQH42ld4l06AjgluPSwGIO
         vQRJnpBlzAM2ISHx8hIF4nZCkReHvq4aHqrsZWpvpOyEwkOxW0mpEXQ/LD4t5lil75Kw
         1BhZWB9q5g17YjL2Azj1SDtB9JR4r9G7SCL3yRHwJrTCalcdLRkOKsz6ib07E3PDOGIm
         vaag==
X-Gm-Message-State: AAQBX9dABLDwnlJ4mnHMIAGiBv0/GXO2sW5zomijZXbELy2uDEpnDkIG
        QcXzpxwBq4HMw6bUnlBjiYATYfOKvzIa4QHBGHJesg==
X-Google-Smtp-Source: AKy350YrzARwXS8DQFIp2Yjci1l9v45eFynyY5At2IrDlpyb+0NB5f39rOS96b7EjLMpprOrk8d3M4mQdbcyMs8c8/o=
X-Received: by 2002:a81:b3c3:0:b0:545:343b:ecba with SMTP id
 r186-20020a81b3c3000000b00545343becbamr1735168ywh.0.1679573638541; Thu, 23
 Mar 2023 05:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230316120549.21486-1-rashmi.a@intel.com> <20230316120549.21486-3-rashmi.a@intel.com>
In-Reply-To: <20230316120549.21486-3-rashmi.a@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 23 Mar 2023 13:13:22 +0100
Message-ID: <CAPDyKFqvEOSOYwTTTfMv2jboASgjiw0pX1+yG6Z2TAqSAimQuQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mmc: Remove bindings for Intel
 Thunder Bay SoC"
To:     rashmi.a@intel.com
Cc:     michal.simek@xilinx.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@kernel.org, yuancan@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com, kris.pan@linux.intel.com,
        adrian.hunter@intel.com, mahesh.r.vaidya@intel.com,
        nandhini.srikandan@intel.com, vasavi.v.itha@intel.com,
        kenchappa.demakkanavar@intel.com, furong.zhou@intel.com,
        mallikarjunappa.sangannavar@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 13:06, <rashmi.a@intel.com> wrote:
>
> From: "A, Rashmi" <rashmi.a@intel.com>
>
> Remove Thunder Bay specific code as the product got cancelled
> and there are no end customers or users.
>
> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/arasan,sdhci.yaml | 25 -------------------
>  1 file changed, 25 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> index 8296c34cfa00..e8e8b48dc5e5 100644
> --- a/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml
> @@ -88,12 +88,6 @@ properties:
>          description:
>            For this device it is strongly suggested to include
>            arasan,soc-ctl-syscon.
> -      - items:
> -          - const: intel,thunderbay-sdhci-5.1   # Intel Thunder Bay eMMC PHY
> -          - const: arasan,sdhci-5.1
> -        description:
> -          For this device it is strongly suggested to include
> -          clock-output-names and '#clock-cells'.
>
>    reg:
>      maxItems: 1
> @@ -309,22 +303,3 @@ examples:
>                     <&scmi_clk KEEM_BAY_PSS_SD0>;
>            arasan,soc-ctl-syscon = <&sd0_phy_syscon>;
>      };
> -
> -  - |
> -    #define EMMC_XIN_CLK
> -    #define EMMC_AXI_CLK
> -    #define TBH_PSS_EMMC_RST_N
> -    mmc@80420000 {
> -          compatible = "intel,thunderbay-sdhci-5.1", "arasan,sdhci-5.1";
> -          interrupts = <GIC_SPI 714 IRQ_TYPE_LEVEL_HIGH>;
> -          reg = <0x80420000 0x400>;
> -          clocks = <&scmi_clk EMMC_XIN_CLK>,
> -                   <&scmi_clk EMMC_AXI_CLK>;
> -          clock-names = "clk_xin", "clk_ahb";
> -          phys = <&emmc_phy>;
> -          phy-names = "phy_arasan";
> -          assigned-clocks = <&scmi_clk EMMC_XIN_CLK>;
> -          clock-output-names = "emmc_cardclock";
> -          resets = <&rst_pss1 TBH_PSS_EMMC_RST_N>;
> -          #clock-cells = <0x0>;
> -    };
> --
> 2.17.1
>
