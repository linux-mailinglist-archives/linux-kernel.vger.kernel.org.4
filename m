Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67CD563FD43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 01:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiLBAsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 19:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLBAsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 19:48:23 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E2337209
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:48:22 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id q1so3089465pgl.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 16:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1aoDrl7lkSS9ga8y4LgwxWtNaGp55cRlozgPoS8NzPE=;
        b=aSMiIJlx2ddMEuoJL1IRIDeYp8aNqLByh5cq+owsK9LDDfg8IXv1mXIA8UeiMDBDCK
         +CLUkUp8qO+xMRN2+uszHnOKrGSObk174GCF3JtR0Wgagc/mk58OpRykjBbCf+Vd4V4q
         q8cAA3zxTndZ1/G+dNx02YJVgUQTwy3VTrr+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aoDrl7lkSS9ga8y4LgwxWtNaGp55cRlozgPoS8NzPE=;
        b=gOwTKSurfwtttSkUL30n6ryRJwEF/s5Jygkd/g53ehYOftDihCfbIKT79k4/Xu4Ggs
         dODvFFkrliW4Wu3WKSVSdN19xKTqYJOW7A1CgtQJN5VNYr2CuYAA4EiB1TFlVvy7zErw
         xa3wqczcuqCcQayUPFprcOG/R3bliN8pL/ECg6KmBA2tNc6i7RhWcpUBIvJH3Sf9VeZI
         anyx64oqiVNmFdiH/v7NVH2lLRhzBe72SYYvhHrI+B7M0IF1IRlEi41TcO4/yYO78P93
         GJO5N535j/qDVfrZhMp/SMmozt223ZDIxRdmjiPRgRFcfTElgmcIf6BV6E2cUZNMPnB6
         pbkw==
X-Gm-Message-State: ANoB5pl3UBDRBP1f1ZmK5Fd0ul/AY5Rstr4bbv1j+5i4UqfKOyx6tFqu
        MiSe/xNKbv4lKPJsduGvtQGxyA==
X-Google-Smtp-Source: AA0mqf6+F8pTy62QAx1b77iaWIFnsSLNBkoekEFWvLL1SzADQ+WnbHmbklWGt6I7xYLGknFEMi6EUw==
X-Received: by 2002:a63:f048:0:b0:477:5e23:f9d1 with SMTP id s8-20020a63f048000000b004775e23f9d1mr41864006pgj.268.1669942101973;
        Thu, 01 Dec 2022 16:48:21 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b001894198d0ebsm4222206plb.24.2022.12.01.16.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:48:21 -0800 (PST)
Date:   Thu, 1 Dec 2022 16:48:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>, ebiederm@xmission.com
Cc:     limin <limin100@huawei.com>, shuah@kernel.org,
        ebiederm@xmission.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        lizefan.x@bytedance.com
Subject: Re: [PATCH -next] selftests/ptrace: Fix Test terminated by timeout
 in ptrace_attach
Message-ID: <202212011638.31BBB562B@keescook>
References: <20221128070454.1850273-1-limin100@huawei.com>
 <AS8P193MB1285BCEDA342A074F6A837FDE4139@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P193MB1285BCEDA342A074F6A837FDE4139@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 08:56:09AM +0100, Bernd Edlinger wrote:
> thanks for cleaning this up.

Oh, hm, I never saw the original email -- I'll check my Spam folder, it
gets overly excited sometimes.

> Just for completenes:
> 
> I have actually two patches submitted a while ago, but did not get any response so far,
> one that would make the test case work as it is:
> 
> [PATCH v10] exec: Fix dead-lock in de_thread with ptrace_attach
> https://lore.kernel.org/lkml/AM8PR10MB470801D01A0CF24BC32C25E7E40E9@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/
> 
> and my favorite one, that would fix the dead-lock altogether (and adjust the test case accordingly):
> 
> [PATCH v11] exec: Fix dead-lock in de_thread with ptrace_attach
> https://lore.kernel.org/lkml/AM8PR10MB470875B22B4C08BEAEC3F77FE4169@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM/

This fell off my radar, but let's look at it again. Is this still an
existing race after Eric's various refactorings? I assume so. Eric, can
you looked at this case?

-- 
Kees Cook
