Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2172B7344DD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 05:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFRDzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 23:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFRDzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 23:55:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C0712F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 20:55:15 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-668704a5b5bso537124b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 20:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687060515; x=1689652515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6MiGCyYWL9afbEiU1hHeFVbLqDHOS9ob6XcRtSyE8kc=;
        b=AJUDOLu5Tl85VIyrAk/hh3ZEQkgwbb9Cmj3AAoi1+FKICy0frYWpCfIJ81Ng4lvG/p
         /qUrcb/cnkcAmsh7v+6pXWJkb9tKzDpJrBoUY5MGNtz/G1JKEPytSvCKTzv3C8pFsd1N
         01SmTtx2fXFU9wXMN6qI+PywFeOZ1Gp2WcYBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687060515; x=1689652515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MiGCyYWL9afbEiU1hHeFVbLqDHOS9ob6XcRtSyE8kc=;
        b=JDdJcCllq2VaVX7UMU0vfcbw9/CqgIzLPfewWFyCKkmfUCR27u1cpBJCxdPwzeSSNL
         uR3P4zzGJg62kj0bDvWQQ3bJLTJplUsBsm4+cJMWPpldV/dPqQsfMX6s/h+pXzjv9xrm
         7y7drVeKzZGaN/tHZs79DUdFaSuJEcYfs7PzoQDTlIoxhmxdtEvs94+j2ZMxxLTT77xd
         QTsGygJSMZXNuOI2uRF1RT5fi1qh563giSyEQBY/mx4BOeIMZHlPyb14YXrdMpSKVuxt
         mlhXgB8t63j8Qxoh+FHqMuppnFpRbgoOS8MlqUbz/gEtZCLhZ7qLne0dkaKAKTxnUUXq
         XnYQ==
X-Gm-Message-State: AC+VfDwRmH2oTgEOt1imjIRgE9G+5nJlZFaH/o2z6vyjRxJKc2KZdzKM
        aXI0IvXm5pUX76bpJm0PHvQ/CA==
X-Google-Smtp-Source: ACHHUZ4QjxT5OBEGlVgoJ7ti/n+FXoNtNY8W2mxClgVX6nXQNW+mXjsgIzWQdLHx8JbZn0JdsPPDQQ==
X-Received: by 2002:a05:6a00:1595:b0:666:e8e1:bc8d with SMTP id u21-20020a056a00159500b00666e8e1bc8dmr8143991pfk.11.1687060515111;
        Sat, 17 Jun 2023 20:55:15 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id d3-20020aa78143000000b0064d681c753csm15477911pfn.40.2023.06.17.20.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jun 2023 20:55:14 -0700 (PDT)
Date:   Sun, 18 Jun 2023 12:55:10 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, hexingwei001@208suo.com,
        pmladek@suse.com, senozhatsky@chromium.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] lib/test_printf.c: space required after that ','
Message-ID: <20230618035510.GA2417543@google.com>
References: <20230614082523.63191-1-panzhiai@cdjrlc.com>
 <f2d8eb955890bc1db1b307db713d4a4a@208suo.com>
 <ZImzXhc7ZRbSvz7/@smile.fi.intel.com>
 <20230614110640.57817123@gandalf.local.home>
 <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInZ1BcHHQbok+wg@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/06/14 18:16), Andy Shevchenko wrote:
> > 
> > checkpatch is for patches (new code) and should not be run on existing code.
> 
> What do you propose to prevent people from using it?

Yes. It should not be used on the existing code because it breaks
backport of important fixes to stable trees.
