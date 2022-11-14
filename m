Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0F2628A58
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237545AbiKNUTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbiKNUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:19:27 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17505138
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id d123so9091676iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z2YfmStb+j2w+cuOjvg/lXsqwEFt/TTueE5RQ9JeBgg=;
        b=H+QgFHumJj5/td7mI/nGTC87xP/OdZnQnzNi72pJqAHqI6qXwXMnYL2jmvnT4ZcXPZ
         KJV8FWe1O7KCaQzVIA6JnlaI5AOca18wbYnpkUeure3/85h0UBKwJPeRqz4t6JJI3Wyk
         g7jqxdI0L1jncqO3gh2FZZVvZ5RUuW5jJoSa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2YfmStb+j2w+cuOjvg/lXsqwEFt/TTueE5RQ9JeBgg=;
        b=hi/zVbQegZsdjZeRl9NqBZOZRYzmfsBN02xjMcrcPSGqtPM7wEHlbg9GMaiBIyFFUW
         J4UeoPKYiG629PnFjvogkyVxKXnL9bllrLlKkGuIuGWKpK606C2F0GTfZYE/7yNNf+m2
         6wqS55y55Nf4z+W9HLlQCJRpUxzz6sDgo7XQj0e1OHyTh6ZLX9JWCgPKjLfJFcsWhf3x
         pVFyk3Mhi0JNJkd8YxkQkmxczt2A88uqTbWXUe82IBSN0iHHn5AVPNWgYjCylGf+AViW
         ZRm/CXRNiZYeGvWHNK2GwIuV+KCRlxZqJ5kEiFjzxPVA83XIEISootS8BgTBxaLUfKiO
         rV2w==
X-Gm-Message-State: ANoB5pl9rkL61qZ5VAC25xVgMMyBOr+ktkDBS9ZtdcJ/ifTLNXVIQy0R
        mx25ZNTdE7X1LqWPb2I+vqXzlQ==
X-Google-Smtp-Source: AA0mqf7IWmybbQ3hDDXF/EtrgdKbnAtlBS6wfTFanMjopif9NV6MnHfXLrQ6d4993Q6+uUW6VPdTdA==
X-Received: by 2002:a6b:d21a:0:b0:6bc:b2ee:a61e with SMTP id q26-20020a6bd21a000000b006bcb2eea61emr6515299iob.195.1668457166502;
        Mon, 14 Nov 2022 12:19:26 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b00375fbb8cbf6sm3224904jad.179.2022.11.14.12.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 12:19:26 -0800 (PST)
Message-ID: <09133d01-b064-d811-16a6-49537286f7ba@linuxfoundation.org>
Date:   Mon, 14 Nov 2022 13:19:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.15 000/131] 5.15.79-rc1 review
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
References: <20221114124448.729235104@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221114124448.729235104@linuxfoundation.org>
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

On 11/14/22 05:44, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.79 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 16 Nov 2022 12:44:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.79-rc1.gz
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
