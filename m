Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37766C6CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjCWPzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjCWPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:54:59 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0696E8A59;
        Thu, 23 Mar 2023 08:54:59 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-17aaa51a911so23152115fac.5;
        Thu, 23 Mar 2023 08:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679586898;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/KvEijazJvNiPPU/a5fowJ2hFtgccv0XDsNbT/x0SE=;
        b=09mrVgI3t7dn3uiSaIsDateeGigJ4jRj9UcogrMiLSQPwXcR9HOfMrCrBwxwZqYieT
         RKqX+zjj0AnDc1zC2oXjAd7btMe33LDNQa7dtap73bup7ScnmmA+avUeqBEuxle8Orco
         Qicy/8gvn/ho6va/0g8/hjr89+whk9CUKLVrrTFARwAyTPanFWF3y09KJoj+4wL+9vfi
         mGBCRtnWoD9oghkKrJ73DL2fLrfMTZK7o4eYcn/j8va3ckAuGZjn2Conxyzkky1B9mak
         E02JIevB5SrmbZkNb4oaP+P80b9/LDQyImzMJ5L8zX/zYuzkjoA8qwsPdaZPGjopr3Kc
         gxrA==
X-Gm-Message-State: AAQBX9cdPAT6Vv0/viIm+BChVML7Hrfc63Rdpod5CMVtM0QtswHw3WcI
        x4leno5njKcioqVwPchw4w==
X-Google-Smtp-Source: AK7set86mbeiCNUpy4qCLV3sydGYRLOG1cG5cp4SBldyYvBYTCsqdx8FVFmekKCNUauRlbFiU58vwQ==
X-Received: by 2002:a05:6870:638d:b0:177:a5e2:442e with SMTP id t13-20020a056870638d00b00177a5e2442emr2905567oap.43.1679586898246;
        Thu, 23 Mar 2023 08:54:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id xs12-20020a056871accc00b0017b0e3a5af0sm5944918oab.24.2023.03.23.08.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:54:57 -0700 (PDT)
Received: (nullmailer pid 3324440 invoked by uid 1000);
        Thu, 23 Mar 2023 15:54:56 -0000
Date:   Thu, 23 Mar 2023 10:54:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     devicetree@vger.kernel.org, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, xu.yang_2@nxp.com,
        Peng Fan <peng.fan@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, festevam@gmail.com, jun.li@nxp.com,
        s.hauer@pengutronix.de, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH linux-next V3 1/2] dt-bindings: usb: snps,dwc3: correct
 i.MX8MQ support
Message-ID: <167958689609.3324376.10714283951918743072.robh@kernel.org>
References: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323035531.3808192-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 23 Mar 2023 11:55:30 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The previous i.MX8MQ support breaks rockchip,dwc3 support,
> so use select to restrict i.MX8MQ support and avoid break others.
> 
> Fixes: 3754c41c7686 ("dt-bindings: usb: snps,dwc3: support i.MX8MQ")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V3:
>  Drop duplicated ones. with patch 2/2 there is no error anymore
> V2:
>  Add a new yaml
> 
>  .../bindings/usb/fsl,imx8mq-dwc3.yaml         | 48 +++++++++++++++++++
>  .../devicetree/bindings/usb/snps,dwc3.yaml    | 12 ++---
>  2 files changed, 53 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/fsl,imx8mq-dwc3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

