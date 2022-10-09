Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5925F8AF5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJILrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiJILrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 07:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325F42D1FB
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 04:47:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C33B460BA9
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 11:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09017C433C1;
        Sun,  9 Oct 2022 11:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316022;
        bh=XsGgJX0z2UgSEslWW/E68avc5PQgZHhsO1l2BLO1H3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DG8RVS9SOZFKoMMY/5AowOJ1yOu9S0Z+1Wejni8P5yB0ZHopdgN5f9LsYA5hvnSOu
         CsJtYV2NWGALAqdZFr+a1MfxklDkMCQ6ls8oMUyfpfLzg4WO8aqrzZNskuDazgKKeH
         TqKDdspW38ToxrNa7Jei1Wz2VPHarpuKY0KrTGg6wN7D9uYIy5BrfJlpmRflFDrZ9U
         MdSe85ONAuSzusX1gIMR063yRPZAmqyT2oUkSk8zzdstXL6ZwCaBWx52JT+Sjc4vaX
         0e2Y3E2e8L7O6esPj5uI4lj5qhPEjzaLEvAaC45JxngXWKV0TIF+GLK3NPmiXR4J5g
         wRv9Z1P7o4eTw==
Received: by pali.im (Postfix)
        id 740857C1; Sun,  9 Oct 2022 13:46:59 +0200 (CEST)
Date:   Sun, 9 Oct 2022 13:46:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: turris-omnia: Add ethernet aliases
Message-ID: <20221009114659.if3iqy4hbmp3nq7j@pali>
References: <20220727130926.1874-1-pali@kernel.org>
 <20220924121302.jtm4qv6vgpc33tav@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220924121302.jtm4qv6vgpc33tav@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory: PING?

On Saturday 24 September 2022 14:13:02 Pali Rohár wrote:
> PING?
> 
> On Wednesday 27 July 2022 15:09:26 Pali Rohár wrote:
> > This allows bootloader to correctly pass MAC addresses used by bootloader
> > to individual interfaces into kernel device tree.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm/boot/dts/armada-385-turris-omnia.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/armada-385-turris-omnia.dts b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > index f4eb6898aa6b..d2afa466e29a 100644
> > --- a/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > +++ b/arch/arm/boot/dts/armada-385-turris-omnia.dts
> > @@ -23,6 +23,12 @@
> >  		stdout-path = &uart0;
> >  	};
> >  
> > +	aliases {
> > +		ethernet0 = &eth0;
> > +		ethernet1 = &eth1;
> > +		ethernet2 = &eth2;
> > +	};
> > +
> >  	memory {
> >  		device_type = "memory";
> >  		reg = <0x00000000 0x40000000>; /* 1024 MB */
> > -- 
> > 2.20.1
> > 
