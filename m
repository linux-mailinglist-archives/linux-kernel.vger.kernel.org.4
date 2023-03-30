Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E3F6D0834
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbjC3O0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjC3OZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:25:58 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A3187;
        Thu, 30 Mar 2023 07:25:57 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id be10so950325oib.6;
        Thu, 30 Mar 2023 07:25:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFW2Fxi2txULIRe3DJUc5qXrtounXXEIdQOAl1fQLSk=;
        b=ZJwYphP6TxIkWg89f+FtoA6XI+k8IK4uPoGQeQtPtPrs7koz2LCNUloggYAvNumrKL
         SZScFYiZniQQXVyYQ9P9GZ1GTWTn6Tnl9iBzZMUTvh0Hu/xn4xHOP3c3K7KuRUuP3nM7
         r1Yrmlp1PoK6g18gSqbELCP134EcXnFaG7mmbgAsmnpzUk31+EzNiRT0htLQYm452k9x
         0w8pHXunf9cxRo/A0HLXSl8XXVNPtZDn/+ludVnHxrA6e7NA/C8AfkCuO6WhmSPSAhvU
         Hq2DgYgWkkFV5AKPlyTAizeGCJRRbG1+RCPDnHIY/1LpBCFER+sFm7KrYSixpUCk6vOT
         ypDg==
X-Gm-Message-State: AAQBX9e7J/gJgW4BsNHfa8WXfHCEzgvXaym2V8x1OG9ajWR3fuUi9Yqk
        IbSG0S5KOYR+Q4oQuLAqag==
X-Google-Smtp-Source: AKy350ZidEg0WyM99bAmG60tXImF4uhx11/uXQd5Ggh/HE1bnuQq5Qgc2+9/Wv8CgF0SLC4fuMtIMQ==
X-Received: by 2002:a05:6808:1a06:b0:389:21:9483 with SMTP id bk6-20020a0568081a0600b0038900219483mr10034574oib.59.1680186356186;
        Thu, 30 Mar 2023 07:25:56 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a4aae06000000b0051763d6497fsm14653566oom.38.2023.03.30.07.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:25:55 -0700 (PDT)
Received: (nullmailer pid 1959245 invoked by uid 1000);
        Thu, 30 Mar 2023 14:25:54 -0000
Date:   Thu, 30 Mar 2023 09:25:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     arnd@arndb.de, jneanne@baylibre.com, robh+dt@kernel.org,
        razor@blackwall.org, eblanc@baylibre.com,
        devicetree@vger.kernel.org, stephen@networkplumber.org,
        derek.kiernan@xilinx.com, yi.l.liu@intel.com, jgg@ziepe.ca,
        u-kumar1@ti.com, dragan.cvetic@xilinx.com,
        gregkh@linuxfoundation.org, contact@emersion.fr,
        krzysztof.kozlowski+dt@linaro.org, sterzik@ti.com,
        linux-doc@vger.kernel.org, lee@kernel.org,
        prabhakar.csengg@gmail.com, linux-kernel@vger.kernel.org,
        corbet@lwn.net
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: Add TI TPS6594 PMIC
Message-ID: <168018635391.1959190.9703045344955071020.robh@kernel.org>
References: <20230330082006.11216-1-jpanis@baylibre.com>
 <20230330082006.11216-2-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330082006.11216-2-jpanis@baylibre.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 30 Mar 2023 10:20:03 +0200, Julien Panis wrote:
> TPS6594 is a Power Management IC which provides regulators and others
> features like GPIOs, RTC, watchdog, ESMs (Error Signal Monitor), and
> PFSM (Pre-configurable Finite State Machine) managing the state of the
> device.
> TPS6594 is the super-set device while TPS6593 and LP8764 are derivatives.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   | 193 ++++++++++++++++++
>  1 file changed, 193 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/ti,tps6594.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

