Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077126C9BB4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjC0HL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC0HLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:11:24 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC41F422C;
        Mon, 27 Mar 2023 00:11:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 417618108;
        Mon, 27 Mar 2023 07:11:23 +0000 (UTC)
Date:   Mon, 27 Mar 2023 10:11:21 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     cgel.zte@gmail.com
Cc:     aaro.koskinen@iki.fi, jmkrzyszt@gmail.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] ARM: omap1: remove redundant variables err
Message-ID: <20230327071121.GR7501@atomide.com>
References: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830142136.299373-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* cgel.zte@gmail.com <cgel.zte@gmail.com> [220830 17:14]:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> Rturn value directly from platform_device_register()
> instead of getting value from redundant variable err.

Sorry looks like this is still pending, applying into
omap-for-v6.4/omap1 thanks.

Tony
