Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47835FDB30
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiJMNls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiJMNln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:41:43 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6135FF58
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:42 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id w3so1046355qtv.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkTxdOquiAi5I+vuMel1T/4RhRbtpcgEF0HcWwU+BAo=;
        b=dxPnKWjhdOCY1p/3NAsVMqmZ/k0Nyp54mbcCwSwCXUsbzY1uxmv1O4iq/j6YAgVyXw
         VGJWoqgSbm0rMivNEeLINjUainAwyhAbW5+GxliRJJbeu3OqkD+p03xfAiSGMm1ejVAS
         eAl5SZE6X6uMy6yge0kqw+IhvRV7qgEgIU9A/lAjWS3pGPCgvWfdCtf+X98gYzaZpqh6
         7Oo5aQP/pqqWowBMeB+O4fHmCJw5j1su7qUwuh0J9EgZVGIW02HWiUTpxFFY7CTWm8hn
         brLKVSa5jG1sHGnYdbSJKIFOiTeFTBlV3uAI+r9hsUlw8lns93j8fLhG3Sc81ZaRrD4+
         8Udg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OkTxdOquiAi5I+vuMel1T/4RhRbtpcgEF0HcWwU+BAo=;
        b=k2bVy9/1uzLZiQvfHcqcKCyQKuoqiwRoyEsO9TOWWHxGPW+TdUgdVnTsmRjSCflW+Z
         qm7cp+O1rFgbgghuC9uZYzKqkhvtwf0IySbc06zWy0pbEBLWXIkOrZcW9IVWhWubph+R
         8K9wAO2qyqns2P1UPXBZW+lHB05+gE76/XzIj9ukIVILaBKpRzRdiZEZf3+r6/jdCVUE
         rVpLL04qQGcHmiMVs1eb2iS50UXYZWbMEeUZ0hpCdkFj4+QYI20FR3CiTLVD+9dJ4z3P
         p3mlIyICTq6ZXe8/yY5zlMuw9aQGD2BIJq/RUykxIf7FpBNtA/1MUJ23JtZBn10LajSZ
         12nA==
X-Gm-Message-State: ACrzQf29gW55HOpKpUwqHnS+7nDgz2ocs24GTWOJEHPzAxtcm5M8N8rg
        LEE+q+YM+OOuh5trJAJMpMVJ4Q==
X-Google-Smtp-Source: AMsMyM5rtgxeDmnURZbGAhdih10u6/L3PE9MvIASJRPGxn+jjxYUx91Hl0Jns6M7KNIQx+5G+6evZQ==
X-Received: by 2002:a05:622a:64b:b0:394:d7c7:b938 with SMTP id a11-20020a05622a064b00b00394d7c7b938mr27498893qtb.283.1665668501953;
        Thu, 13 Oct 2022 06:41:41 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id f14-20020a05620a408e00b006bb83c2be40sm9725523qko.59.2022.10.13.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:41:41 -0700 (PDT)
Message-ID: <e1e8b136-4be4-bebb-71af-fa3eed02272f@linaro.org>
Date:   Thu, 13 Oct 2022 09:41:40 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v9 0/2] add device Xiaomi Mi 6 (codename sagit) and board
 binding
Content-Language: en-US
To:     konrad.dybcio@somainline.org,
        Dzmitry Sankouski <dsankouski@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20221012185245.1282599-1-dsankouski@gmail.com>
 <82891b0026f8f43b266245c7c0c85a98@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <82891b0026f8f43b266245c7c0c85a98@somainline.org>
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

On 12/10/2022 15:25, konrad.dybcio@somainline.org wrote:
> On 2022-10-12 20:52, Dzmitry Sankouski wrote:
>> Add initial support for Xiaomi Mi 6 phone (codename sagit)
>>
>> Dzmitry Sankouski (2):
>>   dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip
>>   arm64: dts: qcom: sagit: add initial device tree for sagit
>>
> Looks like you resent this series just to add the A-b on the dt-bindings 
> patch?
> If that's the case, you don't have to do it, the maintainer will pick up 
> the tags
> when applying your patch and an essentially empty revision just adds 
> confusion.

The ack was ignored in last two previous revisions, so the resend was
needed. Maintainer would not find that ack...

Best regards,
Krzysztof

