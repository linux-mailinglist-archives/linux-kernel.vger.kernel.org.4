Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4906F60973C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 01:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJWXXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 19:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiJWXXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 19:23:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07155F21C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:23:12 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a24so4822002qto.10
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 16:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HpbJ/ZpvZa/C/tSJH1U/vXonAdonI45LVJUGy06h+nY=;
        b=JSmtRgL3OPy4pH2GLh/p6LAgHWy24OUJWrHHIvjNbrr6l3zffgsulKwpCVOficFB6r
         NTtq5BJDtLzO/HPGSHAUmFCxawP5NODck6ewfI9LaTws7t2qA9e8dG3S+KUgmdjdCM9e
         jwUjftVHIqi5qMjwmOAquHq0UF4IpeFrmuE6Y3YgjeUCzToY76JBUP4dRRBVD+b4W+gF
         mq9W0mP3O84eJdJ2yQrmUkJA8o24xGurDL3tgAeTVpW0DtPzMWMpU9Etayd/YFR7VFLR
         nfE0bX9QEP/n6zsPqZAt4pzKv0e0L5P/RHclaUns4OqyVqgyc3OZFUr6NT8WXXV4E5vv
         Fl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpbJ/ZpvZa/C/tSJH1U/vXonAdonI45LVJUGy06h+nY=;
        b=d9WrkR6u08ivgS65Ue6wxyf+HtC1H9ZmBOa8OMjklHg3Nu/sRtEs9wJUpsCYCGEKS1
         mOwfaJZH1+ly/M/be7FOJUnkXcCt0Qhb2P4acQ32+zPEz2CaCKPv066YsKVEM8rDwFDp
         e5Pd1xm/CXVWD1lSoiVjUUBf5I6ktZBBb55NLqZ8URt2sqjF58xEKmXPF1VHHFpl7DI/
         8AkCXlcLgsQhH2aZB/UQDVGDuBDMEs59yOr46EZ5VtVVJadtamtw5PjseXgBBSZ7BO+8
         2eGg/tjfqTcUobUjodZ+H7NnW/vQnJDZpohH0/87hzxyLWY/OwRQrloFtxJlBP4zBcS+
         vqLA==
X-Gm-Message-State: ACrzQf2HB1Q2uvqLjkO/Rf4lj6gz7N787lnRqTy+bt5AyQfXYR14TP7D
        UKZFagsbqg6mMOZjoJazPf0HNQ==
X-Google-Smtp-Source: AMsMyM6Ex+OQdeSW/ce56Qs1Dh51QGWGzLB0khSx/uyD+aZotYjt34K4P3xNdUpsFlQSyTX+8n6ipA==
X-Received: by 2002:a05:622a:1452:b0:39d:9de:171c with SMTP id v18-20020a05622a145200b0039d09de171cmr17003917qtx.294.1666567392147;
        Sun, 23 Oct 2022 16:23:12 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id b1-20020ac87fc1000000b0039cc47752casm12433259qtk.77.2022.10.23.16.23.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 16:23:11 -0700 (PDT)
Message-ID: <3197497f-26ce-372f-6fb9-33e576cc786e@linaro.org>
Date:   Sun, 23 Oct 2022 19:23:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3] dt-bindings: iio: dac: Change the I2C slave address
 for ds4422/4424 to its correct value
To:     Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, ihkose@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajat.khandelwal@intel.com
References: <20221024175008.196714-1-rajat.khandelwal@linux.intel.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024175008.196714-1-rajat.khandelwal@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 13:50, Rajat Khandelwal wrote:
> The datasheet states that the slave address for the device is 0x20
> when the pins A0 and A1 are ground. The DT binding has been using
> 0x10 as the value and I think it should be 0x20 as per datasheet.
> 
> Signed-off-by: Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

