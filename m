Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF36718447
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237496AbjEaOJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237434AbjEaOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:08:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF931359B
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:04:46 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-babb78a3daaso6861575276.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 07:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685541828; x=1688133828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zgZNa9EtHrAIwO3wPspMKG7VOPoKw+bLM8tIqIzljU4=;
        b=73dq1vBSAi729Lilf8hsEKhqFYXzhRCBI6uMLZyuvErH5WN8nLHGymQsclfH1xkkds
         +6qlOW1V0G/D72xBKfuy805DJKiqGU7jlVl9I4OHIcm2kJXPH0nINc3ZYotFu4YITGC8
         2xTH5sY9WC25b/N2LfFTeCJAZSMhYGlOgQI1yfrwpRfCnNIqb+JBCt1Mx2N4U8vorlD0
         FDY1w0Neh0xfk1ErY/wQC70kl5CmojKosloDEqjNLa6zSAPbiY5V63vnIPxsoCHGBSIt
         rP66wSjY08cx2dXI60q6pBlD0u1cD4rKvT2s0DnC/vcelPtgnbW6H/dzVyqzMEPCrI1k
         Qfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685541828; x=1688133828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zgZNa9EtHrAIwO3wPspMKG7VOPoKw+bLM8tIqIzljU4=;
        b=fEGqfxcZF5XK4Rjn5Xuy4zXXP0e6O5Y3v1hY0VjjAjvP88cb/cnomfqgaVmQFguWws
         Uw2two4FCtiqbUiCSvcWLI0IrPtEUcEBYJnTH+7mbTn1RJoB6t/lwBQH5FEBQ0sQ6Qv0
         f5OerKTyZonurnO/igzIKleLd/I1V4qDa3eUzZNyDQIg51KI/q3roc9wvWuVd3DEl64A
         lwxoTA1pnQjnUKockoDYXZIG8HphMwarIImXQT4lgBVW/cPvAshI4Fn28pyiWmuzbZpF
         52tnXv9dcY4RtNGH5+pEGt3s8gYyoFL1iDAYLICio3XZ43UfefVMcq1TupcbuszgoQNA
         tYtA==
X-Gm-Message-State: AC+VfDzTnDgnbQzYSMn0nDFaKCqoQE1i6o8djCKJDP+VtsZYAIsYVyAr
        Twc3cF6/0oXqaVbvbxF03tIpCL5ucE95Dxs=
X-Google-Smtp-Source: ACHHUZ6DEtgX4K6pdimvH3NmwoYvDCaDL753Abz2f/W5Qjy+z7CORXWoLXb2LvEYZj0nfLJnZLh7+T0qXaxZI94=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:3444:0:b0:ba8:37f6:a586 with SMTP id
 b65-20020a253444000000b00ba837f6a586mr3364248yba.3.1685541828239; Wed, 31 May
 2023 07:03:48 -0700 (PDT)
Date:   Wed, 31 May 2023 14:03:46 +0000
In-Reply-To: <xAv635eVJdklAFBXcwxhVWRvgkMs37YDjANEArFkcOdoyH27NSHwbBGgJ6b9Q1EvX8gACiNqkaDYNvwdMWy6YHbeGM4qz1xW54-02UjzzZA=@proton.me>
Mime-Version: 1.0
References: <xAv635eVJdklAFBXcwxhVWRvgkMs37YDjANEArFkcOdoyH27NSHwbBGgJ6b9Q1EvX8gACiNqkaDYNvwdMWy6YHbeGM4qz1xW54-02UjzzZA=@proton.me>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230531140346.3707802-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 7/7] rust: workqueue: add `try_spawn` helper method
From:   Alice Ryhl <aliceryhl@google.com>
To:     benno.lossin@proton.me
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        ojeda@kernel.org, patches@lists.linux.dev,
        rust-for-linux@vger.kernel.org, tj@kernel.org, wedsonaf@gmail.com
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

Benno Lossin <benno.lossin@proton.me> writes:
>> +    /// Tries to spawn the given function or closure as a work item.
>> +    ///
>> +    /// This method can fail because it allocates memory to store the work item.
>> +    pub fn try_spawn<T: 'static + Send + Fn()>(&self, func: T) -> Result {
> 
> Why is this `Fn()` instead of `FnOnce()`?

That's a mistake. Good catch. It will be fixed in the next version.

Alice
