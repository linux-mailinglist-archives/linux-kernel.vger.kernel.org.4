Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD9D5FCE25
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 00:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJLWJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 18:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJLWIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 18:08:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC2812790E;
        Wed, 12 Oct 2022 15:06:43 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5D9BF240006;
        Wed, 12 Oct 2022 22:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1665612348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=egg7PTPd+Td6H4icK4xfYZXNoHe/oN9/MQiilWB/82Y=;
        b=PcAWNdTbQfr+jTBdWlnVxZQF29L8PCjb6BR7rIRK6Ogz0ZdKaxwv30E2Z1sGLtRO2FwC4m
        kWvY4mBy5ZIaN9MwYVd0K47jI3KIuZ4MOafAoijimtkLQiz8kx9MSQ9EVhw8kaA+N3ujCo
        cgXZhH2iC1TRqKOzr/51+s/6su9qqVa99L5ORz10EH3gcU/Nj00FlPfvCWVSVoGGs6ffi/
        mbnmg6gnZ3xSHToV0Z3ICUraiIXy5pvCADHWpNgA0oH7zUKagPRM/eCLX1DtaiWHE4Kzrq
        qSRYJ/X+4YWBDZCJ5PKMpFLn+TbplpzrJaDMSDrcqFWFjLVghLC4gvKKUVVtMg==
Date:   Thu, 13 Oct 2022 00:05:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     wsa@kernel.org, akpm@linux-foundation.org, a.zummo@towertech.it,
        Lin Yujun <linyujun809@huawei.com>, wim@iguana.be,
        alexandre.torgue@foss.st.com, mcoquelin.stm32@gmail.com
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH -next v3] rtc: stmp3xxx: Add failure handling for
 stmp3xxx_wdt_register()
Message-ID: <166561232122.1050426.7852925848421780044.b4-ty@bootlin.com>
References: <20220915065253.43668-1-linyujun809@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915065253.43668-1-linyujun809@huawei.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Sep 2022 14:52:53 +0800, Lin Yujun wrote:
> Use platform_device_put() to free platform device before print
> error message when platform_device_add() fails to run.
> 
> 

Applied, thanks!

[1/1] rtc: stmp3xxx: Add failure handling for stmp3xxx_wdt_register()
      commit: 0759011157b0d666b02b03b986d3de005d84027e

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
