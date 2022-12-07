Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9182646137
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 19:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiLGSiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 13:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiLGSiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 13:38:22 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB32B3FB80
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 10:38:20 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i186so11681207ybc.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 10:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MI36gkcoa82WBWphf8dOS4w63VIaZLD9SoczTV9gm0Y=;
        b=MQs9nIcZX7LliaVqVsB7hR+EGr+h9ItCJamtzr2XczDwpWhs5fq0IqJvLAViSltG4S
         midAHUAWL1vb9BnwH8AhSAx4PP5pPxHZn1HHzjz5gDGFfwlKi586N1zH2yEHeD/mDlaH
         zc7gbVe+fQOTsv1ZooCep9efHSU8npkqKQ2B3zciWUogCnsw4NJV+wlDCcPGnADW1DIg
         PNB5A25nl6OBWojC7leqrhZBYI1q57wZctGcuSBgCdSfTExF5khXzlwzh0J7ojxZIiaW
         +PYUKqHZl/1jx6ft9jqimZNv4DOSCniM8ZIdMJ+4hfTz68tj0InGyCFqkxDQuww2XTP+
         +Hvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MI36gkcoa82WBWphf8dOS4w63VIaZLD9SoczTV9gm0Y=;
        b=En8CXHECvK5GdTqiEPhzekBn9wMdfYIBvss+ZYFSa2875bCrh6AH4clUp5pWpT/umP
         1y9g8DWjz8RJ1RIkBeCVNvT6KsmOueCercDjtm0wgBcgBQ8hSv2NfRczXaZq0CREY+2J
         qqAKNNv050SG8KGDQxOeFdC39mInJS1P0BM+xT45BioLYBJUrnY2eXQZ0IIuUuuRHe8Q
         QTtqybmU1JlxT4XJbrwby9ZN9sUa9ZPci/5aumRr8cJPtMElbsQMeVyeVkULZhVFl8Xi
         QJs6SKtI26EDnW+bTCka0JEyd8F3zNoZQkdKbdLB8ziEaRiFZvP8Bgy8J9Y3TAWsEobA
         L/xA==
X-Gm-Message-State: ANoB5pnfuv+m3yYYTHvaQHjtkmwzSEnbuTCkQhWFbGzTFvRJW54At7rg
        hb9WUVFNEXO7t0KDa7Cxs7mL+5MHRV82oybHqhAVOA==
X-Google-Smtp-Source: AA0mqf7CufYp/DXokYoy/IZMuamDXkcwHmhMQI61ICmuAgU69niU8NGZ47lKiGmKZAF3akr6Ol+PnmpzwdI71l6m/C0=
X-Received: by 2002:a25:14c5:0:b0:703:46ef:3b03 with SMTP id
 188-20020a2514c5000000b0070346ef3b03mr8273795ybu.644.1670438299979; Wed, 07
 Dec 2022 10:38:19 -0800 (PST)
MIME-Version: 1.0
References: <20221130185419.2552673-1-dlatypov@google.com> <CABVgOSm_J878tGhWzvGa_y4fYZEUDrSaZN49=kKnn0W7ESe2wA@mail.gmail.com>
In-Reply-To: <CABVgOSm_J878tGhWzvGa_y4fYZEUDrSaZN49=kKnn0W7ESe2wA@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 7 Dec 2022 10:38:08 -0800
Message-ID: <CAGS_qxr0AWCAT-wAw=fFkzryCc+MDZchi1kuRoRTSahzDQW_Ug@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: make parser preserve whitespace when
 printing test log
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, rmoar@google.com,
        linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 6, 2022 at 7:43 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Dec 1, 2022 at 2:54 AM 'Daniel Latypov' via KUnit Development

<snip>

> > After this change, here's what the output in context would look like
> > [13:40:46] =================== example (4 subtests) ===================
> > [13:40:46] # example_simple_test: initializing
> > [13:40:46] # example_simple_test: EXPECTATION FAILED at lib/kunit/kunit-example-test.c:29
> > [13:40:46] Expected 2 + 1 == 2, but
> > [13:40:46]     2 + 1 == 3 (0x3)
> > [13:40:46] [FAILED] example_simple_test
> > [13:40:46] [SKIPPED] example_skip_test
> > [13:40:46] [SKIPPED] example_mark_skipped_test
> > [13:40:46] [PASSED] example_all_expect_macros_test
> > [13:40:46]     # example: initializing suite
> > [13:40:46] # example: pass:1 fail:1 skip:2 total:4
> > [13:40:46] # Totals: pass:1 fail:1 skip:2 total:4
> > [13:40:46] ===================== [FAILED] example =====================
> >
> > This example shows one minor cosmetic defect this approach has.
> > The test counts lines prevent us from dedenting the suite-level output.
> > But at the same time, any form of non-KUnit output would do the same
> > unless it happened to be indented as well.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> I agree that this is a good idea.
>
> Personally, I think we could avoid some of the 'dedent' issues by
> disabling the test statistics lines when run via kunit.py (if
> raw_output is not enabled). That's probably better as a separate
> patch, though, so this looks good to go.

I was of a similar mindset initially, which is why I held off on
sending this patch out.
But as noted at the end of the commit desc, literally ~any kernel
output will cause this to happen.
And the whole point of this patch is to show such output, newly unmangled ;)

Secondly, only the kunit_{info,warn,err} logs are indented like this.
I think most test output would be coming from code outside the test
file, i.e. normal pr_info() calls.

But I figured I should still call it out somewhere in this email
though, since it does look a bit strange.
Maybe it didn't need to be as prominently as the commit desc.

Also, I was leaning towards just hiding it via some filtering in
kunit_parser.py, but Rae's reply [1] made me more unsure about which
way to go. So I'm thinking of leaving the lines in there for now.
[1] https://lore.kernel.org/linux-kselftest/CA+GJov6QKNy5fxkiu0P29WDtFgNs0GP4T27=X5Sva+V_BYc3+A@mail.gmail.com/

Daniel
