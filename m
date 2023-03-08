Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B586B021F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjCHIzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjCHIzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:55:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB5984F5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:55:37 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id cy23so62559140edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 00:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678265736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jQ1nOnikne88DPW0Xfw2WODiDln5gsGZDJ4DMVG7to=;
        b=ayaBBZGw32k5/6PePoDorTTj4QnhDUZ2Id6iazXimpTQE30uSZooYEeT9JRgNjWDTC
         dc+nzv4MChkbmeTpumOMk9ve9VlNfQXTgLmhI//ocnxxh3Id29UIdK95zU+zkeBFw6ZP
         +KNs4dQNRcI9wd4wHNlbl4X40eYVIEWbhlDPm/Jxai1Wuw1fvK51aKwZCV84Q6qN1U5V
         lBDRFhEz/u38yUUYjlderifFi9b9dYHUminH/u4rYaooeo8S3FCqgSIJhuudpWKFp/d6
         xkI+yQuBYHC+vekXVxoRuy0HleoIsjAKPHJmH5rsMyPNDN7aJ4KnFkD1xzqARPwU+7P+
         SNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678265736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3jQ1nOnikne88DPW0Xfw2WODiDln5gsGZDJ4DMVG7to=;
        b=qkNIbev1ULR1B9L2z9JDjORS2S0G2Pk+t02ylQLUOS04kmzrfyjm2N63uw42KK0xNJ
         TvHiR2gNTgWEco4XcdpUSTm/IcvCr8iRt0bbgULYaJY/Y9ri2GPPTXxSgUjQ9NbFxjpv
         YW62MG7GmzFxMrEF5875lcAd3/gLNPUj3O4awcZRCuurhAjPNckA/M7grXBg4OaSrOur
         M8Gj9YZjE8D6sYbuR810SVXn8dFMr52a0LrzsicR1PXjKZwPAx1RB1Raiv/9apI1KvL2
         TwiY43fJBnplkjD/5F7V220IE+rHNyxLgBc9uXvGDqd+c/8P1xdnLBsAkLefucm94sM2
         /xeg==
X-Gm-Message-State: AO0yUKU4GGMy1d9Xo2Bxf88jEYqHkCjhWDachSPJUndZb/h0/r7NuH3r
        OS3QBGE1YWZqaMssWnSG7qrFSQ==
X-Google-Smtp-Source: AK7set9z/LLx8wdi8M9r0DeujF5+eK+nIkDWrjmN+DlO49GYQlsHQwXDe0gBIK/In+kvp6KkpubtOQ==
X-Received: by 2002:a17:906:11c6:b0:8b1:3191:286f with SMTP id o6-20020a17090611c600b008b13191286fmr15995185eja.25.1678265735892;
        Wed, 08 Mar 2023 00:55:35 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:bba:fbfa:8aec:a133? ([2a02:810d:15c0:828:bba:fbfa:8aec:a133])
        by smtp.gmail.com with ESMTPSA id q18-20020a170906771200b008cc920469b5sm7304239ejm.18.2023.03.08.00.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 00:55:35 -0800 (PST)
Message-ID: <fdedd6c0-ebe0-c2ff-b7fc-4ae4d8caafe3@linaro.org>
Date:   Wed, 8 Mar 2023 09:55:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
References: <20230308083759.11692-1-clamor95@gmail.com>
 <202303080844360ced8b82@mail.local>
 <CAPVz0n2XErDOCERV+XO3ek4_15hiwTasy4agLZLijqx2z67UnA@mail.gmail.com>
 <df35ed19-74d3-5eea-8efb-588417a417f2@linaro.org>
 <CAPVz0n0N=ChOatodt_W-cAne6Tqwa-1crUjWLuHf1HugpNLXuA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n0N=ChOatodt_W-cAne6Tqwa-1crUjWLuHf1HugpNLXuA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 09:51, Svyatoslav Ryhel wrote:
> Ooof, my bad. I will resend v2 with fix asap.

This was for max77686. Other PMICs have their own. None of them is
max77663, but that's another topic.

Best regards,
Krzysztof

