Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A9061D887
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 08:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiKEHe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 03:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKEHe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 03:34:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9A1B1C3;
        Sat,  5 Nov 2022 00:34:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D376B81611;
        Sat,  5 Nov 2022 07:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F24C433D6;
        Sat,  5 Nov 2022 07:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667633692;
        bh=aQJtAVcp5NAThFDgMLMxcHB4FwdnINcIlh7bKws/IQg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GREa/LEXtAVXwHhD1q27JKmuZBtLwBpNZhIo7ysRX6fI+oxqqUIeZ/SXsuhpUgvPC
         RuOlwAOX8UTCGNcg4tCPQJhdwGQgtbfsaAXqCzydGfgqUEYaAPdh/87DE5zIeYvfgD
         8Tb7ysjLqntVLS8GNfwIiVnfxjeURwB8aqQA3/tuXStZoQC1ueEIMuGQGADqT99F6w
         2b97woPGDedsJjSXbb7YKUWoAl5UhDqJ3U/keuhHjYge5TRyzwJ8nZ9tZPvihmi/pe
         6uVWWZWMu5Hl6/kr/og/CKauSbF8YQd9d+s1iuTKh/c+cNQqSxmfxsWSJBxQLF0PI3
         pgRfJ/DODlNNg==
Date:   Sat, 5 Nov 2022 13:04:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: Fix UniPhier SATA controller node
 names in example
Message-ID: <Y2YSGDOXpRQ8MIoR@matsya>
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-3-hayashi.kunihiko@socionext.com>
 <20221028193859.GA2188803-robh@kernel.org>
 <0d7636f6-2c51-587d-1961-face98dfa056@socionext.com>
 <CAL_Jsq+8Rm9v4megza14JPyamV-9Yr4iAa5r+HhM6qtdHRWEBw@mail.gmail.com>
 <07155116-2027-2916-5a39-e4dff8298b27@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07155116-2027-2916-5a39-e4dff8298b27@socionext.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-22, 08:14, Kunihiko Hayashi wrote:
> On 2022/11/02 4:31, Rob Herring wrote:
> > On Tue, Nov 1, 2022 at 4:10 AM Kunihiko Hayashi
> > <hayashi.kunihiko@socionext.com> wrote:
> > > 
> > > Hi Rob,
> > > 
> > > On 2022/10/29 4:38, Rob Herring wrote:
> > > > On Thu, Oct 27, 2022 at 01:49:20PM +0900, Kunihiko Hayashi wrote:
> > > > > The word "glue" is ambiguous for the controller node name. Should put
> > > > > "sata-controller" instead of "ahci-glue" on the controller node.
> > > > > And rename a phy node to "sata-phy".
> > > > > 
> > > > > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > > > > ---
> > > > >    .../devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml  | 4
> > > > > ++--
> > > > >    1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > 
> > > > > diff --git
> > > > a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> > > > b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.yaml
> > > > > index a3cd45acea28..89b8b133777a 100644
> > > > > ---
> > > > > a/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> > > > yaml
> > > > > +++
> > > > > b/Documentation/devicetree/bindings/phy/socionext,uniphier-ahci-phy.
> > > > yaml
> > > > > @@ -117,14 +117,14 @@ additionalProperties: false
> > > > > 
> > > > >    examples:
> > > > >      - |
> > > > > -    ahci-glue@65700000 {
> > > > > +    sata-controller@65700000 {
> > > > 
> > > > But is this really the SATA controller aka AHCI?
> > > > 
> > > > In cases where we don't have a standardized name, I don't think it makes
> > > > sense changing node names from one non-standard name to another.
> > > 
> > > I see. This can't be named generic, so this change will drop.
> > > And "sata-phy" in the same way.
> > 
> > I think sata-phy is fine. It may not be added, but usb3-phy or
> > pcie-phy are common already.
> I understand. But of cource "phy" is also common, so I defer the change
> from "phy" to "sata-phy".

Should it not be just phy@xxx does it really need to be foo-phy?

-- 
~Vinod
