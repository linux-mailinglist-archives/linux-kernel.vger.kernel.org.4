Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011B724530
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjFFOC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjFFOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:02:56 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40B078F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:02:56 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b160f3f384so1738331a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686060175; x=1688652175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uKfMxnlTG/tbmuksWuOGZWrrvfs8QjlyYN4r2hnIpWo=;
        b=VA42Clb/LLV7nHqt/y8/XVxTan46RsgI8crf9vhzZRuiychWUTwqv0bsNXuz1rz7xu
         MlGWultN0RTL1m/HaT5y1hLhfLRp+ea9eGpqaJ04pgBw9o1VxDlkbNsj5SGtYpKtnE3R
         u0gs7e3qAIZZy3JfBBWI/huXTusyPeG55EBuAYrFTrVJs0YnBVt8dHEaa5otkZFA+8x4
         MsgphfPGBFX3hxHFZUie4K7a/KcGSIN0xizFUxP+75ax6WzzD/0WJtLpBXhaDJtvVqky
         f6vxhN6ghr+kGS6VBHc13JH9560ANfmpjy0ygTVrMklQVdZIWOEjfOV+N03omHKgc5ZH
         +87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060175; x=1688652175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uKfMxnlTG/tbmuksWuOGZWrrvfs8QjlyYN4r2hnIpWo=;
        b=K1dVfzbwR0ki9CPRcKVnU7y85D217xtq4dm8uHCS0vwdV4fQtbbFcrcJtgOhMG9CDN
         jo3dePZSjO+VMwzP3a/A+TSh93qthogx4MD9c6C+WdwbpR60ZguePgFigjYqsWkwm4bx
         6GDeqw3+Xpsmf4edj8XhWebu4/+REgi9Dv0wUKkjTlp+FOfKW/f1WldKEPTs3D/I5CMA
         8qDPBNb6Vx7rYJYj2t62n1c82D932t7OKfwlsphZsXmXhnd01HLHtD/NMfAbrJ1vS9mx
         uI5wK0//T9TNR56N7TG/RtJIO7EBY1w08fTskK/ui/PnKIKXMqV6Gs+Sfyp+4GYN1ZWh
         FEdA==
X-Gm-Message-State: AC+VfDyE/XyEBo5UiT5f/XnaQd5J3se8Nsuayl1p6Oja8a7GL04Rk/0c
        ZrR0UvYR+q9LSOBt94v8V8E90Xm4dI4LYT2ioGU=
X-Google-Smtp-Source: ACHHUZ7ElSN1h6Nn2Mycq3M2NnCpSv8PBO/3dsGRn7+ApEUjV4I+bf369hsLA1VMW49PWCrORbuNPG4AeB/CJ+Hvhys=
X-Received: by 2002:a05:6808:98b:b0:398:2b78:5a53 with SMTP id
 a11-20020a056808098b00b003982b785a53mr1067410oic.40.1686060175306; Tue, 06
 Jun 2023 07:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230605183007.204399-1-hamza.mahfooz@amd.com> <20230605183007.204399-2-hamza.mahfooz@amd.com>
In-Reply-To: <20230605183007.204399-2-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Jun 2023 10:02:44 -0400
Message-ID: <CADnq5_N72yxvjVNT5jEe496J36L8x9bZKaWHZ1X6=qwMPW8_rw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: mark dml314's UseMinimumDCFCLK() as noinline_for_stack
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev, dri-devel@lists.freedesktop.org,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>,
        Jun Lei <Jun.Lei@amd.com>, Charlene Liu <Charlene.Liu@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Paul Hsieh <Paul.Hsieh@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
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

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Jun 5, 2023 at 2:30=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.com=
> wrote:
>
> clang reports:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.=
c:3892:6: error: stack frame size (2632) exceeds limit (2048) in 'dml314_Mo=
deSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>  3892 | void dml314_ModeSupportAndSystemConfigurationFull(struct display_=
mode_lib *mode_lib)
>       |      ^
> 1 error generated.
>
> So, since UseMinimumDCFCLK() consumes a lot of stack space, mark it as
> noinline_for_stack to prevent it from blowing up
> dml314_ModeSupportAndSystemConfigurationFull()'s stack size.
>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> ---
>  .../gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_3=
14.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> index 27b83162ae45..1532a7e0ed6c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_mode_vba_314.c
> @@ -7061,7 +7061,7 @@ static double CalculateUrgentLatency(
>         return ret;
>  }
>
> -static void UseMinimumDCFCLK(
> +static noinline_for_stack void UseMinimumDCFCLK(
>                 struct display_mode_lib *mode_lib,
>                 int MaxPrefetchMode,
>                 int ReorderingBytes)
> --
> 2.40.1
>
