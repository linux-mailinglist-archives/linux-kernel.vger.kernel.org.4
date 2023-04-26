Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7086EEB6C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 02:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbjDZA2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbjDZA2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 20:28:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306B1546D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:28:43 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-763af6790a3so26227239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 17:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682468923; x=1685060923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uhyMv9OZ9mvx4IhTSE5UvrwBRU370RxidTCgJvUyue8=;
        b=Heu0niEzxoY5rTYHyEsV4e11x0/pdN65vFedPvVmiwHLXFJkV0f45yqcZAzBYIXF2a
         j+njBZUW4bRtO2noJsWO1x9v+bpd6/9EcJoNj9VMXd6p44FeXR/0rYmRmNdOjztnwbHf
         o/hCSF5meDdVKFySpTD5Um8Vnh26Estd3mKgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682468923; x=1685060923;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uhyMv9OZ9mvx4IhTSE5UvrwBRU370RxidTCgJvUyue8=;
        b=II6LI3ywnv6i2USDj7Z7U0eEwaVcmgRtBhK+lmNzcVk7dQ2zqP+Ap8yAQ6PVJtKhN9
         9HJuHnUedP/8nheFOxfghQcd2lHE2Mw1ZuTuXtoIj10wGqcFtahMF+5O/W2AvQTiR4Qq
         AmlOIijLt2VW5PenyAuXXqZHjIKFKbS5bfwmxlWzP/mr7aMVLXyK36LDnhbkRkTfTzur
         ksm7uPjPtE3IdEr5oqdeiZvLK21uHVSKQgMcSDnAmF1+WvjI79Tzwe9b0lorHRcIxh9m
         /CGSBdL3WSd4zd7O2Y7FFIc3qkvft/34K/uxIA3DXvxYby/2pTJPf/wQJ+2RBvFxf8Fl
         xp5Q==
X-Gm-Message-State: AAQBX9dIU+t1zeVWQCc3l+/KtGY2cdiAvn6FloPxKoZVwe6TLJ/c9yVs
        d2r4xfb3ePS7026cnZIqK6XBC42WWDTtnS5iw9s=
X-Google-Smtp-Source: AKy350ZYv/G9pJTFwWGEygpwAJ1mJ1eme+0ltmLg6fdMNkFzdqS0GA44pp9j5JLnQiesV0wCpicDgg==
X-Received: by 2002:a05:6602:2d81:b0:760:ea9d:4af6 with SMTP id k1-20020a0566022d8100b00760ea9d4af6mr2702166iow.1.1682468923149;
        Tue, 25 Apr 2023 17:28:43 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y68-20020a02954a000000b0040fa2395ad5sm4583603jah.178.2023.04.25.17.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 17:28:42 -0700 (PDT)
Message-ID: <c65f5688-5005-cee4-903f-526cc0d0ca35@linuxfoundation.org>
Date:   Tue, 25 Apr 2023 18:28:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.10 00/68] 5.10.179-rc1 review
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
References: <20230424131127.653885914@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230424131127.653885914@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/24/23 07:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.179 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Apr 2023 13:11:11 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.179-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
