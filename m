Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5276D41BE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjDCKSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjDCKSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:18:18 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63402695;
        Mon,  3 Apr 2023 03:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e3FrLJNdajYAJAcOhz5oBsYPulbF6r76meodxBXCWrU=; b=zUq6hHLjBOsezBf886FSbyKMik
        ayEzRVzG/xoXdPMHHj0fGSIykqm5TwKLZPPX41PeRYC35HTLXFy5sVCeFva8LGVs4vmm2pUmPLN/O
        iuLRiII9l6Jvv7V4WUK2zpr7lUjur/9UirQ0hHWVLKZZX1btx6koMJJW9JuCq1YhNGOsW04u+3aaL
        OFPRJKTestsGDnL56bd04SCVRDiznUA+QEKVXmuY8XvRUgB/vNiSOTFAqxGzbbi/u0ZybPSfrUmL+
        ovzcHdqAF+c0hUzTLuUYtLMNHb65qJyrjHg3EVuEJyjUlyOMiEllCM1sZ3F2cEpN8Nk6cT/oI96wJ
        Un19qHIQ==;
Received: from p200300ccff0449001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff04:4900:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pjHGP-00048Y-OX; Mon, 03 Apr 2023 12:18:14 +0200
Date:   Mon, 3 Apr 2023 12:18:13 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230403121813.55c8aa2a@aktux>
In-Reply-To: <3865a750-2cd1-c92f-8bd2-22dfeea43769@kernel.org>
References: <20230401140248.3363674-1-andreas@kemnade.info>
        <20230401140248.3363674-2-andreas@kemnade.info>
        <3865a750-2cd1-c92f-8bd2-22dfeea43769@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2 Apr 2023 13:26:46 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 01/04/2023 16:02, Andreas Kemnade wrote:
> > From: Andrew Davis <afd@ti.com>
> > 
> > Convert omap.txt to yaml.
> > 
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > [various cleanup, adding Epson Moverio BT-200]
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.
> 
> Your CC list is broken in few ways. Just use the script, don't re-invent
> the addresses.
> 
well, I am using the script and added a few adresses obviously missing.
But maybe I have used the script from an older kernel. The patch was against
linux-next.

[...]
> > +      - description: TI DRA7 SoC based platforms
> > +        items:
> > +          - enum:
> > +              - ti,dra718-evm  
> 
> This is not correct. Maybe you forgot to fix DTS, but anyway it's
> confusing to have dra718-evm with dra768 SoC. Is this really proper
> combination?
> 
dra718-evm has a lot of compatibles, no idea if that is sane.
And to better discuss such things I added the omap mailinglist (with a typo,
sorry). To avoid that trouble in the future, I added a patch to MAINTAINERS.

But I think it is better to not convert dra7 stuff for now, then
it can be discussed by the right people. 

Regards,
Andreas
