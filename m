Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439E56C736A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 23:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjCWWyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 18:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbjCWWyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 18:54:04 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63EB2CC59
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:53:43 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id h4-20020a170902f54400b001a1f5f00f3fso152624plf.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679612023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYvDKOxnIlpQusiF6SA0T7tXCoz4W0iXPvv4uKMc1E=;
        b=At8h77NnzlAZJKd5E5nUfhwLxZxZ+/xC++bofIlWznW1dizloSaOJ8Ma4Dq83EfCnb
         KkSTP4DpHqmt7U8jFvUIhBqLCfI2EomrC09NIR4gP0jBsZMXv808gNLVmRCRkbAiUfNx
         bRd/cPvDWtlCij0tuzTlWFqpiDnAlQYRdHvxhy4KWI91w2ai1lHFJ5t7YNAaVeRiscEC
         hy4l2dkA2rQRbXjbJCnlgcQTWMgnpxqucXL7Qza7wNSiaiKml0CjHtDK7MMYqlkCp6++
         VxFMXWCspgFHC7lc1ZJZqsAwpzv5Q7xvn525yT0clY445S25mvOfRnMgN2YzqdLjj3wU
         idGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679612023;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wEYvDKOxnIlpQusiF6SA0T7tXCoz4W0iXPvv4uKMc1E=;
        b=to7GywNeEIRi4FA4Io1U3WQ05bRDRqLgyRPz30sRoTQOmSiExxWaOPD0mzQF39c5gi
         p19ZGpwMl7GP7FURwviA1CNYnbANWRd/WiKkGlkglcUutl41rFT0kB2Pqm9bVKO4Z2Lc
         t4ElQa212cmfU8RKbTpw30fFnGTZ4ZbbKMo2xOcQTfgaWOZyC6HERGW4LwyXDvNC51SI
         l3tlGyI0UOJyUlrGJrJRh2qbPf3WyP6msKNuJ7sAhBQF458cHnaulfJqjSX8CwXOAugD
         jZ4Y9PZB9e0eAEPNUiUOvMdysLfTHwMlATvL0fZcH0XOJ+NOXhqM4ZbSA4xv+uYpCt1D
         YSbg==
X-Gm-Message-State: AAQBX9dZOBlnWYChzbZEjrSwwcZPhfuIUk7PwojFGE/RxiNVX3V30Oam
        2u1a7ruwP8DYB87Wv1Wt13m0d5dg1JA=
X-Google-Smtp-Source: AKy350bt4xTSvYjFPODKfvs4QgedXHc9Y4eLZfNUlXiApxEkEGf8gsqfxapjIVRed8EOussZqO2FW27Zrkw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:41c9:b0:19f:3a27:6c5e with SMTP id
 u9-20020a17090341c900b0019f3a276c5emr220571ple.0.1679612022984; Thu, 23 Mar
 2023 15:53:42 -0700 (PDT)
Date:   Thu, 23 Mar 2023 15:53:36 -0700
In-Reply-To: <20230119141946.585610-1-yu.c.zhang@linux.intel.com>
Mime-Version: 1.0
References: <20230119141946.585610-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <167942115350.2068418.1799786492353731807.b4-ty@google.com>
Subject: Re: [PATCH v2 1/2] KVM: nVMX: Remove outdated comments in nested_vmx_setup_ctls_msrs()
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Jan 2023 22:19:45 +0800, Yu Zhang wrote:
> nested_vmx_setup_ctls_msrs() initializes the vmcs_conf.nested,
> which stores the global VMX MSR configurations when nested is
> supported, regardless of any particular CPUID settings for one
> VM.
> 
> Commit 6defc591846d ("KVM: nVMX: include conditional controls
> in /dev/kvm KVM_GET_MSRS") added the some feature flags for
> secondary proc-based controls, so that those features can be
> available in KVM_GET_MSRS. Yet this commit did not remove the
> obsolete comments in nested_vmx_setup_ctls_msrs().
> 
> [...]

Applied to kvm-x86 vmx, thanks!

[1/2] KVM: nVMX: Remove outdated comments in nested_vmx_setup_ctls_msrs()
      https://github.com/kvm-x86/linux/commit/ad36aab37ae4
[2/2] KVM: nVMX: Add helpers to setup VMX control msr configs
      https://github.com/kvm-x86/linux/commit/f6cde92083de

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
