Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DA96083E4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 05:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJVDiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 23:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJVDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 23:38:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1EE4E404
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 20:38:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C626B80D55
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 03:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A41C433C1;
        Sat, 22 Oct 2022 03:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666409924;
        bh=QHhBqOVsoir8NrYGC8i2Ktuc/XQbzsVjDpeGNuvAGk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k5zV7G9AB30cJvxK8l0HnAxAL0QOikInNMe2zPdEQhX4Ku4JzFp6udbda4i+HETLe
         wSMOktGxa0vZB7Q4XtO/PapaRcpAcypRLQqHtdVIuNRr4UdXz2KyxlcdC2xq1XhGkj
         HlySsdbBfuwGudxppY4R6gStQSMVwIr676hHzBAzHj9Ak3HITWP/Fg5miyfPasL/HA
         yiv8p+eHP2TR7yl3b057RkICbOM5J1AwtApCRi+HFbdmEnTWDIS6StrXEP+fg/IMjl
         P+vb13OiSeXv8VQGvu0nijPKoCwF6uhYOg3DavXOmnnH/eQRcbHaeUNmU3O/e1j0Ql
         InMYO8CXsZasg==
Date:   Sat, 22 Oct 2022 11:38:41 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Julius Werner <jwerner@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] MAINTAINERS: Add drivers/firmware/google/ entry
Message-ID: <Y1NlwY+RnKth++bW@google.com>
References: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021172624.1.I119456791d197eb7d159f09e7479d8759008a954@changeid>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 05:26:47PM -0700, Brian Norris wrote:
> Per this conversation:
> https://lore.kernel.org/lkml/af9c4bfd-d3fb-1c7a-fb38-0d8bbd507449@roeck-us.net/
> Re: [PATCH] firmware: coreboot: Register bus in module init
> 
> I guess if this is fine with folks, Tzung-Bi might queue this up?

Ack, I can queue both if this is fine with folks.

> +GOOGLE FIRMWARE DRIVERS
> +M:	Tzung-Bi Shih <tzungbi@google.com>

Please use <tzungbi@kernel.org>.  I prefer to use it for Linux community.
