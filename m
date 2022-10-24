Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAF60BD5B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiJXW2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiJXW2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:28:12 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B6D14FD37
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:49:49 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id q5so3189308ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7LHbcvZIY8r47g2KsyoVCnt3cTEDb/n81/RnCjdJ7Q=;
        b=dPue2clgRdYd4AS5JGvWhb+3qRAE5rY9oPc1ac5IJ9qh541g+KjAhAokThvCSYQ85i
         Dt6pI56c/EZr5s5CB0wHhG7FPoMegrU4Mqipew+jdp3Cz4rU3/v1XmrfrkcVhw8DVM9X
         RuuL4tHn0y9LUbqticD45uHEgj6vMPBv0x+F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7LHbcvZIY8r47g2KsyoVCnt3cTEDb/n81/RnCjdJ7Q=;
        b=6cI9ymDu//LcyyTQcqvdOKisTQM8s4/uytukNuFvKBugZRoMYb6UGwInQiV5kxKZGh
         o0Bvg5QrJW5LQKYFwDtNfvs019fUqFrCx5pK38cFcDHbkabvjC3Cj9P7GM6vVqf1xhCC
         9rHW23qZTD0viewdenzoNnw7t8CEvIwXClw6ZC2oMZwBJEV1cfog0Qmv/8Jsi+w2vgAb
         vhFf0VJvYW3RSIDG4u/UZ3yH0w0+fXwhyD9tR4jmpb+KpGDgg0LARCXIeeBn4pGrR2u0
         KLQDopKnpndYzXJl8gqBWit+3Mzs0OrhYwLk2IxEDXs6piGmH9Uj1uTHGITSjTsKAViI
         x9pA==
X-Gm-Message-State: ACrzQf3H/CBLgN3jW4xOjrip/MUSOYB5m9wpn9lS+VDXoWLevZfcCAob
        0K5mWKUB/lp8fARIhA1medpezw==
X-Google-Smtp-Source: AMsMyM4c1uW72CLag7R26KKH7E/esxMYN8j8ZTuhh+8/vqorNM8zozH7TLP1jcG6hAN6CvzhZEjD2A==
X-Received: by 2002:a05:6e02:158a:b0:2d3:f198:9f39 with SMTP id m10-20020a056e02158a00b002d3f1989f39mr23231166ilu.206.1666644493727;
        Mon, 24 Oct 2022 13:48:13 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z13-20020a92bf0d000000b002fa9a1fc421sm317236ilh.45.2022.10.24.13.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:48:12 -0700 (PDT)
Message-ID: <1f6eed06-dc00-c3ec-7298-05de2c4955de@linuxfoundation.org>
Date:   Mon, 24 Oct 2022 14:48:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6.0 00/20] 6.0.4-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221024112934.415391158@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221024112934.415391158@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 05:31, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.4 release.
> There are 20 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 26 Oct 2022 11:29:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
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
