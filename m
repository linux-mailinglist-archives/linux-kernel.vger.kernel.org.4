Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A976B26A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjCIOV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCIOVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:21:52 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4C61B549
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:21:51 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-536be69eadfso38189537b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 06:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678371711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iafJZnGixciBIJiE6m5EiTSjxv4EI/PwHYeMlRsAhQ4=;
        b=RH3d8+9m0PaOPRNA6QFcjWe9nyYCPQccxdKGXGBTmP5ThOw8Dc7il3J4i2yk0mynO1
         atdNjRYJVb52NBqd4PVr6WyI4TFGTDYeKUgT2ggbPB1sY1IXVYhSrmW8pMXjuI3pSxg6
         tCUOn0YOitSMo7KZIEiFAmic6RjUGitG/9KYbVC7lScrvDdHEcs3s4LRWOnwzSUL7TZM
         AZHz3uIRb2tFJxjzIIohukwNg7viX8Wd1k6wCLHgif2K44C+ZPRfpgBefNRGbglWZ3T1
         FuKQrbWqoG7/IscnFZf5pIifrI0NVOVoII4SuCK1ZaIw4mPIC5fbtOebLmo6giaEO1ef
         9nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678371711;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iafJZnGixciBIJiE6m5EiTSjxv4EI/PwHYeMlRsAhQ4=;
        b=GXOFOMOgw0Fmn6L3hqAfOJHBQ88Z2oToij+7sd9weyIIAZczEtjiQZ7uMIYykZACYp
         HGotiaqNDcunvkl84P1Xbw4y9Ef9TT8Ib40BO7G+aiPM1LIdeXLbHpEokr/t5UFCKvWm
         ZctQ1DUHbwhVh7OtQddnMdXu3HefR+Iqu/IDSol3Deu+jc8g68HkHYOMaSruuMijCFLR
         MY6+YHkedopwz1Surw1prqSllqkuCwoWPWJtb2uJbJ+C+MRN0pXVDa2oreq5uDL7DnIn
         wuzF9qf0EGHFqO+q5QlQ/l8caqPXFezG9D7xU0oHjn1+yb4pWV/ayhhQmbILg4lpwgPH
         gV7A==
X-Gm-Message-State: AO0yUKUfy1ntgKidANan95m7APIZX+UY5kxaHpTu+4LLM2GF6M2kK/pN
        eWZAocHZtofdoDXtcwu278TbaDukAyNGHQ9dXn0peg==
X-Google-Smtp-Source: AK7set+m0LG2zwrv2ra5H/2MqKHhYnb/GA0KhFZkZ+CP90teyFtZBj+ePS1tAkcB4HR58mr3QukEhaoLNM7xjKop6D4=
X-Received: by 2002:a81:ad63:0:b0:52a:9f66:80c6 with SMTP id
 l35-20020a81ad63000000b0052a9f6680c6mr13582945ywk.9.1678371710871; Thu, 09
 Mar 2023 06:21:50 -0800 (PST)
MIME-Version: 1.0
References: <20230308145303.826942-1-arnd@kernel.org> <CACRpkdZAJJr5+f8wiEhnAAV8mLjzYCBMDC9GXwQOAmsQLfShoA@mail.gmail.com>
 <ZAnnv/1ETFTRH8Qi@smile.fi.intel.com>
In-Reply-To: <ZAnnv/1ETFTRH8Qi@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 15:21:39 +0100
Message-ID: <CACRpkdYsZhoT4iCigrj=Q728GAmJ3+vF6dnbzZ9fX5WusM4rAg@mail.gmail.com>
Subject: Re: [PATCH] mips: ar71: include linux/gpio/driver.h
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 3:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> >
> > If this is the only problem merging this set was amazingly painless.
>
> Too early to celebrate. We have one more patch on the same matters.

Yeah I would expect some more noise, I had a similar patch in one
of my kernelorg branches and the zeroday robot would spit some
weird bugs like this at me after a few days of randconfig builds.

Yours,
Linus Walleij
