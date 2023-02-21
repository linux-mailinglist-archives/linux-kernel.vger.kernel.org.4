Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B42C69E8E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjBUUKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 15:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbjBUUKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 15:10:40 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6409F30EB5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:10:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id h14so6487172plf.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677010227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LRlUY6P+Ws5JPolkKmM4if+5xV6FQbDYkfpB+lRI9nA=;
        b=p7bEe3YtIo4ajQL8acKLCVuOyUPkB9m1s1o0xoenMbSiaB337hC/CdK/jbzvDugc0f
         Hf4fM4xnGQAICvqcdnsCmWG1jh1fCnAzvC+G7PNSr9l4eEyhUf6HRrEVj0qye4Z9xojM
         3HByT4JE1omYdOn463zyimPZ7tXfslxrCjpy4aS4iO1exB1AF66AgiwSzKq/yd1BQ7jz
         cgyX1mzTZe65lBFWhIkW5bB0yaZ01Wz7NEC10t3zZyXHX0uRN7BeC/LOcD2C9HgNWyc7
         rreJcF/ZpBmEDH/OC8J0GurpsNB6TBWV69eZWIhvxd8szuQUilaJvRL9jPxKLNWOipXz
         1wiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677010227;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LRlUY6P+Ws5JPolkKmM4if+5xV6FQbDYkfpB+lRI9nA=;
        b=F1K1i7cNy7OHYuSGGERarhz+Btpdl2SuPQ753S7OD7kzErLnKvLKjCzxDdM/ditpUh
         qbrDm41dV50EMjm4iRjgtG50p/ZUsrkWTUECBNB1Lp51g0x+kYWJQDdEXdZAhVDkkvJs
         kjidm6Bnkkk3Nvbnb7CtBJviAdlvJ3pFCXx+AgvSmPTO2/g345nSE3vNwkktJuTff387
         4XBFZGbdSZMMgcbq1Yk07wA1C/rlQGbSZwpvmx/2N4zCNrDZmOjuHfgfgzLhSK1FG5Hp
         iR+oNp77QzVF5AdL0gqXKyAwcSzMOd2Vjt7Tlr0AsbjiC9lxeJa81LrwaH+H1GR40L6p
         PGWg==
X-Gm-Message-State: AO0yUKVr8lkp4VG1W80sjNnY7MrG6X/kIOGYL7BDDcOD/m/yON5EoYz5
        1EM6QrL09HeNegL0ouvLsNj7IldvWdYaB+lr9b23pA==
X-Google-Smtp-Source: AK7set/bvzuBBHiSVRwjdCBYFgmcLi2VbO8gyb1hmLmDfOqhiJPx1AXSbHElEgZn5ThzkdRg0ezGAHgn6PJB0Lpc+wQ=
X-Received: by 2002:a17:90b:48c3:b0:234:bd18:61e4 with SMTP id
 li3-20020a17090b48c300b00234bd1861e4mr2124639pjb.83.1677010226892; Tue, 21
 Feb 2023 12:10:26 -0800 (PST)
MIME-Version: 1.0
References: <20230221070837.1502935-1-anders.roxell@linaro.org> <20230221171951.131472-1-sj@kernel.org>
In-Reply-To: <20230221171951.131472-1-sj@kernel.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 21 Feb 2023 21:10:15 +0100
Message-ID: <CADYN=9KdXbCbVCs1C5n54g_EtmTn5iuHwh3BC4drHtAvcOQ0XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: damon: add config file
To:     SeongJae Park <sj@kernel.org>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Feb 2023 at 18:19, SeongJae Park <sj@kernel.org> wrote:
>
> Hi Anders,
>
>
> Thank you for this patch!
>
> On Tue, 21 Feb 2023 08:08:36 +0100 Anders Roxell <anders.roxell@linaro.org> wrote:
>
> > Building and running the subsuite 'damon' of kselftest, shows the
> > following issues:
> >  selftests: damon: debugfs_attrs.sh
> >   /sys/kernel/debug/damon not found
> >
> > By creating a config file enabling DAMON fragments in the
> > selftests/damon/ directory the tests pass.
> >
>
> I think we could put Fixes tag as below?
>
> Fixes: b348eb7abd09 ("mm/damon: add user space selftests")

Make sense, I'll add it.

>
> Though this may not need to be merged in stable.
>
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  tools/testing/selftests/damon/config | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >  create mode 100644 tools/testing/selftests/damon/config
> >
> > diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
> > new file mode 100644
> > index 000000000000..a6b636e438b9
> > --- /dev/null
> > +++ b/tools/testing/selftests/damon/config
> > @@ -0,0 +1,8 @@
> > +CONFIG_DEBUG_SYSFS=y
>
> 's/SYS//'?  Or, I guess this is not needed at all?

This can be dropped.

Thank you.

I'll respin the patch shortly.

Cheers,
Anders

>
> > +CONFIG_DAMON=y
> > +CONFIG_DAMON_SYSFS=y
> > +CONFIG_DAMON_DBGFS=y
> > +CONFIG_DAMON_PADDR=y
> > +CONFIG_DAMON_VADDR=y
> > +CONFIG_DAMON_RECLAIM=y
> > +CONFIG_DAMON_LRU_SORT=y
>
>
> Thanks,
> SJ
>
> > --
> > 2.39.1
