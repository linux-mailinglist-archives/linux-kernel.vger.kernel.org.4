Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E78870CCD9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjEVVs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjEVVsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:48:19 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60B102;
        Mon, 22 May 2023 14:48:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so47219495ad.0;
        Mon, 22 May 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684792098; x=1687384098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYFQfj7RH7xLCxdAm/GI182OJFS6kQaDL6l/UoivNeE=;
        b=Qp59Jo9HZfYsWyecShsx9f3oPfYSagf01XQTuN9w92J2JENJZf+Hg/N/UtiyfWioe+
         5TXqpkr9jUOtuYUBqMVV4+QH9mPv76mlpv+N+V3VwSWdi21Q6qub0XqC3i/TISeKungJ
         TQu5BNMs7p4tJWI+JGUA6KlGFV7ehhni1Io83UmU9BOsAAp8TRZrHgTioKoM7D+jphz0
         jDSroTqBCqoTTwgoVYNhEmoTUxySgyr1ggTo7SsfC8ro6Ia20AfZFxz92hfGe+aBDMzt
         YFY7bbdQ/8U7QirjSndhDaRs1JPa1ZBQBMP56646kjl534sZkawQiz3ut0v2jOAtSuZp
         lWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684792098; x=1687384098;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYFQfj7RH7xLCxdAm/GI182OJFS6kQaDL6l/UoivNeE=;
        b=aV0HRDmTT5itfyTYzbyjr+YKtahb7jrmS3illaVjR+GWH7VT5jcTno7c4OSA7dK8Jh
         6XCP6Yyqt8dnsi16p1VEd3It96PE2EhrYmgxhCQEMH2EjnjqwySR/XfnxXCD87jtLRKb
         2dZM0W2mIv/iZm63A0IwtfgMEzMUPQFylB4LnAP7k1/o+1v2Vb9Q6paZ1ablYNrBJbto
         ZwbHniWdVJC/u7o39gazW6N+BZAvdJH7EFm0yHip/z+IPfVnZ86t5JPtDlSTtIrVYU9J
         yNn3VLCJBSAsn+mjGROSZZnXItO9xfToCmJmV+H/MgwuFRtCKnvPXP8YgpBDjEb/lLBZ
         nEPg==
X-Gm-Message-State: AC+VfDzk7TGXWiJAITRNlqwElkMn2R899vqZfPZ5i4JQ47Dc4daKEMkD
        3lIedZpN1YvefltvNkQebFI=
X-Google-Smtp-Source: ACHHUZ4fT2O0Az+BgY0tofcct7VKUS0Zknla0EAujh6QSeRqhoYLuq1nUjTbtqPRcMEqzM24QqS/iw==
X-Received: by 2002:a17:902:a3cf:b0:1ab:675:3e31 with SMTP id q15-20020a170902a3cf00b001ab06753e31mr11317763plb.37.1684792097612;
        Mon, 22 May 2023 14:48:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k12-20020a170902694c00b001aaeaa27dd5sm2992336plt.252.2023.05.22.14.48.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 14:48:17 -0700 (PDT)
Message-ID: <b7494efa-304b-9de9-c8dd-2053106a9f02@gmail.com>
Date:   Mon, 22 May 2023 14:48:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230522190412.801391872@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 12:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

Same comment as with 6.1, we would need:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3522340199cc060b70f0094e3039bdb43c3f6ee1

to be backported to avoid:

[    0.001697] Early cacheinfo failed, ret = -22
-- 
Florian

