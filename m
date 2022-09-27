Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749E5EB699
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiI0A7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiI0A7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:59:21 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BA9923EF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:59:20 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q83so6636194iod.7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 17:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/cxJ2RtF5lAdYw39eIOATjUYWPEe2tKmpN8dMrga17M=;
        b=KFH3g21hryNRGGEXjd13W0ZZD+MyX81HQ2cEHHdQ3G+jH3mt5bzCnWdWchc4y2ezU4
         tDI4xub+h7uMYjtc1dZCHosBxMN5rr/9rQDIyjBwqzGG9To5wIh3rF6ahHyJDOQ3UUyU
         cd5mjtAhUsDBl+uneLe+RElq5jL2mZZd/tUWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/cxJ2RtF5lAdYw39eIOATjUYWPEe2tKmpN8dMrga17M=;
        b=dqNlHlDMOPxv6an3fihx5a4WtcRR4O0xcZcuzzEfUh6649LhMIgnoVUttH7OVrZw2o
         saZ2s9aHBgnyZQEBIWK4XBTGSCXJ5X+MJ/y/XX0JJOn2IBrbEacEOnwtAD2REKtJtsei
         jN/ys6iqBfQERUS/mWaFP0xe5aUtdihvz7k/AWg0cbmUjrdRCdbVmgc1AR1P4GjuBs0e
         UJpf10Y4JmkqLKnU5yh3ZKHTocEvU8ccYn2Sg38yyAuAQ57dv6+EzNm3488glkepJGwk
         YVGMBIHvDTT7aR4O1Pvm8I4DmIAv2rEUSybOE92BPKlZCjx0B8FN6AJ2USUSgugSImRL
         jhsw==
X-Gm-Message-State: ACrzQf3x0yHEBhq8PGIi5txLqDEna+LTiRPYr3e3M65SnzGTHAemHO8O
        HcTh5EWWPioPSOBiuxjVTpxgjA==
X-Google-Smtp-Source: AMsMyM7l0+yRdLwaBzhRLAbv1rdk8ALwUqx6zLoDDJ+H+6B53TSXCegi1imcBte2ZGPzUyvbZ9SihA==
X-Received: by 2002:a02:cb42:0:b0:359:766e:fc8c with SMTP id k2-20020a02cb42000000b00359766efc8cmr12950391jap.108.1664240360158;
        Mon, 26 Sep 2022 17:59:20 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id u75-20020a02234e000000b0035b4f7172e6sm30756jau.137.2022.09.26.17.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 17:59:19 -0700 (PDT)
Message-ID: <247df1a4-b343-42e7-7c5c-3af3299d03d5@linuxfoundation.org>
Date:   Mon, 26 Sep 2022 18:59:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4.19 00/58] 4.19.260-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, slade@sladewatkins.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220926100741.430882406@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20220926100741.430882406@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/22 04:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.260 release.
> There are 58 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 28 Sep 2022 10:07:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.260-rc1.gz
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
