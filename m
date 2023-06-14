Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FBE72EFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjFMXWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjFMXWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:22:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DE1BC5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:22:47 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56cfd5cb875so1552647b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686698567; x=1689290567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYwd+D4Cb9qTpytZWzkgxnDLoRC1DHKyxU4tUMBIemU=;
        b=BJYiL8TcZs1Ebm49FgZbHWNW1374idz4WZmf8dHd/xHfsmacZVRq+6H7UrbeO7VMH4
         90JHDi6g+rRvUKE3Z54EofTaruSlGc/64/vKeYL9dY2jilM2GMmJFJNKhTRBHHcY9uRT
         +Sq0i+1PkfsaAhnEC6o2uzEZ2941c6hIFx82pVTq+UuPTS1v6Hw+2/t/YVQP6tewDu5d
         uwYykgZMMrJjEofVI2bzjgOlbDLNtXTTJ6ArqUNeDJ5GtDtKuROEBO74zVsUekF40i3w
         kR1Pgnof+w9vW3ZVKCnVOfO0E+DFZSbChVZe7fJrWsVr5DdlVcmvVb1gMKCKQVVUpUFe
         NMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686698567; x=1689290567;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYwd+D4Cb9qTpytZWzkgxnDLoRC1DHKyxU4tUMBIemU=;
        b=cTdXw0LMzGaehlfFEqQh+0TGgn9zPd1scl7lyXllmPAlmP+o89YYxKEJ3e1A3ANCVK
         UmMZIUJ/8Gx/3MVJ/gd2n9FNd4/35SWUlC04kM++e1maO6CazF6Olm6LMEj7eDzE+fB6
         d4/jQ16Dlrv9xGhs3SIcae6VsAtHnJ/wyhI8E+RnTNH4zvilXrG7BYCqx1BPw+dZlpUK
         RXLn+AxWy4ur2wXtAPkhoai4cqfzTOvtzOzW2Mq1VTDVJGpXHjr5vr5VFthcirb3eqNA
         Ie+u4nuLsE5geqxxmJpE4xj5VSYETZmUvgnky/Mh5xZuU97e6XA29gP380o6CIIrA2kC
         gpyQ==
X-Gm-Message-State: AC+VfDwgBZwl8z+sMaBixKqgCeRPT9swOO2evvhYMO7XPxEmiyZXXFyy
        LJpCxRAKpD1qvyG8UZoFw9J+mV3Us0Q=
X-Google-Smtp-Source: ACHHUZ4dfcJyKNqzLWwlR7WUr1Os6eFGZ4GJtJ2uWLUwXEpJIebEkmDNXEj5ETVTmyYehsyjLxnA6Zo1vo8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:c44c:0:b0:56d:3b4e:201b with SMTP id
 s12-20020a81c44c000000b0056d3b4e201bmr80300ywj.10.1686698567169; Tue, 13 Jun
 2023 16:22:47 -0700 (PDT)
Date:   Tue, 13 Jun 2023 16:22:24 -0700
In-Reply-To: <20230601080338.212942-1-yu.c.zhang@linux.intel.com>
Mime-Version: 1.0
References: <20230601080338.212942-1-yu.c.zhang@linux.intel.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <168669238973.1996737.17411190747391186497.b4-ty@google.com>
Subject: Re: [PATCH v3] KVM: selftests: Add new CFLAGS to generate dependency files
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, pbonzini@redhat.com,
        shuah@kernel.org, kvm@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2023 16:03:38 +0800, Yu Zhang wrote:
> Add "-MD" in CFLAGS to generate dependency files. Currently, each
> time a header file is updated in KVM selftest, we will have to run
> "make clean && make" to rebuild the whole test suite. By adding new
> compiling flags and dependent rules in Makefile, we do not need to
> make clean && make each time a header file is updated.
> 
> 
> [...]

Applied to kvm-x86 selftests, thanks!  Hopefully second time is a charm ;-)

[1/1] KVM: selftests: Add new CFLAGS to generate dependency files
      https://github.com/kvm-x86/linux/commit/5ed19528db8d

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
