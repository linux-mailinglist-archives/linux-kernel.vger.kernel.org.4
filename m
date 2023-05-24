Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEF7270ED06
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 07:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239337AbjEXFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjEXFZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 01:25:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC58189;
        Tue, 23 May 2023 22:25:32 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bac6f8325b5so124168276.0;
        Tue, 23 May 2023 22:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684905932; x=1687497932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oH4s8cUK60HKvQMnl3udCHQWgNAGeoNm3adasEf3BeI=;
        b=EtU+mR1OYpsJNNTFwpg4D8QQJbMHQ4a5uqyj6zRLZDgv7mWLEtbYpaANTf4Fz3kogN
         HHGevm+Nj8JaM4yETGV00Kwi0i6n8XD+WSIofFgkZmz752SzBmT38YjXXP9b1VWW2V++
         YF74bKD204tdcj8w/333WWrIb4OmlFbWZE8DozGg7thl8kt5BNAHsCCHy1+K7J9g9q9q
         4Xmb1Ep5eHvxoRpKFZYbb9RWxc70dtX0u6naZ88wdF46MMP+v9AghNLeaGOi1IjVOELK
         u014acznuXCwtcUxWiDzeZn8/Jro+GWNsZ96lwg9aMtqeu3n7oo0bO/ibjNUJaJdKrFJ
         y0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684905932; x=1687497932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oH4s8cUK60HKvQMnl3udCHQWgNAGeoNm3adasEf3BeI=;
        b=IzgCJKiuW6z+LLLuxcNAc89481v1ET88ZePxQUKIDz7BEE9ATh7wRgxZKbk0IFcxTW
         qYLhjKaZBA8b9SLvGpl8IvMKBkT4dZ3GRbdDObsBbcRApC7jZgfqhLqvDam4coOM9+5h
         Tz5l/kRcszCroCVs8uxMm8F1F8IONmGAXl8ot47dHmheiu++JhugRHdadULq31waoU9r
         GNNCZ1bw4SJ84gZAaXW5jHJ/RsnVqvAAN5Jym8BbEO9sxdKAS0WpP5lInU6kCgwsHq5L
         m5bff6j7OOFHtW0Cu9iDHq7GIjq8Z3JR4rPi9RNmJSLfKhtQR43SgcIgmm/BLxd64nnc
         MtfA==
X-Gm-Message-State: AC+VfDyzzVfGNMFJeQ3G3ktcdxe/U0G7GqpcVC13HXiTkJf6kbBFQ71E
        cohqi5U0wIBMpMf/gH5bkEh3MBWa1Phvxppbkto=
X-Google-Smtp-Source: ACHHUZ5D1kD1NK05V+gmlHB7e3f2u66707rziAvZ2xTBkT0SfDoedOHj+1nnTnxb5NEukzdVv26wCAVcMAR56PCfD7c=
X-Received: by 2002:a81:9956:0:b0:565:1d8a:cf94 with SMTP id
 q83-20020a819956000000b005651d8acf94mr7077340ywg.1.1684905932077; Tue, 23 May
 2023 22:25:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZG0fDdY/PPQ/ijlt@work>
In-Reply-To: <ZG0fDdY/PPQ/ijlt@work>
From:   Justin Tee <justintee8345@gmail.com>
Date:   Tue, 23 May 2023 22:25:20 -0700
Message-ID: <CABPRKS9ykHvaOGUboDXZ261LLPS78+YFpOZAcJEeLKGfEUe21g@mail.gmail.com>
Subject: Re: [PATCH v2][next] scsi: lpfc: Use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Justin Tee <justin.tee@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

no_of_objects may be hardcoded to 1 right now, but does it make more
sense to use?

struct_size(rap, obj, be32_to_cpu(rap->no_of_objects));

We probably should have declared no_of_objects as __be32 to have
avoided this confusion.

On Tue, May 23, 2023 at 1:33=E2=80=AFPM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Prefer struct_size() over open-coded versions of idiom:
>
> sizeof(struct-with-flex-array) + sizeof(typeof-flex-array-elements) * cou=
nt
>
> where count is the max number of items the flexible array is supposed to
> contain.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>  - Use literal 1 in call to struct_size(), instead of rap->no_of_objects
>    (Kees Cook).
>
> v1:
>  - Link: https://lore.kernel.org/linux-hardening/99e06733f5f35c6cd62e05f5=
30b93107bfd03362.1684358315.git.gustavoars@kernel.org/
>
>  drivers/scsi/lpfc/lpfc_ct.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
> index e880d127d7f5..f52aeb73af8d 100644
> --- a/drivers/scsi/lpfc/lpfc_ct.c
> +++ b/drivers/scsi/lpfc/lpfc_ct.c
> @@ -3747,9 +3747,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
>                 rap->no_of_objects =3D cpu_to_be32(1);
>                 rap->obj[0].entity_id_len =3D vmid->vmid_len;
>                 memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid=
_len);
> -               size =3D RAPP_IDENT_OFFSET +
> -                       sizeof(struct lpfc_vmid_rapp_ident_list) +
> -                       sizeof(struct entity_id_object);
> +               size =3D RAPP_IDENT_OFFSET + struct_size(rap, obj, 1);
>                 retry =3D 1;
>                 break;
>
> @@ -3767,9 +3765,7 @@ lpfc_vmid_cmd(struct lpfc_vport *vport,
>                 dap->no_of_objects =3D cpu_to_be32(1);
>                 dap->obj[0].entity_id_len =3D vmid->vmid_len;
>                 memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid=
_len);
> -               size =3D DAPP_IDENT_OFFSET +
> -                       sizeof(struct lpfc_vmid_dapp_ident_list) +
> -                       sizeof(struct entity_id_object);
> +               size =3D DAPP_IDENT_OFFSET + struct_size(dap, obj, 1);
>                 write_lock(&vport->vmid_lock);
>                 vmid->flag &=3D ~LPFC_VMID_REGISTERED;
>                 write_unlock(&vport->vmid_lock);
> --
> 2.34.1
>
