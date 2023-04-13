Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9421B6E0517
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjDMDPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMDO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:14:57 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3FB527A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:14:56 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b180b1a50so201614b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681355695; x=1683947695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ksLl+u3g5M94Rsp2MK2e3lIOyx7h9PvptQgecj9BoTs=;
        b=Gwc1/xz7yShN3TYYeX9sg7dtV6rcV+AXuTmtXV2qSQxJ9mNMpgjDTBvYc13pXTwf3h
         EaNxntcdLQCOiepCPK8AvvIkJO2YwtfpLc1+RDYxP1PS07L/AsIvPmgxmY9olkaBm3+0
         zcXGemSUIeaDcM58mox7YLSUzVTmraa9ASvHSukTY25oyb/w+eI3v4bRRySV6s4WBXMd
         PhkAbhEdW/eCc2LoEouApwITuS9iJauQUBuMhXlK0tV21idZ0FTwRsygJwADgS+UOC8g
         8yZIbIzu3/+x3+c9JgUd6LI39uNn1I6tUbIONdxTaXKI6NbutLfOiQv0n3BrNFDfO3Dk
         cupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681355695; x=1683947695;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksLl+u3g5M94Rsp2MK2e3lIOyx7h9PvptQgecj9BoTs=;
        b=FR4Frclgb2arDG0ElvJnPLJaR9rDkY/s9bMtZLFvjafXcB/mtsKGu+aRJGHd/jVe6F
         we8zBCjxRQQkI6dHhm5xURi9CVrSxFQ69i/CpwjhdJB92c2behqQVUJ1vpM/tTQHUISK
         sx21f0s+tRFu74qOCZ+/yKCAfoFMgxDFQwEq6Ml8BsynnBeVn/lmO/QeDWl+hs5uExOB
         zkWgDcq4aK3/cGrSxEUD8E60OUMpciPty4Gua3GsHukNnl96fd0+APXulWkdaI1XZaIr
         WFwAlTxiHRWt8E5iNlDuWRc07jsrmT9Yv2tEyva7yRPvbi0Ft0RnGQ7aRQikcXhyr58j
         nA4g==
X-Gm-Message-State: AAQBX9doTUnKXWIDmo88r6TdVdqq4J4ZiSH48PJ4ie7qeSk7Op2y/eka
        CTw1V0gQ2fUlklGIzwlRPa+FJ/8JFoM2VxQxz1Cktg==
X-Google-Smtp-Source: AKy350bPy6H99b3JztSvag1soTIs7MW/aHYKKmTTHwO5KMRlH67LS0BQqOcTH4IGMvZmFMPX9/vaqw==
X-Received: by 2002:a05:6a00:1a0d:b0:636:f899:4696 with SMTP id g13-20020a056a001a0d00b00636f8994696mr1315927pfv.24.1681355695578;
        Wed, 12 Apr 2023 20:14:55 -0700 (PDT)
Received: from [10.240.2.163] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id p15-20020aa7860f000000b005810c4286d6sm211451pfn.0.2023.04.12.20.14.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 20:14:55 -0700 (PDT)
Message-ID: <5270f8db-ad7e-e260-93b7-40a1a6e75f48@tweaklogic.com>
Date:   Thu, 13 Apr 2023 11:14:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>
References: <20230411011203.5013-1-subhajit.ghosh@tweaklogic.com>
 <20230411144031.000077c7@Huawei.com>
 <eefdbad5-35ed-04c6-0955-87c99a4d345d@tweaklogic.com>
 <20230412214403.5c053ed6@jic23-huawei>
Content-Language: en-US
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20230412214403.5c053ed6@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Can you also help me out with the git tree I should use to format the
>> patches? As per my understanding it is the subsystem maintainer tree
>> and the main branch but the macros and functions which you have suggested
>> in other reviews are available in Linux mainline.
> 
> For a new driver it rarely matters and I'd advise simply using
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> which is the mainline tree.  Please base either on the previous
> release (currently 6.2) or rc1 of the current release (v6.3-rc1)
> if doing this.
> 
> If you need a feature that has only been applied in the same cycle, or
> are building on recent work that has been applied to the iio tree then
> for fixes you want:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
> for new stuff you want:
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> 
> The IIO tree routes through Greg KH's char-misc tree so will see the togreg
> branch move forwards to be based on that as Greg takes pull requests from me.
> Usually this happens once or twice a kernel cycle.  Don't worry too much about
> this. If it should affect a patch because some changes crossed I'll generally
> fix it up whilst applying whichever gets applied second and ask the
> authors to check I didn't make a mistake.
> 
> Joanthan
>>
>> Regards,
>> Subhajit Ghosh
>>
> 
Thank you for the detailed information. Appreciate you help.

Regards,
Subhajit Ghosh
