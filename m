Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DDB6C8BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 07:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjCYG6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 02:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjCYG6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 02:58:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89145FDB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:58:08 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x15so3313428pjk.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679727488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y5cwDPqfEUvy+7nhrVxCwZN/0n8Vzychx7QDsFwXNQc=;
        b=JGDGICEx4hIWwbjtQTNyhNBf6eIhNUT0fHxY8Jpfa/qsZ+IjV2vAsk5WJfuOSS2/gt
         nb9+h/2ksgdbVTfkMBwNxGpVV4uw/PA2pUKz4yfpnq5cLHa6Dir9l0IXXmK9cjTPwkDx
         XgxOVwr351GZDF70nRtWh+f9rD4GO7imQramfwKvR7EJw1zHbJEqy+9aPxXYci7jbcht
         XHwm5Y6/JqD2KClzqC9ZNv3CQaKUQzQ9MFyLDvCAhpgokyaUq9+XvtL5DOFqutfH9LeZ
         N+48VgSeCs57wTEE1fil8Gw+qcPiPUBp5RREJqm4BapJQMaDAkvHaRD9VzF6h8tTi6YQ
         gXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679727488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5cwDPqfEUvy+7nhrVxCwZN/0n8Vzychx7QDsFwXNQc=;
        b=FSOW6ObF2hgshq9rY7SdYYVmW/fusz56QnOt9wIaXpf2i0BaiwR4HJONgowXpCat1T
         UitQ2RFrpcjbX8ipFRVlY7ZgtYuSLAQyxmDn3Wr1wNEDYaAG1Ssylbyd8cwd/w0tEUIF
         YhcGqn7gU8aU0ZTGFrRz81qacmW8ngLdEQQPVg+H1gvRiNOyt9zcHzrTH3lH6HipEs62
         YJKvlzDYjJx8ah4D2UoJVc1gDZa45IBikJnvRWPeeCkjzurWFTRVApnAdFH3RYSahU0r
         ezXCnV4ayejk39+CGalaR8n/t64Wx/30gorZhuXjfIa85vyzTOAlbojtIUFJ85foDpVk
         uyGg==
X-Gm-Message-State: AAQBX9dWpHD25PRJXLJeRKURmMu3T0gUV2AKA51GsYkouJ/8x2qnO8s+
        JdBq9vWT+myzKOwKozyytX03Z90KIVw=
X-Google-Smtp-Source: AKy350aj8j1pWnxE7icwBnU6+5cQ9XGU2Yi7P0nHuCbbs6w4clc/jBg/e6GoP+wcHOxyzh2v2/VRYw==
X-Received: by 2002:a17:903:24e:b0:19b:dfd:a202 with SMTP id j14-20020a170903024e00b0019b0dfda202mr6096190plh.38.1679727488099;
        Fri, 24 Mar 2023 23:58:08 -0700 (PDT)
Received: from dragonet (dragonet.kaist.ac.kr. [143.248.133.220])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902a61300b001a1dc2be791sm9197819plq.259.2023.03.24.23.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 23:58:07 -0700 (PDT)
Date:   Sat, 25 Mar 2023 15:58:03 +0900
From:   "Dae R. Jeong" <threeearcat@gmail.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Vishnu Dasa <vdasa@vmware.com>, Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Pv-drivers] general protection fault in vmci_host_poll
Message-ID: <ZB6be+/X41JNG6dX@dragonet>
References: <YswCW3yBdaI7CkOn@archdragon>
 <465D4025-6451-4810-B816-E93D255BE9A8@vmware.com>
 <4B3A80B8-12F1-4695-90CA-EB6E560833A1@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B3A80B8-12F1-4695-90CA-EB6E560833A1@vmware.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 06:36:02PM +0000, Nadav Amit wrote:
> >> - Crash report:
> >> general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN
> >> KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
> >> Call Trace:
> >> <TASK>
> >> lock_acquire+0x1a4/0x4a0 kernel/locking/lockdep.c:5672
> >> __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >> _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:154
> >> spin_lock include/linux/spinlock.h:349 [inline]
> >> vmci_host_poll+0x16b/0x2b0 drivers/misc/vmw_vmci/vmci_host.c:177
> >> vfs_poll include/linux/poll.h:88 [inline]
> >> do_pollfd fs/select.c:873 [inline]
> >> do_poll fs/select.c:921 [inline]
> >> do_sys_poll+0xc7c/0x1aa0 fs/select.c:1015
> >> __do_sys_ppoll fs/select.c:1121 [inline]
> >> __se_sys_ppoll+0x2cc/0x330 fs/select.c:1101
> >> do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >> do_syscall_64+0x4e/0xa0 arch/x86/entry/common.c:82
> 
> Not my module, so just sharing my 2 cents:
> 
> It seems that this is a bug that is related to interaction between different
> debugging features, and it might not be related to VMCI. IIUC, KASAN is
> yelling at lock-dependency checker.
> 
> The code that the failure points to is the entry to the lock_release(),
> which raises the question whether additional debug features were enabled
> during the failure, specifically ftrace function tracer or kprobes.
> 

Hello,

This crash keeps occuring in our fuzzing environment, and we looked
into this. For me it seems that is caused by a race condition as
follows:

CPU1                                CPU2
vmci_host_poll                      vmci_host_do_init_context
-----                               -----
// Read uninitialized context
context = vmci_host_dev->context;
                                    // Initialize context
                                    vmci_host_dev->context = vmci_ctx_create();
                                    vmci_host_dev->ct_type = VMCIOBJ_CONTEXT;

if (vmci_host_dev->ct_type == VMCIOBJ_CONTEXT) {
    // Dereferencing the wrong pointer
    poll_wait(..., &context->host_context);
}

I think reading `context` after checking `ct_type` in vmci_host_poll()
should be enough to prevent this. Could you check this?

Best regards,
Dae R. Jeong
