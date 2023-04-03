Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59566D54AA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjDCWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjDCWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:20:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE512D7D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B357562741
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21546C433D2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680560445;
        bh=Znl+o7+V3blz+454tt9G84k6gelZDHGJ2xEVfVPeQJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eYhS4lJhDkh1Oc6Be21g6mAh2jJv4BHMJcLumQ+ljyf/orX6D4PvFGHN7qs3VCVdB
         xvm4WV0Cf5wI33oENlOqpqwDZirPtzHMZwfrUWdT/pjhpt9RJbR1sRDR+lnac9sLdV
         3htFMWvxACXsneJYvODpVTd+mm/UpeQNmYwkl/4vP1Cx2pMXK1TCYDoXtY1y4bKP3F
         TIB7HO6II/hoW0b+x9d9Q9Qx+wExSwk0V3TTlL9ESXo/Z7qGOOB4BQ/WdsGjkMFJu5
         gM6kmYiHiABlRaqKfbnVoLE6pABpAuUG3Nr8NsSo81o6jrkK/AhKNl5Sz+fIUSJCqU
         At1E/bursvxsg==
Received: by mail-yb1-f169.google.com with SMTP id p203so36589051ybb.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:20:45 -0700 (PDT)
X-Gm-Message-State: AAQBX9fievasXLd0ychQl5VCNraV/tkJUU2L1HvcvDdIbZnYIIhv/Xp1
        iVPVm1bH/XxUoW5SGh2XMzVPkzCxDPyLlNtLNg==
X-Google-Smtp-Source: AKy350bdrdODBgAFy2ECnofNnQMtuVMRBHx5f1gKv/lbY/PPmjRR9uEaRxRggriooyOPRQG3cvEOrwEoVhE/EQYv7no=
X-Received: by 2002:a25:d8c9:0:b0:b75:3fd4:1b31 with SMTP id
 p192-20020a25d8c9000000b00b753fd41b31mr530276ybg.1.1680560444115; Mon, 03 Apr
 2023 15:20:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230331121017.14324-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20230331121017.14324-1-ddrokosov@sberdevices.ru>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 3 Apr 2023 17:20:32 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLcEYHXTcNQFzycLBMHM2we5-a6Ju4_kZa2o=Z1u7gSjw@mail.gmail.com>
Message-ID: <CAL_JsqLcEYHXTcNQFzycLBMHM2we5-a6Ju4_kZa2o=Z1u7gSjw@mail.gmail.com>
Subject: Re: [PATCH v4] checkpatch: introduce proper bindings license check
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     krzysztof.kozlowski@linaro.org, apw@canonical.com, joe@perches.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 7:10=E2=80=AFAM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
>
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
>
> The requirement is dual licensed and matching patterns:
> * Schemas:
>     /GPL-2\.0(?:-only)? (?:OR|or) BSD-2-Clause/
> * Headers:
>     /GPL-2\.0(?:-only)? (?:OR|or) \S+/
>
> Above patterns suggested by Rob at:
> https://lore.kernel.org/all/CAL_Jsq+-YJsBO+LuPJ=3DZQ=3Deb-monrwzuCppvReH+=
af7hYZzNaQ@mail.gmail.com
>
> The issue was found during patch review:
> https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.=
ru/
>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
> Changes v4 since v3 at [3]:
>     - introduce separate pattern for dt-bindings headers following Rob's
>       suggestion
>
> Changes v3 since v2 at [2]:
>     - replace 'not =3D~' expression with '!~' to be aligned with other
>       checkpatch lines
>
> Changes v2 since v1 at [1]:
>     - include/dt-bindings check is aligned to open parens
>     - introduce more strict pattern for bindings license:
>       /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
>
> Links:
>     [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sber=
devices.ru/
>     [2] https://lore.kernel.org/all/20230320100027.27788-1-ddrokosov@sber=
devices.ru/
>     [3] https://lore.kernel.org/all/20230320203350.13696-1-ddrokosov@sber=
devices.ru/
> ---
>  scripts/checkpatch.pl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 78cc595b98ce..31f49bbe5458 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3710,7 +3710,7 @@ sub process {
>                                                      "'$spdx_license' is =
not supported in LICENSES/...\n" . $herecurr);
>                                         }
>                                         if ($realfile =3D~ m@^Documentati=
on/devicetree/bindings/@ &&
> -                                           not $spdx_license =3D~ /GPL-2=
\.0.*BSD-2-Clause/) {
> +                                           $spdx_license !~ /GPL-2\.0(?:=
-only)? (?:OR|or) BSD-2-Clause/) {

I think SPDX expects capital OR only. Even if not, I don't think we
need to allow either.

>                                                 my $msg_level =3D \&WARN;
>                                                 $msg_level =3D \&CHK if (=
$file);
>                                                 if (&{$msg_level}("SPDX_L=
ICENSE_TAG",
> @@ -3720,6 +3720,11 @@ sub process {
>                                                         $fixed[$fixlinenr=
] =3D~ s/SPDX-License-Identifier: .*/SPDX-License-Identifier: (GPL-2.0-only=
 OR BSD-2-Clause)/;
>                                                 }
>                                         }
> +                                       if ($realfile =3D~ m@^include/dt-=
bindings/@ &&
> +                                           $spdx_license !~ /GPL-2\.0(?:=
-only)? (?:OR|or) \S+/) {
> +                                               WARN("SPDX_LICENSE_TAG",
> +                                                    "DT binding headers =
should be licensed (GPL-2.0-only OR .*)\n" . $herecurr);
> +                                       }
>                                 }
>                         }
>                 }
> --
> 2.36.0
>
