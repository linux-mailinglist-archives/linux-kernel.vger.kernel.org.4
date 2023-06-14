Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E733B730932
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 22:33:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjFNUc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 16:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjFNUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 16:32:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AD7212D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:32:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bd69bb4507eso1246186276.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 13:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686774744; x=1689366744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=rqUNnuSZmxyZA+3FLRLmQGXXAuPP+K6OhcSMkEMWjmz/+X0E9WWAWceF6qaPJbCEf/
         +LcOMoxwadWXOKYaeGEP5rRGpXeZIo2Ksngu9HPwa+EZT5o3QpyOEXoCV4P6jyxRyf4z
         yWVmZv74htbg2qR4hiKLnGjDsjcl3vWgVEkG1DzdRTsfbNLSgOcTuO26AXNwqwdXtcOA
         UeAJLb8lLD0tGurvvkXdA0mc9wvIPjhd6tj4jtVcOfnRz2vdzx++nU84LteJJPgzAW96
         UR/fgVmwczusNfVrjQz9DGIvzbZpSABZQs7RTDWi/j6hWmRIFZ6+FWkU5QfTKYLLs45R
         1Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686774744; x=1689366744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=czEjt+NjAyuH0cAt6yqFee89woVRFsyvQrYC+0eGV9Y=;
        b=a0dMvMd53JwQ+w6rOplty01QJ1POkw6bCmwTFsr/r4TxeT8locpraBU2sNqacHQE9+
         LsQDlx/Ff/+3YADhlxkrYr/0b91hlo/9R6FD3UhFbj4JpsQFWMGdnegEMNkX7KOpvWHS
         D3p1ZLPpog8NlHayp/mDv0GesRT9FkkCpPRQYeSI0JOnzsS8EqFXjIpdKqoohTWgheKL
         JJU64LubUbqC4YkFOPkg230LbRIovEKi4xtj0225dJ/YPxZ2XLbVswX/MO8V5hdrIjy/
         9ArcBHS76S1ffTpZ72Lo6R/rF0+vGeew8aBTo/8SnoW8jYsY58NsTh4/6Oas3EAgCcJU
         Du9A==
X-Gm-Message-State: AC+VfDzEYWi58BQ31hKG67ibscasZHfdLy/2vgjZxSy/PUYL9CKF4xHI
        5kO2mM9ttH0RCmfGaPf6Vlbe/BryTGBOA1I=
X-Google-Smtp-Source: ACHHUZ4lKrCgpFpHSKe1jrlgkrwHsdQtUzGMLfno8/6282W4EFvNEysptvz1ncztZ8ndlqxGsU2He2vAPn/OwjA=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:5087:0:b0:bc5:9faa:24d4 with SMTP id
 e129-20020a255087000000b00bc59faa24d4mr482042ybb.11.1686774744749; Wed, 14
 Jun 2023 13:32:24 -0700 (PDT)
Date:   Wed, 14 Jun 2023 20:32:22 +0000
In-Reply-To: <20230614180837.630180-4-ojeda@kernel.org>
Mime-Version: 1.0
References: <20230614180837.630180-4-ojeda@kernel.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230614203222.2909418-1-aliceryhl@google.com>
Subject: Re: [PATCH 3/6] rust: sync: make doctests compilable/testable
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
        autolearn=ham autolearn_force=no version=3.4.6
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

