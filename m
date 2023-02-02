Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D726887B7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 20:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjBBTow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBTou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 14:44:50 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDEA40E6
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 11:44:49 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id y7so1165267iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 11:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zW6uiDjX0jvi0KnsG74BS2Ny9Z++lqjrUms7YqlbC3w=;
        b=W7KW140j9bjIItgEbTHGwPmkp9SHFSrqkhS7h8mdF/rTE+wXm9V53It/vgmCixYZvX
         27fRwUN3e1MfXJbax7eX8WHeAVRitVMuX8dZu/uztPEMRAWMTe05A+pAicUI26KCr9JD
         P34O5cGxG6MLGrQTh6pmFB537/++GI/2wp2ubiU5K1xvEXrkES2jQHbA3o0Gd3UdSg1v
         O6aoMOsz+Y2Lmx5DZFjsarh3UDXCC8HL8OJfK1aKbN5eylwQzxbzTAiu6fKtRyLa88E8
         spmazj0ILdLKbrLMTeh5l63DSMxvhRw4E5GGuyMx5NTZDI8vHMCk7VprwfIES+YYjav5
         hhcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zW6uiDjX0jvi0KnsG74BS2Ny9Z++lqjrUms7YqlbC3w=;
        b=q8P0tTt+Bc1Hbgdk4kVI1lmtklOyYUfO2KKqKZEdMEp8bJF4Cxwagals/u3urfOi/D
         KcTeE3s6wvVi4kLCmWv92puK2DZ2Xs2ZO0lPChGjJFm6YB72hQk7LgXpFKiEFIVvXumj
         bj2YCMllRNJYirE6g0YpXfxD8Fl+o/iwVFP0gBvxdYW+LMX0rPuEjEMXK+DbTYsk0//I
         KUMkyEJuPW5en2sOB9qHG3eoTrY7s2Bs1/5OXTLA+61Hgn85I8UoMlzJ/kae7hU9bHc/
         BkxG0jTHPE6zdOtCRiX7+14xvsZkNgR9SH23dIM591MZPDYz+uz5x+1KVIsWB7avTm6l
         DraQ==
X-Gm-Message-State: AO0yUKXKzmD4YEG9Jo+nUuZB5L/54YZ1x1icWTG7tqfz1NgMSw/Al486
        q9UCYcEFHIb16rvOg9+4hbNv8g==
X-Google-Smtp-Source: AK7set8cgN/pC62fkOAyUojjf62IR0Bzj2uZMAJLlgTfn0waTcUdpqfiVe7o5oydE10BD/cocNSWFw==
X-Received: by 2002:a05:6602:2acd:b0:6cc:8b29:9a73 with SMTP id m13-20020a0566022acd00b006cc8b299a73mr5163609iov.1.1675367089022;
        Thu, 02 Feb 2023 11:44:49 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id x33-20020a0294a4000000b0039df8e7af39sm197545jah.41.2023.02.02.11.44.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 11:44:48 -0800 (PST)
Message-ID: <fb27661f-59dd-98cd-203a-8fa86dc209d4@kernel.dk>
Date:   Thu, 2 Feb 2023 12:44:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [Syzkaller & bisect] There is "io_ring_exit_work" related Call
 Trace in v5.2-rc5 kernel
Content-Language: en-US
To:     Pengfei Xu <pengfei.xu@intel.com>,
        Pavel Begunkov <asml.silence@gmail.com>
Cc:     linux-kernel@vger.kernel.org, heng.su@intel.com
References: <Y9TgUupO5C39V/DW@xpf.sh.intel.com>
 <812a7e2d-14d6-78cd-5c6c-ce508fc7fc0d@gmail.com>
 <15161e5f-fe26-23e9-1d0a-ebd579d64d9f@gmail.com>
 <Y9t6tflIcFPy84S5@xpf.sh.intel.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y9t6tflIcFPy84S5@xpf.sh.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/23 1:56 AM, Pengfei Xu wrote:
> Hi Pavel Begunkov,
> 
> On 2023-02-01 at 15:52:47 +0000, Pavel Begunkov wrote:
>> On 1/28/23 14:49, Pavel Begunkov wrote:
>>> On 1/28/23 08:44, Pengfei Xu wrote:
>>>> Hi Pavel Begunkov and kernel expert,
>>>>
>>>> Greeting!
>>>>
>>>> There is "io_ring_exit_work" related Call Trace in v5.2-rc5 kernel in guest
>>>> on Sapphire Rapids server.
>>>
>>> Thanks for the report, we'll take a look
>>
>> Not reproducible for me. Apparently, the repro creates a normal ring
>> and immediately closes it, then io_ring_exit_work() hangs waiting to
>> the task to execute task_work.
>   Ah, I put the reproduced virtual machine in gitlab.
>   git clone https://gitlab.com/xupengfe/repro_vm_env.git
>   cd repro_vm_env
>   tar -xvf repro_vm_env.tar.gz
>   cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>      //start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   In vm and login with root,  there is no password for root.
>   After login vm successfully, ./repro   to reproduce this issue.
>   It could be reproduced in about 6min.
> 
>   If you already have qemu-system-x86_64, please ignore below info.
>   If you want to install qemu v7.1.0 version,
>   git clone https://github.com/qemu/qemu.git
>   cd qemu
>   git checkout -f v7.1.0
>   mkdir build
>   cd build
>   yum install -y ninja-build.x86_64
>   ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl
>   make
>   make install
>   Done.

Are you sure you attached the right kconfig in the initial report? It
is from 5.18.x.

-- 
Jens Axboe


