Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD6623920
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiKJBpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbiKJBo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:44:58 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDCF29C9B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:44:55 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id z3so264278iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lBtbVkZS1O7YbzecaVkeQEW2VLlO/W425Vba7t3Ot0=;
        b=HFXqzbHSbg052lZLmDmPZwoSQW8Tcdiy9UvPmwrDN031z+6KJT93GpalKkBT25HFk2
         s8o0+MlC1yWdSmfaZX72pgxEfuCum3Zw2+wGp3G2oBXK8oVeW69xvVnOoHnnSVeMkj/q
         8pm6JgGR7V6LGOP9ntA2wb6y+LN0qyI2LSmok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lBtbVkZS1O7YbzecaVkeQEW2VLlO/W425Vba7t3Ot0=;
        b=v9jWJ3+88ep3stSSiZnYOCLnXQyg2JrEdLus4h76E1t+YexzzdNQMWI/KiuMcs9YZG
         PCamv8ryJhFx0DEnpvY4Yp2RRhg8zq/fEPZUGOMeuGHBwnAUokRlLYHim+C4iMVPuC9O
         ZDZM7Oo/Rm9hOtBoSvTrUYoetzPaGBL7PIOYn5uNHDJ3uNHgp8oVRc2s8f6Xhac8uJeI
         nLE3KtwOKgcsLMTvsoJ8+nPULXveC/qZBo1gC+yxNfAB9/q8ejkTtbqab+5mSFPgvNv8
         PolwuvHnZcqDlwFPhdb9xT0TKT7jGRNSYpb2H8HJ2DZaGUo4xOipIxeNqa4QWYvCOQqG
         X1CQ==
X-Gm-Message-State: ACrzQf22joOzTQtlM9ZxVDLxU0Yfbq4GacE1UEu+GPCGUmUsQis1PMlm
        KP/FTq6EhDIXm1yDyk1Rf8MI5tZox3xq3w==
X-Google-Smtp-Source: AMsMyM4N+ShT65zrwNwM1pqouojkO8Zx8uSOZ0T/e/+0A1Bhu96VM5qrkV9dQ1GG690mLjuMHerayQ==
X-Received: by 2002:a02:6062:0:b0:375:631f:111e with SMTP id d34-20020a026062000000b00375631f111emr2392394jaf.123.1668044695147;
        Wed, 09 Nov 2022 17:44:55 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d12-20020a92d78c000000b003002947096asm5366733iln.65.2022.11.09.17.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 17:44:54 -0800 (PST)
Message-ID: <f27ebae6-cea7-36dc-b7a6-b0d62b3c3b0d@linuxfoundation.org>
Date:   Wed, 9 Nov 2022 18:44:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/2] selftests: proc: Fix proc-empty-vm build error on
 non x86_64
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>,
        Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     shuah@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221109221104.1797802-1-punit.agrawal@bytedance.com>
 <20221109160243.0db030ca1cbae5f180af3855@linux-foundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221109160243.0db030ca1cbae5f180af3855@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/22 17:02, Andrew Morton wrote:
> On Wed,  9 Nov 2022 22:11:03 +0000 Punit Agrawal <punit.agrawal@bytedance.com> wrote:
> 
>> The proc-empty-vm test is implemented for x86_64 and fails to build
>> for other architectures. Rather then emitting a compiler error it
>> would be preferable to only build the test on supported architectures.
> 
> Why does it fail?  What would be involved in making it available
> on other architectures?
> 

I have the same question and also don't like adding TEST_GEN_PROGS_x86_64
Please see my comments on the two patches regarding this.

thanks,
-- Shuah
