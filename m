Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C23B6DDDF6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjDKOa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjDKOaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:30:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB8B5FC0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:30:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E189B6207A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F53CC4339C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 14:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223389;
        bh=oRtlk8LT4FpUc9TOFP7hROtBJDxDkthmceKlxjAhDrA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o+VzgWsTJ73g38G/weVfHHQOf/V+TulRAOsIae1f2bxTYSBXh6WD3rbQHc9gFgiyT
         h7ILUovsEeNNiDmzPx8Y0B1ugAWCd/feiD5eoBCAc7PRFKhpP9le0BdwMVv9h0v1UC
         5CSAIQafwS1pneRAJRpJ4ZPbSuwIWcE5X0Xd30FIN/hwTrlEl+9Lu87i0Ou9d7qVsz
         YG8hlR1XCKV7lCdBk5B9g0V+6TPhpr2BlJ1Xp7ssNfBCaydJXQSOO9tE3Nsu4nj+fN
         u6c6rvSjWIA25UoNwDREQ+aE58TIctiata2+NQ5KoUgncmCdWNz60yb7NYL3gOdtji
         7q/ggy9fUrgYA==
Received: by mail-yb1-f172.google.com with SMTP id i20so12004002ybg.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:29:49 -0700 (PDT)
X-Gm-Message-State: AAQBX9dNzoxRAgmr0ejTyboxXjO1MVVrpWPeyUxyBsKIQ2DGVaHYPhMi
        atYwwqIF7BMjxeCyrG1XrjJFH2Gb4Da9QIAQ1Q==
X-Google-Smtp-Source: AKy350ZWF9QoPnZe5fkVAVq9TNHFUxTfDhlE9sfRtyCNrPk7Re7KFQBQB0yqKxIQcnCTmWieCyJZ26WuwmT4zlrZG4E=
X-Received: by 2002:a25:3086:0:b0:b78:1b26:a642 with SMTP id
 w128-20020a253086000000b00b781b26a642mr5568593ybw.1.1681223388367; Tue, 11
 Apr 2023 07:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
In-Reply-To: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Apr 2023 09:29:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
Message-ID: <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: introduce proper bindings license check
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

On Tue, Apr 4, 2023 at 2:17=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevice=
s.ru> wrote:
>
> All headers from 'include/dt-bindings/' must be verified by checkpatch
> together with Documentation bindings, because all of them are part of
> the whole DT bindings system.
>
> The requirement is dual licensed and matching patterns:
> * Schemas:
>     /GPL-2\.0(?:-only)? OR BSD-2-Clause/
> * Headers:
>     /GPL-2\.0(?:-only)? OR \S+/
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
> Changes v5 since v4 at [4]:
>     - only capital OR is acceptable for SPDX per Rob's suggestion
>
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
>     [4] https://lore.kernel.org/all/20230331121017.14324-1-ddrokosov@sber=
devices.ru/
> ---
>  scripts/checkpatch.pl | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
