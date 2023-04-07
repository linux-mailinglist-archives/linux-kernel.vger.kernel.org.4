Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D0E6DB208
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjDGRt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjDGRt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:49:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE3F11D
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 10:49:56 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a508c1333cso1171465ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 10:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680889796; x=1683481796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOYR5yl6ypiXPPEsw9LGpTcARLtmR0joIO+5Gy/Ym7k=;
        b=gSjbHOfHvFZTwg2Y8sJqAABr4qbOs+k2r0fQ+0VSOZk6KDkWrDRTPyg4C52MCNHNE1
         mBU7V9D/2Md0WXYZkvllimMI1smpQ1C1kFfkReM4r8ktSoI3kxRfchhJRzDwgRFuoOlt
         vbOvICGQVOBv1Qn70leZLT6df/AwluazWABijBn2vcVMO1zE/lo9kQiJeI00WteSuQzO
         4E7JC3dixEOti4CtUDh751L3OUzUjfxsuq57/AW2RnR6Le3p9lCuvLXaMRlsFskWX/9J
         owh1Fitcsrv4fXxFYKplshFL978dzQ3D+fBn9bMuWz/gIKi76FWckOOCuAdt9sSYV7S2
         Fb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680889796; x=1683481796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOYR5yl6ypiXPPEsw9LGpTcARLtmR0joIO+5Gy/Ym7k=;
        b=y8IDf5zo3NQWbCmISgVl3mGvB1IfFapr3YSYYYNcLlGcm5s/NHTTucfk/oRxPzlh4w
         O/DtlYxz37uLQgsoo6W6xihFqUgFluYO+lD7J6FezDUkdaj9NYou4Z+wTBqmbQVa6K9r
         oFpPHaoU29Ft3zhZ6LbsioXB0IDp8cLMAaoAUybEYDQ6bs5GUJTKPUzow5+WQCl1KOxr
         Ak98PaPvw1RjD+RGy/F8nOBPTYKrBkfqgVQFLBLln+Qn3/9Bp5Xv49RiQRn3ZBy7oFOM
         O3IMiBhxQavC7m9N69C3FSDpQZ7KSoveiyL1afZ50P2VtHUJZd4ox62CNBkH3A4Y53R9
         lYew==
X-Gm-Message-State: AAQBX9feH0ROfKZSKOQCr53R7Uzq2UZcSTfa9CwI/XAUT5FR8heRumlI
        e255mRmRu0ns30vfhxfck8jDIheuSy8WjUVSzfZJsQ==
X-Google-Smtp-Source: AKy350YcyBmqWjxSDZIDUgohnwuC5OCKa+DcG7pxNN+qXdDBC9rHkNcGfLqqt8MDPERyF6go6jpkdZN6egNSE+y9cQE=
X-Received: by 2002:a05:6a00:2d88:b0:625:c832:6a10 with SMTP id
 fb8-20020a056a002d8800b00625c8326a10mr1535733pfb.4.1680889795599; Fri, 07 Apr
 2023 10:49:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230324195403.2655148-1-trix@redhat.com>
In-Reply-To: <20230324195403.2655148-1-trix@redhat.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 10:49:44 -0700
Message-ID: <CAKwvOdndQiSbMK6a7nU01HiovY-Bdjt4m4gOO5m5A36y8qQ8=A@mail.gmail.com>
Subject: Re: [PATCH] drm/vmwgfx: remove unused mksstat_init_record function
To:     Tom Rix <trix@redhat.com>
Cc:     zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        airlied@gmail.com, daniel@ffwll.ch, nathan@kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 12:54=E2=80=AFPM Tom Rix <trix@redhat.com> wrote:
>
> clang with W=3D1 reports
> drivers/gpu/drm/vmwgfx/vmwgfx_msg.c:716:21: error: unused function
>   'mksstat_init_record' [-Werror,-Wunused-function]
> static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
>                     ^
> This function is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/gpu/drm/vmwgfx/vmwgfx_msg.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c b/drivers/gpu/drm/vmwgfx=
/vmwgfx_msg.c
> index e76976a95a1e..ca1a3fe44fa5 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_msg.c
> @@ -702,32 +702,6 @@ static inline void hypervisor_ppn_remove(PPN64 pfn)
>  /* Header to the text description of mksGuestStat instance descriptor */
>  #define MKSSTAT_KERNEL_DESCRIPTION "vmwgfx"
>
> -/**
> - * mksstat_init_record: Initializes an MKSGuestStatCounter-based record
> - * for the respective mksGuestStat index.
> - *
> - * @stat_idx: Index of the MKSGuestStatCounter-based mksGuestStat record=
.
> - * @pstat: Pointer to array of MKSGuestStatCounterTime.
> - * @pinfo: Pointer to array of MKSGuestStatInfoEntry.
> - * @pstrs: Pointer to current end of the name/description sequence.
> - * Return: Pointer to the new end of the names/description sequence.
> - */
> -
> -static inline char *mksstat_init_record(mksstat_kern_stats_t stat_idx,
> -       MKSGuestStatCounterTime *pstat, MKSGuestStatInfoEntry *pinfo, cha=
r *pstrs)
> -{
> -       char *const pstrd =3D pstrs + strlen(mksstat_kern_name_desc[stat_=
idx][0]) + 1;
> -       strcpy(pstrs, mksstat_kern_name_desc[stat_idx][0]);
> -       strcpy(pstrd, mksstat_kern_name_desc[stat_idx][1]);
> -
> -       pinfo[stat_idx].name.s =3D pstrs;
> -       pinfo[stat_idx].description.s =3D pstrd;
> -       pinfo[stat_idx].flags =3D MKS_GUEST_STAT_FLAG_NONE;

This was the last user of MKS_GUEST_STAT_FLAG_NONE, is there anything
else to clean up there?  Otherwise LGTM.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> -       pinfo[stat_idx].stat.counter =3D (MKSGuestStatCounter *)&pstat[st=
at_idx];
> -
> -       return pstrd + strlen(mksstat_kern_name_desc[stat_idx][1]) + 1;
> -}
> -
>  /**
>   * mksstat_init_record_time: Initializes an MKSGuestStatCounterTime-base=
d record
>   * for the respective mksGuestStat index.
> --
> 2.27.0
>


--=20
Thanks,
~Nick Desaulniers
