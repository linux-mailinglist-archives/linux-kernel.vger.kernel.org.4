Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ECF6BF504
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 23:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjCQWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjCQWV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 18:21:29 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8729C8C5AA;
        Fri, 17 Mar 2023 15:21:26 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8DE4E40003;
        Fri, 17 Mar 2023 22:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679091684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M1H0b+8pt3zecfZdT4Lt4hoL0pnvHKD6pkdBtwNxvW4=;
        b=hJ5LBiF1mKl2oulAqe7KSjjKGLbCZw1yF7Sc+jPyNHe5He6DEIw3OKO36ROWMv3xJfcjfo
        yQCThlu4bNCKzClbHV/hgDnTHhyrKFLaS+hHB+J323GaZC5MRzwfVPIXuRUSswx+m95XT8
        DKzTeZfrJ3u7mRBsHqEsh3Oz2NlZwYVCVhTu+SGSEkkmi8grjOKaNp5eMWNoBUWwAUj9GP
        FZNLslGB024APPJcabeY2gUrfszNDkes8eD4Mgu6Ni9UN+U5gKRZJ4d6lEJ+qb7U0LxBD2
        Uno1kxl1rBW4gEM7nwQw8AEyiymx/Hkcw6k4AwIzeS2jVPBtEYa/oIl/bLQsDA==
Date:   Fri, 17 Mar 2023 23:21:22 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sun6i: Use of_property_present() for testing DT
 property presence
Message-ID: <167909163830.117471.962092693437106290.b4-ty@bootlin.com>
References: <20230310144736.1547041-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144736.1547041-1-robh@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 10 Mar 2023 08:47:36 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Applied, thanks!

[1/1] rtc: sun6i: Use of_property_present() for testing DT property presence
      commit: 4d9890ac9d43d4dfd011110ab96633caa6fa829c

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
