Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CC45FDB48
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJMNnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiJMNn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:43:29 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3A1162CA
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:43:23 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id h24so726046qta.7
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=92Wr9RbYlDzYG+EccbOZ9/lA2+u8rVgqL8BcyqXuSl4=;
        b=MKZu94Otqs5Xf0Ps1VSdRaQ+O1BRPqeX4mZhRhqImrygdnhYfbChLV4NFuAhcwbUGK
         c/VPuLXYOPRlf6JAb104HlkvecWkCmJ2s5Xuh7/AKhndNMy7DE1IL6pwiQCuQEsu9coW
         Ch9j5DkoB6gsR2owE2VBSKTzi4OxJhridsLkafLPWIyaQOyMJVRb+e9nxBqotY0lpDxX
         95S6Y6ET2OKRUb6upZKDd5QRPGxSfyIRtYhfm0itycTz914EZ8PESR1bRofD1rOnA2nC
         06xRT6Dg07tu1d0z4wj3z2l57M9GPwpt2rKs9MfuLY6p9A6zoMnoKZfmmoPty/i9IZ9V
         EAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92Wr9RbYlDzYG+EccbOZ9/lA2+u8rVgqL8BcyqXuSl4=;
        b=g+GssaPNYRnubFtlGNIOyTrybRXDaVv1ZAzDZO6XwtdG573+BUajgn++Eu3v6GJPSR
         OfFqzbdlFVkf3TEhokYG39fjnWj9aSWOEYCpOuzgmY3cq56tpj0WREwKcRLJzuxihykK
         6H9XeWY5jBkopTRaG9IOHgW+Gup/+Myi0tpFNuqbKK/Yx2VGsMxrb7F0kFvRRayLrfkZ
         JZH6wW6Ovrt/7t8RMZDvj8/JiD3QsYK6CKoi69upNt2XQMhjfCkrWLt14tG9bbydPKoj
         ikMEl0ekcDR9z+qOcFNMYzJypDIkEyR0SMNJH2lueG7gfos9KdiYW+QqAqr9uC49ubXK
         87Mw==
X-Gm-Message-State: ACrzQf294cpUJmfcBIRXeYAIZ7nGQS3QeX6VmlAdQAjxMBLA6BH0j2rS
        Et18UMzjeT0HT/raRiOgpOtzDw==
X-Google-Smtp-Source: AMsMyM605VOR6HMK7CjCsVkJqxtfwVeE8syTVS6wiDoJl7FR6ur1tCmC2CXMF8svi2SV5uQj5YtrnQ==
X-Received: by 2002:ac8:5b0e:0:b0:399:cbf2:4acc with SMTP id m14-20020ac85b0e000000b00399cbf24accmr17353930qtw.208.1665668602728;
        Thu, 13 Oct 2022 06:43:22 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a448400b006cebda00630sm19408696qkp.60.2022.10.13.06.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:43:22 -0700 (PDT)
Message-ID: <99652775-8921-9d4a-193e-20d1487e6759@linaro.org>
Date:   Thu, 13 Oct 2022 09:43:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/2] dt-bindings: arm: add samsung,starqltechn board
 based on sdm845 chip
Content-Language: en-US
To:     Dzmitry Sankouski <dsankouski@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20221012185411.1282838-1-dsankouski@gmail.com>
 <20221012185411.1282838-2-dsankouski@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221012185411.1282838-2-dsankouski@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 14:54, Dzmitry Sankouski wrote:
> Add samsung,starqltechn board (Samsung Galaxy S9) binding.
> 
> Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
> ---
> Changes for v2,v3: none

Where is v2 and v3 of this?

Best regards,
Krzysztof

