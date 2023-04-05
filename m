Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CEF6D83DF
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDEQjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDEQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:39:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27702135
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9C9A628FD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C7DC433D2;
        Wed,  5 Apr 2023 16:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680712752;
        bh=ZU4IDuI+UD+VYcqVNYCPsCR1gEEXwDspotTAU5Z68mQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcwei0ZIHgrfb/bgNI3r8QtveRqgaFJPGCR4450FAHyW0oijbi4holZ76FOdmjCQO
         OjTzfveG9WC2EzBNZdL0DobrlUqs0Jn5wcJXMEPSElL9pXT/kd00NjrciQUAUnGfiA
         E33/nzdxauL4B6coAh87deRZTOf49q0Qj5/1N5bgz/FN/d1NwnT7ugiccACbXM0fkN
         g6DwZyCUoL04fDx4epb3GwXzfHr7lA2KI0xEAkhaR1EMXlepjUDpQTLJvFk9QUc+4e
         XlpDyOe+m3axxa8vMIqdnN9shZlT6yO27ciVaIrUtCdZ7xfk/f9gV8D5ndt6jL7DeW
         LF4ANjVXpBPBA==
Date:   Wed, 5 Apr 2023 17:39:06 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230405163906.GT8371@google.com>
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-4-andre.przywara@arm.com>
 <20230405142103.GL8371@google.com>
 <f1d7526b-7f51-462d-8192-0a05828bfc4f@sirena.org.uk>
 <20230405153651.GS8371@google.com>
 <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e86dd4a9-540a-461f-a78a-5acb480e98b9@sirena.org.uk>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Mark Brown wrote:

> On Wed, Apr 05, 2023 at 04:36:51PM +0100, Lee Jones wrote:
> > On Wed, 05 Apr 2023, Mark Brown wrote:
>
> > > I'm waiting for the MFD.
>
> > To do what?  #deadlock
>
> Whatever it is you need to do to be happy with and apply the shared bit
> of the series.  We're somehow on v10 here for what seems like it should
> be a very simple change, I've not followed the ins and outs of how that
> happened.

From an MFD perspective, reviews happened followed by an approval in v9.

I can't do anything without an Ack from you or some indication that you
want me to apply the first 2 patches and share an IB.

--
Lee Jones [李琼斯]
