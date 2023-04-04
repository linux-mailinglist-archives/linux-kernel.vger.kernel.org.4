Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941216D6F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 23:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjDDVlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbjDDVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 17:41:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29A53AA5;
        Tue,  4 Apr 2023 14:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pbobgRS0atpBTWbqC5uKq0sMF3WP+h7BjtkRsCEWge8=; b=rBK5KwOFOW9d7nCUV/ARx2rs9B
        EeOTAERFr8LTyHveLIloMJV3Ln5soBcwoaQWHiNZJKGfXX86eBwKvNvIr1jghq6Y+eStKRx2CR+OF
        DPq60FolPk7K1FYAKh1Pr6tk2ROKkezqVhTpx7g33r02yhHeZYU70czmpBIy5eb3Hz6UeOYD33SFb
        0o+8UwmW7mHd9o8MODBgqHGA0drq+Hlk6F/n9y3LEEHd02DB4c/572lzBoSWh+OUcCkCGhO4j9ACN
        jAqXerfGt0que/VoYF8ixtzKaPH2yVgfef10ttMJdt+bwYUHknpSnWC/lQOimlN4ILko517Y7zGK+
        3xHWQfTw==;
Received: from p200300ccff1e1f001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff1e:1f00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pjoOd-00080i-5C; Tue, 04 Apr 2023 23:40:55 +0200
Date:   Tue, 4 Apr 2023 23:40:54 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Andrew Davis <afd@ti.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <tony@atomide.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230404234054.30d806af@aktux>
In-Reply-To: <4b9ad103-3210-18cc-50f9-935d95a1efa3@ti.com>
References: <20230404205844.3553159-1-andreas@kemnade.info>
        <20230404205844.3553159-2-andreas@kemnade.info>
        <4b9ad103-3210-18cc-50f9-935d95a1efa3@ti.com>
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

On Tue, 4 Apr 2023 16:09:31 -0500
Andrew Davis <afd@ti.com> wrote:

> On 4/4/23 3:58 PM, Andreas Kemnade wrote:
> > From: Andrew Davis <afd@ti.com>
> > 
> > Convert omap.txt to yaml.
> > 
> > CC: linux-omap@vger.kernel.org
> > Signed-off-by: Andrew Davis <afd@ti.com>
> > [various cleanup, adding Epson Moverio BT-200]
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> >   .../devicetree/bindings/arm/omap/omap.txt     | 152 ------------------
> >   Documentation/devicetree/bindings/arm/ti.yaml | 147 +++++++++++++++++  
> 
> How about
> 
> Documentation/devicetree/bindings/arm/ti/omap.yaml
> 
> as we already have a arm/ti/k3.yaml for our K3 devices.
> 
makes sense.

I was just following this:

> > Move this to arm/ti,omap.yaml or arm/ti.yaml. The rest of omap/ dir
> > should get moved elsewhere eventually.
>   
> ACK

from Rob and you.

But your current idea seems better.

Regards,
Andreas
