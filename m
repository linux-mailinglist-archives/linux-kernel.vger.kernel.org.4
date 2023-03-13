Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA06B6B746F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjCMKnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjCMKnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:43:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E801DB91
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:43:09 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l1so11534746pjt.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 03:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678704189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6e1YTbDJ6oFIxMtLYcj0s/vze6OstkGINdNH2y0sRuY=;
        b=ZQ5UNRYpBGQd8/7jlIgSl53cymfFoYJyqYnmRefDu89BN7w7hiM4A2HLT1Fjp0EkQ/
         1NzMuN1jkFZyYsyrDB2dsjVPe73Jd0QvjBf+3kg+ovkaYjgVOoL6fh+C1pbq5A0wP1X9
         pkXFg5kee1qYF92h9a0W2FGcW/u2iFzqG/4yvFIEA8hd378kmt2lxbvLAbudkbKB3or0
         n0mvCJVqwFygrgVwre1Z03FIuhM7Fi/BHMLir4d33Xq5766ndIzB/fzBXhnxdJ2+LzGD
         uPDAjvB6Rt97GyiJ3HyRDPF+dy+OOPAw7snw0F+oxErERmhr7YUx+Ro2DIqRMys4QVOH
         6lYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678704189;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6e1YTbDJ6oFIxMtLYcj0s/vze6OstkGINdNH2y0sRuY=;
        b=XCdBvmOS9LfzVCQeecj/JZUv7l/bhflAVvaUJD+ZMA0zmfrSJ0Dn1Ziy1mk3+jv+2h
         U8shapAsZdD9VyC0Xm8Iwothtu3AmtzhAZvneEGGeDPz2y6UDN13zPbtZlnkh16YV/wh
         i0CpA/qurPICZkkLtVcAe9AGwegjVheaGAHUvdhDaRFaBBGbzNk56yxtucpVIs7lT4iN
         7twAqK+klUxEJXl0RAm4Egc3/pqxLMh1Sms6JvP+0/TIx3T83qGPeZCc1Rbi4urLLnnd
         TAym4iw3os1KHyndfklrUwPew1D3xfnuWZjLRdsu8dHonoAwT/p+I73hLbWdROSYFo9G
         LDAA==
X-Gm-Message-State: AO0yUKVU3sr26QHYgyl9NMG9vhu1PA5Hlo4F8rGIRXbQXDIQTiol9Ho8
        g4C+KAf2Q3uZ8KA3N9kNJrq1cp//Z6yQYg==
X-Google-Smtp-Source: AK7set+7UN8m9ByEdT9C0U5qGPxpyk1yXT/9SyHimAjY/geXcEMMpY2tl3RlspowSfsX6SRECCgtrA==
X-Received: by 2002:a05:6a20:7da3:b0:be:e0c3:5012 with SMTP id v35-20020a056a207da300b000bee0c35012mr10652056pzj.1.1678704189123;
        Mon, 13 Mar 2023 03:43:09 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7820e000000b005a8c92f7c27sm4081505pfi.212.2023.03.13.03.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:43:08 -0700 (PDT)
Message-ID: <15d79ca1-4124-ed96-4234-64e6e4130d1a@gmail.com>
Date:   Mon, 13 Mar 2023 19:43:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 1/1] extcon: palmas: Remove unused of_gpio,h
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20230215165035.83657-1-andriy.shevchenko@linux.intel.com>
 <ZAtMYGLrTj2BgcwP@smile.fi.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <ZAtMYGLrTj2BgcwP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 11. 00:27, Andy Shevchenko wrote:
> On Wed, Feb 15, 2023 at 06:50:35PM +0200, Andy Shevchenko wrote:
>> of_gpio.h provides a single function, which is not used in this driver.
>> Remove unused header.
> 
> Any comments on this?
> 
I'm sorry for late reply. Applied it.
Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

