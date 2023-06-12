Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C8F72C311
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:38:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjFLLi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjFLLiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DC57ECB;
        Mon, 12 Jun 2023 04:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA4562329;
        Mon, 12 Jun 2023 11:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C6AC433EF;
        Mon, 12 Jun 2023 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686569117;
        bh=AylYKz5Z99jz+F3tMEG1x371NWVG8E1nIblqJLlQs3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jmMFa5EoQxd70BuRNFuGA2Wy09A/A9CAmB5iaZ8KW7L8Oualj28Dh9AB5NGck+oLI
         AwjxWZZ/sZYLU31BmFDBGF73zKJ/QeiCButNzDaHDRWE2xNyOrIs5dG4QisC+ek7UY
         EiQqPL9dh9tXGiFKCLyWXK4jgAm3gY7kpvfIc0BwisWOizDXYyqmtiv1Wjx8iN1bX5
         3WnFceOhD3GTQGa6qkIPxvrnNgyAYn0ll5QDbGWZgwgakK1hXS98FaxiSyVKw5kzhA
         QPq+mLT6SpmPj3jcINRg5ebG3SL2CUrTS6Z9Y0tUEWbTzNvMGRg8v0quI4tlys5PQx
         Nl6KCL3Pxq+Xg==
Date:   Mon, 12 Jun 2023 12:25:10 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: mfd: gateworks-gsc: remove
 unnecessary fan-controller nodes
Message-ID: <20230612112510.GO3635807@google.com>
References: <20230522193219.1477158-1-tharvey@gateworks.com>
 <20230609160008.GA1132019-robh@kernel.org>
 <CAJ+vNU2w+eU=SGROpyWtkBhdqo+M4XDe9m9FecEeXT=dbEr6rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+vNU2w+eU=SGROpyWtkBhdqo+M4XDe9m9FecEeXT=dbEr6rw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Tim Harvey wrote:

> On Fri, Jun 9, 2023 at 9:00 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Mon, May 22, 2023 at 12:32:16PM -0700, Tim Harvey wrote:
> > > Remove the unnecessary #address-cells and #size-cells nodes from
> > > the fan-controller. These are not needed as the fan controller does not
> > > have any children.
> > >
> > > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > ---
> > > v2:
> > >  - udpated commit log to explain why the nodes are unnessesary
> > >  - added Krzysztof's rb tag
> > >  - added Connor's ab tag
> > > ---
> > >  .../devicetree/bindings/mfd/gateworks-gsc.yaml         | 10 ----------
> > >  1 file changed, 10 deletions(-)
> >
> > This is not going to get applied if you don't send it to Lee.
> 
> Lee,
> 
> Sorry, I missed adding you to this thread. Can you pick it up or do
> you need me to re-send to the list and you?

I need you to resend it please.

-- 
Lee Jones [李琼斯]
