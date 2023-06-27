Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B286B7406BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjF0XHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjF0XG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 19:06:59 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FE72941
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:06:58 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2630eecfa6dso953866a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687907217; x=1690499217;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gL62EeYqdZ3PPyujO7ySVUUWGUsaK4x/yrcgDor1fzE=;
        b=fKYm2sX9P4fmxXTP33Md8PfThqEVR6SSfWQ9bmBYHUHZG3jhYeG/jjgOLEnXYzxCHE
         sbchK5/QuJhz3B7rbFAzZPIwE6S0I9idn+wnpefiqki8wGFb+wzUmAKGji+OLo3EbnBL
         2Ymm/eOXqEalFkmXbTY+ZtiyXCknwitFSSmpfZf66g7M2BPbr1RQfxaBbhlXIMhYbXBZ
         DdblIbYvJ7dwC5LDgjVDHTJqYtw/jyv0lBGErMZaun6ZiWzgM+e7bmXs5G0oId1TxEEQ
         zXGgNrWGBZiKPZ4v36VwVcYOXNK3qrsVygftWyhHM0uDe6893F236NH59fBkat35anem
         NVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687907217; x=1690499217;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gL62EeYqdZ3PPyujO7ySVUUWGUsaK4x/yrcgDor1fzE=;
        b=EHxAYqm4usdI9YRsV+o6wUqKUVXX0YFQE7Wb3DP/nfTgcf+TvS0S7CXtkNNOL2//mo
         0ZEdDZOAxYG/alQIcrvLTs07nyrecVd/umv/7+zBc+aDx8l/+sBKLdMQkFoBdHqpc1Qz
         /RKTqRUGCzJ4g12Qr2oWFhR9a3JFU7RvvZu5QnbmZBNP7d9QltOOc+cZaeuHp808I/AW
         lWt31jj4ZyIo0qmh8jYWfWmiE6O62/RuyABfUd0gkyw2ojbWhhm321PeuNXsNYSvsFx3
         ER4w3V6XKoA47vEe4Lnt+pg851sU+lzDKz0/ryOSJem9YwMIwfmgik5BPntYKEL9UsZP
         Ralw==
X-Gm-Message-State: AC+VfDx8wX5JdHbHx17PqhwpeE4gYZdf75q/HOs61sQ40d2JLTbEXJab
        lFK8/9okt8YnlUJ08zFv5itaqmcG12Y=
X-Google-Smtp-Source: ACHHUZ666Fn22KRYLGf7nDT1NpIRjQNKOeRfl8ZbwKBChIE/imADWetbcLmqcEvBBkb/Gqs7ZqR06jmRGBg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:9418:b0:262:e955:3d87 with SMTP id
 r24-20020a17090a941800b00262e9553d87mr1221003pjo.9.1687907217644; Tue, 27 Jun
 2023 16:06:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 27 Jun 2023 16:06:54 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627230654.2934968-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Agenda - 2023.06.28 - CANCELED
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No topic this week, and I need to reclaim some time this week as I will be OOO
all of next week.

For future topics, a few things on my radar that I am hoping to discuss in the
not-too-distant future, but that need additional work before they're worth
discussing:

 - Coordinating guest_mem() development.  I need to post patches, plan is to do
   that the week after I get back.

 - Overhauling KVM's gfn_to_pfn() APIs.  Need a status update from David S., e.g.
   I don't even know if this being actively worked.

   https://lore.kernel.org/all/ZGvUsf7lMkrNDHuE@google.com

 - KVM + UFFD scalability.  We're not yet at the point where we need a synchronous
   discussion, but I suspect we'll want a live discussion before merging.

   https://lore.kernel.org/all/20230602161921.208564-1-amoorthy@google.com

 - Hiding KVM internals from the kernel at large, e.g. moving kvm_host.h into
   arch/<arch>/kvm and virt/kvm/, and exporting "internal" KVM symbols if and
   only if there are vendor modules.  Needs an RFC from us (Google GCE people).

Future Schedule:
June 28th - Canceled
July 5th  - Canceled (Sean OOO)
July 12th - Available!
July 19th - Available!
