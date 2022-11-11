Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C3625328
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKFkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:40:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKKFki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:40:38 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2FA42996;
        Thu, 10 Nov 2022 21:40:37 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id b185so4016842pfb.9;
        Thu, 10 Nov 2022 21:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8HH1xBFiha6+sm/Y4eoKI3Sva17f983aTsKIsT9yJg=;
        b=XOCtEjy6X6yotSYRZaRr4X9l+mtikYBW/JdosZi1C9LWHw3eNb8uToajxLxhJnWXdz
         mg1ZNtzBsbT/ZjaMOsHV0pYETDxI+tMVubLuOLI1Qt++d2dYYWDVnO0AOAMJDr6MieXZ
         KzHFmG/C+gR9ZuKEGWeBIvwjf+4gn2C7gY3zH5aJpLS4rGAggIP7dVuDZ1V4uXhHgTjj
         XujCXOk10zqTj+EMhBxkzAzGI/uFLE1ITWDGbnjk5aqFByRlenlRnBDPb9B4y/eR5lRu
         d5F33g3vzOE31hgf3JJdkPb1+XMI00GY6FaP1ZM1vUcUoR0u/vVgOlzxgeo5rmIQwsHo
         oFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8HH1xBFiha6+sm/Y4eoKI3Sva17f983aTsKIsT9yJg=;
        b=QPpHJJgsWvECxKKkWub1rdb5HD6nDmvS2n2Kk0c4yMN9qZk+hZ9ezzbjF6AIstBcUy
         XFe1kEmlv0sT5THVLifUY4Mp7FmgEOghj7UJip5lVFxsK6FpnMarTAh1vUv96BO7Te0n
         Jmavacs6B1NACcsMyo2DGUv+9TNdfCz5ppIjrsL25U7MB8VaQKfqBrAqdljajEgCa9Ew
         csmyzEVgZHVwrLJDBTvTOnapez7dNGDdnsR+xhXI7+1FmnCvtBy0oK5SaSxansdn+6WS
         lIa3DCFkXF205hxQBhRut3IiuPYuixcb4anH+Ma3kKvuPQLr3JMoJhQ608fzil+UYZJe
         ri1g==
X-Gm-Message-State: ANoB5pm4IWS+CdcuO3x+0w/SQnoQ4fVUmwrmrfnUMhhqS2kUNdd3Tf4i
        vF/UaojlPmBW9BPa32gb2qXvP9vRPJcyWl3U33QgbUPpcdhEbA==
X-Google-Smtp-Source: AA0mqf7LtyWb4mv/BiYN+GCemkrpM0E23HkAcxyLA53+ZairQeI1XE3OCKbdza4ZBfABDJlMa+kqN31acJjCn/ox24c=
X-Received: by 2002:a63:a47:0:b0:46f:b3e:4d46 with SMTP id z7-20020a630a47000000b0046f0b3e4d46mr309632pgk.265.1668145236629;
 Thu, 10 Nov 2022 21:40:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz> <60f6526fffa99416d2429dfb0b454148170cce8a.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <60f6526fffa99416d2429dfb0b454148170cce8a.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Cye Borg <cyborgyn@gmail.com>
Date:   Fri, 11 Nov 2022 06:40:24 +0100
Message-ID: <CAD4NMubS_DV0+1hgz3MEwNd4m9MUpUHXQ_EPJdd2MsgvMBSqpw@mail.gmail.com>
Subject: Re: [PATCH v3 08/15] MIPS: IP27: remove KV_MAGIC
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just asking:
This code in SGI seems to help bring online other CPUs.
- Does it use the firmware to do it?
- Is there a possibility that the magic number in this case is used by
the firmware?
- If yes: do we break multiprocessing on SGI if we delete this
"useless relic", which is not referenced in the linux code elsewhere?

Best regards:
Barnab=C3=A1s Vir=C3=A1gh


On Fri, Nov 11, 2022 at 2:15 AM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> It appeared in the original import of SGI code in 2.4.0-test3pre8 and
> has never been used anywhere.
>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
>  Documentation/process/magic-number.rst                    | 1 -
>  Documentation/translations/it_IT/process/magic-number.rst | 1 -
>  Documentation/translations/zh_CN/process/magic-number.rst | 1 -
>  Documentation/translations/zh_TW/process/magic-number.rst | 1 -
>  arch/mips/include/asm/sn/klkernvars.h                     | 8 ++------
>  arch/mips/sgi-ip27/ip27-klnuma.c                          | 1 -
>  6 files changed, 2 insertions(+), 11 deletions(-)
>
> diff --git a/Documentation/process/magic-number.rst b/Documentation/proce=
ss/magic-number.rst
> index 7dada7abc733..d8ffbc21872e 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -72,7 +72,6 @@ APM_BIOS_MAGIC        0x4101           apm_user        =
         ``arch/x86/kerne
>  FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  SLIP_MAGIC            0x5302           slip                     ``driver=
s/net/slip.h``
>  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``includ=
e/linux/hdlcdrv.h``
> -KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/m=
ips/include/asm/sn/klkernvars.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``driver=
s/scsi/arm/queue.c``
>  QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``driver=
s/scsi/arm/queue.c``
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/=
Documentation/translations/it_IT/process/magic-number.rst
> index f9634a04d349..0e59704aa617 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -78,7 +78,6 @@ APM_BIOS_MAGIC        0x4101           apm_user        =
         ``arch/x86/kerne
>  FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  SLIP_MAGIC            0x5302           slip                     ``driver=
s/net/slip.h``
>  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``includ=
e/linux/hdlcdrv.h``
> -KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/m=
ips/include/asm/sn/klkernvars.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``driver=
s/scsi/arm/queue.c``
>  QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``driver=
s/scsi/arm/queue.c``
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/=
Documentation/translations/zh_CN/process/magic-number.rst
> index 966b9e6b1a46..17a73661ef17 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -61,7 +61,6 @@ APM_BIOS_MAGIC        0x4101           apm_user        =
         ``arch/x86/kerne
>  FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  SLIP_MAGIC            0x5302           slip                     ``driver=
s/net/slip.h``
>  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``includ=
e/linux/hdlcdrv.h``
> -KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/m=
ips/include/asm/sn/klkernvars.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``driver=
s/scsi/arm/queue.c``
>  QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``driver=
s/scsi/arm/queue.c``
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/=
Documentation/translations/zh_TW/process/magic-number.rst
> index f3e87a6b3a01..9d44d49b93bf 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -64,7 +64,6 @@ APM_BIOS_MAGIC        0x4101           apm_user        =
         ``arch/x86/kerne
>  FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  SLIP_MAGIC            0x5302           slip                     ``driver=
s/net/slip.h``
>  HDLCDRV_MAGIC         0x5ac6e778       hdlcdrv_state            ``includ=
e/linux/hdlcdrv.h``
> -KV_MAGIC              0x5f4b565f       kernel_vars_s            ``arch/m=
ips/include/asm/sn/klkernvars.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  QUEUE_MAGIC_FREE      0xf7e1c9a3       queue_entry              ``driver=
s/scsi/arm/queue.c``
>  QUEUE_MAGIC_USED      0xf7e1cc33       queue_entry              ``driver=
s/scsi/arm/queue.c``
> diff --git a/arch/mips/include/asm/sn/klkernvars.h b/arch/mips/include/as=
m/sn/klkernvars.h
> index ea6b21795163..93d5eb873255 100644
> --- a/arch/mips/include/asm/sn/klkernvars.h
> +++ b/arch/mips/include/asm/sn/klkernvars.h
> @@ -6,18 +6,14 @@
>  #ifndef __ASM_SN_KLKERNVARS_H
>  #define __ASM_SN_KLKERNVARS_H
>
> -#define KV_MAGIC_OFFSET                0x0
> -#define KV_RO_NASID_OFFSET     0x4
> -#define KV_RW_NASID_OFFSET     0x6
> -
> -#define KV_MAGIC               0x5f4b565f
> +#define KV_RO_NASID_OFFSET     0x0
> +#define KV_RW_NASID_OFFSET     0x2
>
>  #ifndef __ASSEMBLY__
>
>  #include <asm/sn/types.h>
>
>  typedef struct kern_vars_s {
> -       int             kv_magic;
>         nasid_t         kv_ro_nasid;
>         nasid_t         kv_rw_nasid;
>         unsigned long   kv_ro_baseaddr;
> diff --git a/arch/mips/sgi-ip27/ip27-klnuma.c b/arch/mips/sgi-ip27/ip27-k=
lnuma.c
> index abd7a84df7dd..82bb7ac20ef8 100644
> --- a/arch/mips/sgi-ip27/ip27-klnuma.c
> +++ b/arch/mips/sgi-ip27/ip27-klnuma.c
> @@ -61,7 +61,6 @@ static __init void set_ktext_source(nasid_t client_nasi=
d, nasid_t server_nasid)
>
>         KERN_VARS_ADDR(client_nasid) =3D (unsigned long)kvp;
>
> -       kvp->kv_magic =3D KV_MAGIC;
>         kvp->kv_ro_nasid =3D server_nasid;
>         kvp->kv_rw_nasid =3D master_nasid;
>         kvp->kv_ro_baseaddr =3D NODE_CAC_BASE(server_nasid);
> --
> 2.30.2
