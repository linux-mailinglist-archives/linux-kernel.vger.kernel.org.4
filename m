Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA945EB67E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:54:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiI0AyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiI0AyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:54:10 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F5D8E0CA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:54:09 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g8so6686385iob.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zlGFCvxbnaxYS16b5HdWat/y1yeFarpV5VVVMBrXYu8=;
        b=ebxtA9PYuDORfaxfn6PeqLTUTCu/uFrsxY16h/epQSv50awBBQ9TAh9xDfTlhWFjVI
         k4I1F2RAN2PbdH7HJYHf3IOIB5TBHom4cLJjTus1mRR/zEkbAanDYe2Ucyr05gGeJCOX
         hKwIBAKqDu0hoJvzY3jcKfcWom+yuNovyEkSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zlGFCvxbnaxYS16b5HdWat/y1yeFarpV5VVVMBrXYu8=;
        b=3YEAgEzL3QYf5XjVsaMOPa4ancsf6P/6FEs4gVXmE5508hktESJWgm2OT0CetnQl2y
         TsyzIuuY0Cjx3aLE5CXmVt7SqYbaxk7YNzONrm9vZFwDsz1pyZ4dDt97fakbYtTJr9p8
         MFIcr9xOqnbXHqgGl6ybizPiEGc4tyXAuIEZTKQp2LQwgDI41/WlITpzRDPQVMorwD+b
         ppaZegiFVCUF6MY9ppJEJ64V+lGOAabhfOGpsr04tYYB2H3YchD6+b/pSmPtn+D9QwE+
         JilDUF1Y4cFOuicOXgmjIIdXfGBe+c+chCwme6vUif4PX3wO5PhDiNx7bo+8ukPJaQEr
         yEqw==
X-Gm-Message-State: ACrzQf15K2fYJlrvysl3hF6UFdu7Z4C8t+9nDKEm0FjYfJCoqB34HeFz
        VqgTdrCLejSp3IngNQPVHQzldA==
X-Google-Smtp-Source: AMsMyM7YG+ip9Qw2GHdOAZq9NTbhLR3+pkzK5visaxqivmqxRxv0Z3IBVKmnK6YgGgu15Nu+PDzWJg==
X-Received: by 2002:a05:6638:419f:b0:35a:286e:6bdb with SMTP id az31-20020a056638419f00b0035a286e6bdbmr12438449jab.295.1664240049057;
        Mon, 26 Sep 2022 17:54:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o11-20020a92dacb000000b002de7ceafb4esm128523ilq.20.2022.09.26.17.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 17:54:08 -0700 (PDT)
Message-ID: <d936fae6-7217-ffbf-a8d7-b3ca97b05098@linuxfoundation.org>
Date:   Mon, 26 Sep 2022 18:54:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 5.4 000/120] 5.4.215-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220926100750.519221159@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220926100750.519221159@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 04:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.215 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Sep 2022 10:07:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.215-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
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
