Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1359745C44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGCMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjGCMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:32:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9567B1AD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:32:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25F6F60C99
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DAD9C433C8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387545;
        bh=CowpH8DPo8yW1jG5FQZ0ybumysPwE/V0Eb9qKNvOgnA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SmoQF4FeVG7f4l/HzxQ22Au2vPJuqvRn6sM0q88aRatY1sn31i/hzIjpakbzKbGpZ
         XotpV2+SzHhLJYbfuvRmE8pUzBK9kn/UhIkifj20d92AhHttMyadG9k2G3qIp3tlMg
         CM4A7erip8L30MCrRQgWPvY9DAuih/ZMaen7j8OCBN/vy5SIBQvudLPlgew1bNv9L+
         66qZ7hSGRTxSEGIW7Ba9ykW+xOALWwILxoCmHHiH7O2pMDn3eLvLNFtC/WikJmSzuY
         7dsUD6RLmL4Xc8hlqO5wPKeK2Upb8LJmJmoIBIVS30Q/XHaHc/Xrivsm7d3oZ8DBSs
         9dpcy1+R1R4Zg==
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5704fce0f23so53376827b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:32:25 -0700 (PDT)
X-Gm-Message-State: ABy/qLaFY+O7sDCOzw7j9RnX0XtG3LpS8qqaJRR/UqqSKosBcq5dgL4X
        9Yx0pCnTQb2FXsuSvELc0aGZAwPlC+nLQmaayZo=
X-Google-Smtp-Source: APBJJlEm34QjMiB5XFo7Nn9AAHYzR1pMpFMjO5LeTXpO/Lztydt1Pf0C2v1KinGg8d4ias0oKmZ8R9sSg+JUiozA2uo=
X-Received: by 2002:a25:9e87:0:b0:bcc:571d:a300 with SMTP id
 p7-20020a259e87000000b00bcc571da300mr8636480ybq.20.1688387544656; Mon, 03 Jul
 2023 05:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230616121637.1033074-1-juerg.haefliger@canonical.com>
In-Reply-To: <20230616121637.1033074-1-juerg.haefliger@canonical.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 3 Jul 2023 15:31:58 +0300
X-Gmail-Original-Message-ID: <CAFCwf11dE5cnkJJH0TumpBEHohCy8FL6fQz9dfODn=c_WOsscg@mail.gmail.com>
Message-ID: <CAFCwf11dE5cnkJJH0TumpBEHohCy8FL6fQz9dfODn=c_WOsscg@mail.gmail.com>
Subject: Re: [PATCH] habanalabs/gaudi: Add MODULE_FIRMWARE macros
To:     Juerg Haefliger <juerg.haefliger@canonical.com>
Cc:     dri-devel@lists.freedesktop.org, osharabi@habana.ai,
        dliberman@habana.ai, linux-kernel@vger.kernel.org,
        dhirschfeld@habana.ai, talcohen@habana.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 3:16=E2=80=AFPM Juerg Haefliger
<juerg.haefliger@canonical.com> wrote:
>
> The module loads firmware so add MODULE_FIRMWARE macros to provide that
> information via modinfo.
>
> Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
> ---
>  drivers/accel/habanalabs/gaudi/gaudi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/accel/habanalabs/gaudi/gaudi.c b/drivers/accel/haban=
alabs/gaudi/gaudi.c
> index a29aa8f7b6f3..cd034e98128a 100644
> --- a/drivers/accel/habanalabs/gaudi/gaudi.c
> +++ b/drivers/accel/habanalabs/gaudi/gaudi.c
> @@ -63,6 +63,10 @@
>  #define GAUDI_LINUX_FW_FILE    "habanalabs/gaudi/gaudi-fit.itb"
>  #define GAUDI_TPC_FW_FILE      "habanalabs/gaudi/gaudi_tpc.bin"
>
> +MODULE_FIRMWARE(GAUDI_BOOT_FIT_FILE);
> +MODULE_FIRMWARE(GAUDI_LINUX_FW_FILE);
> +MODULE_FIRMWARE(GAUDI_TPC_FW_FILE);
> +
>  #define GAUDI_DMA_POOL_BLK_SIZE                0x100 /* 256 bytes */
>
>  #define GAUDI_RESET_TIMEOUT_MSEC       2000            /* 2000ms */
> --
> 2.37.2
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Applied to -next.
Thanks,
Oded
