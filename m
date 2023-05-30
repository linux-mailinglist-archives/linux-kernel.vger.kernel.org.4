Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DEF716C8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjE3Sbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjE3Sbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:31:50 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C02B2;
        Tue, 30 May 2023 11:31:49 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25692ff86cdso1759669a91.2;
        Tue, 30 May 2023 11:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685471509; x=1688063509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KEW9iyPphTcnuNe1nVj+a43tMhSuae2gFfmByMfKsa8=;
        b=L+joybXijMGa4/e7fOk+a6C8lsbtQ++whH4ml6c9IAtiZfGctKxBof3xN9w5rrsnBo
         h9BqhpTCrWtwickmrQybCrQdTYN0YYxhFnM1jz5DMSYHJ49cK1l67XxGpQdsb5Kh8PD5
         +6gOQC1bx7JYXAmQBDKYjwRZ44B9ZHhnvKwG/lpFauSeq0sxhye4RwxMyp0L2HKbeKsa
         vGy7oYQx76IJ0pHNsHY+mYgLSJBCgvbGbAcgvbbtKt2UXwB/6oQHPqL3LT6+7Q7PJZ4+
         70ua2Pq0P3wOdjpTRB4Kgz9z9Xnkh3+7V4VrSIfqT016dbed3pS0zQ6E/YifkzSPvPKt
         Hrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685471509; x=1688063509;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEW9iyPphTcnuNe1nVj+a43tMhSuae2gFfmByMfKsa8=;
        b=V6Fx5IJkfwKM7LZdSDHvDtBOw2Q2jwICFyeIcp0yza2ianYloVQ98ASsSTX4SzVxy2
         J/wu+BcXFwUVePenzpQIeKYDRKg92unsxUpigcoS9L1xhCsoGSzIuctjov29+UJPB/+g
         PwhUrE8dB/k+vSbVhtEU5XTZV4UBk6lt1kfmNPY+5fFTGHUv3gUn4Zj/kHYM2K1UMJ32
         tnzRrDCGp1+vg1GZfirCECPESClxqN4Mr/PweqaAKIpNpsaIhwTjnlTtCdonRdiTM/1I
         Nft+wVkrkrNg9FCVmAJYJmu6uLZtcw+poxTgKhxt5QeylRvwEVd8nFKDlBd1F3o50yzM
         xAfQ==
X-Gm-Message-State: AC+VfDzgm6EBFPC1+oMmQk8K2gLOXXLbKWqRiBHE2akaV/eUpC3bAgC/
        Uy+voifD35oneQ/mtxEouy4=
X-Google-Smtp-Source: ACHHUZ7n8ILu1TNR/dRxoHFEDmys9Q+z59wa0gH6crvvzA/gXuzt/1+r4IoY1+rxgRhJXQkVKnFdyg==
X-Received: by 2002:a17:90a:db02:b0:252:75ed:eff5 with SMTP id g2-20020a17090adb0200b0025275edeff5mr3255611pjv.30.1685471509220;
        Tue, 30 May 2023 11:31:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id v4-20020a17090a458400b00246f9725ffcsm9101549pjg.33.2023.05.30.11.31.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 11:31:48 -0700 (PDT)
Message-ID: <26072357-9433-c94d-ef5c-96dba23ebaa9@gmail.com>
Date:   Tue, 30 May 2023 11:31:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 000/211] 5.10.181-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230528190843.514829708@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
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

On 5/28/23 12:08, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.181 release.
> There are 211 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 30 May 2023 19:08:13 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.181-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
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

