Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04595B6CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiIML6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIML6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:58:22 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285875EDE8;
        Tue, 13 Sep 2022 04:58:21 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1280590722dso31456791fac.1;
        Tue, 13 Sep 2022 04:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LYSkHBCtBl6zbH23uUCPqPzkNWE3krDu7GZU/Ogtukg=;
        b=638UqidbXp6mlgdAnabN3U5Ci6ckGrqnu+vYovId+zhVobhx537lJV766/Z02NkzCA
         P2jJ+mYBfjMbnjqS9OPZNKuZbQdtxyx/SSdTmmLOr1MVM1rOL3bE04PL4QQpWcqsWHEq
         wtKDTJsniHi6551wqkUh8Ha7i0Aw1QJrUlj+brgnulueDzhpvc7qfh6ve/7pq6EBc2hQ
         xcVLI8PVAtZqat2R6a+6Q1LeAbF4YUsYZnx5Er6y/PgP4BpySTCdc+NcnnjPnMxj63rx
         4FP8/JHOgT+/m1Qo9uksDYk9sbXD+VEq+DSY67SIGLmoDJx3u+w3MtHfR/8xnMuGgenk
         7KCg==
X-Gm-Message-State: ACgBeo2M6sdKPa0OnLok1rrC3zAZ44/mU2ecCBGcOzlXgdDD2HZftfUo
        4eFq4tXNRXisnDCAKmnc9Q==
X-Google-Smtp-Source: AA6agR4ez4++YFNhv9E7XpmcJu8qnOuUKGvOJhMaGnz0HPD1JZ1/RBEZD4uHDwHaLV3B/+iU07ym9w==
X-Received: by 2002:a05:6870:2419:b0:127:b762:9d1e with SMTP id n25-20020a056870241900b00127b7629d1emr1599758oap.12.1663070300439;
        Tue, 13 Sep 2022 04:58:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b11-20020a056870d1cb00b001276cea2320sm6895753oac.58.2022.09.13.04.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:58:19 -0700 (PDT)
Received: (nullmailer pid 3388186 invoked by uid 1000);
        Tue, 13 Sep 2022 11:58:19 -0000
Date:   Tue, 13 Sep 2022 06:58:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eliav Farber <farbere@amazon.com>
Cc:     hhhawa@amazon.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org,
        andriy.shevchenko@intel.com, jonnyc@amazon.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        jdelvare@suse.com, rtanwar@maxlinear.com
Subject: Re: [PATCH v5 18/21] dt-bindings: hwmon: (mr75203) add coefficient
 properties for the thermal equation
Message-ID: <20220913115819.GA3388125-robh@kernel.org>
References: <20220908152449.35457-1-farbere@amazon.com>
 <20220908152449.35457-19-farbere@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908152449.35457-19-farbere@amazon.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Sep 2022 15:24:46 +0000, Eliav Farber wrote:
> Add optional temperature coefficient properties:
>  *) moortec,ts-coeff-g
>  *) moortec,ts-coeff-h
>  *) moortec,ts-coeff-cal5
>  *) moortec,ts-coeff-j
> If defined they shall be used instead of defaults.
> 
> The coefficients were added to device tree on top of the series property
> (which can be used to select between series 5 and series 6), because
> coefficients can vary between product and product, and code defaults might
> not be accurate enough.
> 
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> ---
> V4 -> V3:
> - Add 'multipleOf: 1000' instead of plain text.
> - Add minimum/maximum for some of the new properties.
> 
> V3 -> V2:
> - Add "moortec" prefix to property name.
> 
>  .../bindings/hwmon/moortec,mr75203.yaml       | 37 +++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
