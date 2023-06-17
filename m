Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 959B8733F86
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346308AbjFQIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjFQIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:14:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE702737
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:14:00 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-51a200fc3eeso2161382a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686989639; x=1689581639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7OBFmnPFYTFTLjcdmiKMIExGB0HeYKYxdFV0TGmR3s=;
        b=QspwaThYA7NiljMSqCg8A0Qx+5EF+VSjv5Fmf3qeYS9/DCjeg5ownffTXEvnS7qlAo
         7e8vhZtX61oyNxIB9McTJRY7/LYuXe0oX+8obGvExXWPEmXv4NE1up4iFN6RpNfL8lnh
         bzHb/QijvMWEn2n8/CgJJzd8mWs4icpIDoipljhmWw/XEbQD6hZlbv7nKTyrXr2tUhdC
         yWCn+duSnEJ0hsvT9CPmLAvbkceCfha+GVEdOBcFTCqnMQFml9Kn9XDSQj0RB/b7FkOf
         vs8yZjtQMIO2eYj0BQJkVTI89xia5kMUdUm40cLQEYC2opBlfkmdU0me7hCdYVEoH1W4
         p4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989639; x=1689581639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7OBFmnPFYTFTLjcdmiKMIExGB0HeYKYxdFV0TGmR3s=;
        b=io1KcArEt/NWbQ9viuQlvuYltdxyk5NhBifxeVO6l2aTncrL/0VA7VxQ9OousQ98Im
         nYPePD6JUHYh4jsyDRhtp6+k17z7iCVooyu9uZHcZBcu6yMSm3/o05YGEj18km1PCW2f
         jL9yA2ppo5NtW/F3Bqu8Po8kuw77QQ42kV6MX/0R8GC6EAoNLSwLIewrKbcZ+Lc0IgWe
         MNYWjBhuCUeAvXWwXvMRKzfeMhvB83U4EfkyBFntwJGjRqhypEqLFiatdJgbkOaxnjqs
         DCb9mLjuMqXmdotswTbcxm5JtGrfautjjtFqOkpEfa2q1Zc47x43C1AZOBzUJtU0BI/i
         f1jA==
X-Gm-Message-State: AC+VfDzVx1Cz2y8iWGeBk9lBdH4ngBxYbjL6P/jwcX3xFE6WPO6DaYmf
        PSea6iAzmQXyvbdaK82T88qKqg==
X-Google-Smtp-Source: ACHHUZ7NQKD4xlp0ToGZ25NSrJkwcHs0DaLF1+JTjdn5QGAZAvklxafouqIiBfei4cR85m4gSwmwrA==
X-Received: by 2002:a05:6402:1819:b0:518:670a:7c57 with SMTP id g25-20020a056402181900b00518670a7c57mr2959109edy.14.1686989639468;
        Sat, 17 Jun 2023 01:13:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7d883000000b00518927ff233sm3845526edq.41.2023.06.17.01.13.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:13:59 -0700 (PDT)
Message-ID: <e2e10171-e830-f403-e134-3722293b25fe@linaro.org>
Date:   Sat, 17 Jun 2023 10:13:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 7/8] dt-bindings: rtc: isl12022: add #clock-cells
 property
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-1-linux@rasmusvillemoes.dk>
 <20230615105826.411953-8-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615105826.411953-8-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2023 12:58, Rasmus Villemoes wrote:
> The isl12022 has a dual-purpose irq/f_out pin, which can either be
> used as an interrupt or clock output.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

