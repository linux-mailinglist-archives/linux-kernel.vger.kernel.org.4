Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C46C71F408
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbjFAUmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjFAUml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:42:41 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAB7189
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 13:42:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so127025ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685652159; x=1688244159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OKl0/TmyqUCpAuOpupn8i7XJtpT5nAF1vYH6XGHvHjc=;
        b=FPZTWOxQswiu52q1RB9Ek5TC8oPmpUovkh1mEQWLvXDPGVw4Ck2gwxzbtupsd32WkB
         r95C07a42vDulZ+tCbu1cKLGs7M9cmBRRkdkUaBRoSpmMMeL791OPLTdkqHc4nMayFBv
         st7SNWQPks4XAt8cYuJHQzKXXba/wzGyMNGz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685652159; x=1688244159;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKl0/TmyqUCpAuOpupn8i7XJtpT5nAF1vYH6XGHvHjc=;
        b=fkmY1DqPHZuwoSci0VgwclSERQgGirtUwLGM3FWPcTqBklJYZr3qEk+SIkAitHeo1S
         Jmp/E/EgzWbS0a+PKERAEYSsb0nu7CqTahtprDvIa+qm5edDj3C8UUwSYxXxzicuuVXT
         i1BnncjiI2lKynGV5/hVPzKroQ27JYpWJjPyi8uvZMZxZBw9z1ILHHFkCU5ZDEN1KIcz
         aEcRjinj8faQ+lcAyXEz0GZNx7WLLPa9ZUGvmf44CCIfkcafOzYGcdY3YAMh4CapW42m
         e6gpf9fYYrnZlQSGzP9xcEoU61E2yWlsZJNlC+j9GOVCDsCPUacTuT9eOrsF9P/DWkVc
         l9zA==
X-Gm-Message-State: AC+VfDyrKXWkctrPxgOi4oz0OgwN9mE6bk6rE+5RwkVE78dURSiqysPq
        itVLk/vhsFWqC1gzurt4GgJ2qA==
X-Google-Smtp-Source: ACHHUZ7D8q0nVmNZ636h4Aayli31YpZDJIWXYvF569qKvamTbIiSnRXcSvslg4ZpOIOdDsaRsfVUkg==
X-Received: by 2002:a6b:c9d1:0:b0:774:8d63:449c with SMTP id z200-20020a6bc9d1000000b007748d63449cmr4520667iof.0.1685652159333;
        Thu, 01 Jun 2023 13:42:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i39-20020a056638382700b0040bbf478147sm2485029jav.163.2023.06.01.13.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 13:42:39 -0700 (PDT)
Message-ID: <31216e05-6cb5-330f-fbe3-f6d75b356707@linuxfoundation.org>
Date:   Thu, 1 Jun 2023 14:42:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
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
References: <20230601143331.405588582@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 08:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc2.gz
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
