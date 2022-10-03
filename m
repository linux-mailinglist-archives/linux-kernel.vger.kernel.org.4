Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30EA65F2C90
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiJCI53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiJCI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:56:58 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4D0A466;
        Mon,  3 Oct 2022 01:41:36 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-127dca21a7dso12160632fac.12;
        Mon, 03 Oct 2022 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date;
        bh=Nw4LxEWOrH2Xh7tKZdWEEria4MFmB9AROdoJC5xBX88=;
        b=WciDKSboW79iNWAcLkYsc1kxZxE5omFXZWCBXhR/0o9M+RB0/luIUqFAVV9BPTOkT3
         t8SPD/n7q0An/9OSLzWQtfMC5uj6siacifekghkbfC86H4VUD5dBeMRr//rvxYmS02yc
         1pMNmvCKZHqjZWE4/4OQRYT9jn8jTRKzzM/nOHm6xTpBSu1Wu2wDXf7nTqR0prISUrhG
         OI+OhOp5tfICq6DZigtZ41lvwWDMn2kfmxk0em5KY4HTSQB0iJW1I3gobAC1WG/cyZlX
         2W1CF8m8mqOOEootCOO7kNLUc7FuWE5wYinw5H/AQOUM1Xpg4ce9RTxZfKvZsC6TQshq
         eI2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Nw4LxEWOrH2Xh7tKZdWEEria4MFmB9AROdoJC5xBX88=;
        b=w/i2wfO7xv5KP8jENGcxupn5YArJt3xJaFzC3UWgk0qPCMd3OLAmSz2Kx411r22BfI
         rKTYaXU8ZgsY2Kz2xNpqUxG89sz9fSvuQzR3t19kmbKRFU0cKfh3VC/BWvdJKIkLhlW9
         qB1lgDbVymqz1QZBGwHA+yTsZ8RqXvqmVGbf+s3QPj12c5rTO55Da9sJ8d+m6OtG2X9Y
         R0Z0hYt1oCRwoY+v6cGAO9Gm/ICZMqTUwXZ1tHB5Ldgr5gasOiksuLPrt1sQApZAG8yH
         qMa0/LJ/EmvV9Ie7XKSnPCk85eJiZAoUs/Cgwifbcy+EVpD42LPcokLZQUOnn66Uvey+
         heVw==
X-Gm-Message-State: ACrzQf3eFQqKs/JaHUbNOgr8HMZxsXDJK4V0aJCduj4fAmErLsNeCRJj
        KTe+jf5fxSQWMumOv/Xx8RA=
X-Google-Smtp-Source: AMsMyM4IYePrxDgZtZXuh8QY5oYXvYtBYxgcqWpgvPar1mTyrYuy0xAcA7PlXtYCNkWbCNrrvFTigw==
X-Received: by 2002:a05:6870:f10f:b0:132:5c4f:5998 with SMTP id k15-20020a056870f10f00b001325c4f5998mr2637500oac.118.1664786496209;
        Mon, 03 Oct 2022 01:41:36 -0700 (PDT)
Received: from ?IPV6:2600:6c56:7d00:582f::64e? ([2600:6c56:7d00:582f::64e])
        by smtp.googlemail.com with ESMTPSA id o24-20020a05680803d800b0035179b87ba5sm2335403oie.20.2022.10.03.01.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 01:41:35 -0700 (PDT)
Message-ID: <b2d905b2-5664-442b-bc12-fd759ac9fa9f@gmail.com>
Date:   Mon, 3 Oct 2022 03:41:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
To:     lukasz.luba@arm.com
Cc:     dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org
References: <20220816130629.3178-1-lukasz.luba@arm.com>
Subject: Re: [PATCH v2] cpufreq: schedutil: Move max CPU capacity to
 sugov_policy
Content-Language: en-US
From:   Russell Haley <yumpusamongus@gmail.com>
In-Reply-To: <20220816130629.3178-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>We can do that since all CPUs in the same frequency domain have the
>same max capacity

Do they? In the Intel Alder Lake datasheet [1], it says that a single
power rail supplies all IA ("Intel Architecture") cores, which includes
both P cores and E cores.

I don't have anything that new, but on Haswell and Skylake, despite the
fact that each CPU has a separate policy that lists only itself in
affected_cpus, with the userspace governor I find that every core runs
at the the highest frequency set among all cores. For clarity:

$ grep . cpufreq/policy*/scaling_{setspeed,cur_freq}
cpufreq/policy0/scaling_setspeed:3000000
cpufreq/policy1/scaling_setspeed:2000000
cpufreq/policy0/scaling_cur_freq:2999997
cpufreq/policy1/scaling_cur_freq:3000001

It seems that these cores are in the same frequency domain, even if
cpufreq doesn't know about it. I don't know if this affects the behavior
of the governors in any way, but it might be a bug in intel_pstate that
could one day be fixed. If it is, then any heterogeneous-uarch chips
with both CPU types sharing a voltage rail would have CPUs with
different max capacity in the same frequency domain.

This might present a problem for any future attempt to harmonize
treatment of big.LITTLE between ARM and x86.

[1]:
https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/processor-power-rails_1/

