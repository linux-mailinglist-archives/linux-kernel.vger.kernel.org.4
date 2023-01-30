Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549B3681C4D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 22:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjA3VGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 16:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjA3VGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 16:06:01 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B9948A0E
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:05:45 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id l128so997524iof.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 13:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Yg7svhVghi2FwAaCr1trqBzknfSY2QukGFpxxcVl4E=;
        b=f9+SVlIeCAtmftHkMq4LU3vuk8e7WGQi5yVTzJYW7GIeXW5odNP349fdMgOLBeMAzq
         LpyGiKEQxsA62QZixvCi7F0UKsw6cNfbTDejCwhigPK30f80OFwpMJauSISEgoTGq+XL
         ZHVgFIi8NBfcBm0j8mvwwPd2CuQFt0qkxqnfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Yg7svhVghi2FwAaCr1trqBzknfSY2QukGFpxxcVl4E=;
        b=fBR2SnsVD5JPATbO2zGQhkMRjrpFJdl33z1eTKItO5Ils2vO/+DS5z7gKQGRflhuS/
         9NIwpLYgtFGCpzmqcew7QoaiyD2jiIUiLkEFccBo6fie0DhtSCrJtbD9JA7ongn/8QAz
         8I4LJKf1E6mf1RCPr32Qxw6fAJfc1i5SYRUiEylPlcu3AFTzDDGS+wEJYjAlBu+TOlAZ
         x3wfyhE8wF9D/NbTy0cfEDM/qdZVQ5ViWRJbz/VEUE8lz4bHS1NkEqqeK/hLJAEQqRIi
         iwUotnQR9J9i7XQsfRs46b92XONvQ+sjYTwqT6NrjcguI9GTSnvcnFC764JVxJcX34nY
         VygQ==
X-Gm-Message-State: AFqh2kq+FY7Aje9tof51d+VpbIBAHVbVphclQJPm2sMWzPIyohiDXFXP
        PpOl8IdactW+iXNlUoUB8rW1yg==
X-Google-Smtp-Source: AMrXdXvqFoVe6g5u6x5x85R35qxNQPoaSl/vg+4nY+i2nCJz1vJxa6EtsKvRTMZ++C2vGiMxXCQYSg==
X-Received: by 2002:a05:6602:341a:b0:704:d91f:9932 with SMTP id n26-20020a056602341a00b00704d91f9932mr8577267ioz.0.1675112745041;
        Mon, 30 Jan 2023 13:05:45 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c33-20020a023b21000000b003a068d00373sm4965945jaa.138.2023.01.30.13.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 13:05:44 -0800 (PST)
Message-ID: <ea974e95-723f-23e1-364c-4d4a388fdd31@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 14:05:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.1 000/313] 6.1.9-rc1 review
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
References: <20230130134336.532886729@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230130134336.532886729@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/23 06:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.9 release.
> There are 313 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 01 Feb 2023 13:42:39 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.9-rc1.gz
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
