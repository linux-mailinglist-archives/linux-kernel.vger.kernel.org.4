Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D869762B579
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbiKPIqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238832AbiKPIqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:46:12 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340C1929C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:46:11 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so28405860lfu.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AgGKNGb0LdTawy847pWTvhqLw92BfuRSU9gC6UKsHQc=;
        b=jkEXwh5Mq0/Kc5cQejc1vNWrpKLpDcBdbIul0MAhY/reqmrU/Pp0va3aLP94RS+Wjd
         5KSxx7osrbr1lkevaa3CfVzAH3XBzmTz8r+nDbSsJ+QDIrEE0oGwamqNliVMj8SSJGVs
         imTupMjXgeKtNl9s+fcC0QnFbTrL+VUm/A/FwEQAuxRbcdazWEywZuBae6lkB9VmcgIW
         Zy8ubvY036ntJx4JXIbl9iubxiU4tHlLYeeUfT78PPHpjhEb1WH0Yi3jmSbT+T6Ub1OA
         p2lsyAK/doA9qYiCjdZ6YclmUfzbiV57KFo3UiERrZ3+Wc0vEKM6xeJ3LoRL+wZQDWeb
         qo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AgGKNGb0LdTawy847pWTvhqLw92BfuRSU9gC6UKsHQc=;
        b=XoHxWrSPeu6wG9TUZ1EvybYB9vNgfr+gJsFZnhW2VgEzBAzqAHoZjrSDzHUA/yxV3m
         cnVw8kReTGZxLbPlTF1LuZMHaXaBXXII6RmXLUGJ3ebwLwQp0O8q2llebTpuKYAOcbV6
         +tf4FKXv+SbmpXshnSqiZDJxfj/Ceta+2fCMehk7teBkgIqvxrqSjmQyhaQqqVl8ePbg
         QsIS0m4lKmjomTUwlf1kZQUv9r0BuIAndC4rR/xc3eiNcZZmcyW+gBp8zp4NuvCmLHMg
         OqiBiKBoMjUZGRZr/XH3aJP5v1bDFFvFb63fu/qO86pxAV53Qs4yOdZG0FHrGUVUgFrW
         G/Tg==
X-Gm-Message-State: ANoB5pmD2bRdLqF0s9mM1tcseqd2LdAr2mPA5qUoFb1DmomEPjd+65Sr
        74Ulj8tGQmuh68FVbVgA5t/kRQ==
X-Google-Smtp-Source: AA0mqf5kQ4Pm6Im871ebqaEFtljYPZ0yK8n3ixiE9AzUvuerWheshmNMFf9TalaQmmvPd/YssAzt0g==
X-Received: by 2002:a05:6512:3195:b0:4a4:759f:9cce with SMTP id i21-20020a056512319500b004a4759f9ccemr7076201lfe.672.1668588370007;
        Wed, 16 Nov 2022 00:46:10 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bf36-20020a05651225a400b004a05837103csm2507856lfb.196.2022.11.16.00.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 00:46:09 -0800 (PST)
Message-ID: <e9d8c14d-38b3-0401-7bfc-b2bd7ab36c52@linaro.org>
Date:   Wed, 16 Nov 2022 09:46:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 06/17] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        adrian.hunter@intel.com, alcooperx@gmail.com,
        andy.shevchenko@gmail.com, arnd@arndb.de, blarson@amd.com,
        brijeshkumar.singh@amd.com, catalin.marinas@arm.com,
        gsomlo@gmail.com, gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee.jones@linaro.org,
        broonie@kernel.org, yamada.masahiro@socionext.com,
        p.zabel@pengutronix.de, piotrs@cadence.com, p.yadav@ti.com,
        rdunlap@infradead.org, robh+dt@kernel.org, samuel@sholland.org,
        fancer.lancer@gmail.com, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, ulf.hansson@linaro.org, will@kernel.org,
        devicetree@vger.kernel.org
References: <20221116010453.41320-1-blarson@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221116010453.41320-1-blarson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2022 02:04, Brad Larson wrote:
> Add support for the AMD Pensando Elba SoC System Resource chip
> using the SPI interface.
> 

This is patch 6/17, but it misses in-reply-to headers. Where is the
rest? Lore also doesn't know...
https://lore.kernel.org/all/20221116010453.41320-1-blarson@amd.com/

Best regards,
Krzysztof

