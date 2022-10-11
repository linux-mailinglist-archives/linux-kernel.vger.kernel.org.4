Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FB95FB2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJKNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiJKNKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:10:06 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA011F9D3;
        Tue, 11 Oct 2022 06:10:04 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id h1-20020a4aa741000000b004756c611188so9990537oom.4;
        Tue, 11 Oct 2022 06:10:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CgkdA89ABmLjGYkv9Bof2QPZ8M/H7iFavcYPqd9mpjM=;
        b=tqI3YOy5EMtKxHRg2IgwzzXWB9R66i4dRtkEKogXlPa3YuiFIG35a+lLW5v8fPYzZS
         XaZHJlg+2t4d1w8qdubS3W+K1w9mtWK4j7z2xCuZESf6j6fBzn8ZWTQqhBooOs0SAQqV
         1Kv4Ixx2VyBvVTU3F/2mgj6Xs0Oj718z9EieghPwibf5MXZ9VdvYwX4I3Dy97JJdYchm
         aDmC+RnbgKwHJmI+3VnsnZFIfMLbYqNFOy7U8o2X1brENTIHzTCe5Vj/I/9A5DMMdcqP
         UUGAWRtt/bU24B8NYYzvpWFpsxYQySSpUyp0Y3YfG2Z+t8P/wTsRQS0HSrSppfwYHkp9
         UL/w==
X-Gm-Message-State: ACrzQf3tzZQ1HeIU2wc9WK1pzXEjdOoAFPQQCV62GnziSdfm1zq2ADGT
        O9mM+8NzEh6PbNr5y9+GsncO0Fs9vw==
X-Google-Smtp-Source: AMsMyM73yZAzvOemf+rxlYPKyoEjwF0daLomlKc0ETxjgG8BdWGBgwMLFpqHrlzB5LnQvIdQNWFFyQ==
X-Received: by 2002:a05:6830:40c5:b0:660:ef3f:97c with SMTP id h5-20020a05683040c500b00660ef3f097cmr10333986otu.177.1665493803657;
        Tue, 11 Oct 2022 06:10:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f13-20020a056830204d00b006594674d4ddsm6266022otp.44.2022.10.11.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 06:10:03 -0700 (PDT)
Received: (nullmailer pid 2704439 invoked by uid 1000);
        Tue, 11 Oct 2022 13:10:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     robh+dt@kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org,
        rajat.khandelwal@intel.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com,
        linux-iio@vger.kernel.org, jic23@kernel.org
In-Reply-To: <20221012074446.726409-1-rajat.khandelwal@linux.intel.com>
References: <20221012074446.726409-1-rajat.khandelwal@linux.intel.com>
Message-Id: <166549347474.2698211.13563129386484307071.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: dac: Change the I2C slave address for ds4422/4424 to its correct value
Date:   Tue, 11 Oct 2022 08:10:04 -0500
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

On Wed, 12 Oct 2022 13:14:46 +0530, Rajat Khandelwal wrote:
> The datasheet states that the slave address for the device is 0x20
> when the pins A0 and A1 are ground. The DT binding has been using
> 0x10 as the value and I think it should be 0x20 as per datasheet.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---
> 
> v2:
> 1. Subject prefix added
> 2. DT bindings validated
> 
>  Documentation/devicetree/bindings/iio/dac/maxim,ds4424.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/maxim,ds4424.example.dts:22.20-26.15: Warning (i2c_bus_reg): /example-0/i2c/dac@10: I2C bus unit address format error, expected "20"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

