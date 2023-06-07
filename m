Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818BD7263E4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241223AbjFGPP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbjFGPPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:15:25 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860A319BA
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:15:22 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8c3186735so10857454276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686150921; x=1688742921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=06HbTUXXP7qSeCUQ65JCVHpgC5ctYDDwQ2ntWKZsrTg=;
        b=kJJuPstV/fd36hGGYqYYMfU6SQ6eMQvBPGcCDCMF+3B6XODR3LYU3yrIc7I+D/zsft
         6zsexaV1k8KZe/Dt90YYquozfp1J7tHh3/wNhp+qeyEDPl0mmZpblATGSxPZhOlApQ0J
         nWw+IiChAXdQZlbw05aYZfAf6p+CnxvcX4Rg0PcgCvj/JAKd03rBxFYqFII+6HhbMWUt
         MJQoZjGU5egLSdtfqOZo+gccpnGFlP1/zD4CHa/tfvvLV0hDeaTL4LDVHQqwwF73RlbW
         HwlA/fmcm34oLZjuYUMNBy5GYgzk2i92X9R2abUaebW1TU9zHIQUm01kaKNz/rrBFgAf
         icdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686150921; x=1688742921;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06HbTUXXP7qSeCUQ65JCVHpgC5ctYDDwQ2ntWKZsrTg=;
        b=OyxUdEeCGqzVYnU9gQUwP7N3h2XbuiNPoZlKOpCMfnWYIfkeHQ8lwz8W4JFSbbGze8
         hGYs8844GxkR6zoTLMYxZvyELebCknCtjMZ2CO4eQ9Tde0smPAU0hH00LYpEwJVgRkTM
         EuciQ53s8ywQnvk1D9G3rV7IiIKVybU1Ynj4kNjFS/Q7cZDjvOkxKEm2DPT3XA40Yrov
         hC9svmPEVdCXvxzDm98EOUbeMxnHgb0XuCr1Gxh9b/LBKuJW8o0qyx/awY0HLxvV6Dfj
         JHuwLD7ptyJALwWdRGhUKzUm7HjbU7d6w4roBZ4L7QwZ4Wxq4CAM46mqhHOOH0iRKOxn
         ilsg==
X-Gm-Message-State: AC+VfDzYSovvQ/5LUbZPW+N5ohqSLYL3zpESdT0xvas3sWhmBljXQ+kc
        b8AAU7I46hLZldVjGnt4ArS5WoWrsnmHkWo=
X-Google-Smtp-Source: ACHHUZ5hfgcmjYBr+gjEpgOSocio7Fae1zcX14/mchK1aXcyQDsxI556aUghMJFfiHNwTqEZrwd4bVwBBywPoxs=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:722:b0:ba8:8ec4:db50 with SMTP
 id l2-20020a056902072200b00ba88ec4db50mr2207946ybt.1.1686150921659; Wed, 07
 Jun 2023 08:15:21 -0700 (PDT)
Date:   Wed,  7 Jun 2023 15:15:18 +0000
In-Reply-To: <875y862lr7.fsf@metaspace.dk>
Mime-Version: 1.0
References: <875y862lr7.fsf@metaspace.dk>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230607151518.1191562-1-aliceryhl@google.com>
Subject: Re: [PATCH v2 2/8] rust: add offset_of! macro
From:   Alice Ryhl <aliceryhl@google.com>
To:     nmi@metaspace.dk
Cc:     alex.gaynor@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net, jiangshanlai@gmail.com,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        patches@lists.linux.dev, rust-for-linux@vger.kernel.org,
        tj@kernel.org, walmeida@microsoft.com, wedsonaf@gmail.com,
        yakoyoku@gmail.com
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

Andreas Hindborg (Samsung) <nmi@metaspace.dk> writes:
> Alice Ryhl <aliceryhl@google.com> writes:
>> +#[macro_export]
>> +macro_rules! offset_of {
>> +    ($type:path, $field:ident) => {{
> 
> Could we add a descriptive comment?
> 
>            // Prevent deref coersion to `$field` by requiring `$type`
>            // has a field named `$field`
> 
> BR Andreas

Sure. It will be in the next version of the patchset.

Alice
