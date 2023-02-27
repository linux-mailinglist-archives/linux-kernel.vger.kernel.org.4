Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD636A49EB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjB0SjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbjB0SjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:39:02 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A312064;
        Mon, 27 Feb 2023 10:38:54 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id d10so4118764pgt.12;
        Mon, 27 Feb 2023 10:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AboAji3jAYuO4XvdPAjYRB2J/AMaxq+rrnO3NBE3aY=;
        b=qwtEN0DGOBja7E0YJ9cfiMfTzhyOC20jJeOjJg48mfG+iu20AcbX7Nwi2jGXqzyFGP
         o3808ii7YGCZZ0VWmGt3MHbmRk8hL+z/7T/UN6Iggtoittggl+dc2LVjMUUZBe0gDtsS
         jUEZ+7ITV2Pic17CmdlZoxdgAV7C5iepBpi0jnX3YNabI53AHQRL3kS1d9x6orQpp9zf
         /fZwwHVzQGoMUAbVBoxzYKWqLkemx/epjNQ4jP9zDeLVw17g79ayBwHaP3smV6R0CQnv
         5zODXCsisr1A5hq7+XlK3LDi70+HgeVRbN25vpftkj84NULczpjf0NwTt3h7CRZjVUZx
         Cseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+AboAji3jAYuO4XvdPAjYRB2J/AMaxq+rrnO3NBE3aY=;
        b=Dj2bjspxz7qNY7NfMNldljUONeVa+jMInvhBGP756izc+0WeqU5KMGkE+vr9lxCii6
         T07PLC2G4b9YiQDiA2JESW+lbk6lCE5RfBYhk0VZl3q1H0Wuy9axXW9P+VUS1XMcTmrq
         k9e6MERAofhnt3rbpi1bGNOCYXMMDiZ5buwW2dCb1BWZxN9xpIblUtzoXZPL/RuxtLEg
         EX8wXPjSg9IJ35tLsIWjQCk/jddkiyRS3Ve9Yc2QWaZ5nRohDE81jE6LO739lkzUZPIv
         bhSfOxLkrFeNjkIuW+a5pIK1tK0wR0IZ31RK4HIMIRIHYP978bfe6bGWuvvvWLliZXOL
         tFrw==
X-Gm-Message-State: AO0yUKVGhnMeW/jSMv+kdll0rhGl/NEkxAk939PcDd6F4nEbc/nzRUx7
        qUTw+BJg68llaO14g7fz6HI=
X-Google-Smtp-Source: AK7set8WYWh/LMiPRCCVzOfK763vGatTubEy0na0hD4jEwPQhc6elxzgYPfp/8HaRV+BaMFI/TCHZA==
X-Received: by 2002:a62:1cc4:0:b0:5e3:a299:da83 with SMTP id c187-20020a621cc4000000b005e3a299da83mr9848408pfc.19.1677523134170;
        Mon, 27 Feb 2023 10:38:54 -0800 (PST)
Received: from [10.69.71.131] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m12-20020aa78a0c000000b005a8ae0c52cfsm4726039pfa.16.2023.02.27.10.38.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 10:38:53 -0800 (PST)
Message-ID: <35dc0b00-0de4-f1b4-8d43-7efd181e7dbf@gmail.com>
Date:   Mon, 27 Feb 2023 10:38:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: bcm: brcmstb: Remove bare-metal ARM suspend/resume
 code
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@vger.kernel.org
Cc:     drv@mailo.com, ssengar@microsoft.com,
        kumarpraveen@linux.microsoft.com, christophe.jaillet@wanadoo.fr,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Miaoqian Lin <linmq006@gmail.com>, Liang He <windhl@126.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230224215249.239405-1-f.fainelli@gmail.com>
 <421678cb-6ec0-903c-a84b-c833f013815d@igalia.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <421678cb-6ec0-903c-a84b-c833f013815d@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/27/2023 10:36 AM, Guilherme G. Piccoli wrote:
> On 24/02/2023 18:52, Florian Fainelli wrote:
>> Since 2018 these platforms have supported entry via the ARM Trusted
>> Firmware using the standard PSCI SYSTEM_SUSPEND function calls. Remove
>> this legacy code.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> [...]
>> -/*
>> - * The AON is a small domain in the SoC that can retain its state across
>> - * various system wide sleep states and specific reset conditions; the
>> - * AON DATA RAM is a small RAM of a few words (< 1KB) which can store
>> - * persistent information across such events.
>> - *
>> - * The purpose of the below panic notifier is to help with notifying
>> - * the bootloader that a panic occurred and so that it should try its
>> - * best to preserve the DRAM contents holding that buffer for recovery
>> - * by the kernel as opposed to wiping out DRAM clean again.
>> - *
>> - * Reference: comment from Florian Fainelli, at
>> - * https://lore.kernel.org/lkml/781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com
>> - */
>> -static int brcmstb_pm_panic_notify(struct notifier_block *nb,
>> -		unsigned long action, void *data)
>> -{
>> -	writel_relaxed(BRCMSTB_PANIC_MAGIC, ctrl.aon_sram + AON_REG_PANIC);
>> -
>> -	return NOTIFY_DONE;
>> [...]
> 
> Hi Florian, thanks for the clean-up!
> 
> I'm curious with the above panic notifier - is it not necessary when
> PSCI is used?

This is a bit of long story, but no, it is not necessary.
-- 
Florian
