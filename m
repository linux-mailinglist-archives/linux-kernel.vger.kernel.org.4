Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738AC6B64DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCLKUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCLKUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:20:02 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB7A15147
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:19:59 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id b10so9811993ljr.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wirenboard.com; s=google; t=1678616396;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1G6SdeGpQybrC3jwWPimjsXVVw9FowHr7K+FT1L/fIo=;
        b=BYbHga1SK5lP8wbAeNYeYxfHxY9CqYGvO5326iszkNm2g1Yr89N2QvICTYCaxPVB+E
         R9BYF8mMVgQgLY75yqrNMBlzzNSdi+6gE02irlDQLRyOXBJr2rnBp61eox0UsqKszj6d
         1yBDiwcTwLQlZ+Lh+8onP1AdqsOBqLBogfYvrV8AduaMprqXqXPoXGWnUEVicpirZgsZ
         00Oampq6NVLMOk6cT7RsX+GvFZF22/Xwgzdkdi0Nrs7VhMoWr6e5hwTe59TQknlt/ro0
         H5uAui6wS2jYfLTE3Yea5JdCD0SZhq+6yJEyyTMUgPrmiD/kp7yWMxqfd8Mjlvsx2X+0
         Iavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678616396;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:subject:references:cc:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1G6SdeGpQybrC3jwWPimjsXVVw9FowHr7K+FT1L/fIo=;
        b=mo+1Z+F7mKhALue7I9hi0Ob+JZ9FZwEn9Ayyr9Srrax1T30117EXGGD8TBJT+lM6C5
         pudzvuzJhAqjg+SE3i/WlZbZtweHNzFZ3SB6NNMx8oYumPD52iXwMjNz2A6gbJg7DOOf
         W9mS+PO+JFnDLTjg1w8UD2qSEXO3+eVzG4iyFis1iejh/C0L0m7E1rSKg7p65fwb0Ykp
         /Y90DQy6scNBeBcKKjQ9pXNNrx24OSqnd1DXul2ooS6XMzQSvHPLAUhgCJg0OSAKsqjt
         dTnk1ykwqhya8RhnJdJfdhTSsj/7pWEphNCXHiYkECr6XUvwhY9H79x+mkff3j9a1kte
         8kwA==
X-Gm-Message-State: AO0yUKXEMcAKMqBZC0Tl4hluY2fuYCq7TIc+XAZNKcnLF4MrUmSJ1/mg
        HxkOpWi/3fqiPSm9h/qXTh6gDA==
X-Google-Smtp-Source: AK7set+bv6eXHvOdAUgQP1JUX6tIPGMB4BDPWcVwAP6A0h7cOHNeAdYEd3GYBQhfVPs1tQGRNxtucg==
X-Received: by 2002:a05:651c:221f:b0:293:4e43:c276 with SMTP id y31-20020a05651c221f00b002934e43c276mr12716592ljq.22.1678616396565;
        Sun, 12 Mar 2023 03:19:56 -0700 (PDT)
Received: from [192.168.1.9] ([78.109.72.44])
        by smtp.googlemail.com with ESMTPSA id j23-20020a2e8257000000b00295da33c42dsm611369ljh.15.2023.03.12.03.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:19:55 -0700 (PDT)
Message-ID: <4ae6feff-147e-3148-cde4-53039c96ea80@wirenboard.com>
Date:   Sun, 12 Mar 2023 13:19:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
To:     m.zatovic1@gmail.com
Cc:     airlied@redhat.com, andriy.shevchenko@intel.com, arnd@arndb.de,
        axboe@kernel.dk, benjamin.tissoires@redhat.com, bvanassche@acm.org,
        dan.j.williams@intel.com, devicetree@vger.kernel.org,
        dipenp@nvidia.com, fmdefrancesco@gmail.com,
        furong.zhou@linux.intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com,
        krzysztof.kozlowski+dt@linaro.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org, linux@zary.sk, masahiroy@kernel.org,
        mathieu.poirier@linaro.org, mwen@igalia.com, ogabbay@kernel.org,
        robh+dt@kernel.org, treding@nvidia.com, yangyicong@hisilicon.com
References: <20230301142835.19614-1-m.zatovic1@gmail.com>
Subject: Re: [PATCHv3 0/4] Wiegand bus driver and GPIO bitbanged controller
Content-Language: en-GB
From:   Evgeny Boger <boger@wirenboard.com>
Organization: Wiren Board
In-Reply-To: <20230301142835.19614-1-m.zatovic1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Thank you for you work!  I'm currently working on Wiegand *receiver* 
kernel driver, and hopefully we can make both sending and receiving 
Wiegand implementation in kernel.

I tried to read all the discussion for the previous series, but still 
don't quite understand why do we need the infrastructure to be that 
complex. I mean Wiegand is point-to-point connection, so why do we even 
need bus/controller/device abstractions at all? There will be always 
just the single device per controller, right?


-- 
Kind regards,
Evgeny Boger
CTO @ Wiren Board

