Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBC36CC8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjC1Q5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjC1Q5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:57:02 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3400DBDC6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:57:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3261b76b17aso127255ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680022620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuhR7C9sPLSc4hNe7UZJGxZfKsFXbBmUVGuYhZev+w8=;
        b=GXLVDiAN+JKnqKU8AGfiMNcTerA/REWmOyg0ptlVwyXP2BCPxG2brolg5skQolJ668
         ou6K0h4IvmSZNHxKwDYNK4CRJ0GdBhzBQiK5oJBz5mADLNm7f9/0s1+F94k5g0p1poUq
         XsAVmsS8dwmkBndJ4lCtL6J0oFDWiuIH4b338=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022620;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuhR7C9sPLSc4hNe7UZJGxZfKsFXbBmUVGuYhZev+w8=;
        b=yAeGkP9FcmhPe/2H1hs7rTnS9p+2359HE6McCXKeOAA+yCaoXpimy/vdfkMulVDqQ8
         GJjVzRY49TLlcJx3mrmSmNDgYd7AEATsEDFC8L/HbhTCUVtcrGOyeg1EB31D4FQbOrpU
         Eaghl6NoKCV5k3kYwBvirqljV32BvDRxhXi6I9CzpgqmNMC58mYijXRytaggveTUN0Hp
         htbHshnrp+3lgw8tNZc1J5qS4lIf8JviIvHTf7Fr83k5VrSX041usg78tndY1Jnlld5f
         /CGOB9mIDY/zMYVbHXPVIjr0kVRMTV0qvf11T4BI+OxfJuZdP+BqoVhjw50Vq0e1/hfy
         Xk9Q==
X-Gm-Message-State: AO0yUKWvhD2OwQOEKWGEcz6NlXLCF+iU8crWgoGv4okAFL2pfhhaTwPX
        ExzlhCYetk4H7d+WlFE6e79G9Q==
X-Google-Smtp-Source: AK7set8LuWrdxjSDNgZjgg6G/M5qRfcCIc7t6efNSu7YQSnIS8BVCNbNfaKrsPxOYeIcDfmKWmEgQw==
X-Received: by 2002:a05:6602:2c82:b0:740:7d21:d96f with SMTP id i2-20020a0566022c8200b007407d21d96fmr10235137iow.1.1680022620552;
        Tue, 28 Mar 2023 09:57:00 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id d37-20020a023f25000000b004062b6d7ab3sm9696677jaa.149.2023.03.28.09.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:57:00 -0700 (PDT)
Message-ID: <65ec8d6c-319e-8079-7445-ae514e328a4e@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:56:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Refactor 'peeksiginfo' ptrace test part
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230220160302.4679-1-ivan.orlov0322@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230220160302.4679-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/23 09:03, Ivan Orlov wrote:
> peeksiginfo creates an array of 10 instances of 'siginfo_t',
> but actually uses only one. This patch will reduce amount
> of memory on the stack used by the peeksiginfo test.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---

Thank you. Applied to linux-kselftest next for Linux 6.4-rc1

thanks,
-- Shuah

