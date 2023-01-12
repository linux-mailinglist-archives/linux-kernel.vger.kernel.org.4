Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9726678F7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjALPVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbjALPVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:21:15 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DB0CD9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:13:55 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id i17so4648706ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lGaCHlOeK+4Xeu53RFKDmMgqs3djpjqDBc2Iko3AJSA=;
        b=gOyKE6Beuz98CkiYz+AOKP/wt4GwJaVJb5DYlxOAqgTlFjdHyNRhCp8XAzKxRetqa7
         nWPV/dJxL8n++6pEnI0mi/LVul2YqNlg82HjKqank6/SA/Sx9cJRaKGhUnWTpq+fV+dZ
         9b7QeuGldoYmGFw33Imdg1LnscE1V3ezAOi/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lGaCHlOeK+4Xeu53RFKDmMgqs3djpjqDBc2Iko3AJSA=;
        b=fmQHPPvu9P12pekfnzE0tadn7jLWlEnNJqsxct+7n+el3bE6A+TmTSyEulU2Xun3eX
         eSUJDpJ60zjRGxWPTbxpoSuJD6K5D3Q7VK/SJOanNopGKEieZp0Sb5O5StI3bYrJTyug
         n8C8xGut7wYT4yx6KI2SLUYNF/6nbbWJLmgm+OCFwxqiZJIluFabgAT8HbP+IzsCaRfj
         HSYgUHdchp9OhLKLPVStGqA61FUPYA2N4SWP6i3r5uiwPj7CFGq83AM89WhjjCY1SJsq
         hoqSu9VBGcjhUqK1zYH2ETsH4ogWsFMy7eKr6P05WqGpJiBUKfw25LknnKR0+onGo1dP
         ILSg==
X-Gm-Message-State: AFqh2kqS99FQhfe0PWOjkjuZbqclb0TbYkR8JrpXKdTz5em8lRr+kGIC
        tOtnxFgas1rKomNCEl0ATqrgtg==
X-Google-Smtp-Source: AMrXdXv7AEI45wWpGwkSR5qrc8D6pSJLOn1EhbZ60iPCVQgJGC7n2zM+7uSSAmDuY3KTJHo84yAMWw==
X-Received: by 2002:a92:ce03:0:b0:30d:bf1a:b174 with SMTP id b3-20020a92ce03000000b0030dbf1ab174mr1109422ilo.1.1673536434448;
        Thu, 12 Jan 2023 07:13:54 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a14-20020a027a0e000000b0038a5370658bsm5384767jac.6.2023.01.12.07.13.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 07:13:53 -0800 (PST)
Message-ID: <4c9a5640-9ebf-db87-fcb0-b076b615e4e4@linuxfoundation.org>
Date:   Thu, 12 Jan 2023 08:13:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: =?UTF-8?Q?Re=3a_kernel_BUG=c2=a0at_mm/usercopy=2ec_when_using_usbip?=
Content-Language: en-US
To:     =?UTF-8?B?U29zdGjDqG5lIEd1w6lkb24=?= <sosthene@nitrokey.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robin Krahl <robin@nitrokey.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <aa686f98-c9a3-6225-18e8-7ca57678ce4a@nitrokey.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <aa686f98-c9a3-6225-18e8-7ca57678ce4a@nitrokey.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/23 01:40, Sosthène Guédon wrote:
> Hi!
> 
> I have stumbled upon a bug that is triggered reliably by using usbip.
> 
> We are using usbip to test our firmware. usbip attach works, but once `opgpcard-tools` interacts with the firmware through pcscd, a kernel bug happens.
> Then usbip stops working, and `lsusb` as well as other tools interacting with usb devices hang.
> The symptoms are similar to https://bugzilla.kernel.org/show_bug.cgi?id=215487 but the kernel bug is not the same (see attached dmesg logs).
> 
> The bug can be reproduced on arch (Linux archlinux 6.1.4-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 07 Jan 2023 15:10:07 +0000 x86_64 GNU/Linux
> ) and debian (Linux nitropc 5.10.0-19-amd64 #1 SMP Debian 5.10.149-2 (2022-10-21) x86_64 GNU/Linux), though the reproduction is not minimal.
> 
> To reproduce the bug on Arch Linux, with the packages rust, pcsclite, and openpgp-card-tools installed:
> 
> - Compile and run the usbip runner from this PR: https://github.com/Nitrokey/nitrokey-3-firmware/pull/149 (`cd nitrokey-3-firmware/runners/usbip && cargo run --features alpha`)
> - Run `usbip attach -r localhost -b 1-1`
> - Run `pcscd`
> - Run `opgpcard status`
> 
> The bug should happen.
> 

Thank you for reporting the problem. I will take a look and
get back to you with possible fix. Will you be able to test
fixes?

thanks,
-- Shuah
