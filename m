Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99005B3DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 19:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIIRMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 13:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiIIRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:11:44 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4565EA431;
        Fri,  9 Sep 2022 10:11:38 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D87C240002;
        Fri,  9 Sep 2022 17:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1662743497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qzTczB6munZOD4DwLGAw/A7taonsXXSbVs8d7tpSJ3M=;
        b=czkgcDmevNYuTr84omI64YQ7bf32DFyD3vn9t5gdj9ru9e9w3lYITFnCP81FR2oWOiIGcV
        90THyh7b8kJx7inMaW213VE8lE3bsvtuAktpMsIgl5iWB2KGweR/DZwgzzEEGioTjG3Bc4
        bMYCCaSCIgNncZ0bAbv9wTcKF5QnHtBRSjnDUtm2Y/j6Za9Rm+XMC97wtkGhplR7ufE+uF
        8xf40iVDGPzxYQVrNxJTvY9Wh8N1VsudkoYasIXba+j6YvZ7DaTf5aFtwgmWqPfYWMnE6o
        eIbP+4Y/E1GJ4ct9jDDmsphv8IzVtnkfFQWtFYelErFspv2kVc5nytaKcZP8sg==
Date:   Fri, 9 Sep 2022 19:11:32 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec
 driver
Message-ID: <20220909191132.6920ba09@booty>
In-Reply-To: <YxoX+G5OFVDTX7s3@sirena.org.uk>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
        <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
        <YxoX+G5OFVDTX7s3@sirena.org.uk>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Thu, 8 Sep 2022 17:27:36 +0100
Mark Brown <broonie@kernel.org> wrote:

> On Wed, Sep 07, 2022 at 04:21:23PM +0200, luca.ceresoli@bootlin.com wrote:

Thank you for taking the time to review my patch in such detail! This
is my first contribution to ALSA, and it was not clear to me which
parts of the existing vendor driver needed even more cleanups than I
have already done. I will probably get back to you with specific
questions later on, while addressing your comments.

Best regards,
Luca
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
