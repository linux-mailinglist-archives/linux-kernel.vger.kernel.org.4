Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4194E65CB91
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 02:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238887AbjADBhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 20:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239015AbjADBh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 20:37:28 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B4E178BB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:37:26 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id t15so35052697ybq.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 17:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o+6CzOy0CAP0ecsYxKWZ90I9ape91rJYpbkSwqevcg8=;
        b=N6YHgWrsP9L3QB2IT95p8DJprk2mLCA7HuiNeqDr97A9qDEymEKWo73KguQM93wTCX
         2aOuVlAO4ZIUXQWHyGZ5p5WvA3im/McxYtWRPbSSZKO5oYbc0YwP8ct3wTHzpHsnO7lc
         TXskQkYzp++vcFX+bGEwOz4jpBN6Yjn7r5IgvqxGBzCPFdP9k41pzncXQaAFgUyGKOW+
         uuDlMkI64pFkP7PjcoLnLgooVTUg/NI3X+JZH67mwu88hbgYntocLMgH2RKyN9B9F4KM
         9MuMjJE/xCDGEx8rmNL2iOazXVc3c9rR+Jo+jkODdVsExDRUUSTU6zRlJCFv4kI0o8w6
         X/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o+6CzOy0CAP0ecsYxKWZ90I9ape91rJYpbkSwqevcg8=;
        b=g61ujby4zYIRO1ZUTMuAOjjx6JfnBcjb/osKM3aw7ZbSzcaWWADfnO+mT52cSXljLy
         yP/YaWHwHl3zKACkMFSeaUInBstu+WHaNv+ZvppYSnuGU3wzsXPi9jM3EYmlzOzkk5VX
         ml/+A0MVANYwK7q7dGL7HRQXg4Hvy0QYv4Q3iS8mGl4GcszMf6ZwvwgLsta/qV/tQLDq
         yicBymy1w3ZkXdaLXqjUUPSi1Me8ZgXylDPh2VTHwgT02YvE+abiJziOFTSgb+/x/41K
         oUxPhO0eRBCyEVG7g8bKQfNyQLNZ+9by4OfywH7LMxFnxdUkYWupYpV3n/nYzNUETZHl
         rmUw==
X-Gm-Message-State: AFqh2kryc1d3Vyx6Ey++ojqGJeqd/UuInps4q2imKrHgakym7VGzdPeZ
        k0n287NdZi/cUmpGubkwfq2Q94RHUnOhokTvQFwvpdyhPT4ZnQ==
X-Google-Smtp-Source: AMrXdXv3VLQSwRtgRUrr1lfCnGaSVr+RhK0rBcgaiEy8h0FqNpr8BCTTGDyCU8D3j/XK5+BHD2k5/vUuaJCsESsZyUU=
X-Received: by 2002:a25:6d02:0:b0:6f9:d605:92d1 with SMTP id
 i2-20020a256d02000000b006f9d60592d1mr4726402ybc.341.1672796245815; Tue, 03
 Jan 2023 17:37:25 -0800 (PST)
MIME-Version: 1.0
References: <20221229100746.35047-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20221229100746.35047-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 Jan 2023 02:37:14 +0100
Message-ID: <CACRpkdZGx+Sdsx_=cuQMsLJZMWixVf7QFPzEfkTrJLEUOfg1zQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] pinctrl: nomadik: Add missing header(s)
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 11:07 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Do not imply that some of the generic headers may be always included.
> Instead, include explicitly what we are direct user of.
>
> While at it, sort headers alphabetically.
>
> Fixes: e5530adc17a7 ("pinctrl: Clean up headers")
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>
> v2: removed double inclusion (Randy)

Patch applied for fixes!

Yours,
Linus Walleij
