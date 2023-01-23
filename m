Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8342B678A14
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjAWV6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjAWV6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:58:21 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB4810428;
        Mon, 23 Jan 2023 13:58:16 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id s124so11690333oif.1;
        Mon, 23 Jan 2023 13:58:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJiSu97o4lCeTUBe9wojm8v79wAbd4QPt39f5l1BYq0=;
        b=LGd5VqXWt/gsVpNCokHW51zzGUysi4dyuuMiaoqGFQTBC4AtmPEtRuF/cYRgIk7C2B
         kudMnriCGtZLUYUW6NuhPXYdz3G9i5XlecJrds2wTp3HSkLFbL9XMdOUG7nrE8hnK/zk
         FJPZU+MSWBVncfRXRSFU06oY8YCdGfy7y00SmZTxVfs1MQ7CiNLE2Sy2XZKfYN+ef4Ko
         9V1UVmmh5w2Nxem+Mbw2y3m35fhTvJwZwM6NM30+dezdoeirDDb8xTOBCsSr81jGYYIs
         6pjs8At1sBHQjLFvO+mRhxCzpgymWsnYzH5zP+SVihuVv4fmCgm8Ebrlv/JC4woxT3FK
         O5Pw==
X-Gm-Message-State: AFqh2krL6zxjsXcTsUfzkq3FQot4y71yVzXu3gfI/F+3Z4ZXA+o7c27o
        EetZ9Cc0EJk2ev1WJwum5g==
X-Google-Smtp-Source: AMrXdXvGa8Cb4hckgcIEZDhtmqI+tjbfS6fU7dH8uyZS39QjqvXvWjjk21kQVwnHc4uw9EUplZ4q5A==
X-Received: by 2002:aca:2401:0:b0:355:1df0:9b84 with SMTP id n1-20020aca2401000000b003551df09b84mr11116983oic.2.1674511095862;
        Mon, 23 Jan 2023 13:58:15 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id et12-20020a056808280c00b00364a415f0bbsm230245oib.39.2023.01.23.13.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:58:15 -0800 (PST)
Received: (nullmailer pid 2710693 invoked by uid 1000);
        Mon, 23 Jan 2023 21:58:14 -0000
Date:   Mon, 23 Jan 2023 15:58:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 3/3] dt-bindings: power: fsl,imx-gpc: document
 interrupt-controller
Message-ID: <167451109258.2710607.13087918900291726311.robh@kernel.org>
References: <20230120071717.138188-1-krzysztof.kozlowski@linaro.org>
 <20230120071717.138188-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120071717.138188-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 08:17:17 +0100, Krzysztof Kozlowski wrote:
> The fsl,imx6q-gpc is used as interrupt controller (routing back to GIC):
> 
>   imx6sl-evk.dtb: gpc@20dc000: '#interrupt-cells', 'interrupt-controller' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/fsl,imx-gpc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
