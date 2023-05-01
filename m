Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CE36F31F2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 16:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjEAO0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjEAO0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 10:26:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C6C12F;
        Mon,  1 May 2023 07:26:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F47B61D4B;
        Mon,  1 May 2023 14:26:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B16FC433D2;
        Mon,  1 May 2023 14:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682951177;
        bh=mJ4N+fkYvHqgtKjKmqHaK5QlK5kWfu9OzNwlkbek+YU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Iozp3A8b7FBDSssgN5UO7cGhSCRi9LiZejoDi0+eQtqv87O7gbFAVPrY1lzDvznUs
         D/n1G5lqjCMIYO4DT4ZRG7b75cVKFG0+8qQBSCKBnX6PD6B0ZU6uTgDooaNErArRtS
         5rX6bJ7HhD2fJEnEJsYsOC16e80PXdCKM2jqrIOGSZWOSLeSV3EK6C8nOCmFlgGUY/
         ZBRPf0kvhZ+RnqmyPevdsg6ekeqxlx/t/OJVct0y2YMdgObkGGeJxhHOVWW9AIzVqk
         JUob0G8CCigf+spcBLqMjnQ4tseAuaB1ceStEwE7H4OQAdcoVwkNqsjIU34brJ6k5C
         dYZoI4HZK+rtw==
Date:   Mon, 1 May 2023 15:42:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/7] iio: accel: kionix-kx022a: Add an i2c_device_id
 table
Message-ID: <20230501154202.50707b54@jic23-huawei>
In-Reply-To: <9b95a754-cc73-9d96-049b-35e708cd2e86@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
        <a232fe7a8104f8d1cddfc5950aa48748ea90bffa.1682373451.git.mehdi.djait.k@gmail.com>
        <9b95a754-cc73-9d96-049b-35e708cd2e86@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023 08:31:20 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 4/25/23 01:22, Mehdi Djait wrote:
> > Add the missing i2c device id
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Regarding the question (Jonathan asked in previous version) if this 
> really is a fix - I am unsure if this can be of help when dealing with 
> non OF-systems? (I don't have much of recent experience on those).

I think it's fine to treat this as a 'feature' be it one that
we'd happily backport to stable if someone asked because the driver
didn't work as expected on their systems.

Jonathan

> 
> Yours,
> 	-- Matti
> 

