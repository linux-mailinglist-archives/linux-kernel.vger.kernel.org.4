Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6902F5BE174
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 11:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiITJLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiITJLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 05:11:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091D41D5;
        Tue, 20 Sep 2022 02:11:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9682761CEB;
        Tue, 20 Sep 2022 09:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93CBC43141;
        Tue, 20 Sep 2022 09:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663665062;
        bh=vgp1hqroueELOf0HkLsZXn6WvdIxgVzLklJz+ZBpoRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2vx/1BZEUEFyHcXFU0FOb4XiQwvOA9C3kxkqTvhol6D3Dj2WCFT2hRw3rxT9fj26
         v4NgQJKpCYQZiGa3lbvChp+TgXs35AIHxGd6Cwzib/CpKzxNj0DKARW1/l49dfO1bT
         M/iAUidqdDNkcFSUpsjKdQ/OiENvWCIHTHGt5sunwdzIm5cNJhx8iS74LOfDtP5pD0
         3XpS3RLIgaS/fnNB9sZce+KOboB2MLHWA+dn7dms+6BtY/QG2YKEW4yt+X5om4dRkB
         PyDFBrfeioCDPIFNaTDqdWk4qVAElgNc28I/g/+9vun4fbV31RYwQzXmopaPBpHDZm
         At+3+uUzs5ZnQ==
Date:   Tue, 20 Sep 2022 10:10:55 +0100
From:   Lee Jones <lee@kernel.org>
To:     Matthias Brugger <mbrugger@suse.com>
Cc:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Message-ID: <YymDn+ZEIFUqpIEb@google.com>
References: <20220830091110.27857-1-matthias.bgg@kernel.org>
 <YxnGBN4QEb1yMrGw@google.com>
 <336cb80f-8f58-92ba-aa92-1bb57a75f0fb@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <336cb80f-8f58-92ba-aa92-1bb57a75f0fb@suse.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022, Matthias Brugger wrote:
> On 08/09/2022 12:37, Lee Jones wrote:
> > On Tue, 30 Aug 2022, matthias.bgg@kernel.org wrote:
> > 
> > > From: Matthias Brugger <mbrugger@suse.com>
> > > 
> > > The file describes the scpsys node for all SoCs and not only the mt8195.
> > > Rename it to reflect this fact.
> > 
> > Actually, this is fairly typical.  Same with actual drivers.
> > 
> > Both tend to adopt the name of the module first supported.
> > 
> 
> Well I think that's unfortunate as it can create confusion for people
> searching for the binding as well as people adding a new compatible as they
> might think each SoC should have a independent yaml file. For that I reason
> I think it makes sense to fix the naming.

I'm not keen to open those flood-gates right now, sorry.

-- 
Lee Jones [李琼斯]
