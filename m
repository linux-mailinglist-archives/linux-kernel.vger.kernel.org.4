Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EC661A06E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbiKDTAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKDTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:00:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF19D122;
        Fri,  4 Nov 2022 12:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2C0DCCE2D8A;
        Fri,  4 Nov 2022 19:00:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04F8C433D6;
        Fri,  4 Nov 2022 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667588439;
        bh=2fJkX7Sa4qoLW96SXggBTYnFdz/SkFodsqwcX2upn20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=miZBGYEU2/q/Plpq04rVgRc7AompgdFw/qtzyqy7IjoAKZ1Qj8cDigdVoddcpAtDE
         zSF4Wv0ItqDUrv1lSCtHx0l+G/v/pn8cPtWw8X4MFap4PPpKQtuIs4NZgNmQDvYc4a
         dhXXEwSz9/sVYCS2dF/LxLFaWHleZFF66lx09ctLn/9a8lVr5V3ZxN0SRyw3CLIMgB
         ByPFwSl8q3r4TU8gdHCBUNVm7KAgtrMkp3QQqt+bILE1u4RQi4J0QQeb9Ur9zqwiWW
         o/G0ANl/Fkbir0/m6Ra9EEsP4YxbbloBoBr/LIXPK/4dxBBpwMXRaoy/REBkUvBQfy
         Q3xl6/oZ7qm6Q==
Date:   Sat, 5 Nov 2022 00:30:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     vincent.sunplus@gmail.com, kishon@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Subject: Re: [PATCH] phy: sunplus: Fix an IS_ERR() vs NULL bug in
 sp_usb_phy_probe
Message-ID: <Y2VhTVGuqM44G9oz@matsya>
References: <20220911060053.123594-1-wupeng58@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911060053.123594-1-wupeng58@huawei.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-09-22, 06:00, Peng Wu wrote:
> The devm_ioremap() function returns NULL on error, it doesn't return
> error pointers.

Applied, thanks

-- 
~Vinod
