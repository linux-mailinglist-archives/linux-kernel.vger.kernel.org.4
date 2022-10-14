Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40DF5FF1AB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJNPqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 11:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiJNPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 11:46:38 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B491D5E2A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:46:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id l3so2311886ilg.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 08:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z5kWJWTbhCLIU0KzFSLz7SA+60MxdeDsMWAk776+PIY=;
        b=JFcBJzFYE7749zg1Yq5unvXfW9bdpJKVEHHrGTa7PO8VZ4bvaQlVQRoC4xF+noCUWC
         ylAv1wt9PPZ04nRjJr1/eaETmk2wpiUFxfWbaKWRZwCU8lJShAP2avPE5FFggyxyUHYW
         3SGAlXonlLpS3BQWj0/DhxnfGvHGy4VKB2lrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z5kWJWTbhCLIU0KzFSLz7SA+60MxdeDsMWAk776+PIY=;
        b=f2v0T1KkcNT4iiP3EnavGLhG9v1nzFPlEQ4GwevPRiRap/oaGK2PexUhQTyrkSzLMs
         kYnQuw1Adq+D4doF3Ne5+xfY4IsdD+6CUqIev0Fa7Le24pJar5hviYuYRCoKv4RPE0Gf
         O57/Xw56r7aqm5YnnsJiNnOrRGTGnNmeMcFUnNj75yXqahf6gl1nG7xlIGljcCX8wl80
         D9yKw3OomFgQ1M6x+Ino5LW/wt4thGaxPWiyPjN5EtOEW+Mwe6cvIvZMbYRtJB2grUnE
         DhoNEoL2P3k+0+r5bwE3pTGp87RBOv5VNyMYUQpVrguaOUGWVuhcRH/BYca+aQce6USU
         u92Q==
X-Gm-Message-State: ACrzQf1oEk6YIBNc2R+cWTeFIWfXpaSAnM1SRJ5Me+rD/dmCz/dgE6r+
        aahIRKw25i0GoFQ7hJfKR+7GEA==
X-Google-Smtp-Source: AMsMyM75L5kND4ZIQ8A7WllHGvM61JfcpjFyk3/le4pBszfYptiOnWhMisPh4aReM9RY8ADdb2Eq0g==
X-Received: by 2002:a05:6e02:160c:b0:2fc:1bc4:1811 with SMTP id t12-20020a056e02160c00b002fc1bc41811mr2795194ilu.306.1665762391684;
        Fri, 14 Oct 2022 08:46:31 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id az34-20020a05663841a200b003635b1313b9sm1215441jab.112.2022.10.14.08.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 08:46:31 -0700 (PDT)
Message-ID: <0229ec53-376e-75f2-fb80-12c9534cc2c7@linuxfoundation.org>
Date:   Fri, 14 Oct 2022 09:46:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 5.4 00/38] 5.4.218-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221013175144.245431424@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221013175144.245431424@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/22 11:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.218 release.
> There are 38 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Oct 2022 17:51:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.218-rc1.gz
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

