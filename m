Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D457D67D5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbjAZUBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjAZUBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:01:13 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 742C16BBE2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:01:12 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e15so3381973ybn.10
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f32a2/wvvNdzx3AoY5BMI/makxG/nemzmOpCkFsI9Jk=;
        b=vppP75r8d4sqWsClFzUnDhnwmYO8k9mVojnK3AxK2AyG89a4dQ8F0RsHJH2lEmF8qD
         7lwt/edYW8J4mSerQ9wVBV8991vss7QJfhA43RcZQy7R4FnEUPTplcOufl/MLrqKQlbD
         0kFZ7Zz2zuhQsTiBgXyQCVJbJFISyx92Ax74zzzTq6nAHR9QxJXkYT+4dxCyND+usFBS
         vETbQBKHmRzbcxYBDg0YO7H5aWuWlFRZF5PNezqcNwwWco80dAAQeq1o3xFQDAZVtVWB
         zY6Ot5aQGtSNL+FOAgjtGYWGv5pjLdHA+ooG88irBMY5EnbxTt/uhLHxUC9YMKDB3pbY
         37jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f32a2/wvvNdzx3AoY5BMI/makxG/nemzmOpCkFsI9Jk=;
        b=p37sJ9rQeMBw7gaxb7A6dPvUwOblsMh1iWOrogiG1hVDwH7PeVyrlwzNvHFuIURJK9
         mPrAJdbUlTJave6ry68kRypfxqh9OYYt0R2IcQ7Y5gOAL1Oe4iFLr39BmADG1FWmxXCe
         J3Zwmn1l/3NvocOHlCHoXc24eZ+/HeRePLXxK7En3fpYqZHEjFfG9qcrJnGO2ZC21N2u
         FvxDAcASguJStr4oRf2hkFm+rq/mdCmcxjqIMb0OZYDfqltYbWUm+Fg1ZJY9+wwErsXH
         QchK3/nDvPkHQEzhAJsGWEB4Ojoex8kqBW/BqPrf4jY+oHa5xcLWqzsY7GwAWzPQU4Xu
         JmVQ==
X-Gm-Message-State: AFqh2kqOACyslsHpTtxjJOcsoKW8j4C4rzdwR2eBtQ5Xta1GjxVd6AO7
        RDbVbRLwTHBko1LO8CbZ20pq2az8BzETpwz6EDtUOg==
X-Google-Smtp-Source: AMrXdXuCXiRxV9rZvzUC4gGTFCQvFN+Id/etgHogwhYcuzi5cE7+SARlJ7ObnCOYBrOOz54ladFo7vyfp/x3HAG6z8g=
X-Received: by 2002:a25:5303:0:b0:7e4:fa1:b33 with SMTP id h3-20020a255303000000b007e40fa10b33mr3404080ybb.460.1674763271709;
 Thu, 26 Jan 2023 12:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20230120154437.22025-1-andriy.shevchenko@linux.intel.com> <20230120154437.22025-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230120154437.22025-3-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 21:01:00 +0100
Message-ID: <CACRpkda2wDHcEwEa-ime9o3RatAhWsox1Unw-NhsjLm0EHt6OQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/5] usb: fotg210-udc: remove redundant error logging
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 4:44 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> A call to platform_get_irq() already prints an error on failure within
> its own implementation. So printing another error based on its return
> value in the caller is redundant and should be removed. The clean up
> also makes if condition block braces unnecessary. Remove that as well.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
