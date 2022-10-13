Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC765FE355
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 22:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJMUdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 16:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiJMUdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 16:33:09 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4545815B13A;
        Thu, 13 Oct 2022 13:33:08 -0700 (PDT)
Received: by mail-oi1-f177.google.com with SMTP id n83so2992514oif.11;
        Thu, 13 Oct 2022 13:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tPeVUiYe/rPuSAZQr2xhy5gyzXk+Uxt50hvIusVXsOg=;
        b=RUv4V8aBu9zmfAUlc1lXNCUFZCxIvsW031OqYmfytDtJPV+jYI4esHqtI3pc5fLcE5
         VhtTvoofI55zB9eI8cQ+CLrwWrUNRyptUB2twi0AuDtyYeZBF7bI4tAdAeJXSRy6OBTH
         HrFP5rIHCpZGTwIi9Bvik6gB0rAZq3ilrJAsKO5fdF7mYtVjDd9J1Q96Zwh/vbF+Ps4A
         dHyr+vxxu4bKHdsg56Vhv9a/t16uW6LcOgRyTeScTN/mnAM+GdhVVOREljHyCoqvf6Zn
         eU0WUa0eAk+bjD9Yb1PT2NQY+nv7Q+B12jTg/6JHZqT/t9Bcx7mW1SYw9/bcKEwjyJtR
         WwRA==
X-Gm-Message-State: ACrzQf2KdQH05/FQJqaqqzKP1oc8P/61oTWwOOyABHZzks9E3wM8XFR6
        UJ19yVxOU7p5I/4+FvbIyWAqJOn1Gw==
X-Google-Smtp-Source: AMsMyM5b1PUrHX5hYBnNdAXYyxwtLh6CvlIqdzOyzG4Ar6QyGnDVsF/KdqtWKkuGlQP4a8f7AqI/Dg==
X-Received: by 2002:a05:6808:ecc:b0:353:2f37:5527 with SMTP id q12-20020a0568080ecc00b003532f375527mr783111oiv.259.1665693187471;
        Thu, 13 Oct 2022 13:33:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k2-20020a4ad102000000b004805dfd3f31sm200805oor.10.2022.10.13.13.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 13:33:07 -0700 (PDT)
Received: (nullmailer pid 181607 invoked by uid 1000);
        Thu, 13 Oct 2022 20:33:07 -0000
Date:   Thu, 13 Oct 2022 15:33:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, dave.stevenson@raspberrypi.com,
        mchehab@kernel.org, jacopo@jmondi.org, paul.j.murphy@intel.com,
        sakari.ailus@iki.fi, Rob Herring <robh+dt@kernel.org>,
        linux-media@vger.kernel.org, daniele.alessandrelli@intel.com
Subject: Re: [PATCH v5 1/3] media: dt-bindings: imx412: Extend compatible
 strings
Message-ID: <166569318747.181558.7381468461702818435.robh@kernel.org>
References: <20221013125142.3321405-1-bryan.odonoghue@linaro.org>
 <20221013125142.3321405-2-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013125142.3321405-2-bryan.odonoghue@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 13:51:40 +0100, Bryan O'Donoghue wrote:
> Add compatible bindings for imx577 which uses the same silicon enabling
> reference code from Sony in the available examples provided.
> 
> Cc: sakari.ailus@iki.fi
> Cc: dave.stevenson@raspberrypi.com
> Cc: jacopo@jmondi.org
> Cc: "Paul J. Murphy" <paul.j.murphy@intel.com>
> Cc: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: linux-media@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  Documentation/devicetree/bindings/media/i2c/sony,imx412.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
