Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6991E6DEAB5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbjDLErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDLErF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:47:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E805D469D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:46:56 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 60-20020a17090a09c200b0023fcc8ce113so13298562pjo.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 21:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1681274816; x=1683866816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bx1peOWUY+EguIhN3+HEV80l+NpcfNfRNogKL9pYa8=;
        b=TYD6k5TkH0f+f2VcgwjIMuLUw5PF7L9qlFK7nKXfGEzzYqg5yocLOj1NQcTK3AlAX8
         7L49b8EJyccPPe9AEmNfHPbpp9gwhlxoNTDCh0SE1hZc6MyxITgRVf7vXAHMExP+UADL
         dlSuONYrS5XVbWrjQ2wBV/vTEO137v89cT9dkfhh4QNwnjBK2IgJHRgEo+sMqHdnQIXb
         J01mLe7aZYR537STAD/H0nm6pewLefxODOua1AMHGwSXynhqlckI5SFYTlRwMFWzpF+s
         DjYo6pyAbx8fB4OIo6s1D7zEEreKB/Urtle6rqgWkKeAbOMUehI2F1eh3X8b6ZrwliIr
         s5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681274816; x=1683866816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bx1peOWUY+EguIhN3+HEV80l+NpcfNfRNogKL9pYa8=;
        b=r5rEhpaJfpclr8pBBRDlpSRnVEYmHTgS63JSJ00kKL3kcbn4dyEyRuGdIduyGyVCnp
         yE9cTu8GYPhNR6LHpPsxAz3MqKTcAuOOeMTueu+80ySFjUyY6e4Xr1twNqZRZc3arll6
         vaDjymz13j49f3cbAGZ0HKDrxmA3NhtzqSVAww0FvDhNSlyZR87LVqcIJ18CPFoto7FO
         QrlUDj3e8YV7cer3/e1wlKTJQCSkt9KpMfQe1zP/LoVvyBOrBL0JJJQ3m/fl1O/FPopM
         AN6ykki9n/8yKqXM7J16mnQoDTtgrKZUVC6uDefn/Ax1gHrVj4nipIQwIni9hHFrT+XF
         6i1g==
X-Gm-Message-State: AAQBX9eQLfAppd04LQQSi82lMb8IVHcOtlR6zNi87HUB1FyNkGlVM/2q
        ZhPorw9jMLn9j0kCOr3nfqciiA==
X-Google-Smtp-Source: AKy350bg2rc3G/bZAa2f5cAlYhqK3olpjYj+ekBeQ1nXB59cT5PADukrzvEam2VsqAsPQONrpjRcZw==
X-Received: by 2002:a17:903:2943:b0:1a4:f156:a1e3 with SMTP id li3-20020a170903294300b001a4f156a1e3mr12911958plb.58.1681274816319;
        Tue, 11 Apr 2023 21:46:56 -0700 (PDT)
Received: from [10.240.2.163] ([124.148.245.238])
        by smtp.gmail.com with ESMTPSA id f2-20020a170902860200b001a258041049sm5509039plo.32.2023.04.11.21.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 21:46:55 -0700 (PDT)
Message-ID: <eefdbad5-35ed-04c6-0955-87c99a4d345d@tweaklogic.com>
Date:   Wed, 12 Apr 2023 12:46:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH 0/2] Support for Avago APDS9306 Ambient Light Sensor
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
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
From:   Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
In-Reply-To: <20230411144031.000077c7@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,
Thank you for getting back.

> Hi Subhajit,
> 
> No need to sign off a cover letter.  The content isn't captured in the
> git tree anyway.
> 
> For an RFC, I'd expect to see a clear statement in the cover letter of
> why it is an RFC rather than a formal patch submission.  What specifically
> are you looking for comments on?
> 
> Point us in the right direction and we might answer the questions quicker.
> 
> Thanks,
> 
> Jonathan
Thank you for clearing it up.
Next version of RFC I will put specific reasons.
Before submitting a formal patch I wanted to check if my implementation of
single reads of ALS data raw values from userspace when interrupts are
enabled is the right thing to do or not. Also wanted to check if my event
related userspace ABI implementation is in line with IIO subsystem.
I will put it into better words in the next cover letter.

Can you also help me out with the git tree I should use to format the
patches? As per my understanding it is the subsystem maintainer tree
and the main branch but the macros and functions which you have suggested
in other reviews are available in Linux mainline.

Regards,
Subhajit Ghosh

