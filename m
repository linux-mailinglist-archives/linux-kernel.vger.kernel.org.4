Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1D727449
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjFHB17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjFHB15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:27:57 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F3D269F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:27:56 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so172739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686187676; x=1688779676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DXgYUVNjJdt95Bw4bVvM3IlDSa8GvPwJzPZG92LbNYA=;
        b=gLlNl2r30bJe81WazsC9tTCXmOgMYBN7lt41Y5AxUnK5TBmtgO9dVHTHDyIRJUxc5/
         6jDO9dkPPtTn03fMotxYvTWfkquQQzPxet7mXG7auWZo/rtaw6XZwzRUnsd9rdUz1xKx
         mqcZluOcBWxrh7uQbBeY1HR2B0sLmpeblTkxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686187676; x=1688779676;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DXgYUVNjJdt95Bw4bVvM3IlDSa8GvPwJzPZG92LbNYA=;
        b=JpChDjypklXQKab+YW0fUYI8/4FaHUO0PvbzLOo2nn4pkkv4FJ+HO060/V9j/ufVgq
         qqN+BHISEef0wa6Wbc3gL99ikyAcuZJhUIg/BQ27suTx80KOcbhg+dDKNJBAsDUAqUFl
         9PDJLahj+MaS7pmFchoAxO5qmkNPLTUq0lujJ1eACHGwABElWBQDuVloowm5fmG/qjUG
         em3Q6qf5+EndGpyouMvlFfd5Ee4DdRwKNjX+kKEnx+B6GjyRbIGG4rvg1FvcZj547DNT
         TqPZYhpSxm9aTo80PY+lYrpheDV2yMiH4aTsykb1gb6Tzs68I0wKXi9vRxoakFYpsz32
         S4Tw==
X-Gm-Message-State: AC+VfDzID08UfHFL24iWm3d8h/MFk/wdh3FHSQNIxnhOlXKLN/i6tyCN
        pAT60S1sCHQj+rrXK2Dl9Ux9aA==
X-Google-Smtp-Source: ACHHUZ4bH6hCj19Qca9ZKp2WKi/nzl0FkTLr7/4qN4AVsI+iC/ot8ie5l/adYTSuJe0G02VnG7iRkw==
X-Received: by 2002:a05:6602:2c94:b0:777:b6a9:64ba with SMTP id i20-20020a0566022c9400b00777b6a964bamr3521098iow.2.1686187675970;
        Wed, 07 Jun 2023 18:27:55 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u12-20020a5ec00c000000b00774efe6fa24sm22748iol.10.2023.06.07.18.27.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 18:27:55 -0700 (PDT)
Message-ID: <687dee66-ff86-7958-7dfb-0d13375469a6@linuxfoundation.org>
Date:   Wed, 7 Jun 2023 19:27:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.4 00/99] 5.4.246-rc1 review
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
References: <20230607200900.195572674@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 14:15, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.246 release.
> There are 99 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 09 Jun 2023 20:07:31 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.246-rc1.gz
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
