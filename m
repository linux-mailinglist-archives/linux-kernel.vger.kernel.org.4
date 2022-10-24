Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB1C60BDB6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbiJXWpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiJXWom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:44:42 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6223617A973
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:07:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id d142so8786522iof.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sMKtE2hhzgHv2HBqWzucHUcm8HcwpCie3qJsbROuUfw=;
        b=Jr5Wt5vmvv2Zdl+HFMM33eNpfJdKz8kO3X7cAPWdxTkr3HViwI8493JrbXE8z+aRj+
         8u973BuRIVS+8hxnqxv2xgiIMXtaCqsFnPE+0R55MLl2WlH2IAhJbQ82SJL+VGP68Mdt
         HeL4WEoZHU2sYxsUBV2P1wNF54JMyLIC8MnzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sMKtE2hhzgHv2HBqWzucHUcm8HcwpCie3qJsbROuUfw=;
        b=XYeRtOCM47THpZ6WeKhRmepSHggLZwvpyuVWUjG2LLwLYdPenTDGfiUDkM31aTBfGZ
         ZZI8eLYLZ3K3QhipWq71hGVWhWlMiyra/qrxa+/GWs8EZO9Vy9QkGAiqFOr2ZOvbuEMu
         WqkDiDFhnf/q3VDvh0GP/p3+V7AQquP4fhyc1j8k8FlflcLpJ7jxupv0cDtOYbUt+bPF
         n9cVbsaMOn7hbCCjgRiVeReRxVnNZ6g+l2ZgGK8fXi04Ru0bxiHadIiBMurYFLd5D/Z3
         zvf/Fi/qxnNiO5FO5mWxUVUcYqrP9MP8QrCFMl+dTBmUGQVp1mA62rpxuGeXjC3YHlEj
         q0sQ==
X-Gm-Message-State: ACrzQf2mBjdIatH3+hNMXx1SaK/APDsI4Wa83Do8UNOX57b0nIQqxmhX
        2LVtI4Ww/OwT+sjtnQTmu9iUWQ==
X-Google-Smtp-Source: AMsMyM776wszyJv/RICW1tRtaLUxtDNvqlaMUeVsn4WSM2T6jSfqQlYHVfL/mkDe8ywursZPbzFQ3A==
X-Received: by 2002:a05:6638:4810:b0:374:f69f:fd51 with SMTP id cp16-20020a056638481000b00374f69ffd51mr2523467jab.152.1666645577250;
        Mon, 24 Oct 2022 14:06:17 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s13-20020a92cc0d000000b002f966e3900bsm315326ilp.80.2022.10.24.14.06.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 14:06:16 -0700 (PDT)
Message-ID: <5bfc0604-550d-9c9f-933b-f9b07349a4d8@linuxfoundation.org>
Date:   Mon, 24 Oct 2022 15:06:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.4 000/255] 5.4.220-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221024113002.471093005@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221024113002.471093005@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 05:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.220 release.
> There are 255 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Oct 2022 11:29:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.220-rc1.gz
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
