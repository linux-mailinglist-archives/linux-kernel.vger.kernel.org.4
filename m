Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B55BA201
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 22:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiIOUwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 16:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIOUwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 16:52:19 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914FC48C80
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:52:18 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id o13so15165139qvw.12
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 13:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=h6GP7OMr98DgtTyeApOsh0thg3e2Q1uN92gwxmTHO34=;
        b=E8Ap1REycdzFe39/XRMw1m1jAGKPXO/Uq4k6BR2syVJGth1OWVrqSyDtMVnyFx6j1P
         RrlIKjS/XINphFZXfY7elpDMuu55ePnAnFjoo7gmStlr/a/7ugzN2xA4/kdxBPcIePYU
         4RdkcoDZZ42InaqgiRbungzUAuoKNt+MBEaKxUag6+VZ7zHRdmTfROd+nIaup5CVeHVW
         FzrEHpQZWhj9gF/leIwJm57jv/Jka26UbRJUjc70GE7PJsFVgr34cXtvZ2i3Np35ZMnH
         s4RdZfH4kUSdVD5wV/rqixuKJeL7VmG3rmhpi85EhcaP58MPFvJHQivgoD9LV+K29xSJ
         nC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=h6GP7OMr98DgtTyeApOsh0thg3e2Q1uN92gwxmTHO34=;
        b=SOdKEqXNs1sPz4FVCq60tefua4RNUiiSOBir7XtuuSeFoDUmIimv68b9r7BO/gpCZO
         k/rFJiNwICfBnX0bip9NHI96sya8xogzOsU527/NUqYHryBGq3UrKyFdpulBACtYL7HC
         UdxPmW9ANarN1pNaxM1ZtC12kVF5J2qPOQjuI3hcAm2kxkfycMfXn9A2gtYkMPkb4AhG
         WsdJeuKbbDVxhiCffZGtBeP+m77Lt4d/F+gsGeaOK3D7ayy+ow5exPfwk6o/JG8jiX1H
         IgTlcpgdp5j/j1X2TYZLMUR1LvqbYT2nMa9+rgH6uyw5vyeG0qL+08aLwKgMu+e9uy5L
         jaHg==
X-Gm-Message-State: ACrzQf1DprgsI5Uf8asbv8+VFXnFR528CRS6lG1z1lVSvTbvC907xLq5
        u3OybqIQChtktYEvv7vx5LU=
X-Google-Smtp-Source: AMsMyM4Z5cKWgJDetP3HbLHXQcRthknzjqVa+UA9gJLy0QHWAFQ+GqDV40URFEaPLuktx3ogjxJ7Hg==
X-Received: by 2002:ad4:5ae8:0:b0:4aa:af21:b43c with SMTP id c8-20020ad45ae8000000b004aaaf21b43cmr1266892qvh.36.1663275137671;
        Thu, 15 Sep 2022 13:52:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w8-20020a05620a424800b006ce5fe31c2dsm5069897qko.65.2022.09.15.13.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 13:52:17 -0700 (PDT)
Message-ID: <3dc9d86d-7b98-33ab-880e-a9584b8fac4b@gmail.com>
Date:   Thu, 15 Sep 2022 13:52:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] arm64: Kconfig.platforms: Group NXP platforms
 together
Content-Language: en-US
To:     Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, soc@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        krzysztof.kozlowski@linaro.org, arnd@arndb.de,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        william.zhang@broadcom.com, anand.gore@broadcom.com
References: <20220829173830.3567047-1-f.fainelli@gmail.com>
 <20220829173830.3567047-3-f.fainelli@gmail.com> <YyNN/IZgOAlbSHnF@lx2k>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <YyNN/IZgOAlbSHnF@lx2k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/22 09:08, Olof Johansson wrote:
> On Mon, Aug 29, 2022 at 10:38:29AM -0700, Florian Fainelli wrote:
>> Group the three NXP platforms under an ARCH_NXP menuconfig symbol to
>> make make selection of similar vendor SoCs visually nicer.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Hi,
> 
> While these are convenient if they're done right from the beginning, the result
> of adding a new dependency like this is that old defconfigs stop working if you
> just go with the default.
> 
> Was there a reason to group these now and cause this config churn for
> downstream users?

No reason to cause churn, and no specific reason other than visually and 
logically group options from the same vendors. I had clearly not 
anticipated the defconfig breakage, too bad that Kconfig does not allow 
menuconfig items to be enabled by default, or does it?
-- 
Florian
