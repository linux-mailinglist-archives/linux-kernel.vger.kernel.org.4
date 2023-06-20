Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC437371AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjFTQcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjFTQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:31:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DBB1FE7;
        Tue, 20 Jun 2023 09:31:11 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2D5FD6600873;
        Tue, 20 Jun 2023 17:31:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687278669;
        bh=Y9tvPReig8gmKXdmzgK1D+yZ0bHJi1pX+/SYM0CaaCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vf3K1+F7Y1XW2cVGXJmAn9KJj9mP5Epmo3LI1I5+xTE73Yqh5QgptpZv5v2f/lGZf
         xh74/x7jKjp0g06k3QYw7oDfGwJT0WmnC1aPXCuXaiolPKDVbZTbaqpLv9ku/nyV5a
         Dkh3fNuZlWN872H4KcidPxRI6iufj1fBDptlXqh6lBGsRvlOzM0u9cTxN2OA5R2iFM
         eT5iL/l8x2UE3TiF++xHqLYwHgGX2iJDPp4yAcSX2RPt6IQiL9EAh3J0O2bdvgvn/v
         RF/ArBZ3zEEjzdZJPQ6jzPdzVDNB0HkYKRcXmgTwzft5LrbfGn3s04WCRclDh7Nwv5
         EwO5rEpF3MoRw==
Date:   Tue, 20 Jun 2023 12:31:02 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 3/6] media: dt-bindings: mediatek,vcodec: Remove
 VDEC_SYS for mt8183
Message-ID: <6b41c5e4-bae9-4c99-8a28-7272c8a598a3@notapiano>
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-4-nfraprado@collabora.com>
 <8b5e4a9b-7496-02a1-d3b6-a0be8ea85798@linaro.org>
 <a82b7f2d-04d4-4ac0-9a72-ad1c17118e19@notapiano>
 <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb2dd67a-d3df-f194-6595-789d12b38f3d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:00:00PM +0200, Krzysztof Kozlowski wrote:
> On 20/06/2023 14:46, Nícolas F. R. A. Prado wrote:
> > On Tue, Jun 20, 2023 at 10:12:14AM +0200, Krzysztof Kozlowski wrote:
> >> On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
> >>> The binding expects the first register space to be VDEC_SYS. But on
> >>> mt8183, which uses the stateless decoders, this space is used only for
> >>> controlling clocks and resets, which are better described as separate
> >>> clock-controller and reset-controller nodes.
> >>>
> >>> In fact, in mt8173's devicetree there are already such separate
> >>> clock-controller nodes, which cause duplicate addresses between the
> >>> vdecsys node and the vcodec node. But for this SoC, since the stateful
> >>> decoder code makes other uses of the VDEC_SYS register space, it's not
> >>> straightforward to remove it.
> >>>
> >>> In order to avoid the same address conflict to happen on mt8183,
> >>> since the only current use of the VDEC_SYS register space in
> >>> the driver is to read the status of a hardware controlled clock, remove
> >>> the VDEC_SYS register space from the binding and describe an extra
> >>> syscon that will be used to directly check the hardware status.
> >>>
> >>> Also add reg-names to be able to tell that this new register schema is
> >>> used, so the driver can keep backward compatibility.
> >>>
> >>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> >>>
> >>> ---
> >>> I dropped the tags from this commit since a syscon is now used instead
> >>> of an extra clock.
> >>>
> >>> Changes in v3:
> >>> - Removed the active clock
> >>> - Added a mediatek,vdecsys syscon property
> >>>
> >>> Changes in v2:
> >>> - Merged with patch 1 (media: dt-bindings: mediatek,vcodec: Allow single
> >>>   clock for mt8183) to avoid changing number of clocks twice
> >>> - Added maxItems to reg-names
> >>> - Constrained clocks for each compatible
> >>> - Reordered properties for each compatible
> >>>
> >>>  .../media/mediatek,vcodec-decoder.yaml        | 30 +++++++++++++++++++
> >>>  1 file changed, 30 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>> index 1e56ece44aee..2f625c50bbfe 100644
> >>> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> >>> @@ -21,8 +21,13 @@ properties:
> >>>        - mediatek,mt8183-vcodec-dec
> >>>  
> >>>    reg:
> >>> +    minItems: 11
> >>>      maxItems: 12
> >>>  
> >>> +  reg-names:
> >>> +    minItems: 11
> >>> +    maxItems: 11
> >>
> >> maxItems: 12
> >>
> >>> +
> >>>    interrupts:
> >>>      maxItems: 1
> >>>  
> >>> @@ -60,6 +65,10 @@ properties:
> >>>      description:
> >>>        Describes point to scp.
> >>>  
> >>> +  mediatek,vdecsys:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: Phandle to the vdecsys syscon node.
> >>> +
> >>>  required:
> >>>    - compatible
> >>>    - reg
> >>> @@ -79,8 +88,26 @@ allOf:
> >>>      then:
> >>>        required:
> >>>          - mediatek,scp
> >>> +        - mediatek,vdecsys
> >>>  
> >>>        properties:
> >>> +        reg:
> >>> +          maxItems: 11
> >>> +
> >>> +        reg-names:
> >>> +          items:
> >>> +            - const: misc
> >>> +            - const: ld
> >>> +            - const: top
> >>> +            - const: cm
> >>> +            - const: ad
> >>> +            - const: av
> >>> +            - const: pp
> >>> +            - const: hwd
> >>> +            - const: hwq
> >>> +            - const: hwb
> >>> +            - const: hwg
> >>> +
> >>>          clocks:
> >>>            minItems: 1
> >>>            maxItems: 1
> >>> @@ -101,6 +128,9 @@ allOf:
> >>>          - mediatek,vpu
> >>>  
> >>>        properties:
> >>> +        reg:
> >>> +          minItems: 12
> >>
> >>
> >> What about reg-names here? They should be also defined and in sync with
> >> regs.
> > 
> > That's intentional. As described in the commit message, mt8173 will keep having
> > the VDEC_SYS iospace, while mt8183 won't. And we use the presence of reg-names
> > to tell them apart.
> > 
> > So, mt8173 has 12 regs, no reg-names and no syscon, while mt8183 has 11 regs,
> > with reg-names and the syscon.
> 
> reg-names is not the way to tell apart variants. Compatible is. If you
> add reg-names for one variant, it's expected to have it defined for
> other as well, because the order of items in reg is always fixed.

But differentiating with compatible in this case would be wrong, since it's not
not something inherent to the SoC. We really just want to be able to tell
whether the vdecsys iospace is supplied as a reg or as a syscon.

This series focuses on getting the mt8183 decoder working, and as part of that
introduces the binding and DT node for mt8183 with vdecsys as a syscon instead
of a reg, to avoid introducing new 'duplicate unit-address' DT warnings.

But in a separate series we could drop vdecsys from mt8173's reg as well,
passing it as a syscon instead, which would solve the warning on that platform,
though some more driver changes would be needed to be able to handle it for that
SoC. The newer SoCs like mt8192, mt8195, etc, should also get vdecsys dropped
from their regs to have a correct memory description.

Thanks,
Nícolas
