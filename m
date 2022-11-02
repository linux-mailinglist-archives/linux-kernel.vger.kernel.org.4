Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595BC616247
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 12:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiKBL5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 07:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiKBL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 07:56:58 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85355209A7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 04:56:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id t1so6822809wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 04:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3e9t+blyZILLQE6+pdIsU2hY3jSYuQx5qRFvKHlvSLE=;
        b=qxJ9L9frQZsd+GiyQsLz4nLJjiTxQCyCQ4aU6KrpcMdz2BX4mmDrU7AnKEytp4Mmt/
         FcbBjhuTbYqi8/gAWzie7RLuC9+ebGSF1sjLKek+3T9FRBRcPQqBGKOT9yHxsCrCwtxj
         ngvrlZ0aXiC3CX6LDo5uOQnCJKALdFyHKXHRv4ScR7nI86UtCy/AbHDlKGfAzS9sOTAp
         Zqjtiw61z/Hh0QJ7KQh9LvytNl54wcMPrAR34V3M69AgeEE3umxtyGqk44TdVFrk9XLd
         AdjTsAP4m2IT0TfRHb/ziMm94np4auh7McAznjbfU8gEanwhTuIr69uV5AG5/xC2vhTK
         mtGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3e9t+blyZILLQE6+pdIsU2hY3jSYuQx5qRFvKHlvSLE=;
        b=4/MuJEsIfAFhBwFelREsaakxDpcVLGuSA3k8V6d2jmmIrlEfkoUh8tFOvvwkwGqWnd
         MZsS06gW97f1ozFMs/XmZOMsUOaaINI09cl+g74D8E6AyiJhtMOr3p/LMnuyHfZKML4A
         xEifmrcANgHs3lyq7PFoDs703cGP2WXckz/geydYbncZ7ZtKi19tzWCX8TRNHk1GA8ea
         rdFINpL1FSBrYYCB7tCcOUbst0nt9MOL8MqcnAHJyelKshqZ8mBNnwyEUkVpe3goSyFy
         kUUoEEi4D53GxyJYXQ7kDC+nxpd9NPe9PUcg4+qMMpowhO9JVCEGale5MgoE7XLzR74o
         YW5g==
X-Gm-Message-State: ACrzQf3ElvEqtiWEH3slHTBduruOtgsHqXBe3YM/s9Wa8oo3ymdDIeQ+
        BncJ5AzUVwXH3sStcb/Ew7HS8oQSXdresJdc
X-Google-Smtp-Source: AMsMyM7SxlNvhz8doHhCL3CXM9xeACf776xPP8VH08abG36RMKjRN/S8EL6Etwoz7L9l5PvypYpL/w==
X-Received: by 2002:a05:600c:4ecf:b0:3cf:8762:1a67 with SMTP id g15-20020a05600c4ecf00b003cf87621a67mr1700311wmq.41.1667390216130;
        Wed, 02 Nov 2022 04:56:56 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id ck7-20020a5d5e87000000b00235da296623sm13002090wrb.31.2022.11.02.04.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 04:56:55 -0700 (PDT)
Message-ID: <6927ffa1-e7f5-6691-dc86-da6c0d628c4f@isovalent.com>
Date:   Wed, 2 Nov 2022 11:56:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [RESEND PATCH] bpftool: Support use full prog name in prog
 subcommand
Content-Language: en-GB
To:     Tao Chen <chentao.kernel@linux.alibaba.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <2851b8859666a02878bc897d6c2fb51c80cadce8.1667356049.git.chentao.kernel@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-11-02 10:35 UTC+0800 ~ Tao Chen <chentao.kernel@linux.alibaba.com>
> Now that the commit: <b662000aff84> ("bpftool: Adding support for BTF
> program names") supported show the full prog name, we can also use
> the full prog name more than 16 (BPF_OBJ_NAME_LEN) chars in prog
> subcommand, such as "bpftool prog show name PROG_NAME".
> 
> Signed-off-by: Tao Chen <chentao.kernel@linux.alibaba.com>

Thanks! But you mean you want something like this, correct?

	# ./bpftool prog pin \
		name prog_with_a_very_long_name /sys/fs/bpf/foo

This is already possible since commit d55dfe587bc0 ("bpftool: Remove
BPF_OBJ_NAME_LEN restriction when looking up bpf program by name"). Your
first version of the patch was based on a version that didn't have this
commit, but bpftool from bpf-next already supports this.

Quentin
