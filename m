Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D865FCD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiJLVrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbiJLVrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:47:18 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21ECFF215
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:47:16 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 124111BF207;
        Wed, 12 Oct 2022 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665611235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PYRXTnYlOIai//bTBVSmjPYeweD1Rg8CDON7kToZxqc=;
        b=mDRF+yzSENuSMTSuohsAgbDIO8I03+JnWAJC3whECcSRQ7fLSjk6AtB0E2K5wOnrs31hRn
        u9Ljp6WgXUq1nZqVaxPlZPh+h3dbRoDeAUmM7BX/mfS+JlXhnH5n2pUf36uGxZRq2I9cWP
        jODLi3GKCCQbXoeAsgrP5J1W5LP7n06uaAVZtCtDm+RPD3OfUe20jLXpPaqM6dXSj4ZJGG
        KUfCFOLlaLE6zsDLZluXSXq4RqcmBJL3lD+l8oyO9QcxW1Jl5Cb9Vz4CiT6zP6Gn2aXjFJ
        OgHuHcGJx64aXwPmAM2O+P7dkAxzcKt3mfUo5MxHWEDLAVf1I2PjNcilxFy+6A==
Date:   Wed, 12 Oct 2022 23:47:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-kernel@vger.kernel.org,
        Billy Tsai <billy_tsai@aspeedtech.com>, BMC-SW@aspeedtech.com,
        linux-i3c@lists.infradead.org
Subject: Re: [PATCH 1/2] i3c: master: Free the old_dyn_addr when reattach.
Message-ID: <166561121428.1047719.12420586269753157995.b4-ty@bootlin.com>
References: <20220926105145.8145-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926105145.8145-1-billy_tsai@aspeedtech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Sep 2022 18:51:44 +0800, Billy Tsai wrote:
> This patch is used to free the old_dyn_addr when the caller want to
> reattach the device to the different dynamic address. If the
> old_dyn_addr is 0 the function will treat it as no old_dyn_addr is
> reserved on the bus. Without the patch, when the driver reattach the i3c
> device after setnewda the old_dyn_addr will be permanently occupied.
> 
> 
> [...]

Applied, thanks!

[1/2] i3c: master: Free the old_dyn_addr when reattach.
      commit: d4fa7d772adc02451076b3ad1f990d8b822909fc
[2/2] i3c: master: Remove the wrong place of reattach.
      commit: 90f4a09a15239f4a819b2e90a7a0b92a75060655

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
