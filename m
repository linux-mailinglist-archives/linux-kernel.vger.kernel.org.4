Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9DE7042E9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEPBa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjEPBaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:30:24 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C9010F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:30:23 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3357ea1681fso3214765ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200622; x=1686792622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UVHnUIJWgu5B9c3GLUqRjUfbsWVf3ceFNu26vMPD94I=;
        b=U7IUelUOQMiqu6XmHrkSmtLo1ts+0gK2GWfpo43p0rgqXFxoR96alZvuiF86gN0EKl
         cbSzE5SCdA5fZp+99/nTyC7DsFhK6NSo0lRNx3zJMfElZdvIc+r/TwhP42InAi9Kg0FV
         Gmd6v/a7MLjbcLKcex3k+tWarkBlKR2EPU5Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200622; x=1686792622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVHnUIJWgu5B9c3GLUqRjUfbsWVf3ceFNu26vMPD94I=;
        b=Oc9HPD0bX/MyAVKNuIotBGiaKL/viKV55jrKM6WL8CCyseta9NdVZ7OLYloB9DrVAf
         ZKzNIaOFvGAp/xJk1v/11NJxsFMh+M/MLBBvbGWvyG9YP0fsBoKLy3tlKPCa9m98JtZt
         x7iWn5H7xg7Rixj/j8HEFcfdTabQU+7cd4Y6TIP6/5dIRtQqrvcagBHGLBUevZd17z8D
         djCBPqxmOlez/QnenJuyVKnIDCsxnAYGJspHq1j59ZH6pbRQR+wSl5UzPQwSI/fSmmI9
         Qs0veYWD6RcGl4T+1acWTOvQrHP8dAUOLBMpIOwssUW/nWnQWhdDcFzDePKteyC3jPZG
         NVaw==
X-Gm-Message-State: AC+VfDxKBj45rixhzxk0lcXPsIGeIeKdPCSAAeNFAMUfEvJlJgB7p66H
        Kl/Mmlqtu0x1vf3ONHCvZtgs+A==
X-Google-Smtp-Source: ACHHUZ4CpY87zIekDbcb4isU2iclMy4ONult/VJKgANjWIil2QvPH58pR928VEqWdN+QYp4EHtGQag==
X-Received: by 2002:a6b:3117:0:b0:76c:7342:dde6 with SMTP id j23-20020a6b3117000000b0076c7342dde6mr765163ioa.0.1684200622564;
        Mon, 15 May 2023 18:30:22 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m20-20020a026d14000000b00418b836f89bsm628708jac.63.2023.05.15.18.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:30:22 -0700 (PDT)
Message-ID: <6219ed8b-af51-4fbd-c8cc-0aa88c26fa7a@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:30:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.10 000/381] 5.10.180-rc1 review
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
References: <20230515161736.775969473@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.180 release.
> There are 381 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.180-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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
