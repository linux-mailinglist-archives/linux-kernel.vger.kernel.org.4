Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97416D916D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjDFIYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbjDFIYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:24:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548AA4C05
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:24:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ew6so147295297edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680769449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uKZyvY+7dHlJ0SFNSLUfxjJR8//OCnc5fau2a0KRJKc=;
        b=go9MxiI7Z7xk0S10Ex0sMu7YsYpXKBbssscZbu6HRqMfHy35joTui0NPa2VPjyiZU8
         Z5AEzQVSLahVZI5e7SelkvHm3+fhAijFT9KYhPWnG35IEkyDQpyFA9A39JDE4+FHwTNg
         lnmH/j1tqahCuMgvq/s6kcjpFl6nkSWuyjRUzlqSUBHlce5SKxhWUrg2FdZoLTojHEBo
         1XtMzhvUTfC0bYNTJHc5/HStHItouoWEyIx+/W/+JSYCIEUo6bjWJc9G7nwSZjNvana9
         Hz9h5yThn6tOaACBZ+6buySixoF2ft+PPV+1wPBdJ9eRD286CT4McTwKuQD6Y5DsVXb7
         oEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680769449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uKZyvY+7dHlJ0SFNSLUfxjJR8//OCnc5fau2a0KRJKc=;
        b=sB6O4vwKSNkadzRI/jKr1BNKWAF9JUzmWAu6PxvMrztHu4bidVHyrrcPH8in90xIof
         FH7q4Q3i/zPpDnHkwzZbJVqMPQTtXdsupH1cAS/wNCNDgWX2+82HJz04VyuWbNClvRfy
         2XFm9RbViwgev2MunzkoTf/lLzbURfxebI+efpIH+nW6YdpmzxA4xQekPq+xUXb/b0a2
         UATgjvVGRSnAnk4getTmLvtdzsk+QHgs/KMtVE+wQTZQlOHIjV2hd2WFOF6TFAlonON0
         j+uu0j11pFlDUxzJvbf8mPKmRsrEw2HZaVAOFFOUu+kcRR8PXhLe4pelv04Lry/2q3+4
         8B6Q==
X-Gm-Message-State: AAQBX9fd1VE/Aobv4lp3/Qlo/e4gRs9eLyJ/mBf3zDqSfiItew8aXGiK
        ZLYPcZMXFksHv4OwPch3vIdS77m69Lapunri4Cs=
X-Google-Smtp-Source: AKy350ai/gJSvYeqcmjxrfEU+zFFq5U7pYdXX07MHDy9I6+14GxU5F+JmNUDZ1mePI8fd2k/6t7t0g==
X-Received: by 2002:a17:906:edcb:b0:930:f953:9614 with SMTP id sb11-20020a170906edcb00b00930f9539614mr7109983ejb.1.1680769448837;
        Thu, 06 Apr 2023 01:24:08 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id lc18-20020a170906f91200b00928de86245fsm481102ejb.135.2023.04.06.01.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:24:08 -0700 (PDT)
Message-ID: <1bb5453b-e464-9b5b-9e47-54a9bed70508@linaro.org>
Date:   Thu, 6 Apr 2023 10:24:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/8] regulator: dt-bindings: fcs,fan53555: Add support for
 RK860X
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Joseph Chen <chenjh@rock-chips.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
References: <20230405194721.821536-1-cristian.ciocaltea@collabora.com>
 <20230405194721.821536-2-cristian.ciocaltea@collabora.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230405194721.821536-2-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 21:47, Cristian Ciocaltea wrote:
> Add compatibles to support Rockchip RK860X regulators.
> 
> RK8600/RK8601 are compatible with Fairchild FAN53555 regulators, while
> RK8602/RK8603 are a bit different, having a wider voltage selection
> range.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

