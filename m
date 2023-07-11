Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281D374F648
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 19:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGKRA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 13:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjGKRAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 13:00:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82FE210CB
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:00:53 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-51b4ef5378bso4359394a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 10:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689094853; x=1691686853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjdBm9r4v+Ai8dx8XOLGpj/M16ExfA2ti1QWcSGJBEM=;
        b=D3eHX6mW8sRVZwL/LbZFwwUi4C6QNMl0EkyDqnWGMqIQVkll2TcyX3LLXdCUqLR1vp
         doNX6SB3xadoUNV7DvpW09dMeTFuWs8nzjCDf24V5DD5OTqOpkYLtGGy3fJt/YJhSTsE
         +P6I85DPmZGbZCnYUGXILkK7kaK6CTmYJDbag8jyPHWLkJst8NXJGZQmFBJ6NvfVy1wX
         Kqx5A/7Ts7vaWP93YOYfHxEBPTpWt8H9iUy0hvuzw8v35PuLie6mEYPsVgXE9saFUb16
         b9L+octD/weCgoaGamRF/oW28PCuLBTjHTMCYt8jUmoyg+hxIZAiI8Pd2DldLX4eY8/+
         CkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689094853; x=1691686853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjdBm9r4v+Ai8dx8XOLGpj/M16ExfA2ti1QWcSGJBEM=;
        b=cw4yCxsFRj8w7+LsryXg6tSfU/tHV96XTjsmR7idWaGBApeBO+PPcKsQm33KSnSPZt
         7PGgVeEI4Wd/yxC6b1d/uM26eea97t5qkf99nN8FtiBUX0L7AnRUGcfz0SEzqwdiTgN1
         X39E4f7D5xO/THnQGG1M+Ol8Lmfk0TG0pQZ7ymaek212RcjXm6j8UHjDJEsXvrcNSr1r
         orygvYysw7lTPDtK4KTPZfYrFoxcmBRJVYyQjlfrqt6JJfet/2dUG0d5VrkNAEEYWH0K
         WiPFk90h6xjeWW/i/m/3WJPXDKE2ayvMT4w/HyV08OXLzI7nF8EjST/NZNHAYN6v9TYE
         rtgQ==
X-Gm-Message-State: ABy/qLbv3/ad7GTYx7Nm+g5ZlsWEY5q4hMBzsU6L9jLe4tNQWi9A4HX3
        exd6VysklVf+VXAIcV0UDeET1sK8rvSA6bZiZ+185A==
X-Google-Smtp-Source: APBJJlElzBUqt9brN3WkdBYspoLN+ugvRwtHICbp2dyC6rSR+4Ol09QVGlmB5Ih44ZkXB+um4Wsu8SVymGBguo4iDvg=
X-Received: by 2002:a17:90a:d586:b0:263:4815:cb9a with SMTP id
 v6-20020a17090ad58600b002634815cb9amr15695007pju.41.1689094852746; Tue, 11
 Jul 2023 10:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230711105930.29170-1-larysa.zaremba@intel.com> <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
In-Reply-To: <a05a4ac2-40c8-da67-6727-b9844930386e@redhat.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 11 Jul 2023 10:00:42 -0700
Message-ID: <CAKH8qBtBHD=1bXQyPUczLRUSNagNTKC6DNhO1rqHmrGE5kLHWQ@mail.gmail.com>
Subject: Re: [PATCH bpf] xdp: use trusted arguments in XDP hints kfuncs
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>
Cc:     Larysa Zaremba <larysa.zaremba@intel.com>, bpf@vger.kernel.org,
        brouer@redhat.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 7:21=E2=80=AFAM Jesper Dangaard Brouer
<jbrouer@redhat.com> wrote:
>
>
> On 11/07/2023 12.59, Larysa Zaremba wrote:
> > Currently, verifier does not reject XDP programs that pass NULL pointer=
 to
> > hints functions. At the same time, this case is not handled in any driv=
er
> > implementation (including veth). For example, changing
> >
> > bpf_xdp_metadata_rx_timestamp(ctx, &timestamp);
> >
> > to
> >
> > bpf_xdp_metadata_rx_timestamp(ctx, NULL);
> >
> > in xdp_metadata test successfully crashes the system.
> >
> > Add KF_TRUSTED_ARGS flag to hints kfunc definitions, so driver code
> > does not have to worry about getting invalid pointers.
> >
>
> Looks good to me, assuming this means verifier will reject BPF-prog's
> supplying NULL.
>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>
> > Fixes: 3d76a4d3d4e5 ("bpf: XDP metadata RX kfuncs")
> > Reported-by: Stanislav Fomichev <sdf@google.com>
> > Closes: https://lore.kernel.org/bpf/ZKWo0BbpLfkZHbyE@google.com/
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

Thank you for the fix!

> > ---
> >   net/core/xdp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/core/xdp.c b/net/core/xdp.c
> > index 41e5ca8643ec..8362130bf085 100644
> > --- a/net/core/xdp.c
> > +++ b/net/core/xdp.c
> > @@ -741,7 +741,7 @@ __bpf_kfunc int bpf_xdp_metadata_rx_hash(const stru=
ct xdp_md *ctx, u32 *hash,
> >   __diag_pop();
> >
> >   BTF_SET8_START(xdp_metadata_kfunc_ids)
> > -#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, 0)
> > +#define XDP_METADATA_KFUNC(_, name) BTF_ID_FLAGS(func, name, KF_TRUSTE=
D_ARGS)
> >   XDP_METADATA_KFUNC_xxx
> >   #undef XDP_METADATA_KFUNC
> >   BTF_SET8_END(xdp_metadata_kfunc_ids)
>
