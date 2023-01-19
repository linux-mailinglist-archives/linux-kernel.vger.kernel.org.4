Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE89674416
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjASVM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:12:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjASVKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:10:40 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584824C35
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:04:50 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 24-20020aa79118000000b00580476432deso1441389pfh.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nvmk2/jak230OqvlUzM7kqwdVz758d1LaNNIenA2q88=;
        b=RSK235oiGkX+MEF1SJf0PHRcdlBagAhddBhFeC1XNbAWK1zPQCAnV4WEPDIDboHywp
         GHCgiww11RKxAp1ZMBvRYG3y5uzqN4UT3Co0wm+5SvIlPGySY8SU5z/IWCNIf3ehnZSD
         b3hSNsy3LYIaj683uLnQBAjE1Zz0unS7+iQUaoaj1lbkFEp7D9/Krr4FCo5bIvN/tYVo
         IbL0C8qM1GSEYzg2Z3I/6pSJTgwS/oJlCAPQlzkQeSO7+asVtcO5LZKjJamsIkdTvwN5
         7hK9ZsiA9dXgB/0Jw+0netALBDs27IowRv05vRe1Jv/ZIQeBnXtXuZS5pfBXNs/gHmiG
         KVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nvmk2/jak230OqvlUzM7kqwdVz758d1LaNNIenA2q88=;
        b=7RfZOiR4ivh/vM7g79+PMNRHKdOhPd6dXjCKYpUkT2NbKz/5Bv1HRER++/SmvHM0sX
         A5XIlqlt3Hmfyk+dvrGgiTUBGQAhCjJsPXBiP7fdfNbLsmjBU34sSYXi12Nxt0o3+z3V
         2j0WxGzy0rozIpyeel7H0x9F2Coa6WBP6F1vIx4gbl1wTP04B++nnsq80pv5nkhNTxS3
         xvxFKZ+MBoaz++BRAwNADZnlKgT1EkBxvZ6jaPHq2Ocuvs0ExnoWA6meSlFuDIMNZuz4
         NDQvqdaU/9nasD8bmSrlHSY4OWQaOrfZ6OYFJLKveP89QUsnVz5CC1ultjxiy5vN1Sr8
         yu1Q==
X-Gm-Message-State: AFqh2kqdSR5LrLKfe57vZeBDxsFlWz3uWSMBPf+GBXgNfemDgE+UMDXT
        OKz/TMuV8eLSBx5oPcMHNhz5aYfQ2oQ=
X-Google-Smtp-Source: AMrXdXssljGqQ+0w5mOWKaeVHAG8iyFA0OE5O+uBTvzOFiovVAsGUYvmmAWnVUx41ebtO84b5X/YN8Gb2Zw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:1201:b0:229:81a7:c5a2 with SMTP id
 gl1-20020a17090b120100b0022981a7c5a2mr1126674pjb.187.1674162289487; Thu, 19
 Jan 2023 13:04:49 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:04:32 +0000
In-Reply-To: <20220920060210.4842-1-wangliangzz@126.com>
Mime-Version: 1.0
References: <20220920060210.4842-1-wangliangzz@126.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <167409120474.2377579.16608951423859920496.b4-ty@google.com>
Subject: Re: [PATCH] kvm_host.h: fix spelling typo in function declaration
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        wangliangzz@126.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangliangzz@inspur.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Sep 2022 14:02:10 +0800, wangliangzz@126.com wrote:
> Make parameters in function declaration consistent with
> those in function definition for better cscope-ability
> 
> 

Applied to kvm-x86 generic, thanks!

[1/1] kvm_host.h: fix spelling typo in function declaration
      https://github.com/kvm-x86/linux/commit/b6ca5cb72f58

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
