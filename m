Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F60A689B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjBCOWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjBCOWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:22:10 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A103AA7
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:22:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DD8DE6000D;
        Fri,  3 Feb 2023 14:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675434128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JDf/E5qRsQ13O+6osABAwgoxPH8VjUVG7UNYlqOUD3U=;
        b=K8tgW27V3mmWiCh4RtIUsHnJKAUoAZu8O8C+mwuXplj8Sr39A82ZQSgAfrOY2s/HTFKdvn
        JBs3InxamnYXahQWOCzF2dF33xtWeNPoWvu7hZgP2wHgbSQhB1nWMgXcYXkWLeAZ++fxjJ
        xj4GjAzqIIgVs5z+0gzAEQwqtKqpRMZ9+QjOEoXczIdHpnCxh2bXrg3QeLHdpVPg9HYRs8
        Gon8z7mKr+Al1F6gv7LbVbvOB9VZlZPRwSoBwb37GaP4WTMlrNBsBiEGxDg7SF40mfkKBr
        vfjvKF/CJz2bS/CA+D5hCr6g5Kh0PDtb8zB7DH97G7VMbRcWj+0QcVN0qqcI1w==
Date:   Fri, 3 Feb 2023 15:22:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     pratyush@kernel.org, michael@walle.cc, richard@nod.at,
        broonie@kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: s/a SPI/an SPI
Message-ID: <20230203152203.55f584a9@xps-13>
In-Reply-To: <dac961df-c43a-03a1-2d85-33075f75589b@linaro.org>
References: <20230203080136.68505-1-tudor.ambarus@linaro.org>
        <dac961df-c43a-03a1-2d85-33075f75589b@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tudor,

tudor.ambarus@linaro.org wrote on Fri, 3 Feb 2023 12:18:25 +0200:

> Sent a tree wide patch instead, feel free to comment at:
> https://lore.kernel.org/all/20230203101624.474611-1-tudor.ambarus@linaro.=
org/T/#u

I'm wondering how relevant this change is, because I ear a lot of
people (including me) saying both:
- "an ess P. I. controller"
and
- "a [spi] controller"

Anyway, I won't oppose either.

Thanks,
Miqu=C3=A8l
