Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535556A58C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 13:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbjB1MC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 07:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjB1MC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 07:02:27 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0BC41024E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:02:25 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j19-20020a05600c1c1300b003e9b564fae9so9336730wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOil+rmUBFJnsQrtO4mSmdPRv6I6Z8F/QkUyhuD4Ppo=;
        b=Lg8uh+4cTsDN+Kf4VvOc7btsCDJvtNMmrwLkQ8tCBKnJZ7oi/a+fMX6SdOwpn6l2p5
         SH5vEoCsC3WE+c42LJ9SejOh4W2S06JGi2+qdeX5gdhIm6+KgaMPJzO0skzPwNEQfwMN
         DDp0VsxYWVi8OPFQxe15KAj/fUBPgDxtwESkIx0aHzTNGo/0JEGMCoAzO7nnYgvF22ua
         A6qTOhMxzkWP1HNa+oFu+LiqUqmvOuIRw400N+B2A2DLhHKJ6MO95KhUEi1cEnplx0nl
         471q1cQ+gqdNs4JylSAm80nyFzQqZ13+wWSFJGt/j8vK7ieT1hOCzH4G2Ds+mjRjUDE2
         JtAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOil+rmUBFJnsQrtO4mSmdPRv6I6Z8F/QkUyhuD4Ppo=;
        b=ElcOXbe7wNgUQdolptmPwxN6B5XtDOjIAbPJg/UKhJ2wjzbrVJolOIXVpezh69U+Sv
         efUteRzkWK3Y2pgq4YtZ2gTVQI8ijQpeTQIHZl6uqIEuDrN1WpQCCNZaF5iDfvfcZdca
         Kesy7bgVjUzjlfgOLj9DwP/1WLbDH+Vwcxw2ydpkrWGlECzh8vPLoiy3vd4c8j95uEqt
         PKR4Aisvv08oawUhSqoxH3UUw7wxMFnBc7YwNAJ4BCyDO+pvZCHVg1KdEt5ZKeNh1hkZ
         8xItzH49Al9/e0oD66AIdsJ7oIzTZCsSEd9/8SzwRN0DI4BdrrmCnua7bCiFoLExCoPD
         YJ1g==
X-Gm-Message-State: AO0yUKUIMsavgoNot5QavhjoxERV++8L9bAERzoTBWu969QeALU9L8mf
        /1nFDCyBlat8sQCkiwV9psx7wQ==
X-Google-Smtp-Source: AK7set8naYHPskgq2n+dpMigAxIXBgugkmme9zsENGOr36KsES9+Ir0HbUQfWSuX1p/zAanX0YizeA==
X-Received: by 2002:a05:600c:1992:b0:3ea:f0d6:5d36 with SMTP id t18-20020a05600c199200b003eaf0d65d36mr1952197wmq.29.1677585744390;
        Tue, 28 Feb 2023 04:02:24 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b003dc521f336esm11966128wmi.14.2023.02.28.04.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 04:02:23 -0800 (PST)
Message-ID: <6198f1c8-29b7-dba4-2469-2a99eb03c83e@linaro.org>
Date:   Tue, 28 Feb 2023 13:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] MIPS: ebpf jit: Implement DADDI workarounds
Content-Language: en-US
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        johan.almbladh@anyfinetworks.com, paulburton@kernel.org,
        bpf@vger.kernel.org
References: <20230228113305.83751-1-jiaxun.yang@flygoat.com>
 <20230228113305.83751-2-jiaxun.yang@flygoat.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230228113305.83751-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/2/23 12:33, Jiaxun Yang wrote:
> For DADDI errata we just workaround by disable immediate operation
> for BPF_ADD / BPF_SUB to avoid generation of DADDIU.
> 
> All other use cases in JIT won't cause overflow thus they are all safe.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop 64BIT ifdef
> ---
>   arch/mips/Kconfig            | 1 -
>   arch/mips/net/bpf_jit_comp.c | 4 ++++
>   2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

