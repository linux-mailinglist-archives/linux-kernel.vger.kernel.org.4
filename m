Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB47246B7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238332AbjFFOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237799AbjFFOrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:47:20 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B0F268E;
        Tue,  6 Jun 2023 07:46:17 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba829e17aacso7723462276.0;
        Tue, 06 Jun 2023 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686062773; x=1688654773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxHl+ipU+ZDLZfzTOn/c27PgH2beIB/6BgFtv/UvuGs=;
        b=Dh1PzSTUKHit9jeQYeJ2K2O09l0hxiYqBOueqmDoSZt/bG08R357RJyV6olMuQj7KM
         ExSoMYeX6pozMxl8Xc0B2/As9/Pci9XZvfsrwJBjU5gvpC+aQJ8y7ZsfAOokw9va80Jq
         fc3F6E6WaRStkX2UvOGUvjoDIOTX+Y431Vr9pt2A6qMzoulT8flLAk8gHfS5I3hm+D7F
         CBWBCLE4lBUwgMPhxbqhlEZzf9zxlqbTok6unq60A8/f1/vgO+bkATJDz5Qe3GSht3bc
         9cls+ydoZz6LYCNd4P+r/kb2Zfdqt8hkLmo6c7hmKJzUH2p3OgMqMGVm6PI5bqWhqnLp
         AQ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686062773; x=1688654773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxHl+ipU+ZDLZfzTOn/c27PgH2beIB/6BgFtv/UvuGs=;
        b=aJCyvoUMnjD2lEH5U8uoRpUYCb98IfxByI8PHWQ+3ZtgizgsHyP6vRqxkA+zPR4yIb
         UnKODxeuzTAIsPwI6N/QPbEq5P3bQHku0cwh3uRvVN2U0Gw96LK+dT9J32f35/+UEhOj
         V6vtRjKhBfvlGGlE0XDG1Zi1jh1AcUhauUoPVO6xsuA7AdZSdRzsJaPzXEBv7PQfUJLM
         EpSSiVTR3ZH9v3Pb8MxhwNQWoRfND2FcVgeHxr9tdmdOvxcmcV/jhHnWErpnb4Z541w6
         j63pYgE9F9ZtIERZWsH/TIa2fmqC8eRxU5GJgiFBG5J1/Z2+YY7WJ5fZw9m8MIx1uuB/
         yKnA==
X-Gm-Message-State: AC+VfDwlkFE9fmEBxSkhSK+Mrl/Dtj+iE5CMNvV59EMNcwwKuoF1fXta
        AFlp8HcSi29ZSO798QlbA5SoxqpPEJe+6QIDbI4=
X-Google-Smtp-Source: ACHHUZ6r28OgpTb4skzaYajMiLnd9SU4e6H84abqyT5Y6x8WBSY+gkL9EdR/1lqQ6bZQtV5X2hnvyNQC46h4RtKHE6k=
X-Received: by 2002:a81:6a87:0:b0:568:fe3a:46b3 with SMTP id
 f129-20020a816a87000000b00568fe3a46b3mr2547087ywc.28.1686062772654; Tue, 06
 Jun 2023 07:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230503090708.2524310-1-nmi@metaspace.dk> <da7b815d-3da8-38e5-9b25-b9cfb6878293@acm.org>
 <87jzxot0jk.fsf@metaspace.dk> <b9a1c1b2-3baa-2cad-31ae-8b14e4ee5709@acm.org>
 <ZFP+8apHunCCMmOZ@kbusch-mbp.dhcp.thefacebook.com> <e7bc2155-613b-8904-9942-2e9615b0dc63@kernel.dk>
 <87ttvkaevf.fsf@metaspace.dk>
In-Reply-To: <87ttvkaevf.fsf@metaspace.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 6 Jun 2023 16:46:01 +0200
Message-ID: <CANiq72kMgh8qKzmLUokvRt=LbZY+vNVU481=-b-kKamupaxajw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/11] Rust null block driver
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
Cc:     Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        open list <linux-kernel@vger.kernel.org>, gost.dev@samsung.com,
        =?UTF-8?Q?Matias_Bj=C3=B8rling?= <Matias.Bjorling@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 6, 2023 at 3:40=E2=80=AFPM Andreas Hindborg (Samsung)
<nmi@metaspace.dk> wrote:
>
>    Samsung will provide resources to support this CI effort. Through this=
 effort
>    I will aim to minimize any inconvenience for maintainers.

This is great.

>    We also have Rust support in Intel 0-day CI, although only compile tes=
ts for
>    now.

In addition, we also have initial Rust support in KernelCI (including
`linux-next` [1], `rust-next` and the old `rust` branch), which could
be expanded upon, especially with more resources (Cc'ing Guillaume).

Moreover, our plan is to replicate the simple CI we originally had for
the `rust` branch (which included QEMU boot tests under a matrix of
several archs/configs/compilers) to our `rust-next`, `rust-fixes` and
`rust-dev` branches, in order to complement the other CIs and to get
some early smoke testing (especially for `rust-dev`).

[1] https://github.com/kernelci/kernelci-core/blob/65b0900438e0ed20e7efe0ad=
a681ab212dc8c774/config/core/build-configs.yaml#L1152-L1197

Cheers,
Miguel
