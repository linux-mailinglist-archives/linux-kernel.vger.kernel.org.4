Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDA678ACA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjAWWeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjAWWeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:34:14 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 267E81EFFB;
        Mon, 23 Jan 2023 14:34:12 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDAA2240002;
        Mon, 23 Jan 2023 22:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674513251;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4UD1AIabJqYpx1X1gmf/wjnYlkvV6/xWHyijXijRzg=;
        b=WuaAaVU5RC1AEq/Zejn9ikEtpCcAlDWWL834kSW8cnL4tk4Emi7JIOxkQ5L6xvAWORY4SW
        0s4/iQPCqgUu8IRebJ/dmxe30QKaMCbdWMz/6SIv7UKEyLG/nBYU1wCheTqS/4KHda8WKC
        zLcLCUiPf5fL1kP9uVDbtFsM4QvIgskrt5mcIHQXkoWjo5SRqlFG2C9/pQ/iMcFfcLJYis
        BF7CpREgqp/OoWABdxFmv/t0UFfGi92zRH4uQ0THMSRk2FPu8qY0juGcwCJ8LhmO9CNHLE
        YX8SFk32GaNPGqudwIXz/d/dZDAxbfVzFK0Cjhppn8CBZlfz6qAYIwnP38D0wQ==
Date:   Mon, 23 Jan 2023 23:34:10 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Vincent Shih <vincent.sunplus@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: sunplus: fix format string for printing resource
Message-ID: <167451323420.1260058.8607663873249763877.b4-ty@bootlin.com>
References: <20230117172450.2938962-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117172450.2938962-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 17 Jan 2023 18:24:44 +0100, Arnd Bergmann wrote:
> On 32-bit architectures with 64-bit resource_size_t, sp_rtc_probe()
> causes a compiler warning:
> 
> drivers/rtc/rtc-sunplus.c: In function 'sp_rtc_probe':
> drivers/rtc/rtc-sunplus.c:243:33: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
>   243 |         dev_dbg(&plat_dev->dev, "res = 0x%x, reg_base = 0x%lx\n",
>       |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] rtc: sunplus: fix format string for printing resource
      commit: 08279468a294d8c996a657ecc9e51bd5c084c75d


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
