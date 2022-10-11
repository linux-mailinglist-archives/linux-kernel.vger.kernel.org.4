Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07245FAE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 10:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiJKIcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 04:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiJKIcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:32:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739BA857D3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:32:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r14so4732165edc.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 01:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unimore.it; s=google;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yDrTjRtrwKB9Ai/CodWTnJbodB9awBLkx/zBQbUM9g=;
        b=E5J+TuJMpIllmYFmN0HquX/0NhS4RHYTFtM1zhiY0fMKk3O8OStqqviUKm+nkRZEUD
         2/TYsF9gTG/R0yk+3pVwD0pMt974rvTpE9A6IMSoFcBw6OET7YUn6seQNxpadA2Fqlpv
         TXAgFXaFyDj35nhzWhFDFUPL8OUTRus35pBB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yDrTjRtrwKB9Ai/CodWTnJbodB9awBLkx/zBQbUM9g=;
        b=zr9bADn/D73DRAN7i3grQb1CVgXySnV5chnAbHM6K7hjPy9Y7pFC31VgzRAJHl3ZAz
         FH/SA0DJwuaU3JID4qCrVZ+39cYpW3uoSIyQ/yfm1onL4SF45iTI7StlXJ52SgFNEEVk
         c39AMFgWp/xkhMJEAa3H38AFvvfA1AHNs+ITObaJ3KV1Bl5bwX+euepPoYtmU3X3ilE+
         7VXkFbp+7owdiaWlQSrJXYeLUCscLwKfcsqnXK+G3JiwVFw++OR81APXGzuiaIgMwsta
         f8Ush1KDo/MGHNrCvUalYBmoenS3/Ii/Y1oio0s3MaWbxouTm2ewYJSdU6X+wD+TuTHw
         KMGg==
X-Gm-Message-State: ACrzQf3ONjuCd7m0dlHD2wI5zT2CmrHDqJ8Mjwr2SKf9t20YtqG/BE50
        MXDEKS/atx27R+UYk2h0OJAW0nP69yyc
X-Google-Smtp-Source: AMsMyM5wB5PQ7SFZPpdBM1KRlHXkZcFCjoyibrYqyURQdo3k0qB/tmjXuNNfyZmrrSBtCZPDWsthfQ==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr13183722edh.355.1665477132911;
        Tue, 11 Oct 2022 01:32:12 -0700 (PDT)
Received: from mbp-di-paolo.station (net-2-37-207-44.cust.vodafonedsl.it. [2.37.207.44])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090618a100b00782ee6b34f2sm6552777ejf.183.2022.10.11.01.32.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2022 01:32:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] block, bfq: remove unused variable for bfq_queue
From:   Paolo VALENTE <paolo.valente@unimore.it>
In-Reply-To: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
Date:   Tue, 11 Oct 2022 10:32:11 +0200
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7FA0FAA3-2F41-4337-B6B3-C70A5AE472DB@unimore.it>
References: <20221010132907.1252-1-Yuwei.Guan@zeekrlife.com>
To:     Yuwei Guan <Yuwei.Guan@zeekrlife.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 10 ott 2022, alle ore 15:29, Yuwei Guan =
<Yuwei.Guan@zeekrlife.com> ha scritto:
>=20
> it defined in d0edc24, but there's nowhere to use it,
> so remove it.
>=20
> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>

Thank you very much for spotting this!

Acked-by: Paolo Valente <paolo.valente@linaro.org>

> ---
> block/bfq-iosched.h | 3 ---
> 1 file changed, 3 deletions(-)
>=20
> diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
> index 64ee618064ba..0a7b3506697c 100644
> --- a/block/bfq-iosched.h
> +++ b/block/bfq-iosched.h
> @@ -372,9 +372,6 @@ struct bfq_queue {
>=20
>        unsigned long creation_time; /* when this queue is created */
>=20
> -       /* max service rate measured so far */
> -       u32 max_service_rate;
> -
>        /*
>         * Pointer to the waker queue for this queue, i.e., to the
>         * queue Q such that this queue happens to get new I/O right
> --
> 2.34.1
>=20
> =
=E5=85=8D=E8=B4=A3=E5=A3=B0=E6=98=8E=EF=BC=9A=E6=9C=AC=E9=82=AE=E4=BB=B6=E6=
=89=80=E5=8C=85=E5=90=AB=E4=BF=A1=E6=81=AF=E5=8F=91=E7=BB=99=E6=8C=87=E5=AE=
=9A=E4=B8=AA=E4=BA=BA=E6=88=96=E6=9C=BA=E6=9E=84=EF=BC=8C=E9=82=AE=E4=BB=B6=
=E5=8F=AF=E8=83=BD=E5=8C=85=E5=90=AB=E4=BF=9D=E5=AF=86=E6=88=96=E4=B8=93=E5=
=B1=9E=E4=BF=A1=E6=81=AF=E3=80=82=E6=9C=AA=E7=BB=8F=E6=8E=A5=E6=94=B6=E8=80=
=85=E8=AE=B8=E5=8F=AF=EF=BC=8C=E4=B8=8D=E5=BE=97=E9=98=85=E8=AF=BB=E3=80=81=
=E8=BD=AC=E5=8F=91=E6=88=96=E4=BC=A0=E6=92=AD=E9=82=AE=E4=BB=B6=E5=86=85=E5=
=AE=B9=EF=BC=8C=E6=88=96=E6=A0=B9=E6=8D=AE=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=
=B9=E9=87=87=E5=8F=96=E4=BB=BB=E4=BD=95=E7=9B=B8=E5=85=B3=E8=A1=8C=E5=8A=A8=
=E3=80=82=E5=A6=82=E6=9E=9C=E9=94=99=E8=AF=AF=E5=9C=B0=E6=94=B6=E5=88=B0=E4=
=BA=86=E6=AD=A4=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E4=B8=8E=E6=94=B6=E4=BB=
=B6=E4=BA=BA=E8=81=94=E7=B3=BB=E5=B9=B6=E8=87=AA=E8=A1=8C=E5=88=A0=E9=99=A4=
=E9=82=AE=E4=BB=B6=E5=86=85=E5=AE=B9=E3=80=82
>=20
> Disclaimer=EF=BC=9AThe information transmitted is intended only for =
the person or entity to which it is addressed and may contain =
confidential and/or privileged material. Any review, retransmission, =
dissemination or other use of, or taking of any action in reliance upon, =
this information by persons or entities other than the intended =
recipient is prohibited. If you received this in error , please contact =
the sender and delete the material from any computer .

