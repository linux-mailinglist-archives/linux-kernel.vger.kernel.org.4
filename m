Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D3B721AE9
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 00:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjFDWwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 18:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjFDWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 18:52:31 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630EFCD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 15:52:29 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685919148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RZRdUHlQY3oR10KG52Yo7mbzjUpNi1/wxbDtPAhI6Ag=;
        b=XS4XiBcci0oSAnwTzoiCwpjgP4I08SmevJnLnExqcf5VxEnZnlK/kGiX6KSsA6kOw53MJM
        eiJQwRpvCTfpbRG8sS+oW6R4LmQBn3d6y0g0DMPQeI9MbpDvVSdVCGJHm0GoQcjqlcXEUc
        c86m9XAb7oU9a39ZT4UYuSKItSREyqburxAgRLLNeci6IYpYOh38F9zyqryBtKzhfkl9oz
        MtAZF0XsGPnL5eq7IYVhrtAmTR7o7IA+qjghhUhJe9ENZHEqeAeK11S3eMe0a/7+EPDJD8
        qfvIsbtaVECejaUtOjEu176+7Ua61DoXxjY8v/uGG9e6xI2QVAYXDXv9Cn1ExQ==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 58FE61BF204;
        Sun,  4 Jun 2023 22:52:27 +0000 (UTC)
Date:   Mon, 5 Jun 2023 00:52:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     miquel.raynal@bootlin.com, conor.culhane@silvaco.com,
        Clark Wang <xiaoning.wang@nxp.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH] i3c: master: svc: fix i3c suspend/resume issue
Message-ID: <168591905817.3958179.10538086649174750608.b4-ty@bootlin.com>
References: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517033030.3068085-1-xiaoning.wang@nxp.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 17 May 2023 11:30:28 +0800, Clark Wang wrote:
> When system suspends, if i3c module is powered down, register
> value will lose.
> Need to save the key registers before system suspend.
> So save these registers value in runtime pm suspend, and restore them
> if these register's value is different with the saved values
> when runtime pm resume.
> 
> [...]

Applied, thanks!

[1/1] i3c: master: svc: fix i3c suspend/resume issue
      commit: 1c5ee2a77b1bacd4c333bebea93610aaf17977be

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
