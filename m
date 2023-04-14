Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0756E20DB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDNKdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjDNKdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:33:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E23EF1B0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:32:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F07FB2F4;
        Fri, 14 Apr 2023 03:33:42 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B73B3F587;
        Fri, 14 Apr 2023 03:32:56 -0700 (PDT)
Date:   Fri, 14 Apr 2023 11:32:54 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] regulator: axp20x: Add support for AXP313a
 variant
Message-ID: <20230414113254.4e0618c5@donnerap.cambridge.arm.com>
In-Reply-To: <d74c94a6-77d1-41f1-82e4-a046f7935aee@sirena.org.uk>
References: <20230401001850.4988-1-andre.przywara@arm.com>
        <20230401001850.4988-4-andre.przywara@arm.com>
        <d74c94a6-77d1-41f1-82e4-a046f7935aee@sirena.org.uk>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 14:49:44 +0100
Mark Brown <broonie@kernel.org> wrote:

Hi Mark, Lee,

> On Sat, Apr 01, 2023 at 01:18:50AM +0100, Andre Przywara wrote:
> > From: Martin Botka <martin.botka@somainline.org>
> > 
> > The AXP313a is your typical I2C controlled PMIC, although in a lighter
> > fashion compared to the other X-Powers PMICs: it has only three DCDC
> > rails, three LDOs, and no battery charging support.  
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

so is there anything Martin and I can do to help this move forward? I
guess broonie's tag above means that the regulator part is good, so the MFC
parts can go ahead now?

Cheers,
Andre
