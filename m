Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7C96C2552
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjCTXCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCTXCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:02:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495851CF53
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:02:00 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id p17so4451821ioj.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679353319; x=1681945319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ol+B8Rm7LVaQanwklijT53+0nw4R6I7B4CbLiSGN/Pk=;
        b=PR98NuIACi6GbtffTTQ7GRyP4Rm4we7JytqtLL0DNMowMIpj6lwi+zMMLMW357zcV6
         YdebfM1/BAdRQY3RkxPHtNVbJ0GYit4yBNH7E1whw/0NeFAWrn4AEkkLVkT+jZmar9oD
         SSq8qzXDLWndR0TLSaixDGX1C/o57uvdI+4N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679353319; x=1681945319;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol+B8Rm7LVaQanwklijT53+0nw4R6I7B4CbLiSGN/Pk=;
        b=Z9TzMRvRhq8Gepf5wQvy8YxyteLo1uVxQ9nvYmybXarwDWfzM41qsUdIfY9dhfR8U5
         kd6j8oZhdMJpnoHhO5+h4YXENh5DarLK8qCAT84PoZzKph6nB9APGBgxhcxo/CXycywO
         jSQKNRT7NkWhGL6dx1OYGx7Y0q1D2AAPLCx1Zj/iuwgIJrJQuJv8Ywkbq7SiravijIH8
         /7WeryjDzbva+LhjGFXisQi6vmrXRjcOkSHNzH8AWiKMgiWc28uZY4mtc7HawwfOc5ru
         ce/36Z95tZH7kYr9kp0U+XHkVxfbUTHGBPerVuIzzYkOtSnNto7Ef7CHf2vaQ4fOWGf+
         WxIA==
X-Gm-Message-State: AO0yUKXoksFA6BWJZ6oPhcPZaoJBjFLNyC/tc1G2NcFhzAbuAKI/WdIP
        v2TFaHon1k4qpg2tFx4PgieRuw==
X-Google-Smtp-Source: AK7set+J2U/lAYm7gRWd7YMrfKnfYIGgwX40P085kk4oMiavf4S1Ehp5iZ4v8YfjrYKAmn+dfxfwDg==
X-Received: by 2002:a5e:c817:0:b0:752:f9b6:386b with SMTP id y23-20020a5ec817000000b00752f9b6386bmr690135iol.0.1679353319570;
        Mon, 20 Mar 2023 16:01:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id g21-20020a05663810f500b00405f36ed05asm3553624jae.55.2023.03.20.16.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 16:01:59 -0700 (PDT)
Message-ID: <9d8e16ec-4336-f26c-a132-d95cdde2a4a1@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 17:01:58 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.2 000/211] 6.2.8-rc1 review
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
References: <20230320145513.305686421@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230320145513.305686421@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/20/23 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.8 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Mar 2023 14:54:32 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.8-rc1.gz
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
