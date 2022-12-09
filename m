Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9EF647EC1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 08:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbiLIHsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 02:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiLIHsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 02:48:22 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4434FFB4
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 23:48:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so5746852lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 23:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NsuZyFPaWs/2xOslubtL3bTv7xZraftR6tRWln/UHA0=;
        b=L0ObW+6jVYepqRQlOuSGYejbeGJxoK2QtyeJ8hUusQv0T1wIqZbpYlI1rbKASAM82q
         Tsuu631UcDvh3dpORs7Dkq6MOiW73wcKDfoQqx2+ex12mu7QgOIgpy8L0iKqc/Y2wxeO
         MVlQwsOrl86I/ULPLD5Pmu636m8TPx3+MzPsQbLfKWcWvb8+e2RX2P9dsW+aRBdh2nQw
         DlcubyQYjk9X3/XCK41jJeOSxOV+V69sKUyp2q1ON3R4oX9jMkWZ3rAazapizSgNtGUq
         jaN3VrungIzhOox1TjRfJNmXEPsdB51mws3POhJ7RwD/NlZ/U4kiQJ7aigL6pnMTbGMa
         lVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NsuZyFPaWs/2xOslubtL3bTv7xZraftR6tRWln/UHA0=;
        b=h0b4zFVD8D6sGqx9pLwsK1K5Kbw1S12IDcWkDOmvtHVoXgJAPq/urnQcaXsPpgWGlb
         2GFYcADz3Hipm32zDl83Dpe+ynqufSgu7/lQTV8q6L1oWGwJshL3N4QAIfOHdiXYZSVO
         KxWdbCcfwaJLdkIPJ/mCXqIIhe5vnk6zR1F8htbbNvPn0HV4rPDBG6A6PnqbnfogFkgQ
         BROMWleI/xWyJx7cnR+GfEa1NmqT+eVWjdKqXsPc9m3owJMk+nUih88FV5jva1xmNDo0
         9F5ryX6yc2qBmVQh5tQll4b1fsvDEvHM2nuhnORi9Sae2V3q5iPSJULTISU14wh4K5Nm
         ObmQ==
X-Gm-Message-State: ANoB5pnKFWCgMJbIYcle8xDO25zlQ8gjsrng0eRzNuagk85cNPJljH55
        5P+GIsdL85LAo5NCYZkWB+h4Ww==
X-Google-Smtp-Source: AA0mqf50R8kzIqUKGZ8njOLQTZPpV95PUHF/rpYhGJtY+iZVQ8Z32kmn45AQFCSJtdOmMzqch/n1Uw==
X-Received: by 2002:a05:6512:16a1:b0:4a4:68b8:f4d6 with SMTP id bu33-20020a05651216a100b004a468b8f4d6mr1739705lfb.28.1670572096037;
        Thu, 08 Dec 2022 23:48:16 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id a6-20020a19f806000000b004b5766f48d8sm155053lff.19.2022.12.08.23.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 23:48:15 -0800 (PST)
Message-ID: <41500a04-b004-0e2c-20a1-3a3092b90e6d@linaro.org>
Date:   Fri, 9 Dec 2022 08:48:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [v4 1/5] dt-bindings: mfd: Add aspeed pwm-tach binding
To:     Billy Tsai <billy_tsai@aspeedtech.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lee@kernel.org" <lee@kernel.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20221123061635.32025-1-billy_tsai@aspeedtech.com>
 <20221123061635.32025-2-billy_tsai@aspeedtech.com>
 <c4b188b1-06a4-3cb0-a758-e12942e1f67b@linaro.org>
 <27055c13-11ab-cc73-f2ba-c269785b0e28@linaro.org>
 <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <A5EA19E5-21D8-4954-9636-9B28AC8D946A@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2022 01:54, Billy Tsai wrote:
>     > > However I am surprised to see such change, so I have no clue why this
>     > > was done.
> 
>     > Actually now I see it was like that in previous patch, I just missed it
>     > during previous review. Anyway this must be fixed.
> 
> I have two module (PWM and TACH) but share with the same base address,
> The PWM will use the offset (N*0x10) + 0x0 and 0x04.
> The TACH will use the offset (N*0x10) + 0x8 and 0x0c.
> The range of the N is 0~15.
> Can you give me some advice to fix this problem without using simple-mfd?


Use regular driver which populates children.

Best regards,
Krzysztof

