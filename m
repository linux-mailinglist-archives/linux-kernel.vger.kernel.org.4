Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5EF6EA5C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjDUIXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjDUIXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:23:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7403524B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:23:36 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-94a342f15e4so182413466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 01:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682065415; x=1684657415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmPBpQGOUS8JJiDMBMaclv6rO3Q/6XPU7C23CWrw9Rw=;
        b=mG0wLaPN4fSBV8/3aWZPz628ip8mxdPk1vppSyIJVHde9nPTtOkAKZCbix6EHNBKnV
         PKP9L487EYvmJ8xwf6Yo6fPGC4YxrwwbKGUE43EVIOzEWVge0o9LEZ4txc7F42UY57hK
         DjzcMHDlF8N/qyyWbK1mz17jrxHmGYl+o7W8Sgu3dmydVg4vpLqJ1SLuBpxl9Lp4r5hP
         WMEgR1aMSSh3Tc2RF2GsbZOnpoHzr9Tug14wGjEQg735+ALOnw4eWK/c/HKyg1rxjMb1
         LyoMOxc9Gfmf+/94JoQ1B9A4uAbpI9QJte/s8by5iUDLyeDyMO4gXKwizQ2X/xDMdty4
         Onjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682065415; x=1684657415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmPBpQGOUS8JJiDMBMaclv6rO3Q/6XPU7C23CWrw9Rw=;
        b=A7HoZf9smL0wWkXkoTojEP8rdEuV8srmtbt2YnjiFk2q/rpBHQVFi7l0yPUjhdsg/x
         SQ/Zr2WSCLb7TfLh/4XSiAkEoOyoAZFENgwX8uAntOs6+zIQ0rQBSQHIEaalkQ5Q/AGK
         N2qERpouDIllZuk5O4Fh7+ls0HOuV2+fPvHizF+46e+hlI4jMdt24b8fzQaPyNMLf2jM
         Og5PiX4FyS+ghbHSmI0vMPvx4GBa046U/79e3nlOuB03lsZsOTaCWCzqLVkmALYv8myo
         AD+q9P7vgOEQCOIQS/tM2yBHl4xdu0u0GEdIfBqixOmUsQ5DOydzSybqVzMjUeYQDheh
         Eu6g==
X-Gm-Message-State: AAQBX9dlNqhlVrcsgTtRxHppZLbssv8ZSa32YMyoVvBHzLz6gHaYNdRj
        LRX1sZnBKEmGQGFTGNDQZGEFsg==
X-Google-Smtp-Source: AKy350YvfZWr5OqJW1qfClL4SIH2kms66aJYo321dM7KyczZNmMStEzdxqlMpa/xHgBaw2s6lEL5BQ==
X-Received: by 2002:a17:906:6bc2:b0:932:cec7:6801 with SMTP id t2-20020a1709066bc200b00932cec76801mr1362738ejs.54.1682065415213;
        Fri, 21 Apr 2023 01:23:35 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:668b:1e57:3caa:4d06? ([2a02:810d:15c0:828:668b:1e57:3caa:4d06])
        by smtp.gmail.com with ESMTPSA id n6-20020a170906700600b0094f5a74ba83sm1759590ejj.39.2023.04.21.01.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Apr 2023 01:23:34 -0700 (PDT)
Message-ID: <b406dd13-fedb-0e6e-2f1b-ad3ebb617dc4@linaro.org>
Date:   Fri, 21 Apr 2023 10:23:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] dt-bindings: iio: imu: mpu6050: Add icm20600 bindings
 to mpu6050
Content-Language: en-US
To:     Hermes Zhang <chenhuiz@axis.com>, jic23@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@axis.com, Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org
References: <20230421071630.524822-1-chenhuiz@axis.com>
 <20230421071630.524822-3-chenhuiz@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230421071630.524822-3-chenhuiz@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/2023 09:16, Hermes Zhang wrote:
> Adding the invensense ICM-20600 to the compatible list of the mpu6050
> driver
> 
> Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml          | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> index ec64d7877fe5..67711bc0ee6c 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml
> @@ -20,6 +20,7 @@ properties:
>            - invensense,icm20608
>            - invensense,icm20609
>            - invensense,icm20689
> +          - invensense,icm20600
>            - invensense,icm20602

Didn't we start switching to compatible groups of devices? This looks
compatible with 20602.

Best regards,
Krzysztof

