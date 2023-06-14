Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3DA672FDFD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbjFNMMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244467AbjFNMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:11:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA00F1BC5;
        Wed, 14 Jun 2023 05:11:42 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62884fa0e53so17994406d6.0;
        Wed, 14 Jun 2023 05:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686744702; x=1689336702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfeQaw+ScJyf8YtahpLruw3sSgKj9ssLSfyFkigJ6Tc=;
        b=kkmMLHeIjxJq6WCELQ4uRlrhY0T0CqJeEg84WDKeORRX8QZg7TQxmtC2H3J1mzevUB
         rPZnF1iZapA34xXSlA3122Wzg1nEAJ7jNXJfkV1p+11m/VNs54S4jQeUNUgO9sDDQUNF
         E6Kf3GIXmvKqhVVhY4tu06tjGE2ylIAZjXieiUIJn105s5opLs4YpsB52GzehCcydysH
         JGtlcn4FBB6dsF26jZFfn6ePH8pioOJg4VLlZMDDnjqAjTiAbAEyLkb2NAe/b04PtsRc
         KMN9LdCVAAIUl/mS7ABA90MkDt2tNBt/CFzNz1KFOWR1xNwMXadXkdAYcwxF5u93/7qC
         o2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744702; x=1689336702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfeQaw+ScJyf8YtahpLruw3sSgKj9ssLSfyFkigJ6Tc=;
        b=f8e8Ob6VO6mTuY+4wydJFUrC/kpU6OwvSwx+mg9SGoy04Zo8AN+ktxm2Rf16L6Gku0
         Ax59taJ9+V+cbe6iYudoVEQzQujqyJY+0122pHTMCFKh2o3Q6aTL6ONc4tvYLiQsGexP
         Vm/Z4RzrhQoo/1/NRXc/HNwVFQc2E9i5toTDjBSglknP+19sLiH0BxavIK9utW27aNI0
         zGGd9Oc+JVbb3Jr2d+bShhXg+TAlYTpMKwoBHSTNRMvm8R1mqy/8B+eLkHy2uGToMpgP
         DQTXBpzw8Gjy6i9MscTU/cqY+j8rhxQEShu5WvCY+A/brSBbtT5etzly/Lz+NLOt/irq
         nHvQ==
X-Gm-Message-State: AC+VfDy6nluGr/IMAqx/PJkhduCWi3pFcpnUx67SJDVEXuAR6JbvELX+
        C4E+yv1oTY8tTprw4WOIgTh2dk1m3wnPzLUkt0/Dv6wA
X-Google-Smtp-Source: ACHHUZ6q/B/k5sEOClpChlEtYK3pBtd9BcQBmAx71AC7KmstsV008dZMmCn/9srFUsKZ+ikPUFcZUWtwrLHILLfKi+0=
X-Received: by 2002:a05:6214:501a:b0:62d:e672:2fd7 with SMTP id
 jo26-20020a056214501a00b0062de6722fd7mr13484199qvb.61.1686744702034; Wed, 14
 Jun 2023 05:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230614061130.64214-1-zhanglibing@cdjrlc.com> <5cc396aff142acbc4ba4b2541a5e4d71@208suo.com>
In-Reply-To: <5cc396aff142acbc4ba4b2541a5e4d71@208suo.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Wed, 14 Jun 2023 22:11:30 +1000
Message-ID: <CAGRGNgUW30BYGyPOwwV-zteO7O4gjVgZ4NsoP-xLhuG994bL7A@mail.gmail.com>
Subject: Re: [PATCH] sparc/kernel: Fix syntax error
To:     wuyonggang001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

Hi Yonggang,

On Wed, Jun 14, 2023 at 4:19=E2=80=AFPM <wuyonggang001@208suo.com> wrote:
>
> Fix the following checkpatch error:
>
> ERROR: space required before the open parenthesis '('
> ERROR: do not initialise statics to 0
> ERROR: trailing whitespace

While this patch is mostly correct and is fixing real issues with this
code, it is very old code in a very old part of the kernel and the
maintainers are unlikely to apply it as they'd prefer to leave it
as-is and not introduce any potential for regressions.

>
> Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
> ---
>   arch/sparc/kernel/apc.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/arch/sparc/kernel/apc.c b/arch/sparc/kernel/apc.c
> index ecd05bc0a104..40b9c72ad4d9 100644
> --- a/arch/sparc/kernel/apc.c
> +++ b/arch/sparc/kernel/apc.c
> @@ -162,7 +162,7 @@ static int apc_probe(struct platform_device *op)
>       if (!apc_no_idle)
>           sparc_idle =3D apc_swift_idle;
>
> -    printk(KERN_INFO "%s: power management initialized%s\n",
> +    pr_info("%s: power management initialized%s\n",

While this is most likely harmless, this is technically a change in
behaviour and should have been noted in the commit message. Also, as
this is technically a change in behaviour, it will make it even less
likely that this will be applied.

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
