Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B0C5B587C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiILKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiILKc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:32:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD6EEC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:32:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b35so12094238edf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=pa6W1YODU5uWUjf7zUhRw95uZp1QNrawRSVyyiW7Vl0=;
        b=RbzFH4Z4USAJQAYUrNqiIlm2Ou3paeEKXx7EA6MqxzRIeMg5OYjW7hnVzCRokjI8Uh
         UlSugb4mjNXVJA3f+6Stg4HhjA1g6w4rzssqcy+trVOXpReT/SWY/DhL00wgMFauBPY4
         +9KqJAYCJwyhtrWvNCzGEsoSLnpJdz1zmnzBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pa6W1YODU5uWUjf7zUhRw95uZp1QNrawRSVyyiW7Vl0=;
        b=coScyrooYXHcvxaEzCf64nXQcGtczuVhNYtGJwMgldFxsrfyWk/0q5xFsjrAepobfs
         VclK/A5LZQDkodDvW7EuM8OPiqM/SCU9b00PTuBBl/0ED2tyV9KVcg6DL95k2yPY84Kh
         NOxwQPtDY+y+kV7WQyIs2UIyxzehvua18Ur7GPiLDboL4HbDhDGHgdqnHyGc4j+GMVL3
         o3zh2qti/PpsnQZFF/QmZtO3nZrdYFTWcCijJXmS/IG43bDC3mngmbgbzvor33ATA8da
         I6qJAAeBuhKSM4UANwEKWLAFrlMTEoZ6F2SN+bkv0YQd5bt2GXDK6lrv5yP+Y8BGeV57
         tJCA==
X-Gm-Message-State: ACgBeo1WhUvTrknNIo06FVNJwDN9/FOwj0ZjhGUlyPHVHx+FIyeAKD3n
        nE9go9RZCV/OG803xLkmM1wlOvOWqw/1gcbPjq+oKg==
X-Google-Smtp-Source: AA6agR4M8kUfW+1+K71sRAnTB0B7zC1boeAgnNmeFDTIx6IxH5frVa+UGb0pWsh9PfgPzIod9Cpy0WGwITz9nMf2SRs=
X-Received: by 2002:a05:6402:890:b0:44e:bb54:7f54 with SMTP id
 e16-20020a056402089000b0044ebb547f54mr22112611edy.307.1662978777293; Mon, 12
 Sep 2022 03:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220908171153.670762-1-nfraprado@collabora.com>
In-Reply-To: <20220908171153.670762-1-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 12 Sep 2022 18:32:46 +0800
Message-ID: <CAGXv+5ERm1kXf+YgeDMOgkEY77Fx1o8FK=anWn22g7SAGXSfhw@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: mediatek: asurada: Enable internal display
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 1:11 AM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
>
> This series adds and enables all components required to have a working
> internal display on the Asurada platform.
>
>
> N=C3=ADcolas F. R. A. Prado (3):
>   arm64: dts: mediatek: asurada: Add display regulators
>   arm64: dts: mediatek: asurada: Add display backlight
>   arm64: dts: mediatek: asurada: Enable internal display

Tested-by: Chen-Yu Tsai <wenst@chromium.org>

Tested _remotely_ on Hayato, with EDID read back correctly.
