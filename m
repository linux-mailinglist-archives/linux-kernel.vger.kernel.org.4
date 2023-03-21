Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454366C348D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjCUOm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjCUOm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:42:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A114ECF7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:42:54 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-544787916d9so283973347b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679409773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtPwkY/8VKMjRpZP8nkE6+KZh9AWGMgm4pAyQ2A8hVM=;
        b=FII/3p0k8pjrZHGDKphWpd7fUhCUOD9TVyjqLi4tM6OJ8yYht3gJybn1gnqnlHfMYB
         SYScvVhv9xnr8ezXeWHguSZ9HSxmimA/MjNmMv6FxevTxmVW2UtxMBAxeDcxL8fnsWG/
         NVcHHTwGEPs9srNVotYsjxltm68oFhd9CdC6BuZwavkPVUteX/3qJw7rWbxEmSMgAvm8
         r6p6YBkCTj6CKxzfIjUNmioe3pPqsl5eXoDuW6zlNS4lwqo9LTjTDSFpK6AFo9x7UA9B
         XmySarRca1OALqwKGNKzJm9l7arueZNM/MfN+iEy4o2+gPk6EGOlK1pJyaLj6YdZorte
         mqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtPwkY/8VKMjRpZP8nkE6+KZh9AWGMgm4pAyQ2A8hVM=;
        b=uGgSUMA243EU3b5aKppiP3M8vMkFSDPPg7Er/Dvssds7kIT8s2o/Jechyz7o2/4nk7
         SEJChylIWOP/AEmznn+unQdYD4THRJr5UXseoeNkBWrSw8FuNAJr6dG+gg0DrFsuT+a6
         EQT8aHEiG9/QbVHOjguDCxx0jxoAyQgT/qCpqPiw0uxJiU0WMuGG1ywTa+Xven60BdAr
         cBjcghx9IDIhwGHhZj4fTx+HlYCR2IqVP0u8tpDdD420BUfLV/JUraSA+BpWVEHriQQp
         WfPEOv6/EHuryWQnZZ7ZLigayqDZHVAj7ihSCkZ1L+VLkbuQKJh5KDs74UCV/Fyl+1EO
         werA==
X-Gm-Message-State: AAQBX9duudl9D2RRpxCRRbYsn/G4bbDaNh4HBD+diPtVNGD3p5iV0f3x
        a1ui8HWgUOtZpJ7yyAqSBwd3eit3q1RVFauGKbCEfA==
X-Google-Smtp-Source: AKy350YiBo4gj35uuLlpHRCbAICvQZFyf4Q+EQjhiIv5FG8Ep4/T1OExCBbDtBy02JODvfTnzdwO7Epd4eR+yRjIh8g=
X-Received: by 2002:a81:764f:0:b0:543:bbdb:8c2b with SMTP id
 j15-20020a81764f000000b00543bbdb8c2bmr1199639ywk.10.1679409773530; Tue, 21
 Mar 2023 07:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230321132052.7d12fd7d@canb.auug.org.au> <20230321132227.5f63cd43@canb.auug.org.au>
 <ZBlDaMh023N20uuo@bombadil.infradead.org>
In-Reply-To: <ZBlDaMh023N20uuo@bombadil.infradead.org>
From:   Jiaqi Yan <jiaqiyan@google.com>
Date:   Tue, 21 Mar 2023 07:42:42 -0700
Message-ID: <CACw3F525O1TLBYRpSSo2_+3tWWoSy3bKzPqcjPvveRgXvwOsGA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the sysctl tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:41=E2=80=AFPM Luis Chamberlain <mcgrof@kernel.or=
g> wrote:
>
> On Tue, Mar 21, 2023 at 01:22:27PM +1100, Stephen Rothwell wrote:
> > Hi all,
> >
> > On Tue, 21 Mar 2023 13:20:52 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > Today's linux-next merge of the sysctl tree got a conflict in:
> > >
> > >   mm/memory-failure.c
> > >
> > > between commit:
> > >
> > >   44b8f8bf2438 ("mm: memory-failure: add memory failure stats to sysf=
s")
> > >
> > > from Linus' tree and commit:
> > >
> > >   cfe7e6ea5ee2 ("mm: memory-failure: Move memory failure sysctls to i=
ts own file")
> > >
> > > from the sysctl tree.
> > >
> > > I fixed it up (see below) and can carry the fix as necessary. This
> > > is now fixed as far as linux-next is concerned, but any non trivial
> > > conflicts should be mentioned to your upstream maintainer when your t=
ree
> > > is submitted for merging.  You may also want to consider cooperating
> > > with the maintainer of the conflicting tree to minimise any particula=
rly
> > > complex conflicts.
> >
> > Sorry, I forgot the resolution - see below.

Thanks for resolving the conflicts, Stephen. It also looks good to me.

>
> Oh sorry, its on Linus' tree, so I can just rebase too. Did that and
> addressed the conflict as you did, thanks!
>
>   Luis
