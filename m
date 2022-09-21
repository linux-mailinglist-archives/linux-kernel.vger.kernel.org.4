Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75EB5E4F90
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbiIUSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIUShW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 14:37:22 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C352A0279
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:37:21 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q17so8061901lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 11:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=21yo/o9B1Z///KQURij6FTrdwpuSR6f9Iw+FckBY2pQ=;
        b=scx5aDinqwOzyktx9EfIUAeNOHk77EkF6br4UcMXBuVwtoxL9iYFi8xijVRCpHvPV9
         F7MTHj9+nQr5Qn0WPkx8Rtx1szwHU78eK7p7AxgbblziBHJxioaz3RnNszdowlC+iVvs
         I4HKglXBuw/40CeoXtNAye4gvB84iHMZpwzxnJD0VPDz7EjxINsV0EJP4RFNEURGHWBc
         Bj3G7xztwKJwVeMwPGJzAZyvlEtVeydENF+4Oxhy2evgKC3rD2H2yY6R6PuQmJ0747K2
         PQ9NB/hn8JOuKmantMPWAh5Jb6HeKBQuoqZAs289cwEOoodh8gNpoqmO3clxM25sGAg7
         QJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=21yo/o9B1Z///KQURij6FTrdwpuSR6f9Iw+FckBY2pQ=;
        b=qsK/W5WaysCOB4tKIPCx63NjPXWhqD9+SglSNGooBJcA+JorW+1cPILVnrqGxKGV+R
         gg+pjki4XKRZ45tfa5gHZfB0ichNVjMQW8d905/C/W6yvruQlo4Pc9m6dRTak+LLRQiY
         aPGj3YTIHL85UrZgA2b9ILjTEcZaB6IGsSwMs489hnQFfp8Rf6lm38Uq3rwJ6y0FMyzf
         occttJpF6eS+vVBZHJ+Lm6MLsUiN/W2ZX0POGlhOCEYlg6H1ZjdtKQmOKPZfnokC85QP
         DIwuUod0tYS3ckCMSKFemYDY8JWFa/yAgEuQBiIptODVAWajOpU1qa0jh51WLDOHoyUj
         3oOQ==
X-Gm-Message-State: ACrzQf22wgoN7HCR9CC9LfmlLKB44ngh9fmpjlNk1yTQk10XcaSMB2zo
        ekT2Wdts8g17F7MgeyVT/vsCWw==
X-Google-Smtp-Source: AMsMyM62wnzWt6Vp8mUjb+gIZEsui3L9hXgPsI7/JmBOT8VcKQ2uhobjPCK+P25klFmqdlSyfydITA==
X-Received: by 2002:a05:651c:1951:b0:26c:6215:1e92 with SMTP id bs17-20020a05651c195100b0026c62151e92mr2540306ljb.240.1663785439395;
        Wed, 21 Sep 2022 11:37:19 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b004979ec19387sm532855lfo.305.2022.09.21.11.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 11:37:18 -0700 (PDT)
Message-ID: <8cb14446-01ec-255a-5bf6-e16098628f60@linaro.org>
Date:   Wed, 21 Sep 2022 20:37:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 1/8] memory: tegra: Add API for retrieving carveout
 bounds
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
 <20220920081203.3237744-2-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920081203.3237744-2-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:11, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> On Tegra234 NVDEC firmware is loaded from a secure carveout, where it
> has been loaded by a bootloader. When booting NVDEC, we need to tell it
> the address of this firmware, which we can determine by checking the
> starting address of the carveout. As such, add an MC API to query the
> bounds of carveouts, and add related information on Tegra234.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

