Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DAE6FCBA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjEIQtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEIQtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:49:40 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAA61725;
        Tue,  9 May 2023 09:49:39 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75773a7bd66so308362085a.1;
        Tue, 09 May 2023 09:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683650978; x=1686242978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+v/X+OxvTsGwJMDiA5a3JO4hrqmYlFbvSipw3tCkW7k=;
        b=mi18ne7/zmw24M0PE5a/jix7FCxVRAPj2OWezMOLK435O6KTl91ufM7ecY/3An5FlG
         3eDIxoiYdu6nOfrJG1xvexSDGBBA8iftptyC0At0dA4g4TSRiM+tkA3sJL8/LCj+5u2H
         Bvl8EJoSWHQqjhd+Qtaly9hiW0mzpXzSC+Ff/OGOg6C6OOPVed4LlRAo/4/qB/c9FXM3
         qAAJNsx/YYbRNnn7PHjDliADKFOFEmo3AV9DioKrvGDQHhEqFe3NYV0/YaryXGzVXliQ
         7RKZFyJhAY3QPNhuyesiQtVX9bbyj1FqAqLttQffgFNCN5QhF4Ip9Qbx0BWt/7pTO0US
         besA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683650978; x=1686242978;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+v/X+OxvTsGwJMDiA5a3JO4hrqmYlFbvSipw3tCkW7k=;
        b=DraFSfJAYldTwMvMM8xq0QNwz2oBAKqXGg4DNDS3VRzD8A2q4X9XlmXibFSYXO2GnW
         YVn7vnmj36oSeThnBVpaFGkpb/SZGKdY2V6GxbabhrKPbplD9s6KlIK4yehZfYoJHsfP
         9GOor5Ol1WwFKnPURMTzSESOAMWxven20+7u5jCaOFLbJtT1TXOo10l0nfIXtO3di7c7
         JH9XtAC+kJaDiqhc3X9wYLJKZpwVOmhwJsKAPdMgE5kyBI3yIwwnSFyvFIHUAPthhlv3
         QflFPQiIth5M4htQE+t8IF7kvatqGlpwwZWyXX2pOEmbdV+cY8BTfWJxhwoOhgsbR5EJ
         zq+A==
X-Gm-Message-State: AC+VfDx3SWShDz91uhp68LF2g7jkJRjeplCzqGsTVavRymu/FncyKaVR
        ioL0qVeR9pruf/QQ9VxixNo=
X-Google-Smtp-Source: ACHHUZ4KMC8JbEB3svxiOe6ARE2a/tn5H49VSw4ZqmLxsz8hib28t5obbwshSIBb3QlXSqLgXxD0Vg==
X-Received: by 2002:a05:6214:1243:b0:5c5:1a25:edf0 with SMTP id r3-20020a056214124300b005c51a25edf0mr21819667qvv.26.1683650978520;
        Tue, 09 May 2023 09:49:38 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id u2-20020a0cdd02000000b005ef6128255bsm875900qvk.92.2023.05.09.09.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 09:49:37 -0700 (PDT)
Message-ID: <1f7ec6f8-dc61-9ea0-a7c6-1a51d69d0610@gmail.com>
Date:   Tue, 9 May 2023 09:49:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 000/370] 5.15.111-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230509030611.521807993@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230509030611.521807993@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 20:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 370 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

