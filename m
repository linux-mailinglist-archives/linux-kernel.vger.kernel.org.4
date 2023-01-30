Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44810681E11
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:29:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjA3W31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjA3W3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:29:25 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40DC18A95
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:29:23 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e2so2316824iot.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 14:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FrkG7DevmIdVc4QArNSZDf3MBemOe3Y2WuDo8bGLhYY=;
        b=eYp1e+HlTRtX/dmDx1X/Nzf4NRNxwLZBD1+YjCo8GWixigQSZfNV0vOpD3Z39FSFXX
         v8f/klrijTAWh0RAdtn0o4kbVmd7JYq4DxFZeVpqGFwFRiQvnGkAcaQ07no/E8wTF4jw
         esuV9HG5GnmnBMJQI99nqNS77Bd+cbKzC/1K8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrkG7DevmIdVc4QArNSZDf3MBemOe3Y2WuDo8bGLhYY=;
        b=In0+vEACnormOdp+oXvgCw8/CP7FrwS3DJ5SC9Z/lwU7bAhto3T6pVz8Kh4tqTCff5
         5XLcpErmZfp5Bq52cQ9/tJwqnc1wEIR4nrcgUxuLzaEbwNMQT6AcbrYsp3MQKYI3ynnw
         2LUFP6X1qIdJSSZWuElbE9+dFMpOzsGMVPM13esAiPiipfYTFiSZUc5i40UvJQFtD3Gr
         OCnsEs7wy9011YI8mqp5hv73zNOU5QZQGmcXaNrP9L7opSD8i7f3NZ2oklATacu6laoE
         kJEUJw8X4WtovOLA81dloM/bP/noTG3Az2S2DkF+ka++N8i8RVm5IFE7hyyEk0OkfU7U
         iu8g==
X-Gm-Message-State: AO0yUKXuk/QpRn6hsP3MUj0pJzYT6qr3j8yqZ2QKvNUqDNPrOuynpyo/
        LPaO7yD06xIRMPStZWhwqIPfBg==
X-Google-Smtp-Source: AK7set911zMxEqxO1w9EG1O10Ez3qr3zH2+1KFmESEgMcD4E8s1Ysp+q7URLob2ktg+Dq9IYDPRD9g==
X-Received: by 2002:a5d:9d11:0:b0:718:2fa2:6648 with SMTP id j17-20020a5d9d11000000b007182fa26648mr1441851ioj.2.1675117763133;
        Mon, 30 Jan 2023 14:29:23 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id c4-20020a92cf44000000b00310c6f85ea9sm3699637ilr.82.2023.01.30.14.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 14:29:22 -0800 (PST)
Message-ID: <560824bd-da2d-044c-4f71-578fc34a47cd@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 15:29:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/34] selftests: Fix incorrect kernel headers search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Hi,
> 
> This series fixes incorrect kernel header search path in kernel
> selftests.
> 
> Near the end of the series, a few changes are not tagged as "Fixes"
> because the current behavior is to rely on the kernel sources uapi files
> rather than on the installed kernel header files. Nevertheless, those
> are updated for consistency.
> 
> There are situations where "../../../../include/" was added to -I search
> path, which is bogus for userspace tests and caused issues with types.h.
> Those are removed.
> 
> Thanks,
> 
> Mathieu
> 
> Mathieu Desnoyers (34):

The below patches are now applied to linux-kselftest next for Linux 6.3-rc1

>    selftests: arm64: Fix incorrect kernel headers search path
>    selftests: clone3: Fix incorrect kernel headers search path
>    selftests: core: Fix incorrect kernel headers search path
>    selftests: dma: Fix incorrect kernel headers search path
>    selftests: dmabuf-heaps: Fix incorrect kernel headers search path
>    selftests: drivers: Fix incorrect kernel headers search path
>    selftests: filesystems: Fix incorrect kernel headers search path
>    selftests: futex: Fix incorrect kernel headers search path
>    selftests: gpio: Fix incorrect kernel headers search path
>    selftests: ipc: Fix incorrect kernel headers search path
>    selftests: kcmp: Fix incorrect kernel headers search path
>    selftests: media_tests: Fix incorrect kernel headers search path
>    selftests: membarrier: Fix incorrect kernel headers search path
>    selftests: mount_setattr: Fix incorrect kernel headers search path
>    selftests: move_mount_set_group: Fix incorrect kernel headers search
>      path
>    selftests: perf_events: Fix incorrect kernel headers search path
>    selftests: pid_namespace: Fix incorrect kernel headers search path
>    selftests: pidfd: Fix incorrect kernel headers search path
>    selftests: ptp: Fix incorrect kernel headers search path
>    selftests: rseq: Fix incorrect kernel headers search path
>    selftests: sched: Fix incorrect kernel headers search path
>    selftests: seccomp: Fix incorrect kernel headers search path
>    selftests: sync: Fix incorrect kernel headers search path
>    selftests: user_events: Fix incorrect kernel headers search path
>    selftests: vm: Fix incorrect kernel headers search path
>    selftests: x86: Fix incorrect kernel headers search path
>    selftests: iommu: Use installed kernel headers search path
>    selftests: memfd: Use installed kernel headers search path
>    selftests: ptrace: Use installed kernel headers search path
>    selftests: tdx: Use installed kernel headers search path
> 

These will be applied by maintainers to their trees.

>    selftests: bpf: Fix incorrect kernel headers search path # 02/34
>    selftests: net: Fix incorrect kernel headers search path # 17/34
>    selftests: powerpc: Fix incorrect kernel headers search path # 21/34
>    selftests: bpf docs: Use installed kernel headers search path # 30/34

thanks,
-- Shuah
