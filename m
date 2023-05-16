Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6705B7042C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjEPBWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjEPBWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:22:34 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4721BF6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:22:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-76c6e795650so36606839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200153; x=1686792153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ac0ioQ+c/agX0WRk7EeCUVraJoAhLJrQS8Kbcj9FXFE=;
        b=NYP3izrDKGFAKo9cBmRWpQKR6CChN6VnP0SWN/kKVdhE8JVMhJbMqbOG5sxG3UkdE7
         DjrkEm04JHWfQmwc3nITa+Fg+gDk80wTapsJwJCvMTNXET8oz231b8ldndv2NRXUMd90
         lD3cRBi9FWmhQQDSGlYpB6qpd0ufgBXbyCcss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200153; x=1686792153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ac0ioQ+c/agX0WRk7EeCUVraJoAhLJrQS8Kbcj9FXFE=;
        b=QjD64HDX2sjBgi6m4jKRfd1c3PFPGCv3bcWIv0Mr56aU+alRVXQvbuElxGFJbz6Y0I
         /+WgUWeZAIakv1pyj/rS5ctlKMWe7PIimEYB9CAO2PWlvjx0/coneXreZBxFL3VIvtH4
         49Ea3N9BlUOhTTJXTMWQReECQ0S+vxaYoWxqPbsYvSsK2WsavCrM0jIiqLLxyZvbf1NZ
         VOQB+tT4jYuER5ku4uRW40EIQHzXjV6DrXwMHGAyn+ftoJ1v67tIqa+vskPNdMjvCHXI
         eDvjyLI7slUMj7cEjNRSYUIstShEpKY34zFVKjoTpyzhC9Ivx3Sa6HPb1qV+3rLTdYHv
         mskA==
X-Gm-Message-State: AC+VfDycq9akZOis3iPDMFWihJI/UBMfWrIMyEdh/jhdq2dVqWJtA7FO
        YHEiZbCWv929PbFvKfAJKzQISg==
X-Google-Smtp-Source: ACHHUZ7GIECJNU3Z41yOk9WmJnpNx2+ypBsPtv5STNILsOTiATWOHiIRettKcCXEe0mkzYZKBIGpjg==
X-Received: by 2002:a5d:9da0:0:b0:770:4c3:cd0c with SMTP id ay32-20020a5d9da0000000b0077004c3cd0cmr2083290iob.1.1684200153524;
        Mon, 15 May 2023 18:22:33 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u10-20020a02230a000000b0040fa32ccb0bsm7126442jau.79.2023.05.15.18.22.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:22:33 -0700 (PDT)
Message-ID: <1f28967e-19cc-4911-4e7e-4387a3093bbc@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:22:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.2 000/242] 6.2.16-rc1 review
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
References: <20230515161721.802179972@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.16 release.
> There are 242 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.16-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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



