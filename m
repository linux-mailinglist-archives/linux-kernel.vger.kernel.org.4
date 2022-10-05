Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE1D5F4FFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiJEG7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 02:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiJEG7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 02:59:30 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055D57285B
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 23:59:29 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a3so12220714wrt.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 23:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DD61bO2yXyduzXwcEA+a9rUVOtmPojUtJP0aFwD0z2g=;
        b=tDCW67H+QAR3GqjSMXyIJExNi8GYBrP++oEzYN68T+yI6I+cXVwxmbBkQmiqa1K8Bl
         hqjPsD7Kxphl/WABwIyhsS1Z+iazgiAdnPKMXqu6jrKN/kCsxPirfnZ11uVP8f3SQy9T
         rjw6PE2AtGoN6WkO7cdThNVL2eay1DnlrY3TNXxpbqScka/TUl6mFNNkEiVnT7RlETf2
         /k9p7F8PHSk0bXhp35AyFLUyskVwo+4PFF9j94iQUnHQeNDqHaCmazSy8fXhUL6myciW
         c9fNmdmYR5iwdk9oR2Bw+pGww98VD8NA2yv2/0HPYhUw+g79/xl48/4XMtq5wO+bLVMH
         b7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DD61bO2yXyduzXwcEA+a9rUVOtmPojUtJP0aFwD0z2g=;
        b=mVh+heds07RD8OgCDLV0pcBv4/6y4l/ibWWdFVtR8Je9Qo+ncMP/jKPpzvekdWMIfJ
         e92TU/YtKOhjkGYvxdFRGjoVPfyNUB06pEXT3NXpSjTeZ40o7E/63zBQffTZb7qBx003
         R8TjER+CYs0oJihNXuTkzTbKgeVr/7jur/f1r3eByui4hs0edSdnyIIHyM4WUR8uQCZg
         wa7PA1cx9g1lfZAo9eXeubrL+p20N52q4OyOb5BFTFtrd1PCrUcCcCgUn4CJ8zCe5M3L
         f8Dd5df1ueBvLZIvqNQpsTDbxg013MsFlVLHBWRSj4ee3/m5cPvILPojjAfCYsk1YolN
         /mJA==
X-Gm-Message-State: ACrzQf2ogkHaGYHZ6KbkccKsUG++mPdZpUNqiylfQqW85tzU3a+N63ye
        2IRJQk9eOBPCTrrx6n73OtIpRtnK761n7w==
X-Google-Smtp-Source: AMsMyM5MRgbhj9SJm6v0ekeV7YiCyO/O3bDlQ+HazvYgT9L9TvrbRNJ4GOcPADhhWeMW1TcHRfkKsA==
X-Received: by 2002:a05:6000:a11:b0:22e:3dab:537c with SMTP id co17-20020a0560000a1100b0022e3dab537cmr8622807wrb.638.1664953167541;
        Tue, 04 Oct 2022 23:59:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5? ([2a05:6e02:1041:c10:ffcf:b5a4:bbee:42a5])
        by smtp.googlemail.com with ESMTPSA id j5-20020a05600c1c0500b003b477532e66sm8291607wms.2.2022.10.04.23.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 23:59:27 -0700 (PDT)
Message-ID: <0cc605a3-27e8-38f1-2909-e3caf34ed09a@linaro.org>
Date:   Wed, 5 Oct 2022 08:59:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 2/3] ACPI: thermal: Drop redundant parens from
 expressions
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <12068304.O9o76ZdvQC@kreacher> <2256715.ElGaqSPkdT@kreacher>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <2256715.ElGaqSPkdT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2022 18:32, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some expressions in the ACPI thermal driver contain redundant
> parentheses.  Drop them.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
