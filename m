Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DEF633F24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 15:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbiKVOlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 09:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiKVOl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 09:41:26 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFEF6B22C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:41:24 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id z18so20901823edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 06:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Kacw5FrPZZ3AdW9d8qAJ/kGPVPvKgJmlT/4YyZBVx8=;
        b=eMW459fMFldVshj3WV+ihtUTZnN2/2Hj68P41SlaqDDiVW1hhAWBX0UC5DRobZqGCP
         /o2moQdFpE7zKyynoZQqpKGvskmLYvyw1ySQqT7VUDyYANvGI/KnSQCX4kXiTpN1TBYs
         914g4PnWap5OJDSgzWDCCgkuPvasp8UlkBmkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Kacw5FrPZZ3AdW9d8qAJ/kGPVPvKgJmlT/4YyZBVx8=;
        b=f75qMUTnDMrdc3xqYSOsEqKFteo2xC/PFtJbYgm3/id7SBIh+xazGQdoUwrNY1mqeM
         4qyvIq0Ar5HuIa7cstgDhv38j8lE4AgHcRO3X2oHqzrQR0p24b892Bdg/v7miFwEyahB
         3EULVpXFwHjLNm0nPlFlk23eKRVgQxxfdaHmbcgtEG7molBgu7DnqFjqcJsMzMDQfNzK
         mDxV0QjgK998DEncapNhxvbmd7IBwRNwk+PWKGZXGSOtdKnfDGso/anLoGKdOaSyg3Lc
         IA7rinJ0sBtfYIZNz88REo2ssuJplfOze77G+bYap8P2bPSG6UM21j0XuNWt+Kt1WnC9
         vJfA==
X-Gm-Message-State: ANoB5pkRox7Eaz03E7OAUKHeNPNxE4l2Ax6kSqyfwTfs9KC3dkbDKMxt
        tJGoRNi0zwsPmnpGFiKvl9GN3M7KKKgB5w==
X-Google-Smtp-Source: AA0mqf45QBsCoAXSHHBUHYZ7dwpofHSYAG7JNRqA1tuzcnNIyNfvrmjTgFwdQCNZjxFH/v19IZ+I8w==
X-Received: by 2002:a05:6402:3203:b0:467:b8c9:a7fa with SMTP id g3-20020a056402320300b00467b8c9a7famr5581006eda.25.1669128083250;
        Tue, 22 Nov 2022 06:41:23 -0800 (PST)
Received: from [192.168.1.149] ([80.208.71.65])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709063caa00b0078907275a44sm6058819ejh.42.2022.11.22.06.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 06:41:22 -0800 (PST)
Message-ID: <d8e3b536-06ac-2346-3fe1-90ed2fb1127d@rasmusvillemoes.dk>
Date:   Tue, 22 Nov 2022 15:41:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] iio: adc128s052: add proper .data members in
 adc128_of_match table
Content-Language: en-US, da
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Javier Arteaga <javier@emutex.com>,
        Dan O'Donovan <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20221115132324.1078169-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 14.23, Rasmus Villemoes wrote:
> Prior to commit bd5d54e4d49d ("iio: adc128s052: add ACPI _HID
> AANT1280"), the driver unconditionally used spi_get_device_id() to get
> the index into the adc128_config array.
> 
> However, with that commit, OF-based boards now incorrectly treat all
> supported sensors as if they are an adc128s052, because all the .data
> members of the adc128_of_match table are implicitly 0. Our board,
> which has an adc122s021, thus exposes 8 channels whereas it really
> only has two.
> 
> Fixes: bd5d54e4d49d ("iio: adc128s052: add ACPI _HID AANT1280")
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---

Ping. Any chance this could be picked up before the merge window for 6.2
opens?
