Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C1070C929
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjEVTp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 15:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjEVTpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:45:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DA3A3;
        Mon, 22 May 2023 12:45:21 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52c40be1417so2702688a12.1;
        Mon, 22 May 2023 12:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684784721; x=1687376721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCGYl6IZIvRLxU63KxQU2qXn8DNWfF3Co4wSA+QVCTA=;
        b=YdS2IRdufNojXxnoShz3C0cLahSB7BKF89xs4x56Rdiq6ggSZ8cutQ9p6SABxDJ7Ow
         d33kTREQkIy7Uq/DXYZRUsaBKvHtigTIG+4JvG+aJz3k1djAojiE6zfvG7eV52tLgGBx
         C+DXv2Zc2XslrGsIP6jaoiDHTDi+zG6XNfqQ0yw4WZAJRoZDoBcKRfHeqEVeo6mHHmyK
         TviJg36KVmxQZ2U6VeLt/pATIWJfEQUYq1GVg0GUomkL+Y+libdRIIdAHOYstj2om81Q
         oszIYdMN3hnVrnp+Aod0HvZ9FL8yTR2eFj8lZCkkq4KCF1YGd3fzxNlu88lwHf6D9SU6
         tKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784721; x=1687376721;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCGYl6IZIvRLxU63KxQU2qXn8DNWfF3Co4wSA+QVCTA=;
        b=fcuAvV1MJ18mQuOuM1nFfAGgek+w2hZyW9N4JUUeD0Nd4HduvQ8+RbUXNLMRHWL5Fw
         nXGTdvxZi4hU6ZsI5BOQ3glAcyD8R7PmEJILOCPIBJdpHrPO+/xQGU4TRfa9MzICPkbA
         k9LqLBybWkC4dIZ0QDV2mP8s3n78PcKlPexq+McZduxVf3AitLkbBi3sMmr+B1pz8Q26
         SYEl1FBXgCQ3qSa2kKzJfp2Vpgpb/sKBLeNUg5R30GVSN1R1uw+ibNF1y368ofVBoVTD
         +1iIP1h97F8VuN2AY5kWv5mXFPtWhA5LOMWuhPOjBJbs27hofdS96JoTt5P26pnG/lIG
         9rTg==
X-Gm-Message-State: AC+VfDx0y1u1EiaseUWkaf1Nifv22MkjaAaDB9BTFWeAbb0+Z14QIJzv
        jE40V2bJEvgcp2XEz/+V1ms=
X-Google-Smtp-Source: ACHHUZ71FKF5etZE2b1weSGm7GtgEE/3SO7HKF/liQMLAoYSUmcuIjrPMFvPAbqFYq93H5bKb0Sbgg==
X-Received: by 2002:a17:90a:b902:b0:24e:201e:dcbd with SMTP id p2-20020a17090ab90200b0024e201edcbdmr12330083pjr.21.1684784721335;
        Mon, 22 May 2023 12:45:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id t8-20020a17090a4e4800b0024e33c69ee5sm4434824pjl.5.2023.05.22.12.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 12:45:20 -0700 (PDT)
Message-ID: <bad6bc72-d87f-4eb1-b2ea-86632a74bf5c@gmail.com>
Date:   Mon, 22 May 2023 12:45:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 000/203] 5.15.113-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230522190354.935300867@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
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

On 5/22/23 12:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.113 release.
> There are 203 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.113-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

