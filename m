Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC7460D2CD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 19:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbiJYRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 13:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiJYRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 13:53:15 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E9889CF7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:53:14 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id g7so23547197lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 10:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/DWO3XKLTp/RYRFQfFYnsNn2htt+v/ieqDvCyvnXiVM=;
        b=TqH2uoUkCVrhd9uLjpamZt/nVfT65rs02gzJAxp+t13bbBmtERJGOuGl8r8fNNCspv
         vJgVufxhc2tTRx8xJZQp0ua3toPexWB9IpoqOSMWXyXUdNJgFw6CKbxENzfGaFxE/09W
         4EK1bQUoWd/DiRGPyZ5uXcYlb6IlKHU+xHax9OvsmGlyRIaDSe/gs66ynnxFDwUiMKDB
         bH/3SbVo235sim6CVIeZOgGD3uPL54dAxBKch2KLRuYFQm2LUBOGj4Im5L+gM6Vjsy3P
         gRS7ZEGTk4pgt7uKnQz7LV0Z0XmT4+fHDaAEnjw5D/OyouTKA9JBQdf+YGMqUBgVUz2+
         fhmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/DWO3XKLTp/RYRFQfFYnsNn2htt+v/ieqDvCyvnXiVM=;
        b=A3iNcqKW8AA9Gl6a3yXGHEbwJZtZgTpl5POBQExRLcOxo3kv944geXrm1R3JPi8fs9
         tNxbU0sKJCh5eb2Z1XXYZVRPcEIobFPDK2yKUbr0mh/7xuWXy7vyqfEHE93N24z+TUje
         mfBAo635UnJFrVvab/zAJOYV8qgHhvlHkFu4WOanwE/HLg9Xj/ryKRoVHJR30hiYTdba
         nSLycV/Xomvw60qk9RXsgYbXr5kAaB8V2HTajsERuNNI04LMBZlhZYiqxPKDZIfPwitQ
         gB90Ya/yIRw8bRTXbOMtc0fZMN3oXk+fRNUf3n0kUnQmPcRVb42AH+GeZ4mBj7R2XaVX
         Uf6w==
X-Gm-Message-State: ACrzQf3sYfTlxC6dtndo/LdHG0jrkoE9UHYAPnACARqYeX3a0wHB+9YK
        rHDcvh4R9Ez5/8eMAEorbK1EZVQzugphlWRTxCV/xQ==
X-Google-Smtp-Source: AMsMyM4VvdU86oQkaUGC9uoWzsnwbya9LrfRLDNv+7Yhr3KVP+2bVahni0JjeA8Bqw9zA2D/Xq5Ht8t/mqjlM4Ns+Co=
X-Received: by 2002:ac2:5195:0:b0:4a2:bd54:90cf with SMTP id
 u21-20020ac25195000000b004a2bd5490cfmr14836939lfi.486.1666720392960; Tue, 25
 Oct 2022 10:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20221025055844.1231592-1-davidgow@google.com>
In-Reply-To: <20221025055844.1231592-1-davidgow@google.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Tue, 25 Oct 2022 10:53:01 -0700
Message-ID: <CAGS_qxpwfpa-d9FAsVFORDH5eu3_ezu7s6Xen3WdeVnC3_wTBw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: Remove redundant 'tips.rst' page
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 10:58 PM David Gow <davidgow@google.com> wrote:
>
> The contents of 'tips.rst' was included in 'usage.rst' way back in
> commit 953574390634 ("Documentation: KUnit: Rework writing page to focus on writing tests"),
> but the tips page remained behind as well.
>
> Therefore, delete 'tips.rst'
>
> While I regret breaking any links to 'tips' which might exist
> externally, it's confusing to have two subtly different versions of the
> same content around.
>
> Signed-off-by: David Gow <davidgow@google.com>

I liked tips.rst, but I agree we should probably remove it for the
sake of deduping.

The only blocker in my mind is we're missing an equivalent of:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/tips.html#customizing-error-messages

Non-blocker: we have a duplicate section on assertion vs expectations:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#assertions
https://www.kernel.org/doc/html/latest/dev-tools/kunit/usage.html#exiting-early-on-failed-expectations

Daniel
