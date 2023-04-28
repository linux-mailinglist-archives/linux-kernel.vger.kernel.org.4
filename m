Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E86F1D87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 19:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346055AbjD1Ri4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 13:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjD1Riy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 13:38:54 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EED1BE9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:38:54 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b8f5121503eso15224299276.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682703533; x=1685295533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEUjkbJ9fm2PEZ0Extrs/fz2ygbuTmXTyZY3mX3KEeA=;
        b=Ejv3a7PTN3IXJZlUkERwq3qQqtM27hv3V/XVRK+q4CMH1ibISS1AUFOYPzIsgGNwwk
         N6yvZ25VItjCEm5GC+6CpTcsEm04Ctrp+zBiffAoyWnadzym984vwc9eU5FyFOvKJfDV
         jlzqw6dw2tFpOEPvWMP5tD/DyR75jfwaRmskAyVJxujy3goFuHJMfR7EoLYJ44DaijeX
         5iCJ5mASHCmQtoNWBeC4E3MizVlKVFlLU8h5MEd4DSC+69Ra8V72SYEen6He4EyD8zhN
         Dzdt7A0PIM0wqhf7HG6Qp54oT08+WXKmFGwdV9W+z6FEuRSIhsB79ObhJx3TnoaRxlWL
         /cqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682703533; x=1685295533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEUjkbJ9fm2PEZ0Extrs/fz2ygbuTmXTyZY3mX3KEeA=;
        b=J8n5KANXZ627nVXPb2WUl8tP6qcPqTKNjkBIRq2X6tUKdMtcktyYyKwq6Q6pk09pxi
         NUdIcjmJAMqdGVSTYCXmrx5iMNXKUio3SytDgB47YUjNz2QwbS8xF5ILF/Ztu75hFOE9
         /YNOWKHIuP57bYcUN1pmpbdHo5BYd/9PHLsfFrfVW91cNlDn2X6J+FbJtF6z2Jy6XXY6
         PDK3kNuHHwLiBE0/Cd5s60agt+EhKNJRm/55meu40RG0elAyASYIZiQCDVzOx6Jjq/AG
         fxpcNPEtqhcuzAJsXsXk4Ys/lBDh2wvZpKP7cdifikL9jFg8SlYO+Q36XOYxtgMt9MFy
         yTuQ==
X-Gm-Message-State: AC+VfDymlmCTwO/ehoFCGH/BDiclFBgvRhuN8GY++qGkSAg928ggl2hw
        hxaDsgL5SAWJpoW+9MqewKVoC7pDER8/mtddS++CHQ==
X-Google-Smtp-Source: ACHHUZ6dLw6HJKkdLP6bWUPEO+9DUnDl5TOE1khXQwqotKvbKlIA03lwf1QpEuW1QgEj7BGdNI+Cuqs60JkcFYGYE50=
X-Received: by 2002:a25:3606:0:b0:b99:3d0c:f6e1 with SMTP id
 d6-20020a253606000000b00b993d0cf6e1mr4264643yba.23.1682703533178; Fri, 28 Apr
 2023 10:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230427153345.451d86681f9c6775ea579e5a@linux-foundation.org>
 <CAHk-=wi5=LfeCMv5ZPAtzWhJyW=y1rVJFTRBfgcqzoUNk5NRDA@mail.gmail.com>
 <CAJuCfpHZSEjG2nti5iWbPQjWgXcHZ95hFS2FKwaPC-sZPdSznw@mail.gmail.com>
 <CAHk-=wg0SyFDp_sdcEH-D+LNxuzL_dWA1vZEowUN16n_+yRHPQ@mail.gmail.com>
 <CAJuCfpHouhrEtomhPe2sf+p0oG4pGFKb3xidhOXP6BN-PydY-Q@mail.gmail.com>
 <CAJuCfpGcnJiJyU78v1r548W3bZ2LyfaYpr5huKKG8-WaiRHFHA@mail.gmail.com> <CAHk-=wjj7tM9ER57Ed3LAOaxMLM3t5nkA=dYSyN-nKPFbOmAZw@mail.gmail.com>
In-Reply-To: <CAHk-=wjj7tM9ER57Ed3LAOaxMLM3t5nkA=dYSyN-nKPFbOmAZw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 28 Apr 2023 10:38:41 -0700
Message-ID: <CAJuCfpHyY+06MX4QuTnObz2DtA_2J151e_1CBM5J69mDtGfKWg@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        mm-commits@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
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

On Fri, Apr 28, 2023 at 9:20=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Apr 28, 2023 at 9:17=E2=80=AFAM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > Should I send a replacement patch for "mm: introduce per-VMA lock
> > statistics" or a followup patch fixing it?
>
> I've merged the MM pull request, so it's all in the kernel now, but
> I'd like to see a follow-up patch with more of a help text and that
> 'default n'.

Posted https://lore.kernel.org/all/20230428173533.18158-1-surenb@google.com=
/
to address this.

>
>                   Linus
