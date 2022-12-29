Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E2658897
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 03:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232913AbiL2CQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 21:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiL2CQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 21:16:17 -0500
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com [210.131.2.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1261DDA3;
        Wed, 28 Dec 2022 18:16:14 -0800 (PST)
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 2BT2Fpok021636;
        Thu, 29 Dec 2022 11:15:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 2BT2Fpok021636
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1672280152;
        bh=GWtxrRJdBUIm6yq0K8/U3p6klj9xzTVBVsV7DOzKZF0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QJYPBdD+MmGSTemmmKrM1G5gHtD+ZPDYF2atQdgSDBxpKjUsLPQ1i9DpQYFWkvIgM
         xh0rX7Y1mzH6Jp3Er0pRf2YiL9W2GE2ZVZO9Rvnjjfya+AxWG7E0yjlO4lacdfnM18
         2YkDl2d9fDZOB+QWCWYAyxdeC219eT+r04/szvANc+MJx2vpqJIrRwy2MNpyFAmLeB
         gUEDRQBRgGt8b4uV3xCkdVdCtvQk9BL8mUZ751N/mCHHNE/QlRjeehIsSbIgVUPGm5
         IqMgmZJPIlJQQVYqM9mJjx5wguazgaD8vK3boBWSfi5PyGgj3FJzMwATdvYqUcfF/Z
         mJTgv941qoKSA==
X-Nifty-SrcIP: [209.85.160.51]
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-14fe0e9ed11so10565284fac.2;
        Wed, 28 Dec 2022 18:15:51 -0800 (PST)
X-Gm-Message-State: AFqh2krp5xoq4xdETOQDSPBp+WGWvMj1nVeEZpZhqYE1nWDM7/bzdDIN
        wBQ1DKGJW3CnRpS1ptlwRg9wgiY71tLl58fNVQ4=
X-Google-Smtp-Source: AMrXdXveOpmglT/TDzV651Q3Ej0fr/PcpDF27CDKcabWbc6YUQF9SIJ4J+s+KN2kgoOEoRtTKEpQRMctYNeAMLBpLhM=
X-Received: by 2002:a05:6870:cc89:b0:150:39e2:c688 with SMTP id
 ot9-20020a056870cc8900b0015039e2c688mr250722oab.287.1672280150856; Wed, 28
 Dec 2022 18:15:50 -0800 (PST)
MIME-Version: 1.0
References: <20221227092157.329109-1-JunASAKA@zzy040330.moe>
In-Reply-To: <20221227092157.329109-1-JunASAKA@zzy040330.moe>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 29 Dec 2022 11:15:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNATCrM06cquvMdUOQ0KCyuGYRk_G4OPO-PAPpUQsMZBVLw@mail.gmail.com>
Message-ID: <CAK7LNATCrM06cquvMdUOQ0KCyuGYRk_G4OPO-PAPpUQsMZBVLw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: add a missing line for help message
To:     Jun ASAKA <JunASAKA@zzy040330.moe>
Cc:     nathan@kernel.org, ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 6:22 PM Jun ASAKA <JunASAKA@zzy040330.moe> wrote:
>
> The help message line for building the source RPM package was missing.
> Added it.
>
> Signed-off-by: Jun ASAKA <JunASAKA@zzy040330.moe>


Applied to linux-kbuild/fixes. Thanks.


> ---
>  scripts/Makefile.package | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.package b/scripts/Makefile.package
> index 539e9f765d64..525a2820976f 100644
> --- a/scripts/Makefile.package
> +++ b/scripts/Makefile.package
> @@ -158,6 +158,7 @@ $(perf-tar-pkgs):
>  PHONY += help
>  help:
>         @echo '  rpm-pkg             - Build both source and binary RPM kernel packages'
> +       @echo '  srcrpm-pkg          - Build only the source kernel RPM package'
>         @echo '  binrpm-pkg          - Build only the binary kernel RPM package'
>         @echo '  deb-pkg             - Build both source and binary deb kernel packages'
>         @echo '  bindeb-pkg          - Build only the binary kernel deb package'
> --
> 2.31.1
>


-- 
Best Regards
Masahiro Yamada
