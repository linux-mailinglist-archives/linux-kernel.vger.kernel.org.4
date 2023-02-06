Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8000D68C450
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjBFRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjBFRM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:12:29 -0500
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7776E29E23
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:12:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWcuvINuM57fIe+Z/vXE3oEWwftnU+xQaHXoen2h5uM=;
        b=f8i2dPWQXobhJUsTkhsWTfunjjbYnRdRZjBT+kOv3oCuHHUcduQH6TrGjt+tPHWuhEsVWw
        R+w923wyVFy57byaVYtyD845RFZp/Qcsu33iNrdaEb++FkAMCc2PEy7ITmgEbylHNWOp++
        M1ObWIWXZgoisFVUIkJ9EFih5nAxo5g=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     shahuang@redhat.com, kvm@vger.kernel.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 KVM/arm64" 
        <kvmarm@lists.cs.columbia.edu>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 KVM/arm64" 
        <linux-arm-kernel@lists.infradead.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Matlack <dmatlack@google.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 KVM/arm64" 
        <kvmarm@lists.linux.dev>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] KVM: selftests: Remove redundant setbuf()
Date:   Mon,  6 Feb 2023 17:12:08 +0000
Message-Id: <167570350685.3822534.3390093864852926212.b4-ty@linux.dev>
In-Reply-To: <20230203061038.277655-1-shahuang@redhat.com>
References: <20230203061038.277655-1-shahuang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Feb 2023 14:10:36 +0800, shahuang@redhat.com wrote:
> From: Shaoqin Huang <shahuang@redhat.com>
> 
> Since setbuf(stdout, NULL) has been called in kvm_util.c with
> __attribute((constructor)). Selftests no need to setup it in their own
> code.
> 
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: selftests: Remove redundant setbuf()
      https://git.kernel.org/kvmarm/kvmarm/c/6043829fdb71

--
Best,
Oliver
