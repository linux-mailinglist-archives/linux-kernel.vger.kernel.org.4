Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB829639770
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiKZRZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKZRZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:25:48 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CC11CB32;
        Sat, 26 Nov 2022 09:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=oc2TrEmr5KqotgSvg9398nOl+D8T+97lMY4B5EaEzvg=; b=RsUsqCrSLnBVxNF9DQ50ZHA+TD
        uyJHRNxVAfcSDagZmeWTjuRD2W89a2yGOzAipRYzO8zJWN9QO1nr+6qik3SPp1ehavIBrd8WpTu5p
        P2e4qwAHk/YWthWNz063iq0BfeC1Fwhz2o5G0iTLUXK+Ajq7/NR9Fdc6Jvtxsqwl8VsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oyyvL-003WXJ-L6; Sat, 26 Nov 2022 18:25:07 +0100
Date:   Sat, 26 Nov 2022 18:25:07 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     eajames@linux.ibm.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        joel@jms.id.au, andrew@aj.id.au
Subject: Re: [PATCH v2] media: aspeed: Fix return value check in
 aspeed_video_debugfs_create()
Message-ID: <Y4JL89BCcs1pjWZZ@lunn.ch>
References: <20221126022813.57372-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126022813.57372-1-zhengyongjun3@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 02:28:13AM +0000, Zheng Yongjun wrote:
> In case of error, the function debugfs_create_file() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
> 
> Fixes: 52fed10ad756 ("media: aspeed: add debugfs")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Please see:

https://patchwork.kernel.org/project/linux-wireless/patch/20200429101526.GA2094124@kroah.com/

and there are other examples. Just delete all the checks.

	Andrew
