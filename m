Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59416EF696
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241443AbjDZOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240794AbjDZOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:39:00 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD03559FB;
        Wed, 26 Apr 2023 07:38:59 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-63b4bf2d74aso5675698b3a.2;
        Wed, 26 Apr 2023 07:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682519939; x=1685111939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3BCGjGAwt9nzDcLjFkEGmcEFFk7XHVfGUcpqHbAcKNw=;
        b=cmMOdBE3C5NBm/2htsHx9odWgajCNLikfdgI4VUEL7OVeVDSzY05jJdiFnOykoJF5s
         5RI44vTJZOBViD1wSXM4KAn8DXihiJc27ywWv89fHIQ8oiyIkTMUbOPBdIQd7DsMaEw+
         389DWmJ9LAu8D+ct6ELhdPsX1g+LTWPE2pYxrsySX/v191l96+HrvaD8Rp9lTGjy1flR
         hv4V2ag2VV32HSQKjd9bmimuOtfa92m6efCtwnR9SEwQXR8EMs9NnaZAeOzaZAtQiUKN
         icQJdv9QztX/oXXl8fNmUko8lecLvZijAAIbfldAez+EaEO70YL98A7G4bdiNNq5lrgh
         kIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682519939; x=1685111939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BCGjGAwt9nzDcLjFkEGmcEFFk7XHVfGUcpqHbAcKNw=;
        b=Af0JLU3KCXilmYTMeGpKoo9xNAtZmFzrguEmz2a0Ut0mNbiMbbuRp4/ooenEaOsSEH
         iyfbzZnCUTr5okobt+d32BSJkzQhkRFxulI20tRSzWMKcoK/HB5XpQeWg4QhS8RhaXV1
         qlvylEHZGtqwW2QCrHY687UFe+ghD2UAziL+I1tNI9stjC4vxheHDMyttn6Qy9HCDLVc
         IfMZLHJUHPLIlOr7mpxgiAMuPDgGmpHxplm0fPJqh4hpLs6qh03K+HoqSJkO5iMKmmof
         OXx0q0fKIdCgaKCjT++eBh+rfmFeiNILLOAY1WQcrGnV1DKu8zPmaOVTAtK4FjDZWYvt
         eQPA==
X-Gm-Message-State: AAQBX9dqQjP5yVjHEiYnETMw5lb5l06mPrXFH2U0DPHZ6pEhgptODPlS
        mA0UHAoIXbJimIKsiwltUCE=
X-Google-Smtp-Source: AKy350Ze6vJVynaE/sosyjaaJ5tbcOIT47nnb+gn9nXczWmDoem3JCnORWv9plbtWgGj1XJAKRY2Fg==
X-Received: by 2002:a05:6a20:4394:b0:f0:2501:349b with SMTP id i20-20020a056a20439400b000f02501349bmr24646831pzl.25.1682519939069;
        Wed, 26 Apr 2023 07:38:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b0062dfe944c61sm11448152pfj.218.2023.04.26.07.38.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:38:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <abe1301a-8bdf-3e5f-9e52-71f0f77d519b@roeck-us.net>
Date:   Wed, 26 Apr 2023 07:38:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] Hwmon driver for MAX31827 temperature switch
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230426124049.258359-1-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230426124049.258359-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 05:40, Daniel Matyas wrote:
> Removed of_match_table and kept only id_table. Removed other device id's
> from id_table (I have them only in the devicetree-binding).
> 

Please explain. Without of_match_table, it is not possible to bind the driver
using devicetree data. What is the point of that ?

Guenter

> Added mutex protection where it was needed.
> 
> Daniel Matyas (2):
>    dt-bindings: hwmon: add MAX31827
>    hwmon: max31827: add MAX31827 driver
> 
>   .../bindings/hwmon/adi,max31827.yaml          |  54 +++
>   Documentation/hwmon/index.rst                 |   1 +
>   Documentation/hwmon/max31827.rst              |  83 ++++
>   MAINTAINERS                                   |   9 +
>   drivers/hwmon/Kconfig                         |  11 +
>   drivers/hwmon/Makefile                        |   2 +-
>   drivers/hwmon/max31827.c                      | 406 ++++++++++++++++++
>   7 files changed, 565 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
>   create mode 100644 Documentation/hwmon/max31827.rst
>   create mode 100644 drivers/hwmon/max31827.c
> 

