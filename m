Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80DE650CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 14:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiLSNol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 08:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSNoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 08:44:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF193F5B1;
        Mon, 19 Dec 2022 05:44:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09C7D60F96;
        Mon, 19 Dec 2022 13:44:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65533C433D2;
        Mon, 19 Dec 2022 13:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671457477;
        bh=8DEgaFyMiCI3pSsPns5LyeczUD+tuBdDkZplPN5MN3w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KcJTAvDOgM0317Zd/7NS68fk1vL2OhbuCdZsh3KXYOdLv37PS/qvzQrl1IElfIMde
         uyIbgGGtIn1f1JQi5upRyoyPde3NJ+X/NApt/CcAsBKcK4xDKTM/6NxNJDhiU0wHId
         gWNgRfIxDZSwZd932a6bs0r4Dpagjn14d3CtqJObUVDAeOjhbbgOsgkJsKIhD+pyat
         kirGWt5XiwM1BggeeLvovsA3atyRXN2v9umAuIORaEzgtvAiq9gkxmk6GBbOG8jdzH
         K6lfmisgPbLjUEyjjxQzgzEZBqWbEpia3l83j0Zv3H0ALhlhhNeZs4uGYQqrqtC65R
         lO4Ai5kTNbl/A==
Received: by mail-ua1-f46.google.com with SMTP id ay42so2082485uab.6;
        Mon, 19 Dec 2022 05:44:37 -0800 (PST)
X-Gm-Message-State: ANoB5pmsXQ3sUqKWV0XplVvf+lB6/yFa5ELxvOx7Ga5O62oka+Wl2Wug
        bv8uA/mUmSPOvndLrgzNRFl2sU60oa01cOAOng==
X-Google-Smtp-Source: AA0mqf6LC1L0ban3MuhHS7gUmnouWiwkw8y6mxyOu/PDQgiPs+tMBZ2XJgfnpdm8nKWdWQUXjnc8n7jH7ilawhRzDAE=
X-Received: by 2002:ab0:3a96:0:b0:419:678:cf31 with SMTP id
 r22-20020ab03a96000000b004190678cf31mr38454625uaw.63.1671457476346; Mon, 19
 Dec 2022 05:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20221207094921.15450-1-moudy.ho@mediatek.com> <20221207094921.15450-2-moudy.ho@mediatek.com>
In-Reply-To: <20221207094921.15450-2-moudy.ho@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Dec 2022 07:44:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdaVmGKSwR0yiYGKc6Kp6jki632GA6CBOOjGzUmvSRWA@mail.gmail.com>
Message-ID: <CAL_JsqKdaVmGKSwR0yiYGKc6Kp6jki632GA6CBOOjGzUmvSRWA@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] dt-bindings: arm: mediatek: mmsys: Add support for
 MT8195 VPPSYS
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 7, 2022 at 3:49 AM Moudy Ho <moudy.ho@mediatek.com> wrote:
>
> For MT8195, VPPSYS0 and VPPSYS1 are 2 display pipes with
> hardware differences in power domains, clocks and subsystem counts,
> which should be determined by compatible names.
>
> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml     | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

This landed in today's linux-next causing the following binding
warnings. Is this a fix? Only fixes for 6.2 should be added during the
merge window.

/builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.example.dtb:
clock-controller@14000000: $nodename:0: 'clock-controller@14000000'
does not match '^syscon@[0-9a-f]+$'
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
/builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.example.dtb:
clock-controller@14000000: compatible: 'oneOf' conditional failed, one
must be fixed:
        ['mediatek,mt8195-vppsys0'] is too short
        'mediatek,mt8195-vppsys0' is not one of
['mediatek,mt2701-mmsys', 'mediatek,mt2712-mmsys',
'mediatek,mt6765-mmsys', 'mediatek,mt6779-mmsys',
'mediatek,mt6795-mmsys', 'mediatek,mt6797-mmsys',
'mediatek,mt8167-mmsys', 'mediatek,mt8173-mmsys',
'mediatek,mt8183-mmsys', 'mediatek,mt8186-mmsys',
'mediatek,mt8188-vdosys0', 'mediatek,mt8192-mmsys',
'mediatek,mt8365-mmsys']
        'mediatek,mt8195-mmsys' was expected
        'mediatek,mt7623-mmsys' was expected
        From schema:
/builds/robherring/linux-dt/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
