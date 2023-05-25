Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7ED710283
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 03:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjEYBpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 21:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEYBpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 21:45:51 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59112E;
        Wed, 24 May 2023 18:45:50 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so6773125ad.1;
        Wed, 24 May 2023 18:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684979150; x=1687571150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmRyEnm3o0xt10apdc5Jzi2N4nwke7v1h2bvJhvh2Sc=;
        b=Y3VYsLdjT+hFAlWXNNJMthzUBHpsDCRFb820qXsc/dYqkVtHF46gI3sr9FoFAWpmPK
         1hlm+mf5z3p6ji9v+ZKTzT9Ud/5rOifiPxtctTEXhN/mYcTdQDJly13O6L6po9HumSPt
         THtVdpIFaAlFFnWJP/r+vRUM6dx7pcP0G5kqLTY7VncJnXGG/IlTurL00mcU0BLpVez4
         1FPwZH9pfW3M5K0pTI8n8cv+3DPKkIVse8MWf5a9U1riTKyYlrT7RS+lxNyIaWodR6cA
         vjNT7BIHOh03PBjTMTHZB+XLZwnCixe75ykabWmwnB1jykyjo1V9XHYq98mHN9qcn0tc
         BfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684979150; x=1687571150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XmRyEnm3o0xt10apdc5Jzi2N4nwke7v1h2bvJhvh2Sc=;
        b=eOzZLfA25DoJaRIsjE8heLS9zQDjNdYirzx+kgXFK4k29nx8ILoNW8TnehSXSODsI/
         R2IAL/J4cd8C2FWAzD1OqH74QC+FsLv8iHg11j1uZdWOs8NV0xD0xz0C4mOloxz1a9Ws
         O/SQlK6FdqFMDhNK5SOLm7XnviQd13H/QlVaUe7eiJmb+6SwKC8DnsAfeONUf0mf/q1e
         JdVYk+NsXLtjcBRzxhcqtyyuGqpxIRj8rEYLWeDXsbOE8UiOyqrj8hv6TQxyBY1g4St9
         Byecza8B7boAOntyZyTnSKL5gRWKPi6yNTx0QLAQgby0YRxy54b/o3DEb9+bY38H0IKK
         Knsw==
X-Gm-Message-State: AC+VfDzCuet6LQmXPqYIchNcUepE9K5Ez50XgFjKCmqkuSitGKX6R/fZ
        7wUdYimXE9HjnMQn33YqitgZz/KixiDSYPry9XY=
X-Google-Smtp-Source: ACHHUZ78QaeXfyuMyHbp1vFmQ3jeRKwF3Gmim01XYIEsSc0edamhG/qunwujuPjAZzNnq5Sg+oLZgjp0A8WtgT9nkf4=
X-Received: by 2002:a17:902:e848:b0:1a8:ce:afd1 with SMTP id
 t8-20020a170902e84800b001a800ceafd1mr23489423plg.20.1684979149595; Wed, 24
 May 2023 18:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230510092450.4024730-1-victor.liu@nxp.com> <20230510092450.4024730-6-victor.liu@nxp.com>
 <b3b77a65-5109-0e29-99c5-6cefaba0492c@denx.de>
In-Reply-To: <b3b77a65-5109-0e29-99c5-6cefaba0492c@denx.de>
From:   Ying Liu <gnuiyl@gmail.com>
Date:   Thu, 25 May 2023 09:45:38 +0800
Message-ID: <CAOcKUNXTFr-uyEeKkos1m0VwoB76SMdkrAuT4zHC9c8D03Apcw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] drm: lcdif: Add multiple encoders and first
 bridges support
To:     Marek Vasut <marex@denx.de>
Cc:     Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, conor+dt@kernel.org,
        alexander.stein@ew.tq-group.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-imx@nxp.com,
        krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        LW@karo-electronics.de
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

Hi Marek,

On Thu, May 11, 2023 at 12:24=E2=80=AFAM Marek Vasut <marex@denx.de> wrote:
> On 5/10/23 11:24, Liu Ying wrote:
> > The single LCDIF embedded in i.MX93 SoC may drive multiple displays
> > simultaneously.  Look at LCDIF output port's remote port parents to
> > find all enabled first bridges.  Add an encoder for each found bridge
> > and attach the bridge to the encoder.  This is a preparation for
> > adding i.MX93 LCDIF support.
> >
> > Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Acked-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> > v5->v6:
> > * Drop MAX_DISPLAYS macro. (Marek)
> > * Drop the encoder member in struct lcdif_drm_private.
> > * Drop endpoint id check.
>
> It might be nice to check (based on driver data for each IP variant) the
> encoder count, but that can be a separate patch.
>
> Reviewed-by: Marek Vasut <marex@denx.de>
>
> Thanks !
>
> btw if this doesn't get picked by someone in like a week or two, let me
> know and I'll apply this via drm-misc .

Thanks for your review.  I don't see any more comments in two weeks.
Can you please go ahead to apply this series?

Regards,
Liu Ying
