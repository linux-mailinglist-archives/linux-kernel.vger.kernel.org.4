Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE44B7042C5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjEPBUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEPBUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:20:04 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED83E7A
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:20:02 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-3357ea1681fso3211565ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200001; x=1686792001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hFE/2LbHG4DAhyFpHPKPmd13xVP1nkgSLEJ3rUtktCg=;
        b=bdI1VytjzUt/gQfiQzbVmZLPoX1eWLjUutL3gQi/rgEoo8VJ8qqUe3jfaLAwJvC1J3
         91ER7PUZKEKIMatJF4IM8m1OlIL/dviM8nz84pS8D23gnhCLd/j6/IIzQFk7icNWPCbo
         HG3SIPedH7azN4s7i+OO643lA3UPl2qM9e+fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200001; x=1686792001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFE/2LbHG4DAhyFpHPKPmd13xVP1nkgSLEJ3rUtktCg=;
        b=TGFK7QonlSVr80sh0X50wJ1M4R85q7XonypTdSkxN0Hpw2x2YsZLFaAs2QKDORpm/X
         KTPAp7BNWQfu584l1knp2gLhp7nZ/iGOceePxDb4ZKXKNIpHa4r+Uf7XCLcF4HtJYsJZ
         OwRFJs/lPOVa8KhnEhWhk2Y6huVc1fd7GvC3gDZM1T+oqD3MnutpQDmaJ8B/FLdp7Lnm
         s9ZdfD7Q5M1/0itinQADrYGIPhjI2a6iFmjnsuaVSmW3Jp+v1q2eBwR2C7wRWquNXXV+
         BvqBkPH4x/ctjzv7w4DZlikzfju/IT5hY/w1w+FMEsII0Ayvl0wp+GLPY7kojAcdu7sR
         Samg==
X-Gm-Message-State: AC+VfDwuZHyXYLc062DlCu685zc0Ci5aUHQsDJdmBjhJt52jvXFJIXYh
        WfkABHXzjoZxS+D04v1SxkHpZg==
X-Google-Smtp-Source: ACHHUZ5cmh0U8jqt1uM7uoN0KTmKVr51aoJ6tgzIORk2q+odfyB3vQgcuTchpMmkZoOg0vVKpE/p/g==
X-Received: by 2002:a05:6e02:178a:b0:325:f635:26c5 with SMTP id y10-20020a056e02178a00b00325f63526c5mr760449ilu.3.1684200001468;
        Mon, 15 May 2023 18:20:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i24-20020a02c618000000b0040fc3b34d57sm7144781jan.56.2023.05.15.18.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:20:00 -0700 (PDT)
Message-ID: <938d888e-4507-33c8-8a8e-52a92e671843@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:19:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 000/246] 6.3.3-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:23, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.3 release.
> There are 246 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

