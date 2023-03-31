Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36A6D21B8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCaNut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjCaNuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:50:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3259A1EFEC
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B888BB82E86
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEA2C4339C;
        Fri, 31 Mar 2023 13:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270632;
        bh=2cykrbzQ+KKCSCcE8DJnTcmAUhli8KdUwSPQn/1+oCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g2kw+MJuxfkxrMlpRGDu7Hv5mveuj45k8vF1WmmYNmNZ6gVv3AA+T9tWdX8MITEFM
         cTkcslzZ2Mf6j7eJmKVjGpPHsW47g3R2rUT8dk8ACrPp6kGuOTCUqA/3vfqYDP7JQB
         wx/o0Eu1dXfgLzW61cTnwr80LbvOvjRxi/UMhbc0nOke5ZohczTE8daQU0XHghdHBu
         vxnNYCzMXeJXQn/RfWrZDUOsdcaTQTmYXJukgfYHwE3TJ78VCHFjLFwZ68pvK3DjTX
         p9ow5UcvbQu+/MW0CxDVt9WVWMbWSPvNlHpehn24jHOLF+j0H7kAgQynZBRAI0vHEO
         YvahmfzMUWtWA==
Date:   Fri, 31 Mar 2023 19:20:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     kishon@kernel.org, u.kleine-koenig@pengutronix.de,
        linmq006@gmail.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: omap-usb2-phy: Use dev_err_probe()
Message-ID: <ZCblJLBTPMS4z8Mf@matsya>
References: <202303231545522162256@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303231545522162256@zte.com.cn>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-23, 15:45, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with dev_err_probe() to simplify the code.

Applied, thanks

-- 
~Vinod
