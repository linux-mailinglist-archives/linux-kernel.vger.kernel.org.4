Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AA66F0A53
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbjD0Q5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbjD0Q5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:57:00 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C6C1FF2;
        Thu, 27 Apr 2023 09:56:59 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6a5eea94963so8285447a34.3;
        Thu, 27 Apr 2023 09:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682614619; x=1685206619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adzTnoqQu8CXoqBn4BhcDQSGdUaLpEBvIJrGFhq9F+M=;
        b=Jb3/eGspd4EbNCYE9WH0ieut75ezZvtglWlAq1HQc2Na3B+cdni7BX8yljq5pXYj4l
         Bls18AW0wEw/uindh4DR8FUkAuAkAZhhx80Z3QfEJNPXzxPRUgAR//enY39SOXq/3L58
         c3J7z+RgyeQK5l5BMHA/gJsN9IAF6IF7HytACXUV/7DW3lqeEWvfUCP2P+8VpyenizqR
         rMLPWzgZCzzM5+j1PPA7SrQIWGncIJGfisnR8OVbXnvM5ew5deogL0fjePLhgMhjf5Mm
         s9UQlcjjUUWSc6ZUBCE7rh04eVx8gl2qz4Sph8nb8np/FQCx3R7IBHpnCPvg/n8kQwQi
         lkHA==
X-Gm-Message-State: AC+VfDyyGovrkECTUsHHv8aubPL57KJDuInWQAymvTFqWVUsLarfdRdU
        HDlDi6JrlNYQrifXq7GgKw==
X-Google-Smtp-Source: ACHHUZ4WbAgm6mHF+EBLdzXdbD8uGdC6c66fveOsrGxmFr2p5/phM8bCSG22UGmREHTQLNM8j79E7g==
X-Received: by 2002:a05:6830:147:b0:6a6:2f82:5018 with SMTP id j7-20020a056830014700b006a62f825018mr1136700otp.25.1682614618576;
        Thu, 27 Apr 2023 09:56:58 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r24-20020a056830121800b006a647f65d03sm6148250otp.41.2023.04.27.09.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 09:56:58 -0700 (PDT)
Received: (nullmailer pid 3161712 invoked by uid 1000);
        Thu, 27 Apr 2023 16:56:57 -0000
Date:   Thu, 27 Apr 2023 11:56:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: add MAX31827
Message-ID: <168261461678.3161673.9376006927072972936.robh@kernel.org>
References: <20230426124049.258359-1-daniel.matyas@analog.com>
 <20230426124049.258359-2-daniel.matyas@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230426124049.258359-2-daniel.matyas@analog.com>
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


On Wed, 26 Apr 2023 15:40:45 +0300, Daniel Matyas wrote:
> MAX31827 is a low-power temperature switch with I2C interface.
> 
> The device is a ±1°C accuracy from -40°C to +125°C
> (12 bits) local temperature switch and sensor with I2C/SM-
> Bus interface. The combination of small 6-bump wafer-lev-
> el package (WLP) and high accuracy makes this temper-
> ature sensor/switch ideal for a wide range of applications.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  7 +++
>  2 files changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

