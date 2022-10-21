Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A389060793E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiJUOI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiJUOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:08:49 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6782427B08D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:08:48 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id t16so1858448qvm.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FDpW9MuItpEEuLlVcO623NSEy5PTS82MKHndJKcp4P4=;
        b=FknzDeb6kwCVQhetoOYonPLJPrt6MkwaGIRwnZpGhMH8vmpxpHVyAZY0TsRK1lVX1O
         Yrev2dI+woizS5jil4oPn/Di1STDFyoqGO/smGrOVh5R8vtIKbqWbgSz09vDhX8ObPOr
         XxehgBvi6NlFp4+8V9S4JqZziduC7xMxVegX8+0mL70pB31ThAeecwdylJLKJ0zx1Y0M
         Zxr208jP5vmfohO7GctBYY5Kz4GB+cSuM6LHV/ecv+qFs1X56x5t1fZspOtSR1G4ADuc
         R/96O+aCLzcyz9qFuQCdF6wC+1M1mpS4ON46RQqYHkPQby3ahAmJBzWFNofCLnZcMM/f
         X1EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDpW9MuItpEEuLlVcO623NSEy5PTS82MKHndJKcp4P4=;
        b=VKwp6qFBbPAQn+n867zaEGh/LvzVAHiRxAiNlYF9q/kRdnSKqfQHFcDllc0KgFTfSy
         D7fDpxeuJ6gcHwdHuHSo+EADVyJ/qX1Do58r8Frfjg9IVFs6Nt/2I7BRPz7gN1lehdCU
         HyeCIFl7llrVYdrBSR7iHDNaHFaGIVkbl1i83cpVKC35SWAJgpwuKmPLoaaEzLY5tgmM
         zstJpZGDT2bUO3vt41BhBxR+++nbMUISuD9msn+WZq8CFtfJEYjPfIN7f3uc4vV2vEe3
         OqpYNHy1HcXRqpX7MG1CAjrhmbf21OJq/jk8EqKsovxEI8JNnlTReSzQmLHSHxBwdRd2
         pgOA==
X-Gm-Message-State: ACrzQf1FRsj8SnqLl17sJXOXjNmvkBzlpYEQQskOfnCaEaU3IRPeJ17A
        YwC+dqUC+Py9NYlRv2lCNYqMBA==
X-Google-Smtp-Source: AMsMyM6gK0gVC/5ZGxarVG+5fmmBYm+HfyJDkLzToIH6frzg4nPdgRtn9wFVWVDlIOm+inG5eYxdZA==
X-Received: by 2002:a0c:e313:0:b0:4ba:3ddb:cf01 with SMTP id s19-20020a0ce313000000b004ba3ddbcf01mr4990287qvl.41.1666361325241;
        Fri, 21 Oct 2022 07:08:45 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id s7-20020a05620a254700b006af0ce13499sm9791068qko.115.2022.10.21.07.08.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 07:08:44 -0700 (PDT)
Message-ID: <b656b2c5-3f2e-a808-b86f-796dd03127b3@linaro.org>
Date:   Fri, 21 Oct 2022 10:08:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: pressure: meas,ms5611: add max
 SPI frequency to the example
Content-Language: en-US
To:     Mitja Spes <mitja@lxnav.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221021135827.1444793-1-mitja@lxnav.com>
 <20221021135827.1444793-4-mitja@lxnav.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021135827.1444793-4-mitja@lxnav.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/2022 09:58, Mitja Spes wrote:
> Added max SPI frequency setting to the example. It is now honored by the
> driver.
> 

This could be there regardless of driver support (because it does not
matter)... anyway:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

