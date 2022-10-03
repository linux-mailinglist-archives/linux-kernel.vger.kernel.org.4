Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B21B5F388D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 00:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJCWCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 18:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJCWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 18:02:43 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D216532A99
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 15:02:41 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o13so1302831ilc.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 15:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=E1Sl1xXxpGGJLVGbTFaYCan11Ji3Qf4gP0WogW+bp4k=;
        b=b9TMIN4BSypC5t1W+a0Es3JC4H9VOQCm1g22ANPe/shX5WR6McQuAxzKviDWQWMEz0
         vB0VeGw2gDkENjTH4Hvkc/90u/9hHdOCB8fi2qvSVrpKGin22Flo2ZdiCWPHlHTMlFmY
         kKW1OY91D57q67lCSIO9NzV6+/5X4xRMS0Vzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=E1Sl1xXxpGGJLVGbTFaYCan11Ji3Qf4gP0WogW+bp4k=;
        b=JV/sNtKC87D+MmqPCkUc3r1Yi0zeTKTELj3fLXME98USjji6haC/LCOaOce+cd6aUp
         0IA+/7oeUaiLNCEKCLSlFO9lEJHxNTY2hRqS2Z5JedLdURkJWLNh0EQt8kkAq9zHVP4Y
         jJK7xVXwwIK0/mZzv3inPDqRv4H8bX9Tg/+qo5au8rDBKEKXV6hwx67vgn15pMc3YI+l
         KO+ibuTtCTkxeg/Z92w+fRedhTo0EaEryrmToEugQFKUkV9lytLbMPw60N50jhJ3KUHU
         9KQCdzpItSNUyaj/76pbSIsPBLOo3seVC0/WOx3muudMFErWBe6buUnfGxCORFfc3Ijr
         kEVA==
X-Gm-Message-State: ACrzQf04628vricbhsRoVEwPLLHg7Q3DcpbOUm7+ctyb7LRoPtDc+jds
        daiUSAHWFcitOoyhWbvMEssQzw==
X-Google-Smtp-Source: AMsMyM4reRUtMAn1uOcBD7Iozbllz1bC9EgIuUlQWY52DQhnZcqu2Vek6pC6v6e2/y8y5mj/ONw2vg==
X-Received: by 2002:a92:cda2:0:b0:2f9:5302:2c04 with SMTP id g2-20020a92cda2000000b002f953022c04mr7939277ild.135.1664834561140;
        Mon, 03 Oct 2022 15:02:41 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y15-20020a6bc40f000000b006881f702ef9sm4946390ioa.14.2022.10.03.15.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 15:02:40 -0700 (PDT)
Message-ID: <467f11b5-c11f-37ab-f8dc-b98ac0355c02@linuxfoundation.org>
Date:   Mon, 3 Oct 2022 16:02:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4.19 00/25] 4.19.261-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221003070715.406550966@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221003070715.406550966@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/22 01:12, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.261 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 05 Oct 2022 07:07:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.261-rc1.gz
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
