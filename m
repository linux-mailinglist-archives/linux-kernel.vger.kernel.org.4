Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B17C69FCCE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjBVULL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbjBVULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:11:00 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B813457EE;
        Wed, 22 Feb 2023 12:10:42 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 27A94240002;
        Wed, 22 Feb 2023 20:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677096640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mEsg3SXtV3D6Bu5t7TrqpSovZ7Nto8AGzC9zldrBOV4=;
        b=jNw4e308GV40do2Y8Ju5LM9SUF7mhI+scO26MFdH+kCpodbaJAsOBS+xfMCinmdFan4cXH
        mekTbEnnsgXjca7Da+MLjJgdnlGkkhbO0F6K5xmtkEj0Dt91YCexZ1DwNsRzwKuIYMNs5Y
        HMMkTZGnDe56lW1sPstkEzjBv9EtqJrJVPx+3nkFlKV2s40Zma8XTB/eHXunjgE7DpsjVe
        JEEhtGKSOZNcY6PYNs1h5eUnR/iH+DjUPEqZ8eJ6fHT4cdEAveAbV7LhuaDhtLTHfqeiOZ
        o4/e3eWsMGtYbmTfGEMsSA6y66/PEzzN4qzHuIjexyIQJyF+tS0Y133uPfYFmA==
Date:   Wed, 22 Feb 2023 21:10:39 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH v1 1/1] rtc: rx6110: Remove unused of_gpio,h
Message-ID: <167709656545.70897.3624522262002066223.b4-ty@bootlin.com>
References: <20230215165030.83621-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215165030.83621-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 15 Feb 2023 18:50:30 +0200, Andy Shevchenko wrote:
> of_gpio.h provides a single function, which is not used in this driver.
> Remove unused header.
> 
> 

Applied, thanks!

[1/1] rtc: rx6110: Remove unused of_gpio,h
      commit: 38892c48e54760be41f16519456d868e14933789

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
