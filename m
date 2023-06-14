Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A548873092E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjFNUcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFNUcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:32:21 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF7D2132
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:32:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1246111276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774739; x=1689366739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=7qQ2pRRFtJkkGsek6sI8eGIYh2kDVCgIhOHYHltdTmoejySFVhUOI2O+RzdgHUO8St
         DXjUfgph8ErCl0t8k2ZLDkvsaImXoSGboFkpiSNGgCRT6iPw62D0vVVVniU5U9wAzR9H
         zyOpluP2dekBZc94GvHRFyYnDGrmFyTP7mG300SoiX/TsgiH0M59+v3YCw5Na20/LrGs
         YB+9OWXe++0WDbleOpm82V21RhXRmbZYBapRl/mBeNCnlLmEuLlgtZXMp1LVw4jVcVUU
         TqjluAZsA6qWCAlDlayrX3ufyhk1147CBOckGTXvLTg2DrpKExSDZAoeK2t/uOufYl42
         gxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774739; x=1689366739;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=F9dR34Z0KzUxBw5poIQts4lTkdC4POceIxfWfiwPmY5u0u8TlVRjNr+YUrsWFMYcu/
         g3fcaCd+HgjEmCBNRW4gKfc9oU0dq+3B3RJ1A0KYDy6E6t9rszsIK8E2tBbhXXlYTn5B
         vVAtEjrmWR1jOox1x45E7lGrlPkpaTsRWC69pKWqOSDFHBF0icK60iyPj0iAkU264bcP
         LjWNyvE6jd/4LWWzkqTHYof+I1u0LnHedgBWKFpQdqqULAJWK6552ZpTQlvu1vwWdSrE
         MYc+5gC3ydAm9oubEA7B8XZQRWnS+cL6vuqBtKbBxBWM2qcz067EILE/Vo/f2KcZ23Un
         EnIQ==
X-Gm-Message-State: AC+VfDxDU7ln0gqs4VmywwSrfSDbzUti79sSjOYMxth7b+jGVXl1P8kG
        aK0lFV8o25MrP/3RFgtLikb985ZIluYM2GY=
X-Google-Smtp-Source: ACHHUZ7N8NjzbORsY8P9yrlGMhvoX5EEo5wu8Kwz9gBGRafQS4YZfEO18H1Pw0V9rig7JIuYUAUF5fTWR+r6qYs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:d54:0:b0:ba8:2e79:c193 with SMTP id
 81-20020a250d54000000b00ba82e79c193mr472122ybn.12.1686774739295; Wed, 14 Jun
 2023 13:32:19 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:32:16 +0000
In-Reply-To: <20230614180837.630180-2-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-2-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203216.2908753-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/6] rust: init: make doctests compilable/testable
From:   Alice Ryhl <aliceryhl@google.com>
To:     ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, brendan.higgins@linux.dev,
        davidgow@google.com, gary@garyguo.net, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        nmi@metaspace.dk, patches@lists.linux.dev, philip.li@intel.com,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel Ojeda <ojeda@kernel.org> writes:
> Rust documentation tests are going to be build/run-tested
> with the KUnit integration added in a future patch, thus
> update them to make them compilable/testable so that we
> may start enforcing it.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

