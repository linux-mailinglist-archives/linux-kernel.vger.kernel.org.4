Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDAE723183
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjFEUiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 16:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjFEUir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:38:47 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04815E6;
        Mon,  5 Jun 2023 13:38:47 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3f6bb5e8ed2so50015841cf.0;
        Mon, 05 Jun 2023 13:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685997526; x=1688589526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tBzUGtWYUz/h/GEtZLWVJ9w7DC65D2cvEG+PU1++rdk=;
        b=GiYGyKA/2hN1rkG7MtNWRc4nL1bnZ7G8u+iQG2a1SvNE64Q9yKIMAmVeLgV0Qx2ByW
         OrZ0XpvL45XOMZzfDajXu+uW9HdrRURuiRaEdz/rlp0t/TkUbAhrp7uk2JlLtoZb8USQ
         sntoMWGDApTL8H799RGcSw9+tYHQlEWUc67Cb/svn/UNiAjuCk/Bxz6qjnFV8yg5o24r
         uFhUTJDN04dJUnEschdXrtLF9LV2xpDskausF+trh7tPHOO6h9LenJ8mOJU8Dmm5kdAS
         MNGV5FiXMxtLGJeRIvRfMSj0ZaUVjJzUT6cTKtHKlGVpUqRd4SNt/FDqFhH5WEI5ApF6
         QogA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685997526; x=1688589526;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tBzUGtWYUz/h/GEtZLWVJ9w7DC65D2cvEG+PU1++rdk=;
        b=gsClqd1i/fDzzHX9gKh8tMMaO4HncwJKbALwrhAsKKmHI+9uFiKSgclmNujpySfWe8
         t0lAR6gHXDcjWk44R37KDY/bG6c989cxQ7HQARQEN+2Pd/gzWbh5W2n9rBCLuhqNiGTe
         fL/bGMVgaelWnBZ7bQIFmaWiKtekY9F1cGQ4SlRzUvM/WcTPVkB+SZmA9MesFA7Lxm20
         PVWQyBVJ92cLdioZDgv9MuCFbpSgR81uXoWkABrNclK0jcW/Ssk2EoCluh441rf/Ik/i
         NLlF1BEeAjYPMg8hkI51GeRjIPBe/XwYMIKziek3VBF8nP2WcxSS1BJ3WJs6jwYWEpBw
         hVnw==
X-Gm-Message-State: AC+VfDx6hS6oAJIhb9oFBCILT4+OOCrVlW46PG5ccB2t1rb1493vzwEz
        f8zOM/+I4vh+TXmOcA1CntY=
X-Google-Smtp-Source: ACHHUZ72TxA5rtCZJe9S6Nu0SPOvnqmAh41OVTEXtwof33pAaD38MPlQwbZ5A/HVVMrDpdVBbJnpww==
X-Received: by 2002:a05:622a:1055:b0:3f6:aff0:6dfd with SMTP id f21-20020a05622a105500b003f6aff06dfdmr9548580qte.32.1685997526080;
        Mon, 05 Jun 2023 13:38:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f10-20020ac8068a000000b003eabcc29132sm4986051qth.29.2023.06.05.13.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 13:38:45 -0700 (PDT)
Message-ID: <6f75392b-7cef-3595-5422-1aa00384dab3@gmail.com>
Date:   Mon, 5 Jun 2023 13:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.15 00/35] 5.15.115-rc3 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230603143543.855276091@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230603143543.855276091@linuxfoundation.org>
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

On 6/3/23 07:37, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon, 05 Jun 2023 14:35:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

