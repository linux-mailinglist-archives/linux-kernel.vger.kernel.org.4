Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8B7643B51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 03:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiLFCeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 21:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiLFCeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 21:34:16 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D081DF11
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 18:34:15 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id y2so4164576ily.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 18:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YQ+tWAhNbDC0gmqSfgmib95RFSeFm70jylleXDIP6pY=;
        b=O7dnDobbSZ5rZ/6HKQT4AQv4tfeKaCnjYVuqVWXewEiU9XUXptBxB9ZQNGTybQVALk
         M+OGuOcu9HjhXbeCltyAl5laJQs7eB0QJEYH7+S7ZPHdfqeiqcZ3hVj/IjHI3l+MfftW
         aiyA82sgTFnqHv+HuYCdBoCB5koUuX0cs+4ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YQ+tWAhNbDC0gmqSfgmib95RFSeFm70jylleXDIP6pY=;
        b=x99vsjCSWaGXR6y2AhzeP+ebztiCYpQ8GD7LgtIt1fUKFad+6rJh2xs7rlTD1TmkpY
         z9aQYxGDubW53NTsJ1Kl+swf57GRpr6FfJ1NE4w7RcNWiV27yihDvhpqToGHKTW9kNWW
         pwYwNYKr7TJxz9vWjKnolv2LolTngMne4zSaHe2HOK8fXT9+WORcizi/jBx+mZkfPYj1
         SEr9gE4mssIl5DIsXyROOD0QzlBX8esYD2s+xxYTXUAQF7wxveI+BvU3GnWclh+458Pf
         VkIzD68pkqxATFPkwWnn5hqy6EFIj496HmLw+qxUCnPhLetD6GtxtZ8U4nA/JQjGNP9D
         6TuQ==
X-Gm-Message-State: ANoB5pmrvkxUNevBKJY2BlB36YyhBULQeKPtHrAODMeAVK6dvHxHX+lp
        MO2oN1bNuaEqqsSJDJjVajoAFQ==
X-Google-Smtp-Source: AA0mqf6TZ39fhZkN+lz6iWVbqJnfP7DZb0dFPZCAl8c+38xAhdbnjUMZWZ6eQmFYCF179mKTIk9zfQ==
X-Received: by 2002:a92:2912:0:b0:303:c52:274a with SMTP id l18-20020a922912000000b003030c52274amr18202362ilg.171.1670294055082;
        Mon, 05 Dec 2022 18:34:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w193-20020a022aca000000b003760a908bfasm6247677jaw.169.2022.12.05.18.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 18:34:14 -0800 (PST)
Message-ID: <0cc3b3ca-ff9a-538b-4e33-a0d805861ab5@linuxfoundation.org>
Date:   Mon, 5 Dec 2022 19:34:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.15 000/120] 5.15.82-rc1 review
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
References: <20221205190806.528972574@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221205190806.528972574@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/22 12:09, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.82 release.
> There are 120 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 07 Dec 2022 19:07:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.82-rc1.gz
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
