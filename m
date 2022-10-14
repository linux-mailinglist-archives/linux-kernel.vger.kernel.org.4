Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB425FF0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiJNOxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNOxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:53:38 -0400
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5817A1CEC22;
        Fri, 14 Oct 2022 07:53:38 -0700 (PDT)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1370acb6588so6101003fac.9;
        Fri, 14 Oct 2022 07:53:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gy30CbgzVzjQUM+rCFGdEeWdVOvfOjY22rZZUrW/yKM=;
        b=wtj1sAvAbrO8XiBdiTA9xLm34lfiUtMvsvgnzigDpmPsZcW2RSZq82u72ZYhmbbntP
         nD79Vz4Yhk4GYH3IYEgrhL/p/kr6xQtkwf6f1NJDWJRBqu3YQkZA7D7YibOXTO85vvCT
         13WxwF69AALTQ/jaUy984qOyNlnSeYEaTk2MlEe849Mkw39VcMpY4mRCJ8oPY0F7sXHE
         SkfJWCxWR1Xdj5940q5igRxSaY7sf6ZdRNhPymiNKhA3xK2+Dz0FRX0nEC+CU9p8cyBH
         EEdP/EfMJZ/Aw78tMAsnClR6kQses6hXZHvb9BKY3/bvBFyvSMioNK5hRiWQbfYdTCSU
         AXzg==
X-Gm-Message-State: ACrzQf34iMWWuXHUdrqjmENZqVKO395FeVTLPul1xutxMRDHHBP1GOsP
        p5a9r/Evo6tCkURmaSTYQQ==
X-Google-Smtp-Source: AMsMyM4vNolvuaN6nEESb3jchZJppnaf98gn7taPwj073cN4z6ZsJ0f8+guVhtChAanhWKSaKP3H5Q==
X-Received: by 2002:a05:6871:54b:b0:132:b17:d0cb with SMTP id t11-20020a056871054b00b001320b17d0cbmr2806569oal.117.1665759217594;
        Fri, 14 Oct 2022 07:53:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id el40-20020a056870f6a800b0011dca1bd2cdsm1519301oab.0.2022.10.14.07.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:53:37 -0700 (PDT)
Received: (nullmailer pid 1940386 invoked by uid 1000);
        Fri, 14 Oct 2022 14:53:37 -0000
Date:   Fri, 14 Oct 2022 09:53:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        jun.li@nxp.com, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, s.hauer@pengutronix.de, kishon@ti.com,
        Peng Fan <peng.fan@nxp.com>, robh+dt@kernel.org,
        festevam@gmail.com, xu.yang_2@nxp.com, linux-usb@vger.kernel.org,
        vkoul@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: phy: imx8mq-usb: add power-domains property
Message-ID: <166575921695.1940330.11207621757952776145.robh@kernel.org>
References: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014095550.2125018-1-peng.fan@oss.nxp.com>
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

On Fri, 14 Oct 2022 17:55:50 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add optional power-domains property for usb phy.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
