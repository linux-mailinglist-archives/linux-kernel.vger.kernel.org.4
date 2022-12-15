Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8964E4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 00:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiLOXpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLOXp2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 18:45:28 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96464F587
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:45:26 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z144so493095iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 15:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/CC64YfJSCYg/K7qmsImuayWPAKP7dBE78VMBC6wzX4=;
        b=Vm9qo1fTOm9PS/Ef1xv8f0hcXZE/fHPnWP9c3yXChNUfmpjXCFZuflNYbNW9LEBObP
         YHxqjy+DUJikhy/YyxEuaTpFlnsgNuUOXR1DWBf0UBvMBoNsBLT025ENvKyKrEN/fotn
         sUlm393euqw1MK2AqHTfc/wJTz0I2HtNjmZgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/CC64YfJSCYg/K7qmsImuayWPAKP7dBE78VMBC6wzX4=;
        b=Zm/nugyUvTBM8ugkwkvkIbEV2qwquT1clry+j6JWeZ9J3tTif6WWmS6lYOQA6Rl84b
         /C5y+JezT2T6OYtb0dbwbOi3mGMsXAIlZAvjjiZ+ESLxnFhfDEF4Cg2X9m1bMS/jaFsy
         2iteIKlP6ByZr2FLaBAXM+MBG1QC4RCvQT7Q0YXNAP16bhgNLMBss9jcMp70jpE6u4rR
         MhTy8HFCRAyw80p+1VOCCsk9l9Rcsa8q6j7VlafaEf1xWn9vlB3nPEpsissiQ0+2/OlM
         U47UOuKHQo34GdoCRMnnQ5R2dglYcBXE5bKwcb8wa/qTMdnCikgmfohMlcqtcV7nMVb1
         S6zw==
X-Gm-Message-State: ANoB5pkyeBg48YfoAQspXKbgOGp6PJaEu0K5ZsG3AvoVxHUENBjwk14K
        gkQUNvCIkXTIzpJw+VZSbc1G7PvRquRqkMME
X-Google-Smtp-Source: AA0mqf5dtrTlZf5vEfd8yJ8MW3l1j7t1YAW11Rs/G9Fv5y9lVHj2cVPukHtqRBxuaiBj23N74DBQDQ==
X-Received: by 2002:a5d:8b06:0:b0:6df:b991:c03e with SMTP id k6-20020a5d8b06000000b006dfb991c03emr3045706ion.1.1671147925872;
        Thu, 15 Dec 2022 15:45:25 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z21-20020a05663822b500b00386dde027e7sm220197jas.73.2022.12.15.15.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 15:45:24 -0800 (PST)
Message-ID: <3e3a6157-ddca-a705-351e-a2514f5af29e@linuxfoundation.org>
Date:   Thu, 15 Dec 2022 16:45:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.0 00/16] 6.0.14-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221215172908.162858817@linuxfoundation.org>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221215172908.162858817@linuxfoundation.org>
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

On 12/15/22 11:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.14 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Dec 2022 17:28:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
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
