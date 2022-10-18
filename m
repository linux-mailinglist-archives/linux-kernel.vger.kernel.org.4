Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2ABE602705
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 10:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJRIfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 04:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiJRIfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:35:16 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D7876777
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:35:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bu30so22277271wrb.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 01:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irjEodZoDWyqh+myKZC6Ercv4pu3++KsqjUWNNDJUpE=;
        b=JPvqqXowX1wb/VJFyzoCz3lQa4JJH5ObSlbB4B0FMj9dt6WE0Kd1kJ3CmKi02AcCo3
         8gw8/mf2hMix3EFWeSmSLIIr+IXTqq7q6uRvTZfeIRNjMJr8rkWpUi8n1kntqaCPleY1
         BP9IJab7Y0EDsK7xTKSBhlah5agbyrTpl2dAqvBh8IaKEiXDGbub0JrVFoTueFbkXrML
         I70KbL+aC7IOfVXj9DLM1xR2o2FllF+p9ZNQwHJY0xwAcMqbgVHx8rXHoso3+dBsQ/OS
         +UacA5MFyJh3bMj9MkdT3Dnf0dD1isxZhKB96CfTk2qyVBtPghDyc72IvMYiQDpQhpNZ
         CQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irjEodZoDWyqh+myKZC6Ercv4pu3++KsqjUWNNDJUpE=;
        b=ova0eqjGxeLEfo+1HGU8XNdra7rlae54vN6+pGDJwLjnAmLxDR8SnYY/MjIoYI6Mt1
         0mM9Ru+tHs8tXnwoFwFg9NRFY51UQ1d0CZ1rAPczeBplIgUb3V+BG1A3o/BhtpIyyqhm
         AdJV/z3YJdINUYQ2EsMeuSTJvD0Xgog5ShMM+fIRBbVykWtKofNwjJCdkQOoqOMHvbhR
         x8eQkWkXJMmv1tPje3r2jFMxC2+Fu0fV7rXMK0ZhOZcyV9lZVxKQ+UDmWPdiYxC4RVXW
         inSOJRiRlm+ltRW12F6+7/99+2A7OFrCG/E2nvAUvnPUkw+s5NdHmU3WeuK+jflZ6RbD
         oJzw==
X-Gm-Message-State: ACrzQf0jVNFjyKiqTJ9VFEgm7duaXWBInsGOTPuphvYaaDj42RX9Oapo
        x7ytb5MxdjFGQ0xml3pE42Hygg==
X-Google-Smtp-Source: AMsMyM58ioqGoCbBfImW8eqHlvEj78w0cBupGkEntr7jeLeD6WzEB9OB6IlXe5bzqWRzQ4y+5kArCA==
X-Received: by 2002:a05:6000:154e:b0:230:45ad:fb87 with SMTP id 14-20020a056000154e00b0023045adfb87mr1163550wry.270.1666082109826;
        Tue, 18 Oct 2022 01:35:09 -0700 (PDT)
Received: from [192.168.79.175] (93.red-88-29-179.dynamicip.rima-tde.net. [88.29.179.93])
        by smtp.gmail.com with ESMTPSA id bl13-20020adfe24d000000b00228de351fc0sm10301823wrb.38.2022.10.18.01.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 01:35:09 -0700 (PDT)
Message-ID: <ab62f6fc-10f4-a353-5c17-8fec82eea662@linaro.org>
Date:   Tue, 18 Oct 2022 10:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH 06/13] mips: ptrace: user_regset_copyin_ignore() always
 returns 0
Content-Language: en-US
To:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>
References: <20221014212235.10770-1-s.shtylyov@omp.ru>
 <20221014212235.10770-7-s.shtylyov@omp.ru>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20221014212235.10770-7-s.shtylyov@omp.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/22 23:22, Sergey Shtylyov wrote:
> user_regset_copyin_ignore() always returns 0, so checking its result seems
> pointless -- don't do this anymore...
> 
> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> ---
>   arch/mips/kernel/ptrace.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

