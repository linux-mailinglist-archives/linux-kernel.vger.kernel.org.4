Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAF36C2582
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbjCTXP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCTXPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:15:54 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C118C24705
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:15:52 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id o12so6202243iow.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679354152; x=1681946152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtAxNqWOHwLE7yS51A5Odfdi6tRaNsIBNbTA+Awvbiw=;
        b=gmXoMlyrRZWnoT4iQk9DZz5ZraHN2NdE7axHAxJSesQXGmlw3Cr6Lz2F0muj2gdh1U
         lM80APvBr+nT13x4E6cInaKAjMDeu2N411zee2x5VwoRj3D/Lo9dM332gAzMK6yZPgg1
         REwbsI/vMYVrSQuQdgjfz2PO3hyaqzwoMKulA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679354152; x=1681946152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtAxNqWOHwLE7yS51A5Odfdi6tRaNsIBNbTA+Awvbiw=;
        b=CVsd6kvBLLfFxvMUNc6xp6bwPCBJw531QgCrJaOEUwAuzhWQqRYWkj0OUFkZxP65sR
         x7A2AkELQH45gdHaTBKK+N0QGR23kBqCyXpf/Zl1YQm0URjqoXIuvOz1+VoQQvNBmI5h
         N1pmWymsOemDXE/e0rfUlATRk/etHP6w/XQMn8W99XSyK0BYjwgOoShItyD+VHP5WwiL
         VOHJUCSopuankzndTYUnEpDY1KNKtTIKTp+nt+INOmrKHyD5sHGZpYdfCzqz3DkyWlOL
         JPf9LbfDNFEvm6e6AywcSGY2ocniRwPekR8ZPZ0HvExpNlO43huB+t0f7z1Kl37kigZ9
         OmbA==
X-Gm-Message-State: AO0yUKWZ6aNwYvPtTWw0KNJNqkNxyzM1l/npUQdp7QRekA9cSXfQKFhW
        mP/ZZ2qpsxK3vvs2Y4M1zcuWUw==
X-Google-Smtp-Source: AK7set/zjBPDnMBvyuINBNDZgvU8wFXwpesmr0R+3/eILHVMsS7RDiWwUqJuAFgRxcQ/8IIUfS4l/g==
X-Received: by 2002:a05:6602:2a42:b0:719:6a2:99d8 with SMTP id k2-20020a0566022a4200b0071906a299d8mr1130485iov.0.1679354152132;
        Mon, 20 Mar 2023 16:15:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c22-20020a5ea916000000b0074c80aa17f0sm3276618iod.0.2023.03.20.16.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:15:51 -0700 (PDT)
Message-ID: <e3ea7b81-73e8-9ca5-4588-d7aaf9f2dbc1@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 17:15:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 4.19 00/36] 4.19.279-rc1 review
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
References: <20230320145424.191578432@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230320145424.191578432@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 08:54, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.279 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Mar 2023 14:54:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.279-rc1.gz
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
