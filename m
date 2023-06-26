Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E4473E3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 17:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjFZPmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 11:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFZPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5AA1700;
        Mon, 26 Jun 2023 08:42:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B29260ECA;
        Mon, 26 Jun 2023 15:42:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D61C433C8;
        Mon, 26 Jun 2023 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687794152;
        bh=qsIVCEqiEsiNMulMN2stI2PtbXCDoJyDQrPp/INSwFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lKP0x47v5GAaPD7ycZO0BDsDgmwrgyEW2lBLCOh96m2iMPNRyIirkukHIEpucy6bi
         7GBxZtAH1DOswixyxC/fYfxl2hTAM610dP7DANiFjYjwvez5qnxw6OCdgPVXwd1YtP
         jt2IT303/+Xrw9nflWnqp2B8nooiebuw1ekKbLCDp9xMI079PcK91bzZI/uFuGGY+9
         FKuLMfgtJoeUAOIQAoTcCw0C4EDeXN5hARyx0J4wejLG8nSGUjSWjUHNr15M5Usm/0
         Ao4Tx79klY8RBJmYAS5tfEkLN94d9k1PfPuC8yyq9EZO9L7yw8Gpe63+T4zrHKzk2J
         H1D6/SqSu35QA==
Date:   Mon, 26 Jun 2023 16:42:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 5/5] leds: Add a multicolor LED driver to group
 monochromatic LEDs
Message-ID: <20230626154226.GE10378@google.com>
References: <20230616095746.872220-1-jjhiblot@traphandler.com>
 <20230616095746.872220-6-jjhiblot@traphandler.com>
 <20230621193321.GU10378@google.com>
 <e9d23080-3916-f8ff-e179-4572d02c57b0@traphandler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9d23080-3916-f8ff-e179-4572d02c57b0@traphandler.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023, Jean-Jacques Hiblot wrote:

> 
> 
> On 21/06/2023 21:33, Lee Jones wrote:
> > On Fri, 16 Jun 2023, Jean-Jacques Hiblot wrote:
> > 
> > >   create mode 100644 drivers/leds/rgb/leds-group-multicolor.c
> > 
> > Sorry to do this too you, but there are too many nits that I can't pass by.
> That's alright. I'll fix them in the next (hopefully last) round
> > 
> > > +		/* Restore sysfs access when the multicolor LED is released */
> > 
> 
> > Out of interest, why are we doing this?
> To prevent the user to play with the individual LEDs of the group, their
> sysfs interface is disabled (read-only). The interface must be re-enabled
> when the group is destroyed.

Please make that very clear in the code.

-- 
Lee Jones [李琼斯]
