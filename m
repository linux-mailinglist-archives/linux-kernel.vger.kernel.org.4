Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B6267C2AA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjAZCJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjAZCJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:09:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE1AD33
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 937E5B81CBE
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 501B5C433EF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 02:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674698946;
        bh=gbmwm4PALV1z69m1RXQJ0PfTbkkFU9DVnIv66xOuuS4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FGJ39MqofR1OSwQYDV3SoMLCUi0T0li2skG8KmKuM32FIQY0I/A0LvRoUtN7u7Xam
         yIAwqO57Qxo53A3jGq8rxlqC1/ZbCBwyxQSUVi6hQCDMyL09npyvUDIsFsyU0EaVx+
         S+DkelEjmTzxu3czlZAOH9KYVMyVWTtvzGoGx0pCfppKEXHH1Sq/kWanSNq2SpDmxl
         XcHvMDhA03yaxolDsZgy5+TvAyYAxn80W8o6QUloeOUWtF/9eNIP+G8d1uduJX9lFs
         d72JmXi7Pv/vnMwsP69T28zBrIQDIxG4mSk+lmauKfVJxRQKOiK83SWsT96RmWJy0r
         INWbtLqdAc+xQ==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-15f97c478a8so805135fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:09:06 -0800 (PST)
X-Gm-Message-State: AFqh2krKhpdvB7axSrgb3gg7IulNUlrpiRh0xJFUl3912muZHs24qgFZ
        NIDm9BSoFFC2MCvYOmF0RVuvWEWvXzkVwlXVhTM=
X-Google-Smtp-Source: AK7set9bqyZZ5MamULoifU8oWT5GTtgyAuTZM7h1L7UEXKGsGAMAFZygZp57gobAg3Wh7Mi0dWMZ8jisi1q6iyAPVO0=
X-Received: by 2002:a05:6870:110f:b0:160:3296:a9b9 with SMTP id
 15-20020a056870110f00b001603296a9b9mr819617oaf.287.1674698945586; Wed, 25 Jan
 2023 18:09:05 -0800 (PST)
MIME-Version: 1.0
References: <20230125183047.2679976-1-cmllamas@google.com>
In-Reply-To: <20230125183047.2679976-1-cmllamas@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 26 Jan 2023 11:08:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASafoetm5jGjwODKr6S_42mkzSSxGRE4ehV8F0VYRr8mg@mail.gmail.com>
Message-ID: <CAK7LNASafoetm5jGjwODKr6S_42mkzSSxGRE4ehV8F0VYRr8mg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix trivial typo in comment
To:     Carlos Llamas <cmllamas@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 3:30 AM Carlos Llamas <cmllamas@google.com> wrote:
>
> Add missing underscore in CONFIG_DEBUG_INFO_BTF_MODULES.
>
> Fixes: f73edc8951b2 ("kbuild: unify two modpost invocations")
> Signed-off-by: Carlos Llamas <cmllamas@google.com>

Applied to linux-kbuild. Thanks.



> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c1ead4cd2342..561cf98f6889 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1542,7 +1542,7 @@ endif
>  # Build modules
>  #
>
> -# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFOBTF_MODULES
> +# *.ko are usually independent of vmlinux, but CONFIG_DEBUG_INFO_BTF_MODULES
>  # is an exception.
>  ifdef CONFIG_DEBUG_INFO_BTF_MODULES
>  KBUILD_BUILTIN := 1
> --
> 2.39.1.456.gfc5497dd1b-goog
>


-- 
Best Regards
Masahiro Yamada
