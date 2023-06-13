Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED5972D69D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 02:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjFMAsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 20:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFMAsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 20:48:13 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFB310D3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:48:12 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id ca18e2360f4ac-7747cc8bea0so40601839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 17:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686617291; x=1689209291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEdxNFFhVohCl010Oq82D/VKe0cD6dF1PQkmM9OWJ+M=;
        b=WbzZ4rPId/ujKc9WfnzgJNR6zbmZn5s9u1PAGgP008Id6mmzPyoucJQsFkrPVkyljv
         mIB2z4iKTYdDovO98ughUdbkI9XzQY6XiJVOeUXTmYa0nzSlXoJ+koOXr0jrRIk72cyS
         j6hH84lAerhQ5ikOD2bMXj0lh07gLLc3Y/dmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686617291; x=1689209291;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEdxNFFhVohCl010Oq82D/VKe0cD6dF1PQkmM9OWJ+M=;
        b=b7+m/nWpoGwf+43CUrFIIqr9aPDX7R0uc6gNGb07JOH4hFEa0uSMMyt2EGsa7WakHr
         EX/CBMCKGvU/1Sl0bJjauvUS2cDjRsIOa5acEmvndOEa5aM05T8ajo66V6OZ3e6fr9G7
         ySQWs8KD8h9F0y2lwH7qgRS3uvFO6VcijoS8V37Boov7M8YxbfZ3kyWg8DNCwx2wZV5r
         HIDdKN66Iku08lyey6KkQpqsZd7ymEv8uEGK12gPZ6zoeLLOb1GTcK1VWpsuNq1X2ft1
         LJZ44R6YVvJ98WXod+MV40wYJwql4yr/MpPhzbkM/MoPqsTemCqWdpFEQQDFTf/4hgEX
         f/vg==
X-Gm-Message-State: AC+VfDyw+IO0Z4wKZZzqAvHzRSjIxH8ycmY7CnyVuoZX9UMBfxbxJsEF
        PVe9WgLzoShkeHtTv4wG3NEPcg==
X-Google-Smtp-Source: ACHHUZ4lnovdMhPjCWG1A9w376G/N+ye/8qOsLdzIQndElmSaEWOXslLI5f3CVxXZ02VqJUevgg7xg==
X-Received: by 2002:a05:6602:1789:b0:777:b456:abbe with SMTP id y9-20020a056602178900b00777b456abbemr5708330iox.0.1686617291699;
        Mon, 12 Jun 2023 17:48:11 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l22-20020a5e8816000000b0076c872823b7sm3499208ioj.22.2023.06.12.17.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 17:48:11 -0700 (PDT)
Message-ID: <52014a4e-7968-0c71-029f-9f7f45bea683@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 18:48:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 00/91] 5.15.117-rc1 review
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
References: <20230612101702.085813286@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/23 04:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.117 release.
> There are 91 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.117-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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
