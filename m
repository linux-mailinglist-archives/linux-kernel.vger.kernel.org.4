Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3E462612E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiKKSc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:32:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbiKKSc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:32:57 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E035B5A7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:32:56 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 140so4108121pfz.6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt34YV/MZZV7jS+W7OwiyVMKxHZ9NnWwfH2nxadlAxU=;
        b=W7/H5ujz3DpGriSq86yiYiFYWYn/JcloeHWl05yqWHS+xIMd87ea4LAtjMK0+9ZxXi
         2OW5d+S1bLlyWclTcsFjipuxKIrB9vnuqOXu/Tl0SSIzm3nxcrOUgYcfoH/DznABkSf9
         Y6kXj8prg7D2DrEXqrsIrb1vYxXuqEA1PqCb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xt34YV/MZZV7jS+W7OwiyVMKxHZ9NnWwfH2nxadlAxU=;
        b=rk7TE21Vzp46Y11IWx3nsYrPH2I73elYlc6jad+nOd2dW/r++lubgBk5ENNVv7T2Fh
         R5qr+PB+yQjK4K9sS41sXRenuJ2gOAYhl8YR31QN5poXZrJAc2cD/o3qW00P7U3hNlmP
         ZeYJwyZtDi11+1O5sUPhi6lUu+L5fi2YPzM/Z8nMRICdZQIue25uPiP6TrMD85c5n4dz
         D7d8NfpW/HIlEAFYkCy8FFe+jwtA4+zt/GEDqVLJlkYA8Xbq5F4EKzLsPKw0oSpLnkAF
         A0h9YbxVhrbB9BIC0UDbyqxeFRSjf9Qvxf7eXJQQpUmFATLqUzUbOL8+lqniWHenmFRc
         vqcg==
X-Gm-Message-State: ANoB5pmpTChMbnhFSeqGbTeUB/QzQ2Eli8J9CnKpuq06utuKu4y3eFeh
        Qs6o3aEBW112wM7WCW0Zv+K/kA==
X-Google-Smtp-Source: AA0mqf7g6ESXQ+rrvwAbk1yvs3nSG+WSbuhodtw7X5MrTk3bKHz+9SuBMOj1iwwoG1OxjpMvd2yyHg==
X-Received: by 2002:a63:fe51:0:b0:459:a339:89e0 with SMTP id x17-20020a63fe51000000b00459a33989e0mr2758570pgj.300.1668191576394;
        Fri, 11 Nov 2022 10:32:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090a0c8a00b00205f013f275sm5157870pja.22.2022.11.11.10.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 10:32:56 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:32:55 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: ftrace: Define ftrace_stub_graph only with
 FUNCTION_GRAPH_TRACER
Message-ID: <202211111032.BBEEDFA0@keescook>
References: <20221109192831.3057131-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109192831.3057131-1-samitolvanen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 07:28:31PM +0000, Sami Tolvanen wrote:
> The 0-day bot reports that arm64 builds with CONFIG_CFI_CLANG +
> CONFIG_FTRACE are broken when CONFIG_FUNCTION_GRAPH_TRACER is not
> enabled:
> 
>  ld.lld: error: undefined symbol: __kcfi_typeid_ftrace_stub_graph
>  >>> referenced by entry-ftrace.S:299 (arch/arm64/kernel/entry-ftrace.S:299)
>  >>>               arch/arm64/kernel/entry-ftrace.o:(.text+0x48) in archive vmlinux.a
> 
> This is caused by ftrace_stub_graph using SYM_TYPE_FUNC_START when
> the address of the function is not taken in any C translation unit.
> 
> Fix the build by only defining ftrace_stub_graph when it's actually
> needed, i.e. with CONFIG_FUNCTION_GRAPH_TRACER.
> 
> Link: https://lore.kernel.org/lkml/202210251659.tRMs78RH-lkp@intel.com/
> Fixes: 883bbbffa5a4 ("ftrace,kcfi: Separate ftrace_stub() and ftrace_stub_graph()")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
