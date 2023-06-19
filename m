Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE45735868
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjFSNUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232103AbjFSNUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:20:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98FE59;
        Mon, 19 Jun 2023 06:20:05 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3112c11fdc9so1629570f8f.3;
        Mon, 19 Jun 2023 06:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687180804; x=1689772804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2wb2dQCW7fBOdFZFZHr16+OjAXbPjBQ6SA6JZNaR40=;
        b=Cwmoboud/nFa5rnnaQV9sgUFjEfIFxltkAT7WbAbEZ1gIqpspzerjZdmb/5ry4GDim
         wvYoQOKeqhDDx/h/TVN+im1euS2BAVXi5o2tsP41IpCng9031lPP+do51Rwd6WG0edqb
         039JP1YXfduen2E3RrEYCOq2Qct2jya8k1upn8xJgO6qlNnmOpojMFnvC9YVgoioqaXl
         HONZxfSDPEucjjupDEc3Lc2xLGDPScxb+KzzkXUU81DNjI1TRRO61WsFK1p66Zru98SW
         TNW38xd7WpHr/xEkJDkmjryhl4C5QDHRGF6lWySNeeQ6/OjUUoIWRr/Tts8MRktThr8W
         8UUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180804; x=1689772804;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2wb2dQCW7fBOdFZFZHr16+OjAXbPjBQ6SA6JZNaR40=;
        b=NqtluYCnspVHnsdfkJwr8lE7l3K6cDw5Gysn0sVHMqQ9/fJvHKkpat2PL1ltliq/QG
         I6+Mu1+pYeyh8C5myOrFER4S3ECgCj8KNMeARqSghN3ilQX6ms0YWVcFcFSsWOrdheC9
         GFPaUJANoyQi1odakz/PphPu4m9SOpxm8cOJ7zFwGtfukmnMOEaAc9XnC9QXR/DWKQmy
         FjrY9jf8U5BlYYe0hvjuBa5B/mw/h+13If0EHKdFM8CQ1Ct6z0OyeXUiPi6FzypNOz1c
         K92gHPpyjWRPNxyi3Zv3Rrsuia2uyhp6Om1ZS6RWDGFbBmI6g8V+PJ6ON11cI9dLIrJI
         J7Ng==
X-Gm-Message-State: AC+VfDycIkSIzypZbcYu3L+wGYBxBAXjqkPdU9ZQJwWFmSWC3B1S1WCV
        7io1j8HJHX0EZts6qEARgSXc2XtEM73D2nLe
X-Google-Smtp-Source: ACHHUZ5gTJzvZQfjJjDEyn4Q/+S0CagNlqitgicIUCj2Nbo3ecG3/SA2tQh54/7TQUeKn0QxKeIAqg==
X-Received: by 2002:a5d:58c7:0:b0:30e:45ac:810e with SMTP id o7-20020a5d58c7000000b0030e45ac810emr6391868wrf.36.1687180803699;
        Mon, 19 Jun 2023 06:20:03 -0700 (PDT)
Received: from [10.178.67.29] ([192.19.248.250])
        by smtp.gmail.com with ESMTPSA id i1-20020a5d4381000000b0030c4d8930b1sm31500187wrq.91.2023.06.19.06.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 06:20:03 -0700 (PDT)
Message-ID: <390a3ed6-7349-916a-1d2f-19d644c891f7@gmail.com>
Date:   Mon, 19 Jun 2023 14:20:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 5.10 00/89] 5.10.185-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230619102138.279161276@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230619102138.279161276@linuxfoundation.org>
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



On 6/19/2023 11:29 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.185 release.
> There are 89 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.185-rc1.gz
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
