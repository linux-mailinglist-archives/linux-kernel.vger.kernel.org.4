Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD55A726A3C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 21:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjFGT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 15:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjFGT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 15:58:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441DA19AC;
        Wed,  7 Jun 2023 12:58:43 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73E3E6600014;
        Wed,  7 Jun 2023 20:58:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686167921;
        bh=V4aYOfdlmGNGL6oFKj3asBG3FW4Opmc6t8Sp4HBQiyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JZrn2ezwA9qngagBGLJ1UosmKAQnL+vYAWdNsH5eOHqq0/FEOuo67Rf1Tzu7zZnrs
         w0O7sCdDl7KZwkpgVHHvv1PJKb4GU12GLvdKNPzG9eKJHE9wj3hX+W5E8yYpEFQBuf
         TZHhPeFnM1ITGi+R7TaGfzcLmCEYvMLB0ETB3u8+ewtPz3QvAs6sNcuJvRY1Jc+GnG
         fbtkDDtxSugUvFqyG19BAcByG+Q/KANA0Zlo0ea8fknVDRmnOq4qBXs9MUErpanxdX
         ZsvO7/wxa2Qi00y2onNitgvQypYqZ6lt3HSEF6ZqHlbpe2nnzKMkPwGLo94bqOIY9n
         kOjdX61pWjjig==
Date:   Wed, 7 Jun 2023 15:58:34 -0400
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
Subject: Re: [PATCH 3/6] media: dt-bindings: mediatek,vcodec: Remove VDEC_SYS
 for mt8183
Message-ID: <d768f124-dcee-40c7-a5e8-f1c41439119e@notapiano>
References: <20230605162030.274395-1-nfraprado@collabora.com>
 <20230605162030.274395-4-nfraprado@collabora.com>
 <6d476d6d-7100-7674-2e08-661516b75f43@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d476d6d-7100-7674-2e08-661516b75f43@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 11:16:12AM +0200, Krzysztof Kozlowski wrote:
> On 05/06/2023 18:20, Nícolas F. R. A. Prado wrote:
> > The binding expects the first register space to be VDEC_SYS. But on
> > mt8183, which uses the stateless decoders, this space is used only for
> > controlling clocks and resets, which are better described as separate
> > clock-controller and reset-controller nodes.
> > 
> > In fact, in mt8173's devicetree there are already such separate
> > clock-controller nodes, which cause duplicate addresses between the
> > vdecsys node and the vcodec node. But for this SoC, since the stateful
> > decoder code makes other uses of the VDEC_SYS register space, it's not
> > straightforward to remove it.
> > 
> > In order to avoid the same address conflict to happen on mt8183,
> > since the only current use of the VDEC_SYS register space in
> > the driver is to read the status of a clock that indicates the hardware
> > is active, remove the VDEC_SYS register space from the binding and
> > describe an extra clock that will be used to directly check the hardware
> > status.
> > 
> > Also add reg-names to be able to tell that this new register schema is
> > used, so the driver can keep backward compatibility.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > ---
> > 
> >  .../media/mediatek,vcodec-decoder.yaml        | 29 +++++++++++++++++--
> >  1 file changed, 27 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> > index 6447e6c86f29..36a53b2484d6 100644
> > --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> > +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> > @@ -21,17 +21,21 @@ properties:
> >        - mediatek,mt8183-vcodec-dec
> >  
> >    reg:
> > +    minItems: 11
> >      maxItems: 12
> >  
> > +  reg-names:
> > +    minItems: 11
> 
> maxItems
> 
> > +
> >    interrupts:
> >      maxItems: 1
> >  
> >    clocks:
> > -    minItems: 1
> > +    minItems: 2
> 
> It does not make any sense. Just two patches ago you made it 1! Don't
> add incorrect values which are immediately changed in the same patchset.

It's not an incorrect value. At the point that commit was added, the first reg
was still VDEC_SYS, so an active clock wasn't required. This commit removes the
VDEC_SYS reg, and so the active clock becomes necessary. Splitting it like this
made the most sense to me, and I thought it would also simplify review. But
since it seems to be a problem I'll merge commit 1 with this one in v2 to avoid
changing the number of clocks twice.

> 
> >      maxItems: 8
> >  
> >    clock-names:
> > -    minItems: 1
> > +    minItems: 2
> >      maxItems: 8
> >  
> >    assigned-clocks: true
> > @@ -84,6 +88,24 @@ allOf:
> >          clock-names:
> >            items:
> >              - const: vdec
> > +            - const: active
> > +
> > +        reg:
> > +          maxItems: 11
> > +
> > +        reg-names:
> > +          items:
> > +            - const: misc
> > +            - const: ld
> > +            - const: top
> > +            - const: cm
> > +            - const: ad
> > +            - const: av
> > +            - const: pp
> > +            - const: hwd
> > +            - const: hwq
> > +            - const: hwb
> > +            - const: hwg
> >  
> >    - if:
> >        properties:
> > @@ -108,6 +130,9 @@ allOf:
> >              - const: venc_lt_sel
> >              - const: vdec_bus_clk_src
> >  
> > +        reg:
> > +          minItems: 12
> 
> so max can be 1000?

No, there's 'maxItems: 12' up above in the general case.

Thanks,
Nícolas
