Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F973BDDA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbjFWReh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjFWRed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:34:33 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7EC2724
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:34:31 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1a98cf01151so719599fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687541670; x=1690133670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nS07vla6Z4VDTbb2v8uiONE/y3+dsUfJ2mdvXYVnpGo=;
        b=r3+LqWNJapXaQTgcMmErSAmi7nE6X2ZjjEc65henO/IvJmTCngECUMU7yUjolkTPLI
         Rz0O6AFj4K0ioy+5Xnqh4zrSVlhlJTwfnx9t1Adxdn41HJ7siPUeDnSSQ53D6LXdIW86
         KqgDZQ9+DJvSE4Qy4lKb/mlzfbNlhkENqPGLhaC8fTdjzKax/0Ao2bSrjI1k4diKHdM/
         uvQTQah+ma4QXquNa+DK/olibtrb/PuDqcchMjBnlTlePyIOfvaD3JdmVgNr4wVDkGZv
         6YXSwxUH22B+iFnqoZHISqN7SLYlcBIxifkD/xjmk2XiuHrmAMd/cVUCkQ0sLznv1yAE
         cmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687541670; x=1690133670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nS07vla6Z4VDTbb2v8uiONE/y3+dsUfJ2mdvXYVnpGo=;
        b=HxGMkWCTv0QgTHOuBNegnEwLBggZHqJsnBHqdyAJLE1Ah6jbi0eLBdK/BT8HVpE7i6
         3cn6kC6uJCHHAlgcpCrbjAuNkRlaILH66kKKBt79pnuTqWew/rMQerRukKlomhDVyYGZ
         k01gHPoV91FjkdiE02+OQm1nijekfiAKnrxmkcPHZ+V96/P95l7TiKSJPwlPqJxQad/R
         SAENmkHCJklH/ADq5pkiRVZWuifpbwjlHG/Ti9LrXVv/963ZpyTvgRryUtmLRRB3s+YG
         22O46LTBe0jxuZRGeDTvdH9jMPzgfd0vpLrVAHayRe83zqUp+JmpsmDWn5TvujyX7voT
         J64A==
X-Gm-Message-State: AC+VfDzHAtdWAnN4NhduaNZ5Mg8827vQn7n35nFUCJWEfVHxvGDchRg9
        0i7GAS9X4tZORqIGGGJ5cM+JgLbbcCG/OT5f1ZY=
X-Google-Smtp-Source: ACHHUZ6XLGd6HwFFY22hhq6+Wz2p+wlygKmy5RCReOQGkXc/R+u3NwsvFqRCkJR5K13rCNwdWSwr8GINPEIXdFDasIY=
X-Received: by 2002:a05:6870:3842:b0:1ad:544:f634 with SMTP id
 z2-20020a056870384200b001ad0544f634mr8655702oal.4.1687541670388; Fri, 23 Jun
 2023 10:34:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230622004226.7177-1-shamrocklee@posteo.net>
In-Reply-To: <20230622004226.7177-1-shamrocklee@posteo.net>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 23 Jun 2023 13:34:19 -0400
Message-ID: <CADnq5_PYWtz6sgutbTc66WAJgKTTgPtG=s=F+geR=74-hNy9ww@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix comment typo
To:     Yueh-Shun Li <shamrocklee@posteo.net>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
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

Applied.  Thanks!

Alex

On Thu, Jun 22, 2023 at 3:32=E2=80=AFAM Yueh-Shun Li <shamrocklee@posteo.ne=
t> wrote:
>
> Spell "transmission" properly.
>
> Found by searching for keyword "tranm".
>
> Signed-off-by: Yueh-Shun Li <shamrocklee@posteo.net>
> ---
>  .../gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c  | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_enc=
oder.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> index 0278bae50a9d..45143459eedd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hpo_dp_stream_encoder.c
> @@ -154,7 +154,7 @@ static void dcn31_hpo_dp_stream_enc_dp_blank(
>                         VID_STREAM_STATUS, 0,
>                         10, 5000);
>
> -       /* Disable SDP tranmission */
> +       /* Disable SDP transmission */
>         REG_UPDATE(DP_SYM32_ENC_SDP_CONTROL,
>                         SDP_STREAM_ENABLE, 0);
>
> --
> 2.38.1
>
