Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7586970CDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjEVWXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjEVWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:23:28 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F6109
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:23:27 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-397eba8b82aso1293751b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 15:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684794206; x=1687386206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WNt+khR6KUdQ4WDh86OQH9457RdufSjYQVe+FsJiEfo=;
        b=sYiw1iAHMlVr4Lq+l3V6C3Zoo3vzMdbNewKIciC075TpGdu1DY5Ra477bYaoYFYl8k
         Q34bnSrMzh0flro+llWRrJjS+/wA576vCpwMud5muFrEGayKsfyXfk61u1/PSjgkMUwp
         gXTnOuPmlRG068rvQLm2DXZI1/3uipVYJ/oq2euTb31jvi8ta+CvlQr6noSxm51FR6+q
         ZxXvZs3a12en5Vvq9rLaG0Ko0dM/b+Oi1NJA8jtnEyM2JwjHiZxmSIY/qbyD36Meo5Mm
         lFPAeyzmhSsmihN4zEgUjLYW12wCley9SOUnd1EJtfYSZWJmLNT3m8AMYYuUTj9/FHLX
         DEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684794206; x=1687386206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WNt+khR6KUdQ4WDh86OQH9457RdufSjYQVe+FsJiEfo=;
        b=NjzV5o/U6ZMQ5gmNOseklJNYgfPbixUeFmYCd4MLgtWUqbWhceu8pmr3IFoVXQ3MeT
         ReQ0MHCZis3R9wDxnfKnxX8TfsxMRVxZsGRw6YAIURveB7ELYof3RG7W5F1LmEe+9AB/
         iq6JuHcpOt7ahfgPd09JXXE+VjyrU+QsQ/0MasbFfEi/XltR88G8/3OJhr1ltCnIumx8
         QT3NHQQZ+EMKntgoTW2K0DgMov0ckn+8JKlw5hn7so3mkVd7+PxgVhxEpY6SElf7R82X
         W5OSi9HsHrSmCKEeu2TvYQT95YwSuAZNsQhW9xSoDSYlpv8oHApZ0uVetjb5CVFM8s9/
         1P2Q==
X-Gm-Message-State: AC+VfDzUXjzVc40y42Z0WEeQbD9QWm5QHqeLkTeJAN0gw72o9GgrKg7T
        6GNvl2YPzvVLXEmfD00SV1+8mw==
X-Google-Smtp-Source: ACHHUZ66HWhFDHhe06cX7hAyadmAnJYeHff1qDllF1k+QxQZ83xx01N/m3+l2eseBTNzYMsv721rng==
X-Received: by 2002:aca:650d:0:b0:398:29bc:547a with SMTP id m13-20020aca650d000000b0039829bc547amr804476oim.42.1684794206422;
        Mon, 22 May 2023 15:23:26 -0700 (PDT)
Received: from [192.168.2.16] ([107.152.39.94])
        by smtp.gmail.com with ESMTPSA id s188-20020acac2c5000000b003926e3328e6sm3228956oif.8.2023.05.22.15.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 May 2023 15:23:26 -0700 (PDT)
Message-ID: <4889c7c7-1206-dab5-3ef1-13d4506e08be@linaro.org>
Date:   Mon, 22 May 2023 16:23:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230522190412.801391872@linuxfoundation.org>
Content-Language: en-US
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 22/05/23 13:05, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 24 May 2023 19:03:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We see build regressions on:

* Arm, exynos_defconfig
* MIPS, cavium_octeon_defconfig

with GCC 8 and GCC-12:
-----8<-----
/builds/linux/drivers/usb/host/xhci.c:497:19: error: static declaration of 'xhci_try_enable_msi' follows non-static declaration
   497 | static inline int xhci_try_enable_msi(struct usb_hcd *hcd)
       |                   ^~~~~~~~~~~~~~~~~~~
In file included from /builds/linux/drivers/usb/host/xhci.c:22:
/builds/linux/drivers/usb/host/xhci.h:2146:5: note: previous declaration of 'xhci_try_enable_msi' with type 'int(struct usb_hcd *)'
  2146 | int xhci_try_enable_msi(struct usb_hcd *hcd);
       |     ^~~~~~~~~~~~~~~~~~~
----->8-----

Reverting "xhci: Avoid PCI MSI/MSIX interrupt reinitialization at resume" makes the build pass again.

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

