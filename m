Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C796F8043
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjEEJnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjEEJnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:43:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2B9212F;
        Fri,  5 May 2023 02:43:18 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2ac7de2b72fso17711581fa.1;
        Fri, 05 May 2023 02:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683279796; x=1685871796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufubWxzKxARqUJmhZ8ARTI9/l39hZnmHjfZ3QsO10+w=;
        b=nwjy92vk9SA7NIC1OTfFjQympVPDDZquh211pdGqe4NjCE0sTJahrMJGZI7cEs1vi/
         +/ltpXBWXY4quIxhHQW7B0dBv0Hw8sE5qZwQ9WGNKl5EIJYJKuZM2q27bNW40LYJPQAX
         EYsqxOpiLs+TE/Vcv8JZEFRx79HV7t/2ZZSUVSj2U9B/R3PENT4fFYmqblk6IgG16OaR
         tjsJm8hihI9gLMVWGRSmzO0BmhZJBmVEWMqVx1p6nXF706XUWTFmnYR6zb63mEubL13d
         G7NY1VAglT6vRCTRmRUc//mCdLfZS1D13KCIl8R86DcExnvh6SgDTgq1me2fSXXQPEiG
         42og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683279796; x=1685871796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ufubWxzKxARqUJmhZ8ARTI9/l39hZnmHjfZ3QsO10+w=;
        b=Tgh7im0+JgwfHzy/FPOGJK9CGPJHRuGoJHQqGeYt5Qeoj3MRaNOlJc+8HJ6JiZwQtz
         ts8u8W+/pbnEBcjFJxbG2wbel0Im9MQa92VmXc4mgoDm9XpFY0JHJW7XqPGE0tVrShcV
         vUa8keC2Ww5riC2CbfHtvl4iKaMqt2kgAE61uXbEPfkis64VEVmm0IdoBb4ArG3YFk07
         MW40xkweKCCSSOXpQZ6sX/kE8nsciLJSO9u35eBnL3Kj5cOaMkrDonHgOFCVbwmRbLYt
         P5QMSajFdKbQmaRcYViCPM2W+ubG2zvKS6uBW2KSL/DdF3FwyOwgVRMPHRF7sWc52W7N
         nH5Q==
X-Gm-Message-State: AC+VfDyqmwMiuk8e+HCrZ44W/ztJ+uztn/QUiRyYY/vGeeVy+rH8qUWG
        zInuFjPIECTS4Jr4P7jQ5Ib4VmA5DcXVa8e+wlA=
X-Google-Smtp-Source: ACHHUZ71/HLECo1P1dp932YwLL95D9JhH+bQFKVksl3XgY1RO4ty14DlHH99yubfz4Mruj91cw/vHVswfuBkr5YW7EA=
X-Received: by 2002:a2e:9596:0:b0:2a8:b076:3877 with SMTP id
 w22-20020a2e9596000000b002a8b0763877mr280574ljh.10.1683279796416; Fri, 05 May
 2023 02:43:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230505004925.76301-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20230505004925.76301-1-yang.lee@linux.alibaba.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 5 May 2023 04:43:05 -0500
Message-ID: <CAH2r5mu=r8emGeF7aYoSX=9kAox=9j4bgUU-i0DrwT8e_V8CcA@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: Remove unneeded semicolon
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     sfrench@samba.org, pc@cjr.nz, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
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

merged into cifs-2.6.git for-next

On Thu, May 4, 2023 at 8:00=E2=80=AFPM Yang Li <yang.lee@linux.alibaba.com>=
 wrote:
>
> ./fs/cifs/smb2pdu.c:4140:2-3: Unneeded semicolon
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D4863
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  fs/cifs/smb2pdu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 8e7c15e2fd91..e33ca0d33906 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -4137,7 +4137,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
>         if (rdata->got_bytes) {
>                 rqst.rq_iter      =3D rdata->iter;
>                 rqst.rq_iter_size =3D iov_iter_count(&rdata->iter);
> -       };
> +       }
>
>         WARN_ONCE(rdata->server !=3D mid->server,
>                   "rdata server %p !=3D mid server %p",
> --
> 2.20.1.7.g153144c
>


--=20
Thanks,

Steve
