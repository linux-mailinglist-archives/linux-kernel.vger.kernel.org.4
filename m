Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C316665BE6E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:53:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjACKwH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Jan 2023 05:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237152AbjACKvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:51:36 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBF22FA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:51:35 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCetD-00085X-SH; Tue, 03 Jan 2023 11:51:27 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCetA-003Xgr-20; Tue, 03 Jan 2023 11:51:24 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1pCet9-0004Z7-6O; Tue, 03 Jan 2023 11:51:23 +0100
Message-ID: <b567417f0972aed3a4b80b0e1c1ec6210c7dbd8d.camel@pengutronix.de>
Subject: Re: [PATCH] reset: uniphier-glue: Fix possible null-ptr-deref
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Hui Tang <tanghui20@huawei.com>, hayashi.kunihiko@socionext.com,
        mhiramat@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        weiyongjun1@huawei.com
Date:   Tue, 03 Jan 2023 11:51:23 +0100
In-Reply-To: <20221114004958.258513-1-tanghui20@huawei.com>
References: <20221114004958.258513-1-tanghui20@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 2022-11-14 at 08:49 +0800, Hui Tang wrote:
> It will cause null-ptr-deref when resource_size(res) invoked,
> if platform_get_resource() returns NULL.
> 
> Fixes: 499fef09a323 ("reset: uniphier: add USB3 core reset control")
> Signed-off-by: Hui Tang <tanghui20@huawei.com>

Thank you, applied to reset/fixes.

regards
Philipp
