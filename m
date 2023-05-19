Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0117093E5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 11:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjESJni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 05:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbjESJnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 05:43:14 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60A63C06
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:41:21 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-96ad0625249so337552666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 02:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684489244; x=1687081244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qWpQ3Z9uo5d0lko+yuj7LVhbX1lJ1BOQYyhbdzAiJWo=;
        b=dyt7NwVO2a1gKgywYFDD8VjInLnFEg9pkbesUJ5JP62K+efVqGabn2ejkuN+LA0w+3
         7skaMDSCg4NECg+cB+RSOxApwoffaQAtr+X/Aadf95/LadOlW2OybzUpZM2hLDUDP/Rj
         j23AANItbXkHlUHz5AemgqeZt/ql4Uws1OqRWWb50SWAR3QIBqOYgpm4ZZYPVRzLg+Dm
         p4BMj2purjRFRRLB1LFM8so/mUBz31z3Fimh19+TyWPUPdzALTMS5bsDjUIRFj7AVmBT
         sjluU/ZYj/ZOLN7F6l2bDDVzSOj5BVThpWdNmyUAKBVHGZn2ygORwCveYpBHY39Y/io9
         Xfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684489244; x=1687081244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWpQ3Z9uo5d0lko+yuj7LVhbX1lJ1BOQYyhbdzAiJWo=;
        b=hI4X/XGoqYqSTKYb1qgQ3+FCoMA2x6rN5tju5jSUNxCaY4vbYy9g372tjErNQ16Qk+
         ljtNFEIet9Hq+EjeqdcowARpCmpN/ybp1ES86ptnPLtvnGgZN7Za2xe2BSPSeu4/0P+0
         On1x65NtIvTHYelFHKTPhQH2SmuV+oxSYOpxE2BaRsU7HIZ+R9iPb+UVypfBrWRTfeJH
         68hvvHm5M6ZBMdsvHYv88V1AKoV1upfSYPTOC4c1Z1BRvT3gXQSsiKNNnSHeIjqod2vy
         3e3f0f0szVY9QF369uxJSy3ryzr6FmpPXrr1DfyfS1AV3b93ZOedABi8Bqmu3/Ocgl34
         N2tg==
X-Gm-Message-State: AC+VfDy5o5KbrxKd4ddjbTpqfPCzhiXI+debSPSx2reouyqtDGHhrTx4
        TVx+VcR603i0wuCV5FdQOf6pBJ7I9xqsXbQ=
X-Google-Smtp-Source: ACHHUZ5n/GWQx8DIeNB1oencH1Ize+8S1lQNiMrR+ccKmOwSjb/TZ7lXLIx1yetd0ozoxs/LbXo6AOMtrxnl+is=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:907:a067:b0:94a:8224:dbbc with SMTP
 id ia7-20020a170907a06700b0094a8224dbbcmr440656ejc.5.1684489244727; Fri, 19
 May 2023 02:40:44 -0700 (PDT)
Date:   Fri, 19 May 2023 09:40:42 +0000
In-Reply-To: <8e42aad3-d94e-3cb4-ee59-90ded31cea9e@gmail.com>
Mime-Version: 1.0
References: <8e42aad3-d94e-3cb4-ee59-90ded31cea9e@gmail.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Message-ID: <20230519094042.3432952-1-aliceryhl@google.com>
Subject: Re: [PATCH v1 1/7] rust: workqueue: add low-level workqueue bindings
From:   Alice Ryhl <aliceryhl@google.com>
To:     yakoyoku@gmail.com
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/18/23 16:51, Martin Rodriguez Reboredo wrote:
> On 5/17/23 17:31, Alice Ryhl wrote:
>> +    /// Enqueues a work item.
>> +    ///
>> +    /// This may fail if the work item is already enqueued in a workqueue.
>
> Wouldn't be worth to mention that, if not implied, the item it's going
> to be worked on an unbound CPU?

I'm not really sure what you mean. Can you elaborate?

Alice
