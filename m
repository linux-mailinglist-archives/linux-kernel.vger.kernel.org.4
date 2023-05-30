Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEEE716D8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjE3TaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbjE3T36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:29:58 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B35E107;
        Tue, 30 May 2023 12:29:57 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3f6c0d651adso54133881cf.2;
        Tue, 30 May 2023 12:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685474996; x=1688066996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCGe5Caz3DEnl0P8+9VuWwQPUYNNo3nHDhzKR02eYIs=;
        b=hbjlXETznLK4qdRrUeGs/hgHvEYRZwB5YNehCAn/zWwHA3EXNt76XaBTDaJwcy8SLF
         HZePu/OBBxJGnqGWQ1ZoshQ8XvvM0OYAcOeQCpbaDBp4vEKgf0tnKActfBDuAcWdz9tm
         9MRaaGrnHchKUlaqMzzaVR2GW4bWQ3NEYK3O9I+5VKO2rpQ3tnZVrMw9erdPuEqZr/4r
         KFacdRhol0xZfgntrLGD10vgNvHW4+Z+9XD8ROqFpsT0w7xKetYkEG7qiXTRPHTfF6gW
         A2ovI+dcuZhjrXhp711C7WlnRmTY/jTHSTVDLfGkj3boW3aUP7Amvn6gfnv6aN1ufFzP
         nRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685474996; x=1688066996;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NCGe5Caz3DEnl0P8+9VuWwQPUYNNo3nHDhzKR02eYIs=;
        b=GaNZAIzbQlz1m7P2LnqYSmHrkeu1htz//QAX8tqCS9PPv+QyNJuRCtn8NNHEyQz/63
         vD8OwhD3+jKys2uD83IY3R/0BY1VeNi4YXZRtZqAm2C64nAYpHo9sKY3WOdPD74s679k
         GD4pTyOF1+kGxusqYprjEgpFW4AhLqz5yAaLthn4WmGF1JPO8GnI/J3J1TplkXLRbnaM
         nJ9UX7ejhWb6PEP6vS7x7UiOLRbPnMjswnYtpKfWj1e9NT/naExcwFCrp+iBiIw3Pgks
         Iglqi+ULBGuxKuMKyBOoVakOIKwInUzmmhi8prN4XIeO4OuiejqTzfNctb9FVOnyyZjk
         87sQ==
X-Gm-Message-State: AC+VfDwLNBJtjpCcz+Oo8z57hnyiyt2VJP+OlSeyjSh0jAKocKhyNXcY
        /MvWOIF11z1jNfmae0gMk6c=
X-Google-Smtp-Source: ACHHUZ5Q42xzU7BmXAeJg92SVGPbv7pe1B1oigWtYF8kP83jXZMjLmnPfFNzBOQpMr63SuIdJV1llw==
X-Received: by 2002:ac8:7d45:0:b0:3f5:3f0f:3744 with SMTP id h5-20020ac87d45000000b003f53f0f3744mr4036598qtb.52.1685474996631;
        Tue, 30 May 2023 12:29:56 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fg20-20020a05622a581400b003e39106bdb2sm4970070qtb.31.2023.05.30.12.29.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 12:29:55 -0700 (PDT)
Message-ID: <deb58a23-1487-aebd-8fce-e0d6e39e723b@gmail.com>
Date:   Tue, 30 May 2023 12:29:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.1 000/119] 6.1.31-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190835.386670951@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230528190835.386670951@linuxfoundation.org>
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

On 5/28/23 12:10, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.31 release.
> There are 119 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.31-rc1.gz
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

