Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C825FB357
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJKNXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKNWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:22:31 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432813F37
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:21:47 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s10so16808642ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=85p/2HCI5OGegxD2S1Bkqs/JqGI8JWXRrHk/S0crc/Q=;
        b=aJm6u3VRzX5zaLGsga2Nhli04Z5rvtscsg8XWPJfxASZlKv2kIlDEeARfyB6YJFHmU
         spZkCXBgib7BbhqISPPdu2mKK5zseBnatLm2IZa1LxwKW37Af/yTCl1H6KC8qLZK0oDA
         LuO4ZY6LoEiqO2OKtO/NwT0XucfuVM+0n0RWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=85p/2HCI5OGegxD2S1Bkqs/JqGI8JWXRrHk/S0crc/Q=;
        b=tQEG8e5spkgKTF20Oeb7w/tAr01/oapdyADW/sJjHChmmQP9CBVCmt0CrHQjvtJGzg
         4zVFtdlPdCiI9NqqsRcr/Qc+F4tDxfEattnVSAAiY4Iq7wWoMpW8RpjfzJs/AaHkevua
         ukB9UckbD5Zwon5/OfC61QrPyngB95mKKX9eunuWYNSHWTkt8MutMpioMXOtgtwDr4IS
         CAdqxSzAaSvo1vZWmb/XQo90MsfOU1EEusle/quZzNFmMBYbEUHwC/+kFktCXPVeO4to
         v3MPe/KMGZYE29G6gR64Ssf9aA1w+bl8dwCfmns86y5QQ7ABtWo8Dh6j70E7kVbe5cpM
         tZRw==
X-Gm-Message-State: ACrzQf3ZY2Lic3EO8cBlXj4YsYKF6oox9IT6gCgzoSUbq2Nyz77ruANn
        bz4AnM64j5XZxArPPYoY/jszjw==
X-Google-Smtp-Source: AMsMyM4j+j+gCb9oxD3FBwpYxtMs4ByWwMG0P8tbQlHASi12BH4zW1UB7Yb7w1tm7Zy3S4XCSr7zww==
X-Received: by 2002:a05:651c:2103:b0:25d:6478:2a57 with SMTP id a3-20020a05651c210300b0025d64782a57mr8956531ljq.496.1665494506147;
        Tue, 11 Oct 2022 06:21:46 -0700 (PDT)
Received: from [172.16.11.74] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id i5-20020ac25225000000b004a03eb21c4fsm1859869lfl.288.2022.10.11.06.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:21:45 -0700 (PDT)
Message-ID: <0dc78ec5-e934-fcb4-5153-1e8d3840f473@rasmusvillemoes.dk>
Date:   Tue, 11 Oct 2022 15:21:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [crng-random:jd/get_random_u32_below 24/26]
 include/linux/random.h:64:77: sparse: sparse: cast truncates bits from
 constant value (e24d4d50 becomes 50)
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210111756.pMpxXUwp-lkp@intel.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <202210111756.pMpxXUwp-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 11.59, kernel test robot wrote:

> c440408cf6901e Jason A. Donenfeld 2017-01-22  53  
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  54  u32 __get_random_u32_below(u32 ceil);
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  55  /* Returns a random integer in the interval [0, ceil), with uniform distribution. */
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  56  static inline u32 get_random_u32_below(u32 ceil)
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  57  {
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  58  	if (!__builtin_constant_p(ceil))
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  59  		return __get_random_u32_below(ceil);
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  60  
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  61  	for (;;) {
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  62  		if (ceil <= 1U << 8) {
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  63  			u32 mult = ceil * get_random_u8();
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08 @64  			if (is_power_of_2(ceil) || (u8)mult >= -(__force u8)ceil % ceil)
> dbc0933c6b1d8c Jason A. Donenfeld 2022-10-08  65  				return mult >> 8;

I don't have a good suggestion for how to silence sparse, but I think
the cast and unary minus here needs to be interchanged. I.e., the
condition should be

  if (is_power_of_2(ceil) || (u8)mult >= ((__force u8)-ceil) % ceil)

Otherwise it fails to provide uniform distribution for ceil=11, 19, 22,
23, ... [these are the numbers that are not divisors of 2^32-2^8].

Rasmus
