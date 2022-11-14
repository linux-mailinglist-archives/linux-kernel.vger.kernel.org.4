Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21EE628B4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237735AbiKNVY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbiKNVY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:24:58 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1718826D4;
        Mon, 14 Nov 2022 13:24:56 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 17ABD60003;
        Mon, 14 Nov 2022 21:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668461095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKQQdrBMa6jaD/V+H3nTX/7hgN79VqFbdOW7mE98yJ8=;
        b=SeN5abbE0PiJPM1O1cLbP7LRmFrceeOXNBFuTsIvcxATsuvIqDpVemLw1EQAFTSqCXsnm+
        qJIcAtPurC4kv1JdQO1ZuXpJfPQebxA1MXO9mQEUVMjoRJyH7hSFjvEOo1SSF+csgV3pga
        tFgJd8NeuedamRZ+osk5YwBP3MdlNdnvj/vIGzvHh7wa9UgChiezcVGbgTpgdn43RUTPs9
        LXbaiJPHsm1eGRNIYyVHe+8HnZgeIljeoHd9+Le1+SRDFWwMZ/Z6vVwc73LjDGBSLFnIjj
        plJpgm3/3T/7BlSzIBOmIyGk8cUIrLzrVuEL/DdiUSPy/2RWdjecQtyGeW9Hkw==
Date:   Mon, 14 Nov 2022 22:24:54 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Zhang Jianhua <chris.zjh@huawei.com>, rasmus.villemoes@prevas.dk,
        a.zummo@towertech.it
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] rtc: fsl-ftm-alarm: Use module_platform_driver
 replace device_initcall
Message-ID: <166846107297.2114334.9948794801908458724.b4-ty@bootlin.com>
References: <20220906143037.1455317-1-chris.zjh@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906143037.1455317-1-chris.zjh@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 22:30:37 +0800, Zhang Jianhua wrote:
> The ftm_rtc_driver has been registered while module init, however there
> is not unregister step for module exit, now use the macro
> module_platform_driver replace device_initcall, which can register and
> unregister platform driver automatically.
> 
> 

Applied, thanks!

[1/1] rtc: fsl-ftm-alarm: Use module_platform_driver replace device_initcall
      commit: 775f42aaf61a4a2ee09a196d8c7d271ef3ba779b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
