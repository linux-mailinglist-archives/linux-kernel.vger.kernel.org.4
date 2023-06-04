Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BEC7219FF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 22:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjFDUtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 16:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDUtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 16:49:13 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303DCE
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 13:49:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565cdb77b01so42833127b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 13:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685911752; x=1688503752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hrzRhdPWgyFGA5EQAoArkXGFEb9XgbN+NGmVY0Sg/3A=;
        b=EwrOAuRy4PeqUV1EyNpJ1ymgFa87VwLN5JYf46fZ3Pm21IKKSYgFVpQFzsBBRYJGWF
         rGHj4styziiD0rQitQOKJzd5MrbHeFjyeD8SzXwnL9xIn0JfAQtrW7/ZhV91W+ghoD9b
         R3TcRspWr7L5SDhqal9aIbxtSPTGcR4pJJd8KwGf77Pl+3KnJAyzj4zru5FSiFBlQwl9
         pegJKSD/AbSv10yN3IV7tKjwWM/CUKXXZ1UzP5MhVmqAoS4/iyY3Nz11WdRDbr+Bazjv
         gNAym3p+K2WUhR76UBserf7j+x33TOc3u8gqNE34Dp39CKMeVJkJpW1tz/X0r66m/SDB
         nKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685911752; x=1688503752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hrzRhdPWgyFGA5EQAoArkXGFEb9XgbN+NGmVY0Sg/3A=;
        b=RWPJpt9947RLf0py1w7KW7g0NdtSO7vz3vYEOZo8rYsLvWXocz6HktSIowYiO9x3lX
         Sswkf6nwOfFt2maK8ofD20rnZqYdeaqxrYxAZadH+Lk8SIRsSbtD1MNamYH1K8GLMY3W
         1esjjg4/2a3jmGh1YFj+UrIPJA4y/8A0g+LhvuZcnMnWuTkAQSreHAxEHSjPHpKjbiT/
         A4SvztMinumis9MJAmQ/bvDTLEm22tLTEshY7o2+4+BcB6WYrGfiIxz1pXlmHxQmoXnr
         iWW84JjkMRAoHG7caiGUPbPjcyad8zSxN6r1BD/az9jQxxBA+rJAMVFr9MqdDAQUtZ4n
         xJcA==
X-Gm-Message-State: AC+VfDxwmKn2JDwiacSTDnSEo439OTLTIEgofbWfhm9h7NIdi5ZGsC1b
        BUFWafqhkTRLRYcuCtzDNqZ/GA97F3yo24UHw3w=
X-Google-Smtp-Source: ACHHUZ7kYjbjYsj3LPihZL/TAU1vfpq+stfMAVVcNxIsnUmtH3ZFTlPbGJ87az659jTxlqiUL9ILwPtcStT1eAsqv0g=
X-Received: by 2002:a0d:e288:0:b0:565:c7dd:95b9 with SMTP id
 l130-20020a0de288000000b00565c7dd95b9mr6977494ywe.12.1685911751719; Sun, 04
 Jun 2023 13:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <d8afcd26-af64-b062-8e40-b59eff9b4180@digikod.net>
In-Reply-To: <d8afcd26-af64-b062-8e40-b59eff9b4180@digikod.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 4 Jun 2023 22:49:00 +0200
Message-ID: <CANiq72kDJA8e0b+Mo_sxLUXs70E-P2un8GM+XtADr7RpM4eaKA@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>,
        ojeda@kernel.org, danny@kdrag0n.dev, masahiroy@kernel.org,
        jgg@nvidia.com, linux-kernel@vger.kernel.org, corbet@lwn.net,
        joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org,
        mailhol.vincent@wanadoo.fr
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

On Fri, Jun 2, 2023 at 5:37=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> Looks good to me, thanks!
>
> Acked-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>
> It would be nice to have a script to check files and output a diff if
> they are not in line with this configuration. That could also be used to
> measure how many files are compliant with these rules, and add this
> stats in the commit message.

Agreed.

> For some reasons, maintainers may want to exclude some files from these
> constraints. It would be useful to add some documentation explaining how
> to do it.

I would suggest adding it directly as a comment on top of the
`.editorconfig` file itself. Or, at least, put there the link to the
official page (https://editorconfig.org), which mentions `unset`,
assuming that is the way to do so.

=C3=8D=C3=B1igo, I would also suggest sending the patch to Andrew Morton.

Cheers,
Miguel
