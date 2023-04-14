Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372A6E28F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjDNRHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDNRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:07:05 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D08210B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:07:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f9df9ebc5so88015457b3.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 10:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681492021; x=1684084021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wDseySW9a2X7Qw1Sb9G9CgyISJMWN8rI1x6WKWTmJyo=;
        b=ElymJGTZORqnkdX+LifBKgFphfCEVEy1d024fr+67V4qBmQ2e3LHA1P4/5AFoTDrAK
         n7IeTEglCOD5+s9Yyf7odF0sgQBJAOceEBCkvOHysK1Dl26uWwXNooa3Ve2maOAA+EXa
         RuG5yhvYFWVUEF2SNkkNkyGCSoP5fSF3F5I/76n4M6162VODJGGMZh3WfS0G6zfGm7Y9
         MsflPZu+G+dRHRXNjxtOZ0Nk5BXHPlKlQuEeFvKDpRjhsJAVq8hLlE0vYdYy+AOavLsM
         4VdepFJFp2OlkznQwbrZjvSXw35seTJPYZzNYNMwxIHzTUisJ4Fh7Yf6H2VC4/aVs3kX
         33Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681492021; x=1684084021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wDseySW9a2X7Qw1Sb9G9CgyISJMWN8rI1x6WKWTmJyo=;
        b=edVgV1qvWXy1xdGlmIJCUQq3PnR/gUjtPPlihJ+90fmQOkPv6EEWpwnu7BTwgILRAu
         a7EajM8dIZ9HPDiXhOK8V2YenbcWO4WAf+P7s4go5I+6XOjk6ZJ7xHMRg4XdaCMl8MHh
         fCBN9LmknJ0MwWwxYCDDqyKuLxt4HsDFBPHOhJiPc7jlgtIEVb9b8BPkOWlcNxuxWbTA
         ACjLeovCyxcqCYHtqEV/BUQh/g9xhExqGKjCbiNHjSiGs8BPNmbMPX2P0YF1GRaCoXAC
         WjkpVL3OBoFiLB5FVmocVDyoMAScdPHbC3m4mQ0UjZNx2l29Vvv9zcCvFo9t2TWEUpit
         toMQ==
X-Gm-Message-State: AAQBX9cGBuN/ow28ka/mYipePK5Mun3aKTQB3UL2Y5adp5+vIIArOrHo
        gh9ntbaqimCED6vZK8Lg+gsn2YbvBeM=
X-Google-Smtp-Source: AKy350Yat8GT3+tQtPKHn5QSYC3aQP0t7/vwRLFqPeHO7FhubHdEiGDN4FLO5CLDgp8jDvHiAI4diwo8Szo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:d28a:0:b0:b8f:359f:2a20 with SMTP id
 j132-20020a25d28a000000b00b8f359f2a20mr3369573ybg.10.1681492021711; Fri, 14
 Apr 2023 10:07:01 -0700 (PDT)
Date:   Fri, 14 Apr 2023 10:05:28 -0700
In-Reply-To: <20230414080809.1678603-1-colin.i.king@gmail.com>
Mime-Version: 1.0
References: <20230414080809.1678603-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <168149189684.1511520.17004133772489176964.b4-ty@google.com>
Subject: Re: [PATCH][next] KVM: selftests: Fix spelling mistake "perrmited" -> "permitted"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, 14 Apr 2023 09:08:09 +0100, Colin Ian King wrote:
> There is a spelling mistake in a test report message. Fix it.

Once again, your spell checker laughs dirisively at my futile attempts.

Applied to kvm-x86 selftests, thanks!

[1/1] KVM: selftests: Fix spelling mistake "perrmited" -> "permitted"
      https://github.com/kvm-x86/linux/commit/20aef201dafb

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
