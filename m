Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54CB96A8CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 00:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCBXRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 18:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCBXQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 18:16:55 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D8D59417
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 15:16:36 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id w23so1104115qtn.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 15:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled; t=1677798982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6wk6uyA/I4kJ0qrpbw4f072OcKkiUzKgNLTSxWPahY=;
        b=lAxmF9mrCPEH2For/QcFimI2VcJ8P1+8Tues4emnY5xB9QSfo3ozFerN+4AjcNnKJ3
         VzjgqVjdXE0UizJez6KzHFNKf7xQhibQGzyyJy4GGzp1narGuiBMqx2KX8dL3CDGnvOT
         XJqyBMG9Iy4awk620SBFs9XNQKL3L9ix1HVPDWyZYCib/dcB7nHP7bkoicyV0egsIssp
         NKNcDzmIiyhE7pB1EaszduvxfzO6HosFNNXGvZnyhHY1ViJAMugsIAzS0zj/3vC2Y/K2
         9Elmdetaa0pxf/DGGVthEs4rUF6eIgmRN/crYBCBYVkAox5z3RTYSC52PKZUngCXrl8n
         7gZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677798982;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C6wk6uyA/I4kJ0qrpbw4f072OcKkiUzKgNLTSxWPahY=;
        b=rOLHrKjhlAnQAQIbNmwL2/kVuL4g9PUP6jfD5GyC7kMKhJogpWApkbtJqkz07bSnWI
         DYBTuGuR0xMWqAd7W2skj+hsgkD5pv3UElmOtX/H4599bLhH9fUDe/WgEPz1XHwfZF9e
         AAiAEFTfxKDmubrJ49AaWkX0ufYlwsKuhPWOQRxa7gYDbx2UwSe9xd7t5+7G19Phx9ta
         szPvVQ3zdbbfl15m2FyTZgiw28eeXMV2QV+spl6Shbyzf4PBeWqfHfyMvZ4S+Rl9fWnu
         YIx3NfNNH9mWNLHPVFjKPPQb5B7XKsy/C7pex9o2KpgE9xNTgWgBLO/dOw2raMY9w8kG
         LTfg==
X-Gm-Message-State: AO0yUKX27kc97Sp7CW0xbQT66scG8Rvxc/KFzHimG9FoaFsA6mwPeED1
        ZA4xuiEoUkfZij6w5Z7LnJMSoD5HOeepEHr60zPstIspg8zVB5Sgk5pXKOXu2Cfssj9ZLAKL8cN
        h6iJqjYHOsESOe2VAYXU=
X-Google-Smtp-Source: AK7set/kcppLvcyubPB5r+FPoK2bZYHwtckOY9nQSDJAM4KdRP2dG997b3gCxUBe/EXI/lh/27HGYw==
X-Received: by 2002:a05:622a:2c9:b0:3bf:ca92:3b3a with SMTP id a9-20020a05622a02c900b003bfca923b3amr20730412qtx.23.1677798981893;
        Thu, 02 Mar 2023 15:16:21 -0800 (PST)
Received: from ghost.leviathan.sladewatkins.net (pool-108-44-32-49.albyny.fios.verizon.net. [108.44.32.49])
        by smtp.gmail.com with ESMTPSA id q25-20020a37f719000000b007343fceee5fsm608844qkj.8.2023.03.02.15.16.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 15:16:21 -0800 (PST)
Message-ID: <ac0e63e6-294f-5ea7-0e2a-f9386b181d58@sladewatkins.net>
Date:   Thu, 2 Mar 2023 18:16:20 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.2 00/16] 6.2.2-rc1 review
Content-Language: en-US, en-AU
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de
References: <20230301180653.263532453@linuxfoundation.org>
From:   Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20230301180653.263532453@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SWM-Antispam: Scanned by proxmox-gateway.frozen.leviathan.sladewatkins.net
X-SWM-Root-Server: frozen.leviathan.sladewatkins.net
X-SWM-TLS-Policy-Status: enforced
X-Gm-Spam: 0
X-Gm-Phishy: 0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 13:07, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.2 release.
> There are 16 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 03 Mar 2023 18:06:43 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.

6.2.2-rc1 compiled and booted on my x86_64 test system. No errors or regressions.

Tested-by: Slade Watkins <srw@sladewatkins.net>

-- Slade

