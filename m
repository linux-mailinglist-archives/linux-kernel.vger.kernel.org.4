Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAB7E616C1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbiKBS0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKBS0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:26:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623CB2F3B7;
        Wed,  2 Nov 2022 11:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10042B82432;
        Wed,  2 Nov 2022 18:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A64C433B5;
        Wed,  2 Nov 2022 18:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667413575;
        bh=0OnF8htTtPrhW90XoJmnZ9HiTpzXeY8j4Qxh7eEPkcM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=J5jL15/ZggiB//3835TMN3jw4jGvTN1hbV83U0GggX7zajZoFFU3MaXHAncNCHZNP
         uYCl/DjFc3ueFj3RhLeg5yKAiHyZAIXA7kwOf4DeHEeJOoYgI8Pk9hAb9IJEfJq2r7
         96HucyLcPfdqfGCGYrBjouQ6xrquHVYLpnSPMOBKyhYSVyx9llOSWj/61PZn484DTW
         VSwYiS+w8J4+5jVBCFdF20YcJwJrEN/WGwnEL0YhdYZ7c/gA0XmMzo5I4y4+ni3Bt6
         oJCoxJYW3+gTkcq70+PQoTDVQd23r279Ag2a+vHYnlnTTM6j3lkcfbyGBEkpFzNuH2
         Clg5RWQwjeWfQ==
Received: by mail-lf1-f46.google.com with SMTP id b2so29600586lfp.6;
        Wed, 02 Nov 2022 11:26:15 -0700 (PDT)
X-Gm-Message-State: ACrzQf2Wm77KXoDxcwtGWj8qAZZtfR0sqB719nVd5c9yoiO6gVCo79JP
        M1jifYn2UWzQzenPycVUDUYiCR6myG7MfHKpiQ==
X-Google-Smtp-Source: AMsMyM7kjGNrP3+8CtQwqjr4zosxnOmrv8yYX7CqgC43OsFofOIvtBA61DXFtaoqkMCrosPPhD7KyRmyDY2H7UVJfF0=
X-Received: by 2002:a19:f24b:0:b0:4ab:cd12:d282 with SMTP id
 d11-20020a19f24b000000b004abcd12d282mr10160512lfk.74.1667413573707; Wed, 02
 Nov 2022 11:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <136157bd1f94c64504f87ee2db6b3ed0a8dcc3de.1667254476.git.daniel@makrotopia.org>
 <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
In-Reply-To: <1216e96b279d08230cb2aa61d536f44c1e9b800a.1667254476.git.daniel@makrotopia.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Nov 2022 13:26:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBtgXYFqkMmUxp6W0S45KxecVo+Qp261b2-7L7bOJDAw@mail.gmail.com>
Message-ID: <CAL_JsqKBtgXYFqkMmUxp6W0S45KxecVo+Qp261b2-7L7bOJDAw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: thermal: mediatek: add compatible string
 for MT7986 SoC
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 6:08 PM Daniel Golle <daniel@makrotopia.org> wrote:
>
> Add compatible string 'mediatek,mt7986-thermal' for V3 thermal unit
> found in MT7981 and MT7986 SoCs.
>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/thermal/mediatek-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)

Resending as the reply headers got lost...

Acked-by: Rob Herring <robh@kernel.org>
