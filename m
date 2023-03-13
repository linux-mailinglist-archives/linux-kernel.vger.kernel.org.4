Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA42B6B7935
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 14:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjCMNlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 09:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 09:41:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9863F64265
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:41:47 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7492340003;
        Mon, 13 Mar 2023 13:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678714906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gNi+f4vorTzE04nFBS+fe+Vq/HQDmZwpZvJXiXO/HEs=;
        b=ELMxynyL2iduOJ7LXr8Ejg2fe/AjIJFWVrqkueZn7R5GMhjKmx8Q3RjnrI1zFa5WAOMMDX
        OO9E8v5urc1kCEn4nPgM/k6uNW7bJy7a2GmKldB4cQZ8EjmPGzLYhLtku3l2uBObDh+B7+
        vQVfmIpMjavYy6s8kQWUEy2UvZVCiv5n5BKSf9exLtaEDldPdsuefsc5b6Tnq9XrPgKU+k
        ySdYHJPCLJeFnoFvF24zjNJkKEvjDV9IGGTvtzdYVzy5qtMeizJWrv5JBHjiesjifgul2M
        9xHDptyGPbelPj6xB+X8X+IQ8Qlhkf93BtfePUqk7/Sc1t0L4CpImMcIg8QY1A==
Date:   Mon, 13 Mar 2023 14:41:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] i3c: =?iso-8859-1?Q?Cor?=
 =?iso-8859-1?Q?rect_reference_to_the_I=B2C?= device data type
Message-ID: <167871488920.397851.15793351776406700265.b4-ty@bootlin.com>
References: <20230302161206.38106-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230302161206.38106-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 02 Mar 2023 18:12:06 +0200, Andy Shevchenko wrote:
> I²C peripheral devices that are connected to the controller are
> represented in the Linux kernel as objects of the struct i2c_client.
> Fix this in the header file.
> 
> 

Applied, thanks!

[1/1] i3c: Correct reference to the I²C device data type
      commit: ce48f955860db841eeb4bcf9bb973ea3ef177b3a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
