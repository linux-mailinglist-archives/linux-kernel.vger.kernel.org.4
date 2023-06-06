Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00354724BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 20:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbjFFSxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbjFFSxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 14:53:05 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4E2170E;
        Tue,  6 Jun 2023 11:53:00 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686077579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wdyPSgVE27NwbqlhlKleapa7hzQmgnUK3/bw9REerZQ=;
        b=jMbR6cPxWHS9aw4G+biPFQGItfs5ZDTU5eQ4fb8UtlO0InJoWZs7PapuGdGMxuoyCsWcVG
        NBsO+dc06xn6Q3EZ1oXRf87eQ1c9CnFzp5qvuMK6bulM9qWM9subHLAH9Wl4PgGoVK9Pn4
        Ec7UJVqLFCEBUNORIIK+BxciiXxFyPUV//Ea5/wn/1E4DLIMgBLcxA8Xy+FLeR2w7+wN5R
        /OJBX0Bt0A6Uxq7QB6Tl3WtKut4KxO8KUHgBY+p1QmnKYkfMJzV4dGZ5eVWGIDcwr9izNI
        bkd5A2FMkIxpZhR55CNl+y2d2ZteVU/LagFg6DX3HWQ4BhGsO8RTv70AIqJfhg==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 805AF1C0003;
        Tue,  6 Jun 2023 18:52:57 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 1/1] ieee802154: ca8210: Remove stray gpiod_unexport() call
Date:   Tue,  6 Jun 2023 20:52:56 +0200
Message-Id: <20230606185256.197509-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230528140938.34034-1-andriy.shevchenko@linux.intel.com>
References: 
MIME-Version: 1.0
X-linux-wpan-patch-notification: thanks
X-linux-wpan-patch-commit: b'18b849f12dcc34ec4cb9c8fadeb503b069499ba4'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-05-28 at 14:09:38 UTC, Andy Shevchenko wrote:
> There is no gpiod_export() and gpiod_unexport() looks pretty much stray.
> The gpiod_export() and gpiod_unexport() shouldn't be used in the code,
> GPIO sysfs is deprecated. That said, simply drop the stray call.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git staging, thanks.

Miquel
