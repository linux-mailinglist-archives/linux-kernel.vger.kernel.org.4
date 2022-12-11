Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BE1649631
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 21:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbiLKUXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 15:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiLKUW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 15:22:58 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5437A6455
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 12:22:57 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D7AF6FF803;
        Sun, 11 Dec 2022 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670790173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jTZf1uBp49+8nSBFwb8wjlr7frwcrl8n0T2YsoAvuz0=;
        b=mqliGHOowM04/hnk+JdnRDgf2e/fjeMOhvMFrax12T7GLG8786kzzu87tUNLTS5BlMmHj4
        y/mfZ+C/CjwSOq0dxacTbEcpG8h/jLtYw1HIGCa48RuvbZ8GF1qv2gDyhFrMuShBZaMhFm
        vYH/lDZKScFsoSh0Lw2YQEQq1XPcDlnlMVITgZ/G7qePGynll7X8MhftLKnp4k5fI5mOB4
        5Dv2VpfNF4fhGegL0YFutxFJvUgApzOMETYkLJkoG2UKItNMyFzD6ahhrCftROmut+5Xgw
        OtCdvhTl8OOapIn7+mL2voE1zgHwlxtgFUOfHEsYzHZxxZzhR61wCwJsIhytVw==
Date:   Sun, 11 Dec 2022 21:22:52 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-i3c@lists.infradead.org,
        Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>
Cc:     Akshay Gupta <Akshay.Gupta@amd.com>, boris.brezillon@collabora.com,
        linux-kernel@vger.kernel.org,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
Subject: Re: [PATCH] i3c: Correct the macro module_i3c_i2c_driver
Message-ID: <167079004538.14691.7411533712830110328.b4-ty@bootlin.com>
References: <20221205105413.937704-1-naveenkrishna.chatradhi@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205105413.937704-1-naveenkrishna.chatradhi@amd.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 10:54:13 +0000, Naveen Krishna Chatradhi wrote:
> From: Naveen Krishna Chatradhi <nchatrad@amd.com>
> 
> Present definition for module_i3c_i2c_driver uses only the
> 1st argument i.e., struct i3c_driver.
> Irrespective of CONFIG_I3C being enabled/disabled,
> struct i2c_driver is never passed to module_driver()
> 
> [...]

Applied, thanks!

[1/1] i3c: Correct the macro module_i3c_i2c_driver
      commit: 01744ce9f07f0b76b0b2d30adba2a7c104f1ff2a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
