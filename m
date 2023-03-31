Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3326B6D21B6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjCaNuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232165AbjCaNuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:50:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93203EF8E
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:50:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48272B82FD3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A94FC433D2;
        Fri, 31 Mar 2023 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270598;
        bh=z/Ar//fKecpCf9wRkg18J/k+U8y/C1Zx2QWQGp9b4Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et0BefEu3QBhflB0a+HHoSnW5KubjrOSR95wqxNWiBBhpwxazaCrTjl8pIcvzQ/+6
         PWEGCOc+Gjt3SovdTeNO8RTYvvb52/lmxPe0v72S0cvh/JjieCMTjhMfJyvqiZqEJf
         juMEq0wI2jg3pZui65EK2GvBWLGo7DeAOWA3halnI8jvQwMl+TnY/WeA/3wvYMyXLX
         F+Zr/ZIgH/J/BvAVPvgmmjot8EWNYMey0RLRWuy2a0w8rrpodHSicO6ONgreUjdOH/
         xZPjXwUo4KbkOu2K+DhOD/MppezeqnF7WfoZOjQS5qAoFYOR+xVsFAgD34QgJaCtYE
         3rXUA2DCLxLtw==
Date:   Fri, 31 Mar 2023 19:19:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com, kishon@kernel.org,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: dphy: Use devm_platform_ioremap_resource()
Message-ID: <ZCblAoyNJhoRyyKd@matsya>
References: <20230323073534.75037-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323073534.75037-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-23, 15:35, Yang Li wrote:
> According to commit 7945f929f1a7 ("drivers: provide
> devm_platform_ioremap_resource()"), convert platform_get_resource(),
> devm_ioremap_resource() to a single call to use
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.

Applied, thanks

-- 
~Vinod
