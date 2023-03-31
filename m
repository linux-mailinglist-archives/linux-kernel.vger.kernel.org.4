Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2C46D2593
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 18:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCaQcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 12:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjCaQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 12:32:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B3522233;
        Fri, 31 Mar 2023 09:28:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8989BCE303D;
        Fri, 31 Mar 2023 16:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BD8C433D2;
        Fri, 31 Mar 2023 16:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680280120;
        bh=73IgJtnFs2TGSAjju6TrDNqdmySf1qlRHQ3Dsp/nG/0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sVqKIsAAgSmsFGZ07bdHiEQctl6mIt2BmwFbxffGTlp1gfp/4owkzIEgCwUOxeiSs
         oJyjQIlfIRiUg9ZDwJhhMVYdWuIYzy8tzM0V/4zgo099W2vOnYGSikMWU9r2XMFWxU
         251Rr5VIpMk9BQiTavizQ4NpzwyPkD3CXLnmkMLEaFkuiwcmHHNC+pxxiOUSI4N76u
         5R+O0OtEC0xflg3/rcfq+w3fnCbNkpPzMOHpEAu2/T/1s0ifHHQkozWV2DvRvkVr0m
         RNub9dq8rI5HAvmlGINbb5cEmX6yFN2h4x0xrxV77NbzteAIMpCIq7VUVc4XpOT+Kd
         4NmwQR3SWhmGQ==
Received: by mail-yb1-f182.google.com with SMTP id r187so28051248ybr.6;
        Fri, 31 Mar 2023 09:28:40 -0700 (PDT)
X-Gm-Message-State: AAQBX9e0rBDwESX1G/VqeDeuJs/ir6x0hLDLlBzWM9i2ITGkJbXXd8hc
        pjrNy/+zqu2vMybj30FKVODFZelzRYYxPRDaKA==
X-Google-Smtp-Source: AKy350YYHHZOKkd+6rbSZojhyMrcgt5V7WRPtHLi1eZqzNDmhN2F/7X0OcFlMu4lT31y3sbpuZVSo26tzqvlloI5gWo=
X-Received: by 2002:a05:6902:10c3:b0:b79:4826:e8e3 with SMTP id
 w3-20020a05690210c300b00b794826e8e3mr12562188ybu.1.1680280120025; Fri, 31 Mar
 2023 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680248888.git.geert+renesas@glider.be> <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
In-Reply-To: <b8701c04d27e51618444a747c4f4be5cc889ce28.1680248888.git.geert+renesas@glider.be>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 31 Mar 2023 11:28:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJJoTGjTihcCiX8qOowb7tSjxg-rjLVskVPuWvSn=0ikA@mail.gmail.com>
Message-ID: <CAL_JsqJJoTGjTihcCiX8qOowb7tSjxg-rjLVskVPuWvSn=0ikA@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: address: Reshuffle to remove forward declarations
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 2:52=E2=80=AFAM Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> Reshuffle the code to get rid of the forward declarations, which
> improves readability.

Is git blame smart enough to ignore this move? If not, I'd rather keep
the blame than save 3 lines.

>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/of/address.c | 271 +++++++++++++++++++++----------------------
>  1 file changed, 133 insertions(+), 138 deletions(-)
