Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE657618056
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 16:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiKCPBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 11:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbiKCPBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 11:01:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A367119018;
        Thu,  3 Nov 2022 08:01:12 -0700 (PDT)
Received: from notapiano (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5B43666015E4;
        Thu,  3 Nov 2022 15:01:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667487671;
        bh=7vKOiE8wMEV5ju2Qh06ih4W5UBAdst8hPFwPgPbs+Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSSFzAqsTQk1ylbCV+Ttj7valctGzE1nFG8epl/mDXTJvo/BrY5DGyTbM4liGPYiq
         oTVtwl557jKYxegPcjzNCdSij8DZ3Ipunl1YHj8qMHuN8mfJKbQyxciN0pDwEev4Kc
         WUU3ftqq9PZ5zdjTeSlRhB7ZSEObI4uG+QZtBvF+d8borG6xMXndtXd9o06E6x22K9
         NnWMZD20fNV8q68NdQdpNyaIfShwEYlwuZFZOdephumWEmZazXmOdWUiswsRNcvQ4p
         2F1FkouwOWNZor7D5HU27QDjeXAv7ejNb4CADLziBWNcjkjV3nQQn76wRdeTwTlkRo
         p5zjlRmlu2nXA==
Date:   Thu, 3 Nov 2022 11:01:06 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] docs: dt: writing-schema: Document usage of CHECK_DTBS
 make flag
Message-ID: <20221103150106.sjubfjs2xt33dvhu@notapiano>
References: <20221102214300.309347-1-nfraprado@collabora.com>
 <cbeb2bdc-4a36-1f9a-e28f-842773b6a161@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbeb2bdc-4a36-1f9a-e28f-842773b6a161@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 10:19:15AM +0100, AngeloGioacchino Del Regno wrote:
> Il 02/11/22 22:43, Nícolas F. R. A. Prado ha scritto:
> > It is possible to run checks on a Devicetree by passing the CHECK_DTBS
> > flag when building. This is a useful shortcut to the dtbs_check make
> > target since it avoids checking unrelated Devicetrees, which can take
> > some time and is unnecessary if no bindings were modified. Document it.
> > 
> > Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> >  > ---
> > 
> >   Documentation/devicetree/bindings/writing-schema.rst | 7 +++++++
> >   1 file changed, 7 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/writing-schema.rst b/Documentation/devicetree/bindings/writing-schema.rst
> > index 4a381d20f2b4..55ad556472b4 100644
> > --- a/Documentation/devicetree/bindings/writing-schema.rst
> > +++ b/Documentation/devicetree/bindings/writing-schema.rst
> > @@ -167,6 +167,13 @@ setting the ``DT_SCHEMA_FILES`` variable to a specific schema file or pattern.
> >       make dt_binding_check DT_SCHEMA_FILES=/gpio/
> >       make dtbs_check DT_SCHEMA_FILES=trivial-devices.yaml
> > +Note that ``make dtbs_check`` will validate every DT source file that is
> 
> "Note that xxxx" looks a bit repeated... read:
> 
> Note that ``dtbs_check`` will skip any binding schema files with errors.
> (etc etc)
> 
> Note that ``make dtbs_check`` will validate every DT source file ...
> (etc etc)
> 
> Perhaps we can change the first paragraph saying
> "In order to perform validation of DT source files, use..."
> to something like:
> 
> In order to perform validation of all DT source files, use the ``dtbs_check``
> target, or set the ``CHECK_DTBS`` variable to ``y`` when building specific DTs::
> 
> ::
> 
>     make dtbs_check
>     make CHECK_DTBS=y mediatek/mt8192-evb.dtb
> 
> Any opinion?

Something to keep in mind is that the purpose of this section is to describe how
to validate binding changes (both on the binding itself and in the DTs that use
them). For this, people really should be using dtbs_check since otherwise a new
warning might be missed. Using CHECK_DTBS is more suitable for a different use
case, which is to validate some dtbs without having changed the bindings, which
is why I added it at the end of the section more as a side note. For this
reason I think it's better to keep them separate.

About repeating the "Note that", that could just be changed for "It's worth
noting that" or something similar.

Thanks,
Nícolas
