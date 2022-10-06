Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50635F6FED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 23:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232072AbiJFVHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 17:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiJFVHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 17:07:13 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D21C4C1A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 14:07:12 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id r20so1616080ilt.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=0PbsxfciFypoBGS4ctUovIgysMm8UsOS2BI0DhFX6xc=;
        b=BURM6NKuHyGNwu73ErzY1IO5UhtEJ6qv2bms7GkMQuuPgH37yN36JHOZqoTkdFEHav
         k5zlInrR7SE9RmS/PGnYy4KhnY4FGkt2OY6NN5iW/Hnj8bzR1WDZg/0r3QDxG3J2xdya
         A28KiVaODjXBuZDv6WkbcH8IzcQhnOmG7if/RVocKv9Iq+NMdX8AKNoGeq1b5Yc2cfZD
         2y38oyNKBP7nKc9/+ayzZwt7num14g3g0TMZHSfpdzlYHqRfjpWXB01+bSuVZ4q/Uim/
         Ng68XKx0mtBa1DEJujJubaS2eEXQcVGAiwyWzbTHf81odUXbR7AOMM4ZnQBkhDKxwIML
         8uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0PbsxfciFypoBGS4ctUovIgysMm8UsOS2BI0DhFX6xc=;
        b=yQBEyoJVcGSyqYGH8AAJRTKlrGGuHrjwGfHKF6/CNuo/1unAAX19t9/ymUKIAMBrI7
         eEtvjXQKwDsZDkRy8lVRM3nuiWBk0inLeRfd1i1SJwXvrD3b2TFGs7/erp5HiFlzkPWS
         GvqIJw/nKucP21CUtsoNVIbFVnsxh71rHWp8H1974BYqcP7mjvgBOLB06fqGrbUS+hbR
         OzvJVvPRa41RMhNB477ruuzKWkzwcStiPOiWUbNjNtz3EmEnUtu0SgIt/o1QUMFTq++4
         Q0da5VU5xJRSj5yO2+axH1hMNHxA6MdNH2F7YHq63LystaTE88E2+SNIBhw6kMG57sS0
         eE/Q==
X-Gm-Message-State: ACrzQf1fex8NXdydKuljiREmnd0ZiSuSb03OwInxisAg4AOHXobPgUQh
        qpmQoQHYowgz9x4rCz+Arvs0mCkuoDtwKHvxs/0=
X-Google-Smtp-Source: AMsMyM7AKoJhjD6SKr1OOuS6wPVr4uSZMgpfamawJHHr9pIF+gmYz5fCMp8bboN8Ab+KKfU96WfDju0jSpSTd8YE8qo=
X-Received: by 2002:a05:6e02:b2d:b0:2f9:e735:a010 with SMTP id
 e13-20020a056e020b2d00b002f9e735a010mr740919ilu.151.1665090431878; Thu, 06
 Oct 2022 14:07:11 -0700 (PDT)
MIME-Version: 1.0
References: <20221006092042.1753-1-wangdeming@inspur.com>
In-Reply-To: <20221006092042.1753-1-wangdeming@inspur.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Oct 2022 23:07:00 +0200
Message-ID: <CANiq72mE60f3iZvzsDaG758Va=2V357ogfCfYpyFEb-foYzjJg@mail.gmail.com>
Subject: Re: [PATCH] kallsyms: add required space for unified style
To:     Deming Wang <wangdeming@inspur.com>
Cc:     keescook@chromium.org, boqun.feng@gmail.com,
        gregkh@linuxfoundation.org, ojeda@kernel.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 6, 2022 at 11:22 AM Deming Wang <wangdeming@inspur.com> wrote:
>
> add required space before and after operators.

There are some other instances, like `i+1`, `*result=0;`, `total=0`...
that could be fixed too.

One way to find them is `clang-format -i` + `git add --patch` :)

That will also show you other different formatting issues, like a
couple `if (...) ...;` in a single line, `if(` without space, etc.

Cheers,
Miguel
