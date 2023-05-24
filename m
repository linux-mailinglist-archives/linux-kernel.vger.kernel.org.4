Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A7A70FE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjEXTWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjEXTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:22:34 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D1A18C
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:22:33 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55239f43426so723247eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 12:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684956152; x=1687548152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2MKQchWUI0FAkJHrQVirdj5xxCSU2CZ+/GrJRPq7B8=;
        b=qmcA7bO+beP8btIoBYHwlyAwgiDEqzN6A1J0CvnsA911MD/8axY2IazqByJunWum8v
         ff5MHC6Nv0BhDOZ1jh6ZzFKh7yXQ/dqPfbsqiixPqW+xDoLLuaMNN9wYgf5onfgt8ttO
         R4TNEtErOuIX9D/cWyZYCGvo7kKNMjzRn+gP9RNwsKFQ5XdwAYd6WjNply4dSc35lILj
         G3M6RM8aPa2h9mxWRDqFYuBD0bhw1oHO1PkYiGiCa1RlTISx711Yo/2sbeMtvgulKCXW
         SVkdV4hyAKdNmFqy2mIKteOwn+vbM6hpPmlJDQctv/PJIAHwq3BjqL59lNeMcdsKLdFv
         FXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684956152; x=1687548152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2MKQchWUI0FAkJHrQVirdj5xxCSU2CZ+/GrJRPq7B8=;
        b=bOffmuRNJdv8HuWAvc0IGmZXdvVqzvhGc8FH6JhW8dxUHHkmDOvMvclyXOA0j1hVjO
         pYZh2yNPRm17sjK1MIcTUAB0jQq+pjkbd2i/8WV6wmIXdt466zqjrrifuvPTq8+3XwA4
         4iBDaAu2riBULkVScMt19va3WTtySOYno1wTVaDxGu6d5TWirEZggXlv3KZLKUBecT3W
         MPQt2gi0/fjoSsTNUwDT6BEgHVhFSfDOTA/BOtgT4X91MNDp2cX+uEJCyhWS2SOxDMZ+
         g+j2ySb5gsdGX1Mrn99uc1PMLfaj+KNZyj5YnCGBWInhsDJ2bcVR5Jmetp2hg7q9TL6s
         /j7A==
X-Gm-Message-State: AC+VfDyhBTlLz4UgN3tR7rc0XIA8aP1c3iyK3Golp88EyULxd8c5fq0F
        1nx/ZcHPHojfk25EDxqpeDQIVql44UsBo8eRv4k=
X-Google-Smtp-Source: ACHHUZ6+o43wIGXEkDmzv0/0EngB13qldFCGeSitptxs3zpaCN7kPY6u37qi2JoztOJVQXZzTysmEZNfLSW0dIKL58U=
X-Received: by 2002:a05:6808:3b4:b0:397:f715:5e6e with SMTP id
 n20-20020a05680803b400b00397f7155e6emr6895688oie.56.1684956152482; Wed, 24
 May 2023 12:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230524191955.252212-1-hamza.mahfooz@amd.com>
In-Reply-To: <20230524191955.252212-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 24 May 2023 15:22:21 -0400
Message-ID: <CADnq5_Mz6aPFYGnr8J8C8UeTpbo7JDg+uvjqAxo7o4vmTGej2A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: enable more strict compile checks
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Leo Li <sunpeng.li@amd.com>,
        Kenny Ho <kenny.ho@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@gmail.com>,
        Harry Wentland <harry.wentland@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, May 24, 2023 at 3:20=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
>
> Currently, there are quite a number of issues that are quite easy for
> the CI to catch, that slip through the cracks. Among them, there are
> unused variable and indentation issues. Also, we should consider all
> warnings to be compile errors, since the community will eventually end
> up complaining about them. So, enable -Werror, -Wunused and
> -Wmisleading-indentation for all kernel builds.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Kenny Ho <kenny.ho@amd.com>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
> v2: fix grammatical error
> ---
>  drivers/gpu/drm/amd/display/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/Makefile b/drivers/gpu/drm/amd/d=
isplay/Makefile
> index 0d610cb376bb..3c44162ebe21 100644
> --- a/drivers/gpu/drm/amd/display/Makefile
> +++ b/drivers/gpu/drm/amd/display/Makefile
> @@ -26,6 +26,8 @@
>
>  AMDDALPATH =3D $(RELATIVE_AMD_DISPLAY_PATH)
>
> +subdir-ccflags-y +=3D -Werror -Wunused -Wmisleading-indentation
> +

Care to enable this for the rest of amdgpu as well?  Or send out an
additional patch to do that?  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/
>  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/inc/hw
>  subdir-ccflags-y +=3D -I$(FULL_AMD_DISPLAY_PATH)/dc/clk_mgr
> --
> 2.40.1
>
