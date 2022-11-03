Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB42618A10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 21:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiKCU7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 16:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbiKCU7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 16:59:36 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB3565C7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 13:59:34 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id mi9so1988743qvb.8
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tElYA2M/FixcQuYLyiZJm+paAARbaT+RdNA4PCKWIRU=;
        b=XzyHlq6kFEDY+ETiGomS+Vv8HG85WUf87yX0o4pivBLWM2ggANiSrMYpxIkWdaMXlc
         kHOmerpMy0iveGfmWAihqXrY+5ktr9V/WbwaOEQ/FXQCMIE+QvZ0lQ1pBc23VuW0dQ7T
         7rqRpmYZEf38fw/bf+Jotl5lV50Dj73Tv2z9FEi2KNQvlfz9bzJUzGNyEvRDZcFdlMr4
         +yiN/8nW0m1uphlZg+haWCD0m9zRXdWlXIZVHtCVV0HcOZmAoBnwMzkKx7aG4bHnRcBo
         csRo84nwt7/YX4aV+lgOTPXcJ3X5TlV/k3c89Qf0Cu4qt3lPK9kiQ2uE5M5qNaidIQB7
         OA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tElYA2M/FixcQuYLyiZJm+paAARbaT+RdNA4PCKWIRU=;
        b=ZNN6GbAbtMvitScMbm7912JjzJpZaqyCqZnidqPtApUoj1n6pr+fZVDJFeUcVlUutb
         /B/rIdCJwEZeG02hm7IguPP+X8jR4atVkvVeo3q1LLV0M9R2SZtVxVy7u/fW2BQp+fxD
         wRTpN9C9kGkrquS+vkBoVln25Dj6P4WWx402Kz5EDizLjqxZfvtSCYjE7AFvYJ4eUOT+
         fcuxXbiC//YqcYirI2GP53QD2CGL72wE8WkhaGaEiiPPQGW6JIWlntHxG/6ZG1bZEjSX
         OlAFmWWgudUCZ0o3oY7fLKPO+zGwXtDBbRqf9zb3PUc0eHJrLlib0JPn+lg2w0pKiTMl
         EKvg==
X-Gm-Message-State: ACrzQf36vZWvXqxmko6Ej15Q4I92U1gXMn/GgYK0pteFrR3/rYR9xy4B
        yfqHZhIqII+lmkojfaJ6aGnhOQ==
X-Google-Smtp-Source: AMsMyM48VLW/EaI7hvtYsqxGujP68e/eReXcWUHmohHgFaor7Xwr/mS7EhrDyA0sblqDroQ0vMq4+g==
X-Received: by 2002:a05:6214:2a87:b0:4bb:e62e:4713 with SMTP id jr7-20020a0562142a8700b004bbe62e4713mr23942460qvb.2.1667509174019;
        Thu, 03 Nov 2022 13:59:34 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id v20-20020a05622a189400b003a540320070sm1258979qtc.6.2022.11.03.13.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 13:59:33 -0700 (PDT)
Message-ID: <440c0d34-0eca-7180-0c8b-e924ca9136f5@linaro.org>
Date:   Thu, 3 Nov 2022 16:59:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] dt-bindings: timer: renesas,tmu: Add r8a779g0 support
Content-Language: en-US
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103204859.24667-1-wsa+renesas@sang-engineering.com>
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

On 03/11/2022 16:48, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/timer/renesas,tmu.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

