Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42B0727446
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjFHB0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjFHB0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:26:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716322103
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:26:12 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-777abee746cso111539f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686187572; x=1688779572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkN4YhNfQp+ZbfhdGrNxfUu8thCYEN7OW0ct1T3I3As=;
        b=Ss223zaYWFhxjprbff5yEbLaDzyoVlqg4jO4Tll6AipSK5++GbcuYP3SpXwXIJoXLc
         +Qok/gXdmfqYSN7o6y8UEWGOG99NjP0MMPt9Zvehot3K72UdUAZ1o2Bz54x3s4kpItkE
         e/HJep/MTdGaMMNxffPHghBD9JaJbaEQXMN+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187572; x=1688779572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkN4YhNfQp+ZbfhdGrNxfUu8thCYEN7OW0ct1T3I3As=;
        b=NTn+tdQqpJ5sG5QFOgVwuthGWk3O9A3QNUZDwuMMLkrQtB2MLGT9eBNlz13dMwIQ5K
         MsOOxDX+sQ00p8/sCFwP78haM7M0WNDtw19qvjLwrWZXiJu1ANlSNwdKrXpZdthbGveo
         tTexHNPjNL+hD+DHn7qRr5kL/4eRLuIFn9BOlEpQ+qdBf1A32J1TQrHCBccTzNJaCSbr
         ADEPp8atXpvbOlS4FlP1+ZFElW9vWXst02wt4AhDH4jMnAay30XJN2SrV5RIyN/QnHrZ
         disT13B9+C1CH1s77lOqRJRsoH9ii05Un2nqpOd3232YypzQa8yYgrVi7djlcTSan/A2
         z0Ag==
X-Gm-Message-State: AC+VfDyVG7PuvDpc+ZPKX6PLIN4NrZteJKBlnWtgkIm42WnpyZebn9kJ
        YAMD2cUb2swaj7yYM+93rTpyUg==
X-Google-Smtp-Source: ACHHUZ7BaWYaod1rGhEcVO6fZvTKYJM9YW9/GSHfDK9d4uIUofjC4m94DZuF+JDXvU63EjT/SWVHqA==
X-Received: by 2002:a05:6e02:1be8:b0:32b:51df:26a0 with SMTP id y8-20020a056e021be800b0032b51df26a0mr2192524ilv.2.1686187571838;
        Wed, 07 Jun 2023 18:26:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id dp37-20020a0566381ca500b0041ab9b6f5b0sm2944879jab.128.2023.06.07.18.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 18:26:11 -0700 (PDT)
Message-ID: <2f85f1df-369c-cdd2-d92a-e7c2c2b481a3@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 19:26:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/159] 5.15.116-rc1 review
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
References: <20230607200903.652580797@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.116 release.
> There are 159 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.116-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

