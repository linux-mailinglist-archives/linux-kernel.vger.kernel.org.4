Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70C4622BF9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:56:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiKIM4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:56:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiKIM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:56:44 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A712C65C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 04:56:43 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a7-20020a056830008700b0066c82848060so9886334oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3VGgFEfjO9ZkszQA2gGwLqg0SSKkKYKja2wxMfFRT3U=;
        b=Jal9yIdoyEEgRAIFvEDEDq4aaArjPsSX0GXIbB3yqAMZLunSQseRE7IJihFHBXGlzL
         3bcGnzSjcDs9YkyyJHBnJzoK9YNmPcowO7G1HnTSAn7EPWmXB/qqLgO2qC+MT/gKt8RI
         c4Rn2+mhOy9nqskUZrE8PoWgOFiChTMavIQ69RmiuludWaa9PSx4JLZcDea+0krN8hGI
         vxkf4hGVzxkkVw235j5/55qVfhk7v56ub9VlvEPbdUoKeRbnhalmNShUqFLRX0mRfYr3
         rkS1VOLHeXCpBuVItgCW8zQhhCQwwbmBdbfXp7gpPnP+nIlqoFGyEEiYiLLNpqsZhpZ0
         kOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VGgFEfjO9ZkszQA2gGwLqg0SSKkKYKja2wxMfFRT3U=;
        b=Id/JEXxYuopouEQSoTt9r7++VdyBWlVDMyXw9ADJGrp4PlmYu9tPXoHwuwQ5yTCmc7
         npkYXrnR8PkVlaXyWsf9DwQ4SsB5iNNyeh/src2QYDDkl4TGXBSzfHtJvU/PjBt3rac5
         ude0eWz4OkUqeXQbIN7X/yCJvSWYnwUXdiF46bhVrEuo0c2dTxVg2jDUpMo0wlU/wYw2
         CmxyhPhMPiMCNm8L3ovB5xD4M+jzrQ0GGUhGgupRpRYKwoirsmYOvP1nKibfoPe+HR/j
         yvLA1mRPdFNN2WsY8rp8rIlFgJws/fzj8JRANzjvic0O2KgarpOj5ZdQqEK6NfKQT29n
         NC6A==
X-Gm-Message-State: ACrzQf00jRj1GmHpMvDJYad4iFQOopjTHp8LD8setVZlYsgR4fIHqSZR
        Gv1eJUTBrFxXwT3a6TCnVpN5BxZ0DjGnQYH6tA0=
X-Google-Smtp-Source: AMsMyM5LU05XsfSxXNtlaNa56qBkWUepk6jX48Pr2pmwqB0oy7B4te3w9qEfgBgldCCsHarHVIq1j7abooBmSjG/x/0=
X-Received: by 2002:a05:6830:628b:b0:660:d639:f380 with SMTP id
 ce11-20020a056830628b00b00660d639f380mr28675055otb.181.1667998602638; Wed, 09
 Nov 2022 04:56:42 -0800 (PST)
MIME-Version: 1.0
References: <20221109105158.230081-1-zyytlz.wz@163.com> <Y2uLK6Zxsz9TD9WV@kroah.com>
 <CAJedcCyN+D+gsVo10r-bGpAtnL4x_N3TpqhVYBi1P7=dD8fNCw@mail.gmail.com> <Y2uYZFqzYdG/oJCY@kroah.com>
In-Reply-To: <Y2uYZFqzYdG/oJCY@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 9 Nov 2022 20:56:31 +0800
Message-ID: <CAJedcCxstTJQiVPpW7sTMRBBPixQMd3HqNAX3S5GeXGjjXDKAQ@mail.gmail.com>
Subject: Re: [PATCH v8] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=89 20:09=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 09, 2022 at 08:04:04PM +0800, Zheng Hacker wrote:
> > Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 19:12=E5=86=99=E9=81=93=EF=BC=9A
> > > >       /*
> > > >        * If the current task is the context owner, verify that the
> > > > @@ -727,14 +728,16 @@ void gru_check_context_placement(struct gru_t=
hread_state *gts)
> > > >        */
> > > >       gru =3D gts->ts_gru;
> > > >       if (!gru || gts->ts_tgid_owner !=3D current->tgid)
> > > > -             return;
> > > > +             return ret;
> > >
> > > Why does this check return "all is good!" ?
> > >
> > > Shouldn't that be an error?
> > >
> > This check is something like "if the gts has been initiiazed properly".
> > If it's not, I thinks we shouldn't treat the gts like something very
> > bad happend. Because in the later request, the gts can still have a
> > chance to be configed/updated properly. This is different from "it's
> > too bad so we have to unload gts right now". This is just my personal
> > point of view. Besides, the caller of this function have token it into
> > consider. In gru_fault, it will try again and in gru_handle_user_call_o=
s,
> > it will return -EAGAIN. In gru_set_context_option, it will be fine
> > because there won't be any operation on gts->ts_gru or gts->ts_tgid_own=
er
>
> Then you need to document it why this is "success" as it is not obvious
> at all.
>
Oh yes. I will append a comment to document it with the code in the
next version of patch.

Best regards,
Zheng Wang
