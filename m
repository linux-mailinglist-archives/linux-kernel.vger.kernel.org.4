Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01E96EE72E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234887AbjDYR5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234226AbjDYR5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:57:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA56FCC2C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:57:29 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50685f1b6e0so11242393a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682445448; x=1685037448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAmwbD+iFp8552mfl50rKy/4VoWPgoubRGRgmYRF8lU=;
        b=4Mr64z/3gwwVAo+4XwaUcyq0PYdncG+kbkD5NIWnr10rRf16eWOdm11mbvmxXsMwJ4
         fMaK/y2/BUOGGVOl3UhmvNjsWBWealADgat09FuYm3rsPE+nlj+/pU9v66cbcaP2LZaD
         ki5V9Jrf4uCK3ylXLxhZ/qMl/VKW1ip/XYDTOXg+Ez071cvcSFWE1DwqTdaM5eTgQKS2
         +sWQRLpGM6mANwK++sdCwpez8KK2vkdjXtvLmo+Qg3t7r8GJ07W1hCN01NqHEzPefapy
         EwOE8KTep44YtWecSXXYlxKC75MPJEKVqnMtswP3t1+Y2o4tLMiJ4Pk+e5yCEumkWEcp
         TFHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445448; x=1685037448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAmwbD+iFp8552mfl50rKy/4VoWPgoubRGRgmYRF8lU=;
        b=NSgH2NeEqHwpcUhYfQ+F5d6b6gcIDJacw3AIq8kubky1Nxl1rOXCJ6SUS2oaJ7zbH5
         6Erral3y51N6W1hQkv7saKynzNF2q1IgM4xEl6xFZKCbVaRlPlIs4PuYMQqKBqdVzQZa
         YxopGsBw9KZhMKZizvUQbTusFtuRoXYnUALhIljAG5xubyDcmfEG1w6/gXCHWbwlWlAQ
         WJfaKQU6loP7KyzIbBjOkj+GtbQooXRWBB3t5Z79UhoNWgnyTeA8mos6ysFF1TWKmiRx
         aiKtxuBgNQw5R4b/HHFhE4ZVF3cLlk7A5IW8LZ9D+nJSz41JgDINYQMg93Iz0UfeLACF
         z/cg==
X-Gm-Message-State: AAQBX9dY+nMrAEVOWnUl8zW9uMuUTE00wC8cN52l7X/CBScPaloviVWT
        QcC7J/41oX08IM9s13euM8xZeyrBvF0Ai739ECBVqg==
X-Google-Smtp-Source: AKy350ZQQbptayAoJa4FnzDsvHjOdyJI5Nfa2quTyp3J81XJGunrqneDe4H2CTngUkTeyAl+BqMxVOxB8vVgclWfmFs=
X-Received: by 2002:aa7:c153:0:b0:4fc:725:e670 with SMTP id
 r19-20020aa7c153000000b004fc0725e670mr15266599edp.11.1682445448060; Tue, 25
 Apr 2023 10:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230415100110.1419872-1-senozhatsky@chromium.org>
 <CAJD7tkZf-TfRdXiVHwBBYw8PuptpfmzeKFGmDzB0mGnTYURrrA@mail.gmail.com> <20230425135042.3c75591a@gandalf.local.home>
In-Reply-To: <20230425135042.3c75591a@gandalf.local.home>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 25 Apr 2023 10:56:51 -0700
Message-ID: <CAJD7tkZ83FGg1hrT6Xs6vSynNhj3RB+xLFH+ru8nPL02FcX-aw@mail.gmail.com>
Subject: Re: [PATCHv3] seq_buf: add seq_buf_do_printk() helper
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 10:50=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Tue, 25 Apr 2023 06:14:33 -0700
> Yosry Ahmed <yosryahmed@google.com> wrote:
>
>
> > Hey Steven,
> >
> > Is there a chance this patch makes it in the next merge window? It
> > would be convenient to have it in Linus's tree so that we can send
> > patches using the new helper. I am assuming there is no risk involved
> > in merging an unused helper (but I can easily be wrong :)).
>
> Yeah, the merge window opened quicker than I expected. I don't think this
> would be a problem to pull in. It's not high risk.

Thanks a lot!

>
> -- Steve
>
