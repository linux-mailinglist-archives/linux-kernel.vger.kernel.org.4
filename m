Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B65618A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 22:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiKCVeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 17:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKCVd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 17:33:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86718360
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 14:33:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id o7so2892795pjj.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uwWaeFPyUois+zOfqfyT5ohr4xM8T8g0qeP7AoVhxz8=;
        b=L7Z7y+KThkCA7DWPiRRPAC+SFE9rBt9hgXNEz2xJhfmGVCC4AEH6ZMLdGT85/SEhGA
         Gt1ZbCWnXSl0Osu0QYpI7O16omPV8VrW0dUXwqusFX4NeO429JI1A2ArXSHm/38j5KPh
         m7zn9tEX2dYFEXMdBrM67fU9/u9Cs4jzXT+HHKYBg6jkP6qt7ISUwMVx4VvTIE7euex4
         +K6tnLbvemkaSZ3nASPXVU05+dpOfjz8gcGFRfukFj9X4avUqFy4xOj+rXkFkdcP3beE
         5WAAGyWLFMupSoxfP8o3n7y2FlmyPsqlM7wqMUWJDN/4W5wVzpYBGSCXU2k6hmEFNc3O
         xZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uwWaeFPyUois+zOfqfyT5ohr4xM8T8g0qeP7AoVhxz8=;
        b=As2RGCeiBvk95EXaQCEzlUzyFkotwXnLlvuexL9iRfaDymQUpbWCITlAo+6EUYcnJ2
         9hc9irty8TXz+O7khwcnb1D8M70+w/abISv/UHxpIa4BLM/W6SCBjgjrhSy84xZTAE4i
         yGeAtvDwHKzkF+8Kcsu7SRZYtaJ8SqIZ90FihkxmFG1okMvma1dC/BK4xVcANwvOESuf
         btWnqKwDQ/vbKWiaBwrSC+JOdjzXF4hh/EOLHr/04c5yZL96vwEv1IVrTjM+BJaSlAYQ
         zeOTeI+6SUn+6aqArcVOe7YcqBNyG6u6ZjDc5iCqNr2PNeVuCh56u6PNz87cFNp8AEA8
         /0FQ==
X-Gm-Message-State: ACrzQf2P/j+VCsuEnlhZ3au3Rb93yUIjhkML+3qSwXb1cBQCq11U2mN8
        Hfe6O//c3VM8kuYBbfqjlq3hIg==
X-Google-Smtp-Source: AMsMyM5eVZsosy0zyPzcobjPSW87XTyKBh9meympQwj1J55lzNv7IMiQvOxzN4MwFjQ25bQ/jl9KuQ==
X-Received: by 2002:a17:903:50b:b0:187:11e:5f1f with SMTP id jn11-20020a170903050b00b00187011e5f1fmr32604447plb.41.1667511235026;
        Thu, 03 Nov 2022 14:33:55 -0700 (PDT)
Received: from ?IPV6:2405:201:d02f:da6a:d4a2:1253:adfc:370? ([2405:201:d02f:da6a:d4a2:1253:adfc:370])
        by smtp.gmail.com with ESMTPSA id z5-20020a17090a398500b0020647f279fbsm439153pjb.29.2022.11.03.14.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:33:54 -0700 (PDT)
Message-ID: <47b13fed-2c31-f43e-8789-d120fce00dc3@9elements.com>
Date:   Fri, 4 Nov 2022 03:03:50 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v6 1/2] dt-bindings: mfd: Add bindings for MAX5970 and
 MAX5978
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>
References: <20221103080545.1400424-1-Naresh.Solanki@9elements.com>
 <20221103080545.1400424-2-Naresh.Solanki@9elements.com>
 <0c23e569-61e1-3eba-f9fc-4b42ed228b52@linaro.org>
 <dc6c8f79-9830-dd1b-a064-3b25a3b74a35@9elements.com>
 <613d7971-37d6-c8db-523e-cf3cbdcd5287@linaro.org>
 <b9b77873-9004-425c-276d-ea5ef8ebf7dc@9elements.com>
 <e3164343-3b0d-6672-e628-87347a03000f@linaro.org>
Content-Language: en-US
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <e3164343-3b0d-6672-e628-87347a03000f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04-11-2022 01:56 am, Krzysztof Kozlowski wrote:
> Eh, true, but you have there "additionalProperties: true" which are not
> allowed. This must be false and about leds I commented. False must be in
> all other places as well.
Will fix in V8.

Thanks
