Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06CAC62BFCA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 14:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiKPNmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 08:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238639AbiKPNl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 08:41:56 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814A72ED78;
        Wed, 16 Nov 2022 05:41:55 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c2so16424437plz.11;
        Wed, 16 Nov 2022 05:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oiJdwae1A1xSDrJX/8Ai0D9wMJGorNAzyo1cxFVuFg=;
        b=IFOWVUc9Q//uV04jXe5blsnXnYmAjlTPYUbIt3GuANBVZYoyn9L72i8qNB+FhH+q5K
         VDUc0Pj4/f1t7esAG/K3G4XAr1LbBQumraUNb6/7PQIHwT0Od1mQwuviBM8w1TQolzLI
         2OeW3Fn/79WhkC525L+NoL3RZctlrNA7AXKCSB62vFwFFSyN90T8mp1fQ+VO04RLTV5/
         wwR9Hi0EeO0juqed8omd+k1VRTIiVPZOV3UCkaZitKaXU0neFBFyWpHVEgzcWJuz1LyM
         WTH99mMHSMVKqhyA9C57Udm1JBRAjNAd4eB+Dacel3RbqN2hNn+eSr8cNQSJZrBwBCt8
         Y2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2oiJdwae1A1xSDrJX/8Ai0D9wMJGorNAzyo1cxFVuFg=;
        b=gE41ML7/M/1pMLGCyCG/G7mMhQi5JRn0Z/1u8A6Jy5NF4AV9eF/tUt4t+JRP+c22iV
         6AZVXFDK7tXvLlEgCyCpOb7HoTFamUcjhd5QXM4rWauQW6az0zSTelbOUgvVOCsYBJe6
         fl0czk+akeWLuiEsqRclKl8szuzT6VldlE1AwbuSDa6D1JR/YL2z7MltDoylmvDSRZMt
         Raw3h/HFzh97Yp9HwXSYoyKlVC9oFfWZYdIUeXBx54W0ij6HWd/bHWHRxiJkQpTxrSp7
         OEN7Ul3aVWp8/6QM0pCQ6+1GXP+OSFojasCF1gOuPwDggpZ+7h/NaKgyL4WXNSvRgYiH
         USyg==
X-Gm-Message-State: ANoB5pnllkCmxSraeutagycqS3V50JKAER0kVJlRUXLAH6ri1zLu7fbE
        Wf3lMqUjK2DS69V28jIkz58=
X-Google-Smtp-Source: AA0mqf6GQ+JgpcAi4UahQkWMET9Ne7221Qrmg0nhjTJLGJiDdR5oOO7WyKzI/O9+FGYQ2kysUAeE3g==
X-Received: by 2002:a17:90a:aa11:b0:20a:cbb0:3c9b with SMTP id k17-20020a17090aaa1100b0020acbb03c9bmr3792530pjq.81.1668606115053;
        Wed, 16 Nov 2022 05:41:55 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-84.three.co.id. [180.214.232.84])
        by smtp.gmail.com with ESMTPSA id gi18-20020a17090b111200b00205db4ff6dfsm1560135pjb.46.2022.11.16.05.41.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 05:41:54 -0800 (PST)
Message-ID: <cb64a153-9196-e7c4-14e0-bf623ef79850@gmail.com>
Date:   Wed, 16 Nov 2022 20:41:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v10 2/2] docs/perf: Add documentation for the Amlogic G12
 DDR PMU
To:     Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        John Garry <john.garry@huawei.com>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Chris Healy <cphealy@gmail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amazon.com>
References: <20221116003133.1049346-1-jiucheng.xu@amlogic.com>
 <20221116003133.1049346-2-jiucheng.xu@amlogic.com>
 <Y3SwIPnDvEOlL+Mz@debian.me>
 <7bb5e9ee-358b-ce6f-2cb5-a6b6b558c0a9@amlogic.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <7bb5e9ee-358b-ce6f-2cb5-a6b6b558c0a9@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/22 16:56, Jiucheng Xu wrote:
> Sorry for my poor English. Your writing looks very elegant. I will apply your modification in next version.
> 

Please don't top-post, reply inline with appropriate context
instead.

Also, wrap your message text within 72-80 characters.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

