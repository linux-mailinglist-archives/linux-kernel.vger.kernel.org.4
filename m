Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B54D64410B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 11:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiLFKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 05:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbiLFKL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 05:11:29 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0D323BDF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 02:07:21 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b9so16645457ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 02:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMekL2LEk3JOOHB+JWji+lnO2nhMD5gf3MzPJiCM1Gg=;
        b=zUSRpnmTc/RFKY0PPPOizXNQWMOmVuMoluFjVWCiV+y0JRoq9PKRKsnPLuWkRfegVy
         lvfZ9F21HyLiXCuIwExrwL8Z5jwN1Dxx6yqN62A5l9sxY851fdyR0uTwUk+aZMr00KNE
         ihmWwGw6PhJVPHsDTKorJinY9wBcTOvku5MmtsXEVIIunRv7pgDWnNZGdNdQENhYaVEj
         nzFhav+U4nd+ot6HgsbLRfOE0P6Lv4rwKdC20iKoRYXHE2RIoB+bRQsSHAXCUicFTJO0
         fR3jtohuRIdMNBSLfJsOzxCe2JOVL4ED/rtPpZfW1+VJEfaQxw4Niv4bP2x/I7KNzAKP
         D0VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NMekL2LEk3JOOHB+JWji+lnO2nhMD5gf3MzPJiCM1Gg=;
        b=1OwAMka7trh3Uk7q1p8ye7SaWmJZgifHSVHu00ZCdIxwLPksC/qoqkhzyKbuwjZ5CW
         KiOIGnXC+9/aF6WFfbOPQyxwCoEgmJriCiAGCi9l4qS32ImgiKvH6He7eAoLZgdU71al
         tq5anwwAmEOzKNgcNtCUAKpIcWzU1ug2qx5Y6sPR6+A0Gp2Achyk8n5dD5VyYjCxa303
         wZ/0cfNxiExwzCKcT+AMQ0e2dlok4+sx4YmLV7+GALswGy8gKxdW9g/AkrCunGIMY1AA
         6aELw5D357sjFliOpb+FhiJeSPJuOZHxXo1AgueRylAt3UnLiYwsuoqpmYu7ag75aaRx
         xwfQ==
X-Gm-Message-State: ANoB5plU7fEvp5hS0JY6LGH9HEoV9MMu0ZLlbqVSbDQSSN0+L1wMNir/
        OGWYZq8qID//IVA8FNsBNgNN/A==
X-Google-Smtp-Source: AA0mqf6ypVuG5zWj9XR/Lb4mql4LSQssNDupVw8L/tQ9hJunntmG6nm4nXjDV75baL3SH/xhfVddEA==
X-Received: by 2002:a2e:b0ca:0:b0:279:c096:2e8a with SMTP id g10-20020a2eb0ca000000b00279c0962e8amr9625320ljl.433.1670321239588;
        Tue, 06 Dec 2022 02:07:19 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u18-20020a05651206d200b00498f23c249dsm2414432lff.74.2022.12.06.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 02:07:19 -0800 (PST)
Message-ID: <853c1bff-f657-8696-e927-5b5278593234@linaro.org>
Date:   Tue, 6 Dec 2022 11:07:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v4 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        alim.akhtar@samsung.com, pankaj.dubey@samsung.com,
        ravi.patel@samsung.com, sathya@samsung.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <CGME20221129115540epcas5p370eb47c404a8d2c08ab4f264ae983481@epcas5p3.samsung.com>
 <20221129115531.102932-1-sriranjani.p@samsung.com>
 <01ff01d90950$c7768fd0$5663af70$@samsung.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <01ff01d90950$c7768fd0$5663af70$@samsung.com>
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

On 06/12/2022 09:57, Sriranjani P wrote:
> Hi all,
> 
> Gentle Reminder to review this patch series.
> 

If you ping me, then:
1. Pinging after a week is a bit too fast. Standard is 2 weeks.
2. It is too late in the cycle for me to pick it up. I will take it
after the merge window. Anything sent after rc5 usually misses upcoming
merge window.

Best regards,
Krzysztof

