Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B504D70AADD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 22:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjETUNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 16:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjETUNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 16:13:45 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0D8FA
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 13:13:44 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-ba878d5e75fso6102600276.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 13:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684613623; x=1687205623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n8A5e/BMecddVCjsyHoCAAdtVZiJwdMNPvTuwsbGkk4=;
        b=RCiNtiAr1wDrXNh+tvT9gkTBq8oaLF9ahFIYTI6oQanPYxUE94QTt156jpJ/RaSvBa
         pT2GnQAbnrBKMcG+raCVxtt+BZwzSj25cR7bdARfuJImyDsZbIBtT6woQb8hfE4gaM7w
         xtsf8OGoVDJGvi4WzfaZQyqAieCl4YTJawDvtJnhZpztS8Gdz6u/GmE+yX/R9cBAbstZ
         soIRjVZjVjd1poXPoo8NICEV5dWvlE1f+aABLN+CaBFzTXDNyYa4vG0UbCTdeVdIYXhy
         /Agenhg68PWH1/uRfHQi6SQpfDv4df7Wcj0mgP/2FRPDbUFTDqJyrVpWHC0uYxxTpyOq
         fWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684613623; x=1687205623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n8A5e/BMecddVCjsyHoCAAdtVZiJwdMNPvTuwsbGkk4=;
        b=XZZvVfrpDAtnOdb6k45PBNpNRiwNEo0V6GnmUwDdMfVZdbCd//Ms8KuT5XxlQEc2hB
         L2yFoJptqPZN9q8cvYQDIND0gTISWV3W5GP8SWOajlaUUm7lhqFYaoBjiNM7jgd/fA9A
         L+zW9erjUR8KA3mBYx+pRhHlg64Dc8Q2uYjyHBIs9Gbl54Q8xT2bNGEl2Si/wMMrrJPN
         HS7nvok68uJ8zQ9nSiO1gQiam33BVQ9waidMdfXtVupRwC/opq4+VvxzWoAXr9GLO2qI
         CmJStF0PHV0/Ql3meOVXf01LpdqBPq1jDe/IbttcDC7H7ntx+K+p2fEDc+lD8ByT76oF
         4ReA==
X-Gm-Message-State: AC+VfDx5ErXIC0rdquv5Xado1RbBpTfWSc1GfkwANbHdA0C7cWgMc1Ua
        b4vuBHw/Lbvdqmb9XlPubDlNDcrxDhdu9Xh6NA/9VPT1KW75cfd9Qx4=
X-Google-Smtp-Source: ACHHUZ7+r6iC5qvsZ0bUND1BSuO8MAZ3VQmowhvV+EtUZMJSxXJkh1dwaX/EXnFtxc7mAEjTHNKw6GaxWrcVgiEcwmk=
X-Received: by 2002:a25:317:0:b0:bab:d457:76e5 with SMTP id
 23-20020a250317000000b00babd45776e5mr635544ybd.59.1684613623245; Sat, 20 May
 2023 13:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230519130753.3a9d3d65@canb.auug.org.au> <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
 <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
In-Reply-To: <ae1f454c-6023-0e51-f5cc-4f5d84580c55@infradead.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 20 May 2023 23:13:31 +0300
Message-ID: <CAA8EJpom8JnhquM8R0mXK6CVia=7o45hDbFG6rRLCF=_CmFq1w@mail.gmail.com>
Subject: Re: linux-next: Tree for May 19 (drivers/interconnect/icc-clk.o)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 20 May 2023 at 23:12, Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 5/20/23 12:51, Randy Dunlap wrote:
> >
> >
> > On 5/18/23 20:07, Stephen Rothwell wrote:
> >> Hi all,
> >>
> >> Changes since 20230518:
> >>
> >
> > ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o
>
>
> I'll send a patch since there are other build errors too.

The patch was posted yesterday:

https://lore.kernel.org/linux-arm-msm/20230519230122.3958816-1-dmitry.baryshkov@linaro.org/T/#u



-- 
With best wishes
Dmitry
