Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD86B735B28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 17:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjFSPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 11:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjFSPcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 11:32:15 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2EFC9;
        Mon, 19 Jun 2023 08:32:14 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-66767d628e2so773506b3a.2;
        Mon, 19 Jun 2023 08:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687188734; x=1689780734;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wmvl0aCfmdGaJ6IP/J7U3w1ihrhz91UltYjZDif8Ll8=;
        b=SZnTb2zTrDD43NblYvrQTo1FVdEtry0Y95tUye6RBw8eq9WHET8gXoMmuhNZcaSdx+
         o1RVuXo8q4VGuc97TLcDVJOFLXlnDAZp+HfNVGDJuW/p6wBourXrKqEmro8uCs06BVzS
         59nD+IMXFK1rs9USMgiI/wVvGJShDu6cWP6Gyhi5r5JQTpIV3+j9oIlAVLf5FQG6NKCy
         PeQEpdlEo14pwiP+ZcA1Jz1d7NCGpKozrp0qPMG0NWk5s/A/In3vjYW4jPzel7rZeLPe
         spbflAbyBFABmf2YTGXGyWOXerUdETEv6j9WOtqBl0ax60naPh1TjSznyZSINWivy+bq
         eJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687188734; x=1689780734;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wmvl0aCfmdGaJ6IP/J7U3w1ihrhz91UltYjZDif8Ll8=;
        b=CNNMidXjhH8YkVYvnO9H0LmuJEOZg5VHR6FhJN81k9QeoYjmQ36rGLxiJoY2iylOk0
         8E9oMzUHuayxrmFlpmdYWd8+xJujcWDxtkbUVQLDPgb5sZb5qGgzmbPFz1/4x9HKHMVm
         LlRcWyzTmPhhwUI2TKfIKudzT+7u4XkUXe7SfpKEE0h4vhS5M6O+QLVxmAMVnzLh0x2k
         EaATEc9jJm6xsEXWRiy2FOQsiLMw6DRlk2M87XjoTEU+26eZVGkd8YckgTzggzyCAruu
         ecX2C0LqXCb2I9wt+KAr7Tymu2TeaHf/MICdwr7VxhIN+n5XgRT4FRMrzYdHEAMlbOBY
         vyiQ==
X-Gm-Message-State: AC+VfDydyM5ofI0J5hFzv5rNddfQUUMbg7a79//xV/e7zuHJ13Ooa9mF
        8nv0em336krOFM7/FLEItFmxHKjwhhZv3AGn
X-Google-Smtp-Source: ACHHUZ5/TNzfZSPePnXGZ5nGgfPZJWvn922sBf6v6hnhuOxmVmR8EFjYqib7KIl+OGe0U/y/XXWNTA==
X-Received: by 2002:a05:6a20:3ca1:b0:110:9b0b:71a5 with SMTP id b33-20020a056a203ca100b001109b0b71a5mr6754278pzj.23.1687188733724;
        Mon, 19 Jun 2023 08:32:13 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id h126-20020a636c84000000b0050be8e0b94csm18532175pgc.90.2023.06.19.08.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 08:32:13 -0700 (PDT)
Message-ID: <2567d144-b3b3-a85c-00ac-7e560ebb3347@gmail.com>
Date:   Mon, 19 Jun 2023 16:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.1 000/166] 6.1.35-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230619102154.568541872@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2023 11:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.35 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.35-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

