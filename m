Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82637628A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbiKNUJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237449AbiKNUJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:09:12 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C751A38D;
        Mon, 14 Nov 2022 12:09:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ud5so31090463ejc.4;
        Mon, 14 Nov 2022 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MdJG0hGFUyyCI91ddj8JC9nYTc4V0N35yzoPYsarpcg=;
        b=if1cvVB7kZ3p6IsI1icI+itclbcxzY0WdmaPbBN6tPazOVZ0CokbOi0SnbOn+6ucyX
         H6Pl5xHiYQC+3gPfhOpXVpfLkA6nT5EDTnGLGfk/KBaN1UDYP1rrfSYg9QPKptNWXVFv
         rGD05TfqEBYD9YEP6d+PtNxbQQmn0kfcF6yLzRRKl53NDrXSiACfYUbvh/KpfFODdcDN
         NWnOTeo9J971LsIQ/6pRldSAfhN/UWaQD9nqk0mTxmf0BpJR7eUCQbY/bU1g1u5pZfYu
         +ZEoBhPqHeLiHny5rnMRQedlXDVrTnt/u7kPaSy+ArQQfw8PxPpzS5vjVDdZD6lcR76k
         IHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdJG0hGFUyyCI91ddj8JC9nYTc4V0N35yzoPYsarpcg=;
        b=I9xpd0nrvuyld97tBN3BdM8OE8y1uEr8eMkeF+sLGsc3QmRHkwvpRL4+ufQv1oS6g1
         fkYuyP4Hne6uONpWo7VG2s8+NvlvZgVxQCariortUxNCMJu236VYJPGPHWGxbh5/Txt4
         6s+k+tNnNgJdAV3vTYu/1o7WggxzNFCrcQuZ2CWYrnt9iw+Py0QjaPPQ2SarSU8/iQe8
         qtI72GyQtSnrSC1seU8v4Q+XF3DXJM8fryFqz4SghmXauNuZncu3bmzf/P+Y5FiNslRC
         DcrjNGZWNqTIfQuPYOd17BD3Pw9FOSeUDp0TPbszs/sv/wFNV5N+IxQHiM1m2SD3G5Ex
         3CqQ==
X-Gm-Message-State: ANoB5pmS17qCQU6qvlJhDF4MsrmTavXG9QE0f6lFIJTfnVu0JQ+zFE+8
        m+ThDuVmUPa6nePFn8dszb0poKqRAAiJlVa6P7o=
X-Google-Smtp-Source: AA0mqf74TSAkf0yvcI1luyzDEnm65fgkWY2yGou5WVEL5BlFJ1qVXKE6gBq540y26pPNkjIbC5NztZ+6bYP+FGRr3j8=
X-Received: by 2002:a17:906:3ac3:b0:7af:da0:aebe with SMTP id
 z3-20020a1709063ac300b007af0da0aebemr2727739ejd.723.1668456549600; Mon, 14
 Nov 2022 12:09:09 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-3-ojeda@kernel.org>
 <Y3JTZ5sle+/A/CdD@liuwe-devbox-debian-v2>
In-Reply-To: <Y3JTZ5sle+/A/CdD@liuwe-devbox-debian-v2>
From:   =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>
Date:   Mon, 14 Nov 2022 10:01:20 -0500
Message-ID: <CAA76j92+X=GvnPq_MaX3qDiQ1vthoEKa9EZLb0gaRSNHVhWiUQ@mail.gmail.com>
Subject: Re: [PATCH v1 02/28] rust: print: add more `pr_*!` levels
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Adam Bratschi-Kaye <ark.email@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 09:43, Wei Liu <wei.liu@kernel.org> wrote:
>
> On Thu, Nov 10, 2022 at 05:41:14PM +0100, Miguel Ojeda wrote:
> > Currently, only `pr_info!` (for the minimal sample) and
> > `pr_emerg!` (for the panic handler) are there.
> >
> > Add the other levels as new macros, i.e. `pr_alert!`, `pr_crit!`,
> > `pr_err!`, `pr_warn!`, `pr_notice!` and `pr_debug!`.
> >
> > Co-developed-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > Signed-off-by: Adam Bratschi-Kaye <ark.email@gmail.com>
> > Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Co-developed-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>
> Reviewed-by: Wei Liu <wei.liu@kernel.org>

Reviewed-by: Sergio Gonzalez Collado <sergio.collado@gmail.com>
