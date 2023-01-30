Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74666819A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237870AbjA3Stv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237418AbjA3Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:49:47 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4253E30299;
        Mon, 30 Jan 2023 10:49:46 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id r17-20020a056830449100b0068bb088317aso2985924otv.12;
        Mon, 30 Jan 2023 10:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kW8ohaGrxXkWGPa0FCZ4hef9tIH5Omh7JAoheQeQ1mM=;
        b=XvRq2B2vWZR99W+dD+o+96j6GFbyBvVrPcV69KM3EJfvF57DQuIJHTvyqwHFvkSV0N
         SeULFPm6mesoUsvF+ivH7QwqoK6PPOq/pfKKvJSWs8+/b4PZfkCM7tz490MPx3sIAFgK
         9Ne0Kq2V6O/pQ4+rlFz/xIrhuZZRXasvSxPShdXtRX6YMRVi3RlIxFI0zE8Y4ohxM3Jm
         Kk0o3aZJvRuOkpNjefSJKU7m/uUKlnGmva5SyANZfptLw8hL+X94kQ45xrEH8YJwOUmk
         wOD20KilXHPqkh1iI44TjuUmZRcCKtUCY5lWllSpUvLOlHgN2sQbo++Vrk6fUU27Osto
         8eaA==
X-Gm-Message-State: AO0yUKVcV0wDfGO5jQK4I2sTKDIH3F3wiTjxTxmotqHbGi9xQ79A4Hwf
        CXDJWAcR4fCwd7dJHevvKQ==
X-Google-Smtp-Source: AK7set86dmjvFduMxGNkWsXujIuVf9i07CX6Jh1NynnRWXs51cFLdSm6bR69XaKevU8S8H7Y/GAGmQ==
X-Received: by 2002:a05:6830:50:b0:68b:cdc3:78d7 with SMTP id d16-20020a056830005000b0068bcdc378d7mr2581366otp.8.1675104585466;
        Mon, 30 Jan 2023 10:49:45 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f88-20020a9d03e1000000b0068bcadcad5bsm2577345otf.57.2023.01.30.10.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:49:45 -0800 (PST)
Received: (nullmailer pid 3105156 invoked by uid 1000);
        Mon, 30 Jan 2023 18:49:44 -0000
Date:   Mon, 30 Jan 2023 12:49:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 18/24] dt-bindings: rtc: qcom-pm8xxx: add uefi-variable
 offset
Message-ID: <20230130184944.GA3096050-robh@kernel.org>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-19-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142057.25715-19-johan+linaro@kernel.org>
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

On Thu, Jan 26, 2023 at 03:20:51PM +0100, Johan Hovold wrote:
> On many Qualcomm platforms the PMIC RTC control and time registers are
> read-only so that the RTC time can not be updated. Instead an offset
> needs be stored in some machine-specific non-volatile memory, which a
> driver can take into account.
> 
> Add a 'qcom,uefi-rtc-info' boolean flag which indicates that the RTC
> offset is stored in a Qualcomm specific UEFI variable so that the RTC
> time can be updated on such platforms.
> 
> The UEFI variable is
> 
> 	882f8c2b-9646-435f-8de5-f208ff80c1bd-RTCInfo
> 
> and holds a 12-byte structure where the first four bytes is a GPS time
> offset in little-endian byte order.

Can't you just try to read the UEFI variable and use it if that 
succeeds?

I don't like this in DT because what if lots of devices start storing 
lots of things in vendor specific UEFI variables. It doesn't scale.

Rob
