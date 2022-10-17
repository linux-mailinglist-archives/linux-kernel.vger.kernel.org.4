Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B8D60154F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbiJQR1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiJQR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:26:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072AC73337
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:26:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s196so9749788pgs.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=U3yR8f2xGvnli4f6ljBEzHE0/kF8yCV4PFdQwKaLXf8=;
        b=QoIvjpCnmFoa2ARcBy18v3g97+Kq4GhV1zgaEn3giz/25KAkeBFHrUCNRSwvStqAmd
         HaKma3a8oi7+x+/YcpxgZ4dEJ2jjef28CRhb4FO31EozmCmi57Wizm5tgH9zQUohtgUb
         XOEnpGoUGVKXgB6GIFDNXl5RfBqr6SWEK+pLuda/hu/D/VCHF7JTg2c/0mcv8zNc6BJp
         IxrVPEB0NUKyUzerU+ve2lkP2ZV9xO+jftZs0fXAcyZVAxom2rzOGbsNeyZGPOn7DsKv
         UosQM0bIlCRhIM626CItHXM8ZLbBUZByY6wQMKlimRqpqrYu4Pm8HaJawMQI55nzI5sn
         718g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3yR8f2xGvnli4f6ljBEzHE0/kF8yCV4PFdQwKaLXf8=;
        b=mrMIv1sBkgvoXmQZ4bFWwnxlnkPt96Y6e9ztmRlOqDU7ztStTvHVQYvUiQ7X3SwoGr
         SH5ekqdFdeIBI0QSYPo6uX9F58k8c7Uca1/zgTdYJr25WpbPSX79wSAiwXGnODS+nuMw
         Tl+bPIqVS8Z+CrX1FZ/XXOweKmdnXpel2SwOtX8qbNAgPZsaaDK9Th5jj+m2iBo81xkg
         fhb76Rhv71ZH6huIuQou5yYzIpbIKIc3+vYKFb0Tx0xLgKUzQ3Lmw/3C4G7Vp+6SQUBi
         87htk13zaUg30xXrMuiZ/5/dM5GQhlUeWh2TL26pdn/Rx41PRO//iDGl6lLD88CdONBr
         I7MA==
X-Gm-Message-State: ACrzQf0jjRuum8yawBb8SPRF+eQ+/wyAQx/mxAIQo/cNYlrWjE1E+tmx
        lYGeZsRYNwdPjrDt+Vu8u+MWVOG1fDbloqfQFtoeJQ8p6lxLRw==
X-Google-Smtp-Source: AMsMyM50HGv/JVPt9Mg/1/yqJb7RQkP63Y5aESVoSPDp5m6sqFcrlTPsLXWA8wnS7FJd/DQQNi7B/Ce1ADPrxbCb+fc=
X-Received: by 2002:a05:6a00:27a0:b0:566:9cd9:3843 with SMTP id
 bd32-20020a056a0027a000b005669cd93843mr13605761pfb.17.1666027553549; Mon, 17
 Oct 2022 10:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <8702a833-e66c-e63a-bfc8-1007174c5b3d@leemhuis.info>
 <20221015205936.5735-1-phillip@squashfs.org.uk> <2d1ca80c-1023-9821-f401-43cff34cca86@gmail.com>
 <c5980bcb-f345-ff2e-a29b-75e53a6b8708@gmail.com> <a1d46bd2-9603-f89a-ec85-ebcd25db8882@gmail.com>
In-Reply-To: <a1d46bd2-9603-f89a-ec85-ebcd25db8882@gmail.com>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Mon, 17 Oct 2022 18:25:35 +0100
Message-ID: <CAB3wodeqmuE0iZeSddWSGuJ49rKUjSPb9xxsx189hdL9aMn_pQ@mail.gmail.com>
Subject: Re: BISECT result: 6.0.0-RC kernels trigger Firefox snap bug with
 6.0.0-rc3 through 6.0.0-rc7
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        regressions@leemhuis.info, mirsad.todorovac@alu.unizg.hr,
        linux-kernel@vger.kernel.org, marcmiltenberger@gmail.com,
        regressions@lists.linux.dev, srw@sladewatkins.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 1:37 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On 10/17/22 16:45, Bagas Sanjaya wrote:
> > On 10/16/22 19:21, Bagas Sanjaya wrote:
> >>
> >> No Verneed warnings so far. However, I need to test for a longer time
> >> (a day) to check if any warnings are reported.
> >>
> >
> > The regression still occurs with this patch applied. Let's see if
> > reverting the offending commit helps.
> >
> Sorry for speaking late about my triggering cause.
>
> As the background, on my Debian 11 computer, I have lxd snap installed.
> I use lxd to channel my sysadmin side by spinning up containers and
> installing server applications there (LAMP, email, DNS).
>
> Back to triggering cause. I can trigger the regression when the network
> connection drops (when Firefox shows connection problem page). Then
> I run `lxd list` to list container instances and I get the Verneed
> regression error.
>

This appears to be both deterministic, and appears to show something
happening in the Firefox snap triggers an error in the Lxd snap.

This will then not be a Squashfs issue.  Firefox running in one
Squashfs filesystem
can't trigger a failure in another Squashfs filesystem.  This has to be caused
by something else.

Thanks

Phillip
