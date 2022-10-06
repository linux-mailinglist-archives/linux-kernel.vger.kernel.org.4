Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173765F6E4B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbiJFTjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiJFTjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:39:48 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8A8959A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:39:46 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s21so1634898qtx.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnZGCi4lAmBUf8JisG3D6lHwZb0Q4B1rLpDXzInXGYo=;
        b=GudvCiK6AJJcPDBe0RMPUZKJ/Ls83ouOE78RjCgTRwHjduxtK+ucE4gyBEDPavlBjg
         SAKuoLI9Z52JB5EnguWzgReETECnQ4T+QWXMbUgkgQWJoR4KZWwREgF6xATVsod4u1ro
         AVActcJLWfAGLxSyBZzaTZfyXL/iPfMt+KZ9UEW2p0i8zEXmkovEMt8+89dlxSoUqiJc
         aC7I833EdYjJOz4mvL5EWZcO3Qq9ONE4RKm/zSdaibRdnUaTzw1hc+EEee5eXBFe8q5f
         UXzPTxoZoBAmOpNOmqH3leLAWQP5rkD46h5/7bQrM0QDWLCL2E02b9LnqoCQ2v2ySodd
         1/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnZGCi4lAmBUf8JisG3D6lHwZb0Q4B1rLpDXzInXGYo=;
        b=IxUFoLNFDhz48Km687haNl+760vLphsKTLDCd3MwuJOQT5q5Ly+k0Vsnm7Yt+HKNhV
         ru4lpb0Xl6L3pTmg8kis289YMFxOY3d1fsJO/+o4EnEFy3+VHHLl5WCaH75MhkNLDLse
         /GVYW/YJfSAJ0FlPWncncLVrwOKQM0EcUYINRQ1flylBfiqSdtRMMKtGBbFc6r18l1yq
         FFNc0V95PxWtV93c/z4oDbq/ythMFvz5GvNj4VJQENC6D7qdCxaKvmw6VpvbZj2RKzGa
         VX5V6tvtBgra8TbzSO+iQrVoMbGg5Vd8YiibqLfFSHy2R8ouXl9BuNAvlTJI8YQsBlWa
         JrfQ==
X-Gm-Message-State: ACrzQf31YI5xfofOpPIXpq3+c7HHb1JqiPgrmdGDQ5yUYasSmqY8eMtE
        9IHxOgPzmMu9CpRsnnQSYrx5kg==
X-Google-Smtp-Source: AMsMyM5ggu6d7HYK3018zl3UUJe53SmLzrFGiOZdAj8nJkPr9zL6QX+Js40nJA01UQe1FAqeGlxKGA==
X-Received: by 2002:ac8:5f53:0:b0:35b:b155:1c1f with SMTP id y19-20020ac85f53000000b0035bb1551c1fmr1648601qta.148.1665085184482;
        Thu, 06 Oct 2022 12:39:44 -0700 (PDT)
Received: from [192.168.1.30] (pool-108-4-135-94.albyny.fios.verizon.net. [108.4.135.94])
        by smtp.gmail.com with ESMTPSA id bm8-20020a05620a198800b006cfc7f9eea0sm20187653qkb.122.2022.10.06.12.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Oct 2022 12:39:43 -0700 (PDT)
Message-ID: <1777dc59-d580-d843-3049-ff7019de53b3@sladewatkins.net>
Date:   Thu, 6 Oct 2022 15:39:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
From:   Slade Watkins <srw@sladewatkins.net>
Subject: Re: [PATCH 5.4 00/51] 5.4.217-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com
References: <20221005113210.255710920@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20221005113210.255710920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 at 7:31 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.217 release.
> There are 51 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Oct 2022 11:31:56 +0000.
> Anything received after that time might be too late.

5.4.217-rc1 compiled and booted with no errors or regressions on my 
x86_64 test system.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-srw
