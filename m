Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCE37148B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 13:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjE2LiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 07:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjE2LiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 07:38:15 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62683D2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:37:48 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565ca65e7ffso17051257b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 04:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685360267; x=1687952267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PoBEV3k+mp3G2hTQQ0To+BOyb5fQb9lyHNZaR49GYHU=;
        b=ut5MJvhBhJKojVYlk2cxRjOBoW1KLjBUrhQf1nfrqlb34LZjvbT0KUmUhgyl3FDl3u
         rRcgpULH9udsxqIKaA7j8Y/klwMa3AqYLzl/SesP0ZCreRyYQx4L2Eg+3Ec4SeujSuAD
         Lo85iIXK834uNNVUiNvGVnr5N7wA1x65pJseRkGSNdapGczC8O+NlXa1jULtHIf6yhFl
         dP9Iq4LN0pMHtC904YvXGjM1eNbA7voRcexFJyBaN59PmGOraJQdWOCdivlrXEEavhuK
         FkwqgcPby0CpxSRWzsgTP9stNRA4+P7mXTwYpinhaXFhMlaa7usm06hZASQ7VcA2pKjM
         kb/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685360267; x=1687952267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PoBEV3k+mp3G2hTQQ0To+BOyb5fQb9lyHNZaR49GYHU=;
        b=XC5v+66o26O27SMPJU30WUWGzKlHakxCXUXs49revFMmM2d7zg6KOt9bUkm1Shkq71
         JDsu/i0wCD3SwMaiknQl74rKApLlRuq4Qfihf9bdjykUxF4UTkDqJa8dEF38C1wfHbJ4
         60ihQhLDFTKgaviISkSuf71EAYHmSPFQ4JKhyn0PCYxrnNxem3t6leAR6kJ7/V9neSFg
         t2l1OyPaCKOx66CXFZ+z3tt2MHQNsD6C5/2f3CLY0Jcii10Aj5bY8GUM/mtvUvMRQvv5
         afollTFAVRUFejEzYHLTNPfF45aYr6y1972oQHh/fmLIt1xixM2YU7j7+WHwVUE0iNHw
         Cvtw==
X-Gm-Message-State: AC+VfDy6v1gDbfCfpBpSo2xuB/ToptVCptFS8AqycesujsqYVbMEwgXW
        mu/npn9XruTaaBsse/stL0oCBqf8Qmn1ETSNx7W5Cw==
X-Google-Smtp-Source: ACHHUZ5p2vilmWRQxNQEN95NJfAxWvpExjUU9mxsfIG0POxhZXTmyvfucsmHflY2abuz5V35HiQwG0iSAhMreQBIubE=
X-Received: by 2002:a0d:e084:0:b0:565:f045:18c4 with SMTP id
 j126-20020a0de084000000b00565f04518c4mr5503703ywe.4.1685360267197; Mon, 29
 May 2023 04:37:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230528142127.37330-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230528142127.37330-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 29 May 2023 13:37:36 +0200
Message-ID: <CACRpkdYDtVy3gJYnD-y-fzSQEBWJJRU2QBYMoUzK7y1yTK33qQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Kill unused GPIOF_EXPORT and Co
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 4:21=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> There is no use of the  GPIOF_EXPORT in the kernel. Kill it for good.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

That's wonderful.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
