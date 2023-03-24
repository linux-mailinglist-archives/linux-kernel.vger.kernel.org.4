Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3506C8751
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjCXVIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCXVIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:08:31 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED781F938
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:08:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so2948497ybw.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679692083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lFqVmfLzTQzrSzXuGdi5LLurY3nSI1o6H7Ywl0LlWoM=;
        b=JkzLzB9YvNsZIYAowm4t5HQBcR+ava1pPwsTFR9WMFuMnKGxC42iTtvYZGgF12vrhn
         r3jj+OfKa2r06jGrhkjZGGJLSJCQm8GCgYPEYG5SszagCbEpy4t/xzGGrnTHjYQ7pMM+
         BUvgmuGfKyqinPPprSiXCNIZ7eRlsuecbeXoQ+B4oA8g2wXmSXSmc9FbY84HTzsMFpFY
         ihOUWZiDNcwQawwTLgepwqcvxayU91Mm+2WHHXxKNXu3P/Ni/ckLnFhdstJD9CODIWa3
         tR5uQNBWJBkzqdJQSgL33tqw8jtONUEBxd7R6oY9NRWUNcuctI2mV+DjFsher/QLXrCD
         iJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679692083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFqVmfLzTQzrSzXuGdi5LLurY3nSI1o6H7Ywl0LlWoM=;
        b=0VSbW7QaJf0mYBPCosg4S4jxIdjavauxLM9SGc43VDfeCeNlnl4geMreeOiPuYmiTt
         1l95wqzCs4+l2frqblpwyJmm1GUnBcgl95muIO6JDanKcOJuCYLuFc6acGMNKgPYmFHY
         lEy/qYKgJ4ia7Z459PdtjIVniQdFGYTmJw3KJZoSv/mKp8qcV2gi3/P6HtV9OMz2JKhq
         VDknnPtgUoEOVLEllJPVL+ypdo4GynKlzHquqpHyaa70ssnSjd+SxS/4gy8i6QFabfzy
         nRZBRhhviy/5gIVVBcvDRS2yDkpcnUnhRv71i6iNEyC2TYXbDfF/1nhyLA3yE3zGQMsy
         ZOmQ==
X-Gm-Message-State: AAQBX9dAz1y74IWXcdQ82+kIN5mw8BoH4xEJLMTSw0ZcNOoVa/nR2IPq
        v9vo/BfOnZNZigXq2cQaV6L7Pcj48h4=
X-Google-Smtp-Source: AKy350ZMzZxicOo2+ugDp5N8OlZN/ep/foDOjHXjZSdU3Ltahxnieti6/n/jiEw9VKrpXB0cRJqZ9KSZRVY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:21c2:0:b0:b36:c001:d0a7 with SMTP id
 h185-20020a2521c2000000b00b36c001d0a7mr2073611ybh.8.1679692082847; Fri, 24
 Mar 2023 14:08:02 -0700 (PDT)
Date:   Fri, 24 Mar 2023 21:08:01 +0000
In-Reply-To: <20230313085311.25327-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230313085311.25327-1-likexu@tencent.com>
Message-ID: <ZB4RMeM4dmNyHN7D@google.com>
Subject: Re: [PATCH v2 0/2] KVM: selftests: Report enable_pmu module value
 when test is skipped
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023, Like Xu wrote:
> Adequate info can help developers quickly distinguish whether the cause
> is a code flaw or a platform limitation when a test fails or is skipped,
> and this minor patch-set is doing a little work in that direction.
> 
> Previous:
> https://lore.kernel.org/kvm/20230214084920.59787-1-likexu@tencent.com/
> 
> V1 -> V2 Changelog:
> - Apply TEST_REQUIRE() to x86_64/vmx_pmu_caps_test as well;
> - Put TEST_REQUIRE() at the very top; (Sean)

Ah fudge, I missed this in my todo list and applied v1.  I'll probably just fixup
and force push.  One way or another, I'll take care of it.
