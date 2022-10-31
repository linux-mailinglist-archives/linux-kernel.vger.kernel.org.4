Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8131613FF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 22:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiJaVdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 17:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiJaVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 17:33:15 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DD7140D0;
        Mon, 31 Oct 2022 14:33:14 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id d18-20020a05683025d200b00661c6f1b6a4so7497446otu.1;
        Mon, 31 Oct 2022 14:33:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtN0R9c3Xw+alqszrD54ZcT//h0HTwxiHDtbi57TVvU=;
        b=tjNs0X1hheNKFaIsP8L7h+ppWELY3qBwzf5jYrlts0gwKeXVnlM/dsbcl9TdLynmKw
         qOxJuyxM2/eAPOx042DxysiVcDTi0vUuOS2eDgOWIlQyS6S3y5lahphitdohTIPBMy+O
         tGcVddiBfcwajL0MVy2HFCuR1T3eDpQaHbI5mi9ZzwSm30Rn0pqwsTRyHH8LKsKLjCoe
         A4hTcN8EsoGynh8BOOZHcNVdgatvA9cuTkLCEm6L84RdI7hqLs0L0EQrlnrRzMqNcuRF
         hgRndrw20ZlSOeDkZ1BySzdUVbrG0VHtSA+tB+s5GgldI6VG6L6eIH6Dzd+G1XCLI3lS
         9XRA==
X-Gm-Message-State: ACrzQf0FDqfpnY7MTeZlD3PuboH2lXHKNAwJvIfRSg/YdkQAL6FC19Ll
        86hN+fF4e2THr7ilQe3yVCtJtGPRkQ==
X-Google-Smtp-Source: AMsMyM5em5XhVyWzZqhH1B658EIMHFWbI8owAlvqnwExSY0lbeyGKyYhZ8e+Sajuri6YVf3PjGG6rQ==
X-Received: by 2002:a05:6830:1452:b0:66c:46e9:762d with SMTP id w18-20020a056830145200b0066c46e9762dmr5054864otp.258.1667251993271;
        Mon, 31 Oct 2022 14:33:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l18-20020aca1912000000b003544822f725sm2762718oii.8.2022.10.31.14.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 14:33:12 -0700 (PDT)
Received: (nullmailer pid 3609482 invoked by uid 1000);
        Mon, 31 Oct 2022 21:33:14 -0000
Date:   Mon, 31 Oct 2022 16:33:14 -0500
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     steev@kali.org, andersson@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        quic_jprakash@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@somainline.org
Subject: Re: [PATCH v2 01/12] dt-bindings: iio: qcom: adc7-pm8350: Allow
 specifying SID for channels
Message-ID: <166725199395.3609425.1566851123468053953.robh@kernel.org>
References: <20221029051449.30678-1-manivannan.sadhasivam@linaro.org>
 <20221029051449.30678-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029051449.30678-2-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 29 Oct 2022 10:44:38 +0530, Manivannan Sadhasivam wrote:
> As per the new ADC7 architecture used by the Qualcomm PMICs, each PMIC
> has the static Slave ID (SID) assigned by default. The primary PMIC
> PMK8350 is responsible for collecting the temperature/voltage data from
> the slave PMICs and exposing them via it's registers.
> 
> For getting the measurements from the slave PMICs, PMK8350 uses the
> channel ID encoded with the SID of the relevant PMIC. So far, the
> dt-binding for the slave PMIC PM8350 assumed that there will be only
> one PM8350 in a system. So it harcoded SID 1 with channel IDs.
> 
> But this got changed in platforms such as Lenovo X13s where there are a
> couple of PM8350 PMICs available. So to address multiple PM8350s, change
> the binding to accept the SID specified by the user and use it for
> encoding the channel ID.
> 
> It should be noted that, even though the SID is static it is not
> globally unique. Only the primary PMIC has the unique SID id 0.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/thermal/qcom-spmi-adc-tm5.yaml   |  6 +-
>  .../dt-bindings/iio/qcom,spmi-adc7-pm8350.h   | 90 +++++++++----------
>  2 files changed, 46 insertions(+), 50 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
