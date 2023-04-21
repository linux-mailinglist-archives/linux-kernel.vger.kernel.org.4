Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC796EB283
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 21:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbjDUTtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 15:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbjDUTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 15:48:53 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1450B1FC7;
        Fri, 21 Apr 2023 12:48:40 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-546de76c23eso1250343eaf.0;
        Fri, 21 Apr 2023 12:48:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682106519; x=1684698519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkPnOUh0neb4MVTUrbit7nLJd4t84y5z0PgNA0afTZ4=;
        b=c/kjEyOnHOqo3rEBVjjToIgV+ouYAhM0PkZlNNt/oPFiteUIMD5BpA/PUC1rewt5q+
         z6zu4Dlk3mjrxc1+z5dasYyTjO3QWH9MhOnRzoKi6+a4sl3Nk/ViisYntPAcjrRgLrgO
         FMlqzMZBrhe6hEz98KFXatJ8oa0tF2vOg11ZjxPWDD43G4dM0xsHGQO8WEeUFLQ4X6oJ
         PUhdZm/0jUq/Szb/EgmrgV4xrfwn2gp3Bcxp+EQTg4c5fS5J0/k6mKRccHrQxQ3J1GzF
         Dpr/eJbjnjTpNPy+MaUcfsA7fC1KippOtiWwIT50Wwvkqg189LEZBu4jtvHDZ8nnq89T
         f08A==
X-Gm-Message-State: AAQBX9eBqAkZVOvul/sNYXo/9KIbGv+LXFdsxNr9Nedj6zuYV66Ou7d+
        ctLjbpVz6T9ZXfHOvlFSMw==
X-Google-Smtp-Source: AKy350aejOyl8OwPSFtGuW/8nDsydNRzme6iufoYXCm5IQo1b7EplyTp4nb/p6Zpes8WUkyN1b9qaA==
X-Received: by 2002:a05:6820:1b89:b0:547:6a79:18cb with SMTP id cb9-20020a0568201b8900b005476a7918cbmr321342oob.9.1682106519367;
        Fri, 21 Apr 2023 12:48:39 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m41-20020a4a952c000000b005251e3f92ecsm2045502ooi.47.2023.04.21.12.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 12:48:39 -0700 (PDT)
Received: (nullmailer pid 1673608 invoked by uid 1000);
        Fri, 21 Apr 2023 19:48:38 -0000
Date:   Fri, 21 Apr 2023 14:48:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: phy: qmp-ufs: tweak clock and
 clock-names for sa8775p
Message-ID: <168210651750.1673545.13199192508532033264.robh@kernel.org>
References: <20230419120914.173715-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419120914.173715-1-brgl@bgdev.pl>
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


On Wed, 19 Apr 2023 14:09:14 +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> maxItems is already globally set to 3. To make the binding easier to read
> and remove redundancy, set minItems to 3 for sa8775p as this platform
> requires exactly three clocks.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> v1 -> v2:
> - rephrased the commit message as this is not a fix but rather
>   a readability improvement
> 
>  .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml    | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

