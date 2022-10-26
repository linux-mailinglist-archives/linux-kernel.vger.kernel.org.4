Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2360E4EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbiJZPht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbiJZPhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:37:17 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF713589A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:37:07 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k2so22395504ejr.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NRAl70qY3j3vZyMIUT7GcMaBI6a+DFlOIhNnlrtBaJA=;
        b=nR++oRk27KdpUHzK25KyNMB64Fuzm7EE1QplYlREBHrVorYnfPsIjfL7225fR4CFbw
         R3xvYodLRcSfcS+jEZRdyHj8asnb72yEInDf7fjg0UHqx6/d/mLyV4XtTQ/9UIiI6ugP
         4U59B82KVk7dlebEavREE0TgILSbxHrumVJbMz3jX1S8h6fzvJL2yy1DXUE6j+ek+Fsj
         pb2I4RW2bDsz65BbQrV05oUMraHAX4XR8m5mr5yVl/kMwj49u5tXDjHoymCKGDgrHHs3
         kqB6X8WR+yDJVVLk9O418NnltJ3L538wszB0s1iHuCF6Y8yA8GensADLg19zDkWQqf1b
         DhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRAl70qY3j3vZyMIUT7GcMaBI6a+DFlOIhNnlrtBaJA=;
        b=TaPcN5fJHAZMiXXUTirC4svNEfrrBGw8fhLezt4ZsjfQ99sEAeT7WKRtjS6F+RZKIm
         l5BKAS0r5mku+J5WiBOmhoLUaBMXmd1EcB6rnQ4aFnP6mZV5+2NqGMZUFKTJDu32dYc7
         VFKhbFAjxIBtJLxDpJLLncvRVsyNz5f6qheBpVn7W4RaLo7fGFztCuk7kCyo0MEksT3q
         hWI0cS9ObKdqtW5VKHXwLuxtRqBqPZlrvkeaz/7iXgyp8pBksGPgut/EthT/uG3G3uWO
         eWEuCRKg/JPgFKtXNuuw5zV4R91giecoW+Ov5Vv/9z3fORvdp/eKoR7k0Y49rylAYZri
         czlA==
X-Gm-Message-State: ACrzQf0idg7pNcVfO96YjCf28l+eB8Wiv4A6+NBLemrCkhNsrq2mtkIo
        6GrtSkHCb1hlQtT4d/8Q9M1gLRJrRKwe9byNlQY/SSt6ULWhig==
X-Google-Smtp-Source: AMsMyM6GD20fveHyuqvQkjReBdrzYGU7sOoLCm9Y1Gr6teII7lBnYnsilAIBr4rOTLjo/ieQPi4ahPPLbjAl6euKnHI=
X-Received: by 2002:a17:907:7633:b0:7ad:85ee:c66d with SMTP id
 jy19-20020a170907763300b007ad85eec66dmr1087291ejc.730.1666798625785; Wed, 26
 Oct 2022 08:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <202210251659.tRMs78RH-lkp@intel.com>
In-Reply-To: <202210251659.tRMs78RH-lkp@intel.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Wed, 26 Oct 2022 08:36:29 -0700
Message-ID: <CABCJKudMzRcgZCVv4gF3QwKGxq3F2aVQj87WkMdh1ZFvy10DoQ@mail.gmail.com>
Subject: Re: ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 1:22 AM kernel test robot <lkp@intel.com> wrote:
> >> ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
>    >>> referenced by entry-ftrace.S:299 (arch/arm64/kernel/entry-ftrace.S:299)
>    >>>               arch/arm64/kernel/entry-ftrace.o:(.text+0x48) in archive vmlinux.a

We don't seem to have any C translation units that would take the
address of ftrace_stub_graph with this config, which means the
compiler won't generate the __kcfi_typeid_ftrace_stub_graph symbol.
Adding __ADDRESSABLE(ftrace_stub_graph) to a suitable place would fix
this issue, perhaps somewhere in arch/arm64/kernel/ftrace.c?

Sami
