Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE31733F7D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 10:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346258AbjFQINH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 04:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjFQINE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 04:13:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF162733
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:13:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-987f7045f9aso12519566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 01:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686989581; x=1689581581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9XhF1AbZgBc4w90xXvzVaGHxO7u4rSN46uhBHv0hS8=;
        b=Hj2OV1ESAdQP+iZRBErFlbPxNOYXc7f/oc4frykipndr7yM5akNzNjVxG8kWrKI00V
         tPLVSECmWbYViuiKxJCaXvwZTUt/i1i5iLlDAdF+Zz8TjS6ALo5G9uDk1R4picB6NEt0
         +czzvzzYnHscyl0GiQuxM8DfU5yF9WgYR+zfuJWTYqmyKpOm/fDBAPqA492P63/ikRp0
         5mT5cx47tYMC7vPHdmBMn5+ieA12wX71ICmaBNenhuBbEb31ZMpkvi3ZfVBacqcXkOhq
         TDs7ZPTKbQWRe87ivJ8LFnlfp9N2V3y6Eim8rxH9UJec0C5swEBCF4D8jjI0+yHNtnPX
         Hvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686989581; x=1689581581;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9XhF1AbZgBc4w90xXvzVaGHxO7u4rSN46uhBHv0hS8=;
        b=H4tC4lgBK5mjNdBR0na+xF6Kt2RTo7BNZ4mVfhXAsN4QV+4O+HbPLqtSJOyxlnnO/X
         +k83MYobBXTaY7bACifyoy7On808iYBoVzIpERrDf2Xidz+Twh2XA28erSnij7NKFWlA
         zhGmDuF+OKham/1J9iJ3/nIccfiK/NmHaDWMbocHAD8PkC/R4Gw98nxuHHgFDH/RzyNz
         5Lw5F+6neOeYlOV/UV9UsQsEdYfVfyQgXVbA/MSna+Bs3c0qIkStK9PxVuHfauiqxzji
         wEcAUbD1WU4V0TQSZoxgN7Q7lOMghQlPkY4NBbGsOdb7asfEISfWiKTF7WyqEJKwKilB
         Fl7g==
X-Gm-Message-State: AC+VfDzodhh9klyuaG8nRk3CZwftcvn9OZeWddX1fVXycC2GW8qhouCM
        Sz4n0KMrIwM6Cq7YoEuJeqfbLA==
X-Google-Smtp-Source: ACHHUZ7920VxznNipQN2HN5RuxDHXyv+t2OsUpZfL85ldT7SzJwV3ez4MBscPpHMuJ/Pvqre182xgQ==
X-Received: by 2002:a17:907:96a3:b0:96a:1ee9:4a5 with SMTP id hd35-20020a17090796a300b0096a1ee904a5mr5224523ejc.8.1686989581460;
        Sat, 17 Jun 2023 01:13:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id kd14-20020a17090798ce00b00965a0f30fbfsm11749931ejc.186.2023.06.17.01.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 01:13:01 -0700 (PDT)
Message-ID: <3509622d-81f5-6687-ca27-5e4dc28f99dd@linaro.org>
Date:   Sat, 17 Jun 2023 10:12:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 3/8] dt-bindings: rtc: isl12022: add bindings for
 battery alarm trip levels
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
 <20230615105826.411953-4-linux@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230615105826.411953-4-linux@rasmusvillemoes.dk>
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
> The isl12022 has a built-in support for monitoring the voltage of the
> backup battery, and setting bits in the status register when that
> voltage drops below two predetermined levels (usually 85% and 75% of
> the nominal voltage). However, since it can operate at wide range of
> battery voltages (2.5V - 5.5V), one must configure those trip levels
> according to which battery is used on a given board.
> 
> Add bindings for defining these two trip levels. While the register
> and bit names suggest that they should correspond to 85% and 75% of
> the nominal battery voltage, the data sheet also says


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

