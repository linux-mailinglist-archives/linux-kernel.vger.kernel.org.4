Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516D3709B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 17:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjESP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjESP2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 11:28:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11F7106
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:28:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54c2999fdc7so65226387b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684510109; x=1687102109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssI0QgWrOzpdZEqEXNriLfX+2/FsqkrD0LkZmCm7WLw=;
        b=onAdflqTz+yMPS1MbQlrK5cYj+CJxUD5Nzpora8A9Wh1WWGEkuGMFCuXjSL/BseIbS
         tnm3LJ4jWSk8b5bcsA55GpzqqXDdxMT+t6HEjjWGvVr+WzEP6E5OqWgX7owNLMx0KEv7
         kNkKxXbD/ofipeddS+NDyKS8s42cTnNFMz4mjh42AUVnc9QNpZAnEU00+A39v+gmJ/iH
         DBvggO78eIrbDRg4AXk9U5ntmmMXsNMVQfMiuaJSM+ySbo1iMNB5qW1Bap1aLdO6qKP9
         M9QmEGX/Vi2mnBE51iufsuFvnMSjgmlJil3qoz8R4qup/gzh2Gj7Bcd0FtiuEhac/3bQ
         hzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684510109; x=1687102109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssI0QgWrOzpdZEqEXNriLfX+2/FsqkrD0LkZmCm7WLw=;
        b=ia7ZFxCbT0Vm373pA7sVtXtVLTe4y8Hx+S7JAtwPrBBASR/BcsWpBreeJaXUssBpG9
         Fq7g2CIRwV+CshPhb7buWKuccgX9pfWKJAGcNjScqqMYeWtU9IHeD0U+NVxyhxnJE8bR
         WK6ZkRflzu1ByZhEchEph6RhBJ1+PHhyONekxDEAnB9CmXkvHq/r5WM1f0icypBetMAP
         xcCnwHlSmct/EkdU2/EPsWFAD7KF4jldbHnKJMASPn/gAJ/j4pldFbzZK0D6hs7Vkej8
         cdZPhuaxcbxn2BurOQJsFNdGi0Gn20OLxQvaGV/rgx0n95IzbK5pdVur4qgmVrVFv5Cw
         +NDw==
X-Gm-Message-State: AC+VfDyUlypNBdDwrjgiU26iE/gSW/tvwMLnTNVsB2HtAEnyYE9GCZcS
        QfGrVdzZqQGwGKkpyFuXHu33geAbWJ0=
X-Google-Smtp-Source: ACHHUZ7gIzlTQK6bPAG0bDa9af9CVMYOxkUdodPE3pltahEFyT/lQ5rC4UoHh7QM25CpYFBUCdXgPrtDQ88=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:e50d:0:b0:561:8c16:2b65 with SMTP id
 s13-20020a81e50d000000b005618c162b65mr1439960ywl.3.1684510109155; Fri, 19 May
 2023 08:28:29 -0700 (PDT)
Date:   Fri, 19 May 2023 08:28:27 -0700
In-Reply-To: <4d9397fe-1098-dedb-0f35-d3535040e65f@amd.com>
Mime-Version: 1.0
References: <20230411125718.2297768-1-aik@amd.com> <6a0cde0a-e1a4-9119-75fd-12b7c921b5f2@amd.com>
 <ZEFM735qNFOCGbnL@google.com> <4d9397fe-1098-dedb-0f35-d3535040e65f@amd.com>
Message-ID: <ZGeVm48+GeZAnFrm@google.com>
Subject: Re: [PATCH kernel v5 0/6] KVM: SEV: Enable AMD SEV-ES DebugSwap
From:   Sean Christopherson <seanjc@google.com>
To:     Alexey Kardashevskiy <aik@amd.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pankaj Gupta <pankaj.gupta@amd.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Santosh Shukla <santosh.shukla@amd.com>,
        Carlos Bilbao <carlos.bilbao@amd.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2023, Alexey Kardashevskiy wrote:
> Hi Sean,
> 
> is that still on the list? Just checking :) Thanks,

Yes, sorry for the long delay, I'm getting a late start on reviews this cycle for
a variety of reasons.
