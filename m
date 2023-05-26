Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4DE712BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242088AbjEZR3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjEZR3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:29:44 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9189C
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:29:42 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-2533ed4f1dcso809876a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685122182; x=1687714182;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ECdzZZL86eJhjSdjI9LSM4GZH5FHRQRd7R2QuPlZFU=;
        b=SWnwx7Rg5xkMoqvFnqVitXMTN5Tdof0PwAATkTNNiaocNy5T4unuaB/iL4w07jUu5O
         og7U+R4FZ+OyQIOs7eqS/6NZWC6F4zXt/+U99gZoC8DDBzd685xykDFVvxa+LkZEeibB
         w3wdlWx2rS2esBnVGbnBAlNFK7gDIRHG0+UL9EvXSkhUHUdGq2dp70Lck4QdhfyUjH18
         jTcFWqN5ygJiMR+XoVc077o8CJIfR+M6aPDCmTB2fF7VIugiFiBiHyWRYlIRIUaRHQPH
         iKmCz3tmsG8TWNFsVlz9CX3ji2PEjT3eXJJ8xxZXuC4eeCxSckCNO1jkFu/jsWKsDH2L
         AoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685122182; x=1687714182;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ECdzZZL86eJhjSdjI9LSM4GZH5FHRQRd7R2QuPlZFU=;
        b=CiEYjD5W17xQpdrsu927Bj3YlNjrhPtpoAgzgZft2Z8j4iZgrKsIA1oG6j9qbEyrH/
         Xl7D5Ag8RdF/ilIyagKduLtMkoxJcCKnQ4PlksgVK0uGbp3cZJP4SRFSZLxYazMPXBHp
         72AQ+oTttqa5plWh8lQz3aS1UsikUTmFLSgqcWixLTnxQy4GoC59gn4AmfMJmhL8qrVq
         soWojuOoEtnnzbOWLXM5zY/OT7sU/QcQ6lpG1JlLseEdvX+sHfpbG/Te+KgAPwskE508
         OL9BA+pcIH/7q66AFv4pucc/huEpNRAps0qIwPEjV+eIvazFiVSQQHtX410DJRcLK984
         F1cw==
X-Gm-Message-State: AC+VfDyyaycTDRAC42JSBZE7eE/C0P7MNZqQXKHKwwdxZn6OqIImhU9G
        4hBwFM3kVapEJTQKlTTyl/E=
X-Google-Smtp-Source: ACHHUZ4efWUt6aOiOCpOh4DLIyxIGndySrxgX+fK/GvP6JsbauvOYowVM7ihJhz9WwMDHYknbbbWZQ==
X-Received: by 2002:a17:90a:5b01:b0:255:5a5e:df38 with SMTP id o1-20020a17090a5b0100b002555a5edf38mr3045404pji.33.1685122181624;
        Fri, 26 May 2023 10:29:41 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id 21-20020a17090a01d500b0024e2980574asm5270832pjd.4.2023.05.26.10.29.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 May 2023 10:29:41 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: [PATCH v2] x86/lib: Do not use local symbols with
 SYM_CODE_START_LOCAL()
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
Date:   Fri, 26 May 2023 10:29:29 -0700
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <0F07EEDB-8A3F-4224-9FF1-43A5300B1B8B@gmail.com>
References: <20230525184244.2311-1-namit@vmware.com>
 <38e24fd4-9213-229d-9919-7ae3bfb113bb@intel.com>
 <24E47178-C177-425F-A8EF-CFFAE22597D4@gmail.com>
 <20230526155336.GAZHDWAFi1FRqq83TP@nazgul.local>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 26, 2023, at 8:53 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
> On Thu, May 25, 2023 at 12:39:47PM -0700, Nadav Amit wrote:
>> I do not think in this tradeoff not exposing local names worth
>> preventing profilers (and their users) from understanding where a
>> sample/trace is was taken. If for instance you look at a branch
>> trace (e.g., using Intel PT) you want to see the symbol to which a
>> branch goes to.
> 
> If those functions were written in C, you wouldn't see any
> exception-handling symbols either. It is the fact that they're asm
> and the exception labels are defined "out-of-line" so that you don't
> have code duplication and thus are symbols outside of the respective
> functions.

According to my experience any or virtually any code address, C or asm,
can be mapped back to a symbol. I say virtually all, but it is actually
all the code addresses that I encountered.

Can you give me some examples for code whose address cannot be mapped
back to a symbol?

> So you'd have to give a lot more detailed example where making those
> symbols global, helps.

I did not ask to make them global. Just to keep them as local after
linkage in the executable, like all other functions in the kernel.

> And if those symbols are going to be global, then they better have more
> descriptive names as they're gonna be pretty much independent functions.
> Something like __get_user_handle_exception() or so.

I can do that.

