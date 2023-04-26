Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499B76EEB5E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238394AbjDZATZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbjDZATX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:19:23 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0CEBCC06
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:19:22 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-760a1c94c28so35523139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682468362; x=1685060362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=huNhI4IWX2EwAA9qPYkeCvObWSufY3n/3dilITZs/nE=;
        b=OaoiOXyVdX6bHwHaWq02JAGXO2oveqZGkFj2EFCI0ciAU6fkWvAVOpckJTDYh2wr/z
         Ra/9rwRealoYHf1anMaa/opnOB57Zhzn5fZG5LL6VU1FTvnURvw4A2BuXzrHhyZZqqax
         gqk+3kLYt9F+E4S3hjHmPUX7EO98NwDYJcgXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682468362; x=1685060362;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=huNhI4IWX2EwAA9qPYkeCvObWSufY3n/3dilITZs/nE=;
        b=Z3GGLp+chzwNWfdNsvmrPo5PIYkJW7p1YiJ2e0Q5DqR/olLrKecViLWJebs6lWGPh/
         tYXl9SDYMCCl+0JS3G0br/2338sme/mk04C2gKh2+vjBK4wGHWx/S1Wtuqn7heOhJ9pr
         ZU6U49qRsM+fCqGpjMccxnVngD5UxuldIfbUjcKppjAdSoZvKWOUoW9eRkKueDr13LrY
         4J4PhkRzNLLlDqqWT4Tfgpmw7LXw2FT83IZ7F3100k+zcXPLoGrUCkFfu6GFuggJyXD6
         0XYQGK3i2KJHou/iXQB8K1hSFnmHXbLUKqrESs00QfeZfwGZS7EGhL1M9xuxPZ26WfFr
         wy2g==
X-Gm-Message-State: AAQBX9ddDdbinTfAq7+o5tyduKc/n1C3mgWUhFZe34WRAgcxae1NQHCI
        y/pNsEciqdCbnc4V78j2Bw/sGQ==
X-Google-Smtp-Source: AKy350Zr2Bd+FRkC11D/o8t1DbcRF4VismVdhpiUwm2MJNZc65UQF5ztEUvFTSUAX4CmLo1bAR++OA==
X-Received: by 2002:a05:6602:2d81:b0:760:ea9d:4af6 with SMTP id k1-20020a0566022d8100b00760ea9d4af6mr2690297iow.1.1682468362137;
        Tue, 25 Apr 2023 17:19:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m43-20020a05663840ab00b00411bf6b457bsm1897216jam.101.2023.04.25.17.19.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:19:21 -0700 (PDT)
Message-ID: <d3a2df43-a027-bebd-097b-86fee7e0809a@linuxfoundation.org>
Date:   Tue, 25 Apr 2023 18:19:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 00/98] 6.1.26-rc1 review
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
References: <20230424131133.829259077@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230424131133.829259077@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 07:16, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.26 release.
> There are 98 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.26-rc1.gz
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
