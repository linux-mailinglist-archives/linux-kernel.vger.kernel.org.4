Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC3C6E3615
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjDPIgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 04:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjDPIgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 04:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC3735B7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9027260FB0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDB6BC433D2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681634171;
        bh=6P/SFh54TSeDeV9HcBVW8qufcWuXnCsWRpIr/HB1O+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=k/6rxOgyxoPktbggmoBuXjalEfgvIY1gKCwI7QONAIrZjIhBQvxiGtDT4iCLvBX+9
         x7KiuBvBQuWhfpheHLCtsgnFk61YToCss6+ymy2+WhTu2q1aj+Y84jmcuNog44OWS3
         bYoIL9DglqhCVALxS9MOpGWR31hm82u0TfJIwglZ01LuC5PzVwV6DVM17Pjq14M755
         f8WgBnd1gR13bH7HL0DqbffccRsoneiEv0nqgQXfDqJZH2P8UO6sQZEbghWXYJFfF9
         xew4UtCADIKbtCddmhnlZjVimRRzz+RIgOFqI4Rk61erRGZ3Deee0j2HrK89zrcdSs
         YIgCjvKudajYQ==
Received: by mail-yb1-f171.google.com with SMTP id u13so23058738ybu.5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 01:36:10 -0700 (PDT)
X-Gm-Message-State: AAQBX9dB9SnD7cMMvTF8FVP0O4Uiuw7IX4DiuoKvteO0h33ZCVR0Rmob
        q5+u4BaQv6kk0qYdx5k/Yp6wt0oHOWqPiI8rRrM=
X-Google-Smtp-Source: AKy350b1gliAyW9R5Sw+cmthq1OYFRk9fZ7DNVu2cuc1HpHk1Ua5R/5kXBGv6+nsEyhLQWsyy8c1S9oiWOn/LBhe5C8=
X-Received: by 2002:a25:d816:0:b0:b8d:a959:305c with SMTP id
 p22-20020a25d816000000b00b8da959305cmr7215791ybg.7.1681634170003; Sun, 16 Apr
 2023 01:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230411140850.3129374-1-trix@redhat.com>
In-Reply-To: <20230411140850.3129374-1-trix@redhat.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 16 Apr 2023 11:35:43 +0300
X-Gmail-Original-Message-ID: <CAFCwf12tq7-r7Ej2mwWruQHOvk2d1Z2S_BEVoKF45HsJjfZBDw@mail.gmail.com>
Message-ID: <CAFCwf12tq7-r7Ej2mwWruQHOvk2d1Z2S_BEVoKF45HsJjfZBDw@mail.gmail.com>
Subject: Re: [PATCH] accel/habanalabs: remove variable gaudi_irq_name
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, osharabi@habana.ai, talcohen@habana.ai,
        dhirschfeld@habana.ai, obitton@habana.ai,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 5:09=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> drivers/accel/habanalabs/gaudi/gaudi.c:117:19: error:
>   =E2=80=98gaudi_irq_name=E2=80=99 defined but not used [-Werror=3Dunused=
-const-variable=3D]
>   117 | static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STR=
ING_LEN] =3D {
>       |                   ^~~~~~~~~~~~~~
>
> This variable is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/accel/habanalabs/gaudi/gaudi.c | 7 -------
>  1 file changed, 7 deletions(-)
>
> diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/haban=
alabs/gaudi/gaudi.c
> index a29aa8f7b6f3..a1697581c218 100644
> --- a/drivers/accel/habanalabs/gaudi/gaudi.c
> +++ b/drivers/accel/habanalabs/gaudi/gaudi.c
> @@ -114,13 +114,6 @@ static u32 gaudi_stream_master[GAUDI_STREAM_MASTER_A=
RR_SIZE] =3D {
>         GAUDI_QUEUE_ID_DMA_1_3
>  };
>
> -static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN=
] =3D {
> -               "gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq=
 0_3",
> -               "gaudi cq 1_0", "gaudi cq 1_1", "gaudi cq 1_2", "gaudi cq=
 1_3",
> -               "gaudi cq 5_0", "gaudi cq 5_1", "gaudi cq 5_2", "gaudi cq=
 5_3",
> -               "gaudi cpu eq"
> -};
> -
>  static const u8 gaudi_dma_assignment[GAUDI_DMA_MAX] =3D {
>         [GAUDI_PCI_DMA_1] =3D GAUDI_ENGINE_ID_DMA_0,
>         [GAUDI_PCI_DMA_2] =3D GAUDI_ENGINE_ID_DMA_1,
> --
> 2.27.0
>

Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next
Thanks,
Oded
