Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160527419D0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF1UlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjF1Ukz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:40:55 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE972713
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:39:07 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4007b5bafceso27171cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687984747; x=1690576747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HpPgoFO0pSdncXppmusXrUkfxh4ES6Te3jdG2Cg2eVU=;
        b=2wSG3WNANah+mdgC+nya2O5pWqd4PcmMoSbSQ1RduXR5iKstf64V+594XXv/EMB5YP
         nQZUDgSOkJ0z5K/di8IExvuJiKqTMHF5oTTJM8qQUb16BIBPIAvPPGeN+tKF7mhN58C2
         B3JlHc/+8NsuEwxwLlp7T16pcRQkCIFTJ2x9bh0Y7QnkdO23lwnP8cM9KqI0Ewerz8g7
         cc7wRDDr8l2C1gFvKRvA0q9g+w1dbhRVRlne0ImjC4oDkzpju92K5p0XIaL0Vh2+Uaw1
         7mEveiLJ04k1YYbR2HyGltOXn01eNIbdaOZJAU8cdPmMJAWuk/qDl8Nb9hEOo1qX0Cvn
         FrSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984747; x=1690576747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HpPgoFO0pSdncXppmusXrUkfxh4ES6Te3jdG2Cg2eVU=;
        b=MMTOkHTDbOZm6VhVoIrJ7hagTMgqGKyi9KGaLblvQPp6RfaSpgF2IH97YKHtvt4pIh
         qFVamTf3PDI4sJ7+vvi2fCCG/6bIxI4tmbxi1cyBQTtg09ZY9FcJZR8sR0xfxJwggCv5
         pgie7LOXlCEzh7GPZ56zaugjguVbEyrBgIBntEQ7wNN3J2yTwHSkWDerxLrlKop8gied
         YQqEJwr5GQiSKCpDxTbWt8naL2A45LzGsal+kvZ9q7AKMYkunXBQGtzTiHBeue6ZhS2v
         47J4Z1QS/sAyvjeDJiHeZ6sIbNRuQoeD5WsneNuO7rrV7BaR1ujtkIUuoqoVHQtpINBl
         9F3Q==
X-Gm-Message-State: AC+VfDy8iIND7NbKDJHMCtX/gmBxDgVAg1UjF7CtnmTezGjcRQsWAyRi
        Tz69zZIorTLgm4UjWbj9fzeFSW+/c/GQZdIfl3ij
X-Google-Smtp-Source: ACHHUZ4/TbZlYMa41Qfpo1LF3DWnM40YS8CTkj+s37iAs6EIO+6Wa0uTofT6Eaqyh9psw3nW/VBXZb/ILGt5fTgVDk8=
X-Received: by 2002:a05:622a:51:b0:3f8:5b2:aef2 with SMTP id
 y17-20020a05622a005100b003f805b2aef2mr345329qtw.26.1687984746831; Wed, 28 Jun
 2023 13:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230628180534.31819-1-quic_jhugo@quicinc.com>
In-Reply-To: <20230628180534.31819-1-quic_jhugo@quicinc.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 28 Jun 2023 13:38:54 -0700
Message-ID: <CANDhNCqUkhiWgjCuLVX=vpBsHYj9zto95HoBH1f4XqOEkx9Zhw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove Liam Mark from DMA-BUF HEAPS FRAMEWORK
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>,
        "T.J. Mercier" <tjmercier@google.com>
Cc:     sumit.semwal@linaro.org, benjamin.gaignard@collabora.com,
        labbott@redhat.com, Brian.Starkey@arm.com, andersson@kernel.org,
        linux-media@vger.kernel.or, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 11:05=E2=80=AFAM Jeffrey Hugo <quic_jhugo@quicinc.c=
om> wrote:
>
> @codeaurora.org email addresses are no longer valid and will bounce.
>
> I reached out to Liam about updating his entry under DMA-BUF HEAPS
> FRAMEWORK with an @codeaurora.org address.  His response:
>
> "I am not a maintainer anymore, that should be removed."
>
> Liam currently does not have an email address that can be used to remove
> this entry, so I offered to submit a cleanup on his behalf with Liam's
> consent.
>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b53bafc03c..1781eb0a8dda 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6168,7 +6168,6 @@ F:        kernel/dma/
>  DMA-BUF HEAPS FRAMEWORK
>  M:     Sumit Semwal <sumit.semwal@linaro.org>
>  R:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
> -R:     Liam Mark <lmark@codeaurora.org>
>  R:     Laura Abbott <labbott@redhat.com>
>  R:     Brian Starkey <Brian.Starkey@arm.com>
>  R:     John Stultz <jstultz@google.com>
> --

Acked-by: John Stultz <jstultz@google.com>

Though probably worth adding TJ as a reviewer?
-john
