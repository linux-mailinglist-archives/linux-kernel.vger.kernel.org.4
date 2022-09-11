Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DBF5B4F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiIKNf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiIKNfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:35:16 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425726546
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:35:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o2so8510481lfc.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 06:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=QlVRgO/cxLzkQMXlTq+j27uwBVDl70ffY/8cBjcxA7o=;
        b=J54BrCgxF4HVfOhDGi30ygpf0pUi3CG1IwNZTXXn7aL4skdmFnlp8WPUWiBNX0Fu2b
         0If6k6Q5p1FHayfINaA4DoshW4hQ7S6ynyXRP/R94I8BXnaIG87G1r9s14YQqJDr5Nf/
         NOIRRsP+KZ17cQ2cRfZ00X3AOO7JTysmll93g6i4a7u/Are18m+oPb+rpMdVYa/xh8Wi
         3aejEEUcLsO1Jkp9/N9okSom9cESnjsXgeXPxDZB/r453KAeo84AqBtKE0/snWa1R545
         LSrdUp1+rTJHnpr2OD6C/dEZcvhNma2gx9B+heDAMt/In5wIDFzYt+35ZS5wuT+eixFX
         Izyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=QlVRgO/cxLzkQMXlTq+j27uwBVDl70ffY/8cBjcxA7o=;
        b=aGMEir2ImSJIvNh0xZB7UtzbtR5hxLUqpHKqrkqYlHy9RzlGLqrCz130CSAeo9UCjt
         OwdrfZqimWRvLV8oZtNF3qeDhkT8+NlbhRvQTtjpstkz0V0lUWixwEvO8cpKqMhFJAU9
         7yV1tuPDNCThuBw6y4+rF/8kBlOuBE5+EKSR1iShyODvPAVDjhtfL4QJa/MDmGplojaJ
         e9O6h2Fo0A7DZdU48VQCGPXzT0z2aOOg+3172nb0QohNSxNSmHivaQ9h5p3c41jOsyo1
         MtXW30heMoNMTTOvMeBmTzOZV+Cjue8ctYpn47CKcljWRr8DahpWXKHWiKL6zlvGqDiG
         Y9eQ==
X-Gm-Message-State: ACgBeo3SlrVdd3cRUM1/a9W0pUXHs873faClruPhMSOurqmqRuN5BfCF
        MbjFBJRzdJ4NNbeag41HpHcN+w==
X-Google-Smtp-Source: AA6agR61CK8CK9Swd5vV7gek3vz+DGp2FC0Jgm0BFfEyQtU9+TQN+EcHbpzoO7UZssxwhl2LR9uQfQ==
X-Received: by 2002:ac2:5107:0:b0:497:adac:7305 with SMTP id q7-20020ac25107000000b00497adac7305mr6451873lfb.32.1662903312669;
        Sun, 11 Sep 2022 06:35:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u13-20020a056512128d00b0048b256bb005sm618836lfs.49.2022.09.11.06.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:35:11 -0700 (PDT)
Message-ID: <9c7b977c-841b-68d1-505c-3dfaf86ad9bc@linaro.org>
Date:   Sun, 11 Sep 2022 15:35:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v9 3/4] dt-bindings: hwmon: Add bindings for max31760
Content-Language: en-US
To:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, jdelvare@suse.com,
        linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220910171945.48088-1-Ibrahim.Tilki@analog.com>
 <20220910171945.48088-4-Ibrahim.Tilki@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220910171945.48088-4-Ibrahim.Tilki@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2022 19:19, Ibrahim Tilki wrote:
> Adding bindings for Analog Devices MAX31760 Fan-Speed Controller
> 
> Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> ---
>  .../bindings/hwmon/adi,max31760.yaml          | 42 +++++++++++++++++++


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
