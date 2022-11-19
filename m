Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4D46308ED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 02:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbiKSByk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 20:54:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiKSBxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 20:53:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57678220EC
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 17:41:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C2AAB82664
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 01:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F16C433D6;
        Sat, 19 Nov 2022 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668822067;
        bh=dlCBK5dMhB9d3GVIA0pD0qYoZC713KGHTS5GXLvDeYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhjeifABc81j2OrJCTC/gsMXDs+zsk2IXWjZzumuNXNRJPxjbLSBgHvaGdJdoBbKt
         Q4/tRoyWxcWLDdME9XxrsIvgr1Y9sYljzHcmKhRAR3/oMsWYMjjXdx6IgwntVLt/oi
         r31eY1NUoQAfJUKwATfKMTrvEOnH/5eyPp5pAUi+duOCVfVYVMrg4OzbE3POCc6MQQ
         I/p30klitx5m0pQM/8kTtfRAZlwM9IJBlueCQJGTsR5VgEfLUNsGNkWBbzTT/k2Z7h
         Ny8fYlbr2ZQbQWUZsLGmypo7igU3jiG7v5nv6XQjXqIlTM9bNA01Oz9uSRLCbniVZj
         5mYWYLLa7EC/w==
Date:   Sat, 19 Nov 2022 09:41:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Zheng Yongjun <zhengyongjun3@huawei.com>, s.hauer@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        festevam@gmail.com, linux-imx@nxp.com, kernel@pengutronix.de
Subject: Re: [PATCH] ARM: mxs: fix memory leak in mxs_machine_init()
Message-ID: <20221119014100.GA16229@T480>
References: <20221117062011.84602-1-zhengyongjun3@huawei.com>
 <20221117091315.wwojwl7vhp43k63v@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117091315.wwojwl7vhp43k63v@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:13:15AM +0100, Marco Felsch wrote:
> On 22-11-17, Zheng Yongjun wrote:
> > If of_property_read_string() failed, 'soc_dev_attr' should be
> > freed before return. Otherwise there is a memory leak.
> > 
> > Fixes: 2046338dcbc6 ("ARM: mxs: Use soc bus infrastructure")
> > Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> 
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
