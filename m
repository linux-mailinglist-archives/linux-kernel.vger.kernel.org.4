Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516C45FE441
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiJMVcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 17:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 17:32:52 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D66157465;
        Thu, 13 Oct 2022 14:32:50 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AE64E240004;
        Thu, 13 Oct 2022 21:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665696769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/AFwraTNltNY+tI0PBTXwQEkN7fKXUqp2PHeW12J1CU=;
        b=mWXvztsizl1t1XyJvd9wFN4g8i+yrVCSumTwKEZ6wsyBNFkneyJiRh7zfc2Jd7OhWjByY+
        3/Azvd0wqEIs2oAB0Ee6MuJS7rHfY/ZalwVQSuRrj5cp3KKeia8K4J1ELCKEcAgAE2+FLb
        PcFFMdV0TOCtakoRGTgC70+EptFz/wgK1735qBbXwOzemESuWO6G71Pm3zqdr3R2fnVi8E
        Tod9s9Vjejz9hvGtk30Im9N9TZ87K/u4wBMRI1HkdcSH+dtZseBl47izGDyQYvFxEFnAMC
        BeyMl8oKDDb0gsKvcQa1UJ7kaeAAKhtKEWJEPVjcug6NRUKbdN+r0FFUbEI+Ew==
Date:   Thu, 13 Oct 2022 23:32:48 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: mpfs: Use devm_clk_get_enabled() helper
Message-ID: <166569636075.1226796.3261311337977278707.b4-ty@bootlin.com>
References: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e55c959f2821a2c367a4c5de529a638b1cc6b8cd.1661329086.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Aug 2022 10:18:25 +0200, Christophe JAILLET wrote:
> The devm_clk_get_enabled() helper:
>    - calls devm_clk_get()
>    - calls clk_prepare_enable() and registers what is needed in order to
>      call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code, the error handling paths and avoid the need of
> a dedicated function used with devm_add_action_or_reset().
> 
> [...]

Applied, thanks!

[1/1] rtc: mpfs: Use devm_clk_get_enabled() helper
      commit: 24fb316155a5f6ba278a8b110c60e67b79900356

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
