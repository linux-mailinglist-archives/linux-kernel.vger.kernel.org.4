Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BA96B57A7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCKB7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:59:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjCKB7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:59:53 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6E313F18A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:59:51 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id k17so2800307iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1678499990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TmOK8Uz3KkGO3i5LKLy4ogbNt2yEolBlgdmXQA2p1DI=;
        b=Frg3LCd+nllIj2u9mw5A5CegEgBu3zY6KuOu4SYUCXb+OmWxiHrk2nN78PpQSRFmHB
         tpQ3zB0KCvy/7UM36UAzzVeHTSdchJJRLQ5t9vXHB7bpGWUSQPoheRu7iGeOsjWVPmt8
         k4O55Mn0/C7ebIi0omedT/r6LTHWSY1t56KHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678499990;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TmOK8Uz3KkGO3i5LKLy4ogbNt2yEolBlgdmXQA2p1DI=;
        b=Kg5UJSXWPH5v7hQrL35D+sNL3gI17ukDzMO8/4PuVQ0MG5BZfFjwqHjWAL4+nGPPCi
         R/DunMRkXBOUEJ1CCvV9PTnNdcC17KxjpQnV3v1jjX/ZEj3PLa3sUh76pxuAogVsi3jZ
         6LnmI3WaoIw/h3KaR1TYRAJJFRN1tdcyB2y2EjGTRhHl51Iuoq2D5QMH/8e3E0A65+3v
         QSf2tSzKyrgUuFDh0hOva0IFwP78i5RjayTAM83vyLD7SARJLUOy/BCMyso7SofxkbJ6
         OQSL2lSauaf5xupCzoOBrqlNmzVbfae+Ngj/b+p+McnGayWsdwG3ik81p1rCJmnii7iR
         eKaw==
X-Gm-Message-State: AO0yUKX/mDmkjgFTcZ0HqIoRU2PsUJ7zY9oPNZB1meiB/4v4XQAzlwD6
        v16cop127HVbvAl2niUl2JTiyQ==
X-Google-Smtp-Source: AK7set9uqMsOEAiWqWPw3QPsocJFQRv6ctMGqakBIYYpV97+b24VuHfQw0KierQHXjRnN7rGXnwurw==
X-Received: by 2002:a5d:9606:0:b0:74e:8718:a174 with SMTP id w6-20020a5d9606000000b0074e8718a174mr4849943iol.1.1678499990288;
        Fri, 10 Mar 2023 17:59:50 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id k24-20020a02c778000000b003e545419425sm467240jao.84.2023.03.10.17.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 17:59:49 -0800 (PST)
Message-ID: <95f636ed-4d08-f323-7dff-92152287dae8@linuxfoundation.org>
Date:   Fri, 10 Mar 2023 18:59:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 6.1 000/200] 6.1.17-rc1 review
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
References: <20230310133717.050159289@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230310133717.050159289@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/23 06:36, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.17 release.
> There are 200 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 12 Mar 2023 13:36:38 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.17-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
