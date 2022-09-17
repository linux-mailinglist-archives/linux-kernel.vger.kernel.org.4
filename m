Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD435BB9B6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 19:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiIQRJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 13:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiIQRJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 13:09:44 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845149585
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:09:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id k10so40342059lfm.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 10:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SLP3iwWcb8vpfCXgxEBr73mGdccvGbLZXYgUBtgFvPM=;
        b=crVM7+ABnE3qNeY7OlwgC0qKglNZkxppWcjK+GcBZXcN9cV5uYRvG/ACwCaVlHsoOh
         XZ/EM44HOJcTqHvO26BcgZKjIuxgeeeQ3MlJ6hCnyP4fuvgz3VT+pfeR42tF0/8QKTqP
         wZYPKK5mXTU80aF1a0El8qmWoKzxLTv5XBFeT2uY+DIud16K7cRshLuTgCha+/BJ6ilf
         2eofHo2uX6tAF4zZ3aYpXn/jxUknzDe3zEQ5xYGwZDuA0TjfkISfheEJob4btc2frBPz
         QtcvIyL0FxYxo6/80yOo6xQ22dkrjnaWgJPyffujjpGMeuAZpRGKu2XLTQcG5YUcrRTN
         0MtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SLP3iwWcb8vpfCXgxEBr73mGdccvGbLZXYgUBtgFvPM=;
        b=jUHFvYDRPuJUoTok6FA5No26ItBvB2UCRGAUZyoFxvnqxnn5JQWZnV13YxiXimDjKO
         e3lMa5gK9sR1q4eVY1slRayngTmZrtT6BKsicXKVx+jqXuKmfDxWS4SqD3oj9+qOTZc3
         noTJCRWv1fqQpQiBC11FTJUEdYvMO3oRetugn/kJkQvLyFIsJDMLSR12djMg5xtmV1Xi
         Jxf04w7O0BveFIO2Dpc30e5vHlD817m6CYy7cksY75vFKzE6t9jMxJ1oikHlI4H0oBfJ
         BC1j4PZ+MmYiIheMO0EJFUb+lC43ieVL4zXLUxbc65IxWjJgYffUzsQKyQmbcSLYHH2H
         OjVw==
X-Gm-Message-State: ACrzQf2eEwdjohUzX1uv48lTPQ1ammuclT4SE8WX6/lqKKrKWAMhL2w1
        VtsObuze15T6OTZ41ULx87lE4w==
X-Google-Smtp-Source: AMsMyM4uC+rtYSSNzBNLSiiqZ1q40ixdY1cYCBO+UjtSucRUQMekWA0d1jgonupWx4VRDSfUl4drUA==
X-Received: by 2002:a05:6512:3742:b0:49f:53b6:4eb0 with SMTP id a2-20020a056512374200b0049f53b64eb0mr2577055lfs.184.1663434580950;
        Sat, 17 Sep 2022 10:09:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i14-20020a2e808e000000b0026acf2ae007sm4211980ljg.89.2022.09.17.10.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 10:09:40 -0700 (PDT)
Message-ID: <7cab5aab-4c10-8afa-2486-6b29a3acbea3@linaro.org>
Date:   Sat, 17 Sep 2022 18:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] media: dt-bindings: media: i2c: Rename ov8856.yaml
Content-Language: en-US
To:     Prabhakar <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220916110955.23757-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916110955.23757-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 12:09, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Rename 'ov8856.yaml' as 'ovti,ov8856.yaml' and update the MAINTAINERS
> file entry accordingly.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
