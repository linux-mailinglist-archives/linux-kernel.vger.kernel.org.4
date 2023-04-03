Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B616D5519
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 01:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjDCXGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjDCXGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 19:06:39 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00405C3
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:06:37 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3230125dde5so1233345ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680563197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tftNsrKQY35zoWyynO1WCXOq7fOJA4wIHqn5Mjwxi1c=;
        b=GgHbdr0M1S+FoXIAcR3PmPV2pWtcXOMQIYkY4ffWo9l8CPYQCMozTC5lz9s5FOe9wN
         7EH8KV8JgITron3fE2MYkb9FxrBXE8bMWQK8XeEPDC696RGpVYYyqxnA42E2sEhwxNEm
         yNTeoqbZKkFPcqkMJ2jg3SaLNdsdwYF3x/0Jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680563197;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tftNsrKQY35zoWyynO1WCXOq7fOJA4wIHqn5Mjwxi1c=;
        b=swq9XGR/bJmSejXJLLhKKKzcQrQOX9gMz0mEmylhyCKwGtuYh+LGc7HoukedISXinL
         hgeS9EvxSm/15cniiY+gG30fsAk4f+4tSjkUMi9dfPaFoVz0z4KYGez/hyL/0HA/6QHK
         VUDLObHIfVa17ay28CU40phrDvMBa+dfMpj683TbQ9TcKjh9tvx1i0mbqBfJfLUJvesU
         8NeVQePJCmBkvz3hSGEz9Hipnk96kNq3QA0DFi7UgDtDNGReKty+k09CdSg2jMQHgXB5
         1tppmD38NsHUMpwuifqSt/Bfc7tANHfxFerOhPuWRrs4Pc6TO/BfHbwzzB2ZC4wyBQHF
         nrhQ==
X-Gm-Message-State: AAQBX9fJgSbc2mPFskcLeY8rNPU0JbJbYIxAGiYB4n0Dsax0DC8gjApa
        HNOYaY9NkUmIWnRtKdcmVl0v7g==
X-Google-Smtp-Source: AKy350Y8qbVFV58G+meerQx3VnNYFpOFEyTa+nxTiHXM5oBzeompvUn6ExYOaJOQB2nmy8vH/F1X8g==
X-Received: by 2002:a92:520f:0:b0:325:fab5:6e6e with SMTP id g15-20020a92520f000000b00325fab56e6emr441151ilb.1.1680563197304;
        Mon, 03 Apr 2023 16:06:37 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id 8-20020a056e0211a800b00312f2936087sm2858519ilj.63.2023.04.03.16.06.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 16:06:37 -0700 (PDT)
Message-ID: <2583253c-349d-5005-ba0c-f07d15b42b15@linuxfoundation.org>
Date:   Mon, 3 Apr 2023 17:06:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 4.19 00/84] 4.19.280-rc1 review
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
References: <20230403140353.406927418@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230403140353.406927418@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/23 08:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.280 release.
> There are 84 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Apr 2023 14:03:18 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.280-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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
