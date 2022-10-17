Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01426015E2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbiJQSDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbiJQSDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:03:30 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B310C66A7F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:03:28 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n73so9733130iod.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DbgezvXKLgiem3+4EeydQ6CeJxJLx0Dqes/r2HXH/XY=;
        b=aPFgSok91eIpFeBS0hHQvmTHA5hLH2akEb7Nib5Vh43rS2QBdXj8tm+lqTU2EI+3Hc
         bo6wPOBxdtOs3qR/eEH4ylQ7tc2l516gI7GB9id710873m2GiHLNCG9udiwWfTbUdGoj
         yCJMyPhtV4b+Qu1BgQoBc0fXGRXbw7jREmLgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DbgezvXKLgiem3+4EeydQ6CeJxJLx0Dqes/r2HXH/XY=;
        b=zy0HmOSQqvgUI6vmrCSkXwoDs/Wg7ZGcz7sOTFBKPLDXhH1xGYew5Wsu/nKvPTo5A/
         oQSYCRKpghrJZX7866Aj1zHqANUPSkSW21+a6XPCaQ2StI9og/yTk4xdn/hwEyY+hcjj
         6/n7p0Dbo3MY7M++tZrgoBan6CQJdIe3+Jow5mwCRKI8dUfWBwic9rtJmKofHq2sLJmT
         mmDnyVXENfNff3aWdvRkvQsrnNDToFdsUx2shrKrPgoeOIOLRbiDpQgwG3c0HHUZTuu7
         cIt2crldfqlcaSxaPqXtqfdhVvlcbLeocaNNNEfLraPHNo3INop1/3CotaqOenPoE1AY
         TDdQ==
X-Gm-Message-State: ACrzQf0ajr+6/F6rUK8jMarSM+ly0lPafb2DcsY/Qj83h53c0J+lDL2K
        6rOvFEjPFYa7vqzWH+cmkOGebg==
X-Google-Smtp-Source: AMsMyM67qRCW1VJvDsINCOInZu391P8W99lxkNG2u9r2m+xWJQ26OIOAVHKJibKrw4HCNwR8aqNzqQ==
X-Received: by 2002:a05:6602:27c1:b0:6a4:cd04:e392 with SMTP id l1-20020a05660227c100b006a4cd04e392mr4908142ios.23.1666029808025;
        Mon, 17 Oct 2022 11:03:28 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id w18-20020a02b0d2000000b00363b7cec211sm159711jah.135.2022.10.17.11.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 11:03:27 -0700 (PDT)
Message-ID: <7471a614-f063-3ca2-4bd8-2ee7eb8a0745@linuxfoundation.org>
Date:   Mon, 17 Oct 2022 12:03:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.4 0/4] 5.4.219-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221016064454.327821011@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221016064454.327821011@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/22 00:46, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.219 release.
> There are 4 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 18 Oct 2022 06:44:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.219-rc1.gz
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
