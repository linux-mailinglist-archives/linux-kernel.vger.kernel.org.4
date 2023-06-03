Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D79720CB4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 02:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbjFCAwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 20:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236953AbjFCAwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 20:52:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082B0E53
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 17:52:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5692be06cb2so32375387b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 17:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685753554; x=1688345554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XmIMcPVGS0k6n0EiT+HGbgRbY6otS4LW3O2Qm/7SDBM=;
        b=e23hOxkqjoZysJGj5raBz6iGfFys3yTqE/Ii8Po524fwzT4Mg6wW359rgdDf2PEUmd
         3qhoEu+tTPrV7KII58r4o9rgg3ekRRM9LI1Tu1uhVLDiJRKKvHBIr3NfpAxqYpjoaApc
         39H391m9CcY46SGR2RmBEofeFZtBdUGS/UrMsqTlLl57sIDBV4YrbxDAWtE9O7VbHk+V
         Q4KNrHu1M0FpdAlRiMwcU1m3HznNH00KKKv0VChQsfOMyHMxIUAZCy4CSJ2v/hwa9w6f
         8G9rcjUmm9A01ttvbyDyYmvELFYowKUBGoJKpmTAaGTdSOcVPpWDBpyrGVkEiSeeaiOL
         cbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685753554; x=1688345554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmIMcPVGS0k6n0EiT+HGbgRbY6otS4LW3O2Qm/7SDBM=;
        b=aryPBKYiOX0BnXY7irIl6ImeyymSgAARbneucqpme7bYzZbWX5EuyZrAfydMtxjywm
         wPbn6gBLyuOz9i93OJ1DpWYnvNpQGjMuBL7OmYzgiNuDFlp+t7oiUUJdEtafOz63vQav
         u0Mzx/FLLNPOkgaoYQtrx2xGMNcBJgBp48QOyHFFuAyKJpYjdDXyPs9fEOLl1O7B5K50
         Tg38RqFGTSEUHlefxguR4H3kAV9Vl6a+DrloxPdfiby3VWg5G6q6xGeDsxNo+KTqLLaA
         r49MNKid2eRmjdhJOw4/AX44BpBOjD/aAFcovTOX+iCtmrK8+00OyfbnwanApW88k7Kw
         4QZA==
X-Gm-Message-State: AC+VfDynzDYyylyJFxkrAZX15toDvPDP905mIiOxjExA2okN0oRzkJJB
        NJ89ZQCvyDNDEE4fVryvo/ZuOdTmCyE=
X-Google-Smtp-Source: ACHHUZ4RAnvNq7LGDQ1T5V6eADaQEtBr/sSHXOMwfl2lDg7lffrFl8r+LufvFOYpT21HbQ9lQEph6FowXqA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:404d:0:b0:552:abfa:1e77 with SMTP id
 m13-20020a81404d000000b00552abfa1e77mr703635ywn.5.1685753554327; Fri, 02 Jun
 2023 17:52:34 -0700 (PDT)
Date:   Fri,  2 Jun 2023 17:52:24 -0700
In-Reply-To: <be4ca192eb0c1e69a210db3009ca984e6a54ae69.1684495380.git.maciej.szmigiero@oracle.com>
Mime-Version: 1.0
References: <be4ca192eb0c1e69a210db3009ca984e6a54ae69.1684495380.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168574913038.1016879.4889109727408335591.b4-ty@google.com>
Subject: Re: [PATCH] KVM: SVM: vNMI pending bit is V_NMI_PENDING_MASK not V_NMI_BLOCKING_MASK
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Santosh Shukla <santosh.shukla@amd.com>, vkuznets@redhat.com,
        jmattson@google.com, thomas.lendacky@amd.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 13:26:18 +0200, Maciej S. Szmigiero wrote:
> While testing Hyper-V enabled Windows Server 2019 guests on Zen4 hardware
> I noticed that with vCPU count large enough (> 16) they sometimes froze at
> boot.
> With vCPU count of 64 they never booted successfully - suggesting some kind
> of a race condition.
> 
> Since adding "vnmi=0" module parameter made these guests boot successfully
> it was clear that the problem is most likely (v)NMI-related.
> 
> [...]

Applied to kvm-x86 fixes, thanks!

[1/1] KVM: SVM: vNMI pending bit is V_NMI_PENDING_MASK not V_NMI_BLOCKING_MASK
      https://github.com/kvm-x86/linux/commit/b2ce89978889

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
