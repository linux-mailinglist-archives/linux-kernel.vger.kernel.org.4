Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F0A70F686
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjEXMeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 08:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjEXMeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 08:34:14 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A251AC
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:33:34 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-513f5318ff2so988871a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 05:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684931612; x=1687523612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XZafPqgI9Fb4pogcf8RRb1JCJ1KFVqaaBis24tWL2C0=;
        b=6nLPqQkHIbAbRRsrRMRjIaMSxB8wTAHe51+mF9Ro3EK6sZAGVNp7lyfPZztpFwZTXh
         z8VZPUGKeJukHFmyAzqI20VUE9rUSlxm9G3Yi95DGQZOPXEmEh0BXj5AaG9ZfAfiTVDh
         +3wCp8HgcDP32GpMMLsnNDm51CUz/p2Y0dDom6bYLprj56kHfnOsr1Et+ErbIdGbMejk
         /RVyC0E1D4dgHkbc16XZf6WQqd2INAcwgj+mcu3N/MTQpix6xA5GC+F8JDCyf6aYcMc7
         /nUgh1gRYQieFevxn19EJByi5XLeozkDDxrJYxrncCvqtGMUsihyArzJ4VQ/mgEzuyjF
         2oVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684931612; x=1687523612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XZafPqgI9Fb4pogcf8RRb1JCJ1KFVqaaBis24tWL2C0=;
        b=ZMYOBQjaqTFBfBkMj5k9NBhDa45pX2/Ja5gynQFCKEdj7RRfbzTGEMtap9UBRX/NB6
         kRVs+aGGgqxhup6aE0hfYFThK9t7pO2j5Vmwf3tNB2kHRh/6yMzBzllAOD9P0BC/wPlH
         7PN5jKFiLVgb5G1Qqa5lLefu4+IASL7aMGeqw3Sucq+HLj/3e3hoMDYo/Kd6mWY/c9+b
         O3orJBikt9/n/3zegmPNjRfAApCFZ48xUfs1koB6eyxrJ7IzKo1Qaqth+JdzVaNdR/oi
         FGFhmtwGqI3VFNTURNG2REySga6SSPAUQQfzmrQtqhLbgJnv75V54hzZo951UhthctzG
         5nTg==
X-Gm-Message-State: AC+VfDxovsOd7gq2Cd0DPb0tbvkbvXbab/80HRBKNOpkdTPixPmGCqn3
        Ol9OjhSlWd6yJRIuPDlDrUdbgeNhQIhLiso=
X-Google-Smtp-Source: ACHHUZ6nEk5+MTTdAeuKBA1sa0MKBRxd3bRqOe3lsS32BwxY4I+/jQylsZCoMoxlY0J3DOW/9hm18x4HO2Uf4a8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:9f2d:0:b0:50b:fc7b:de7f with SMTP id
 b42-20020a509f2d000000b0050bfc7bde7fmr922098edf.2.1684931612445; Wed, 24 May
 2023 05:33:32 -0700 (PDT)
Date:   Wed, 24 May 2023 12:33:30 +0000
In-Reply-To: <87ilcjdthc.fsf@metaspace.dk>
Mime-Version: 1.0
References: <87ilcjdthc.fsf@metaspace.dk>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230524123330.2501843-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 0/7] Bindings for the workqueue
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, wedsonaf@gmail.com
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

Andreas Hindborg <nmi@metaspace.dk> writes:
> This does not compile for me. Could you link dependencies to be applied
> first?

I messed up something related to the patch for specifying error type on
`Result` [1]. This patch doesn't _need_ to depend on that though, so the
next version of this patchset should compile without it.

Alice

[1]: https://lore.kernel.org/all/20230502124015.356001-1-aliceryhl@google.com/
