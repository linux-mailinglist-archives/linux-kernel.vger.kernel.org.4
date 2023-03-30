Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B96D0C29
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjC3REb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3RE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:04:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD78FDBD8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:04:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 707BE620D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14632C433EF;
        Thu, 30 Mar 2023 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680195864;
        bh=hA56lFC26dHtZ4WHOglCEyR6sSNfxMpZJNIzvD9aBy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JkzwekvFFV493u37Yd4URHvn68Q0Ajlgg2/sFFJaqDbYTQiI1E/nh0w9kkJINb+Dw
         GScCzmbLxvsd4ZkaXTum5xLAlixPOK+W6Q2U3ce/Fb9P0SH3f4aOYjvhJ1+DBjBmvd
         jxXLfey4rJTDjE5/zJkXVr504SeeUO581k4q7fd8A1SUaHWA8ZLJazSidSvseOpspi
         kj1nJgqok2y5rr7PQa3JiQtu2R8QWw/r2AZ2/Xz18ApMnIXHhqwhb+lXn1a80ZlWzG
         MBeEBUoBy9JojKnYEimYDPq5yecAoO0v7quB1cSGRV5MZv0MnyvalEkJoHa+OuXymd
         3YMlQ80WjSzig==
Date:   Thu, 30 Mar 2023 18:04:20 +0100
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: axp20x: Fix axp288 writable-ranges
Message-ID: <20230330170420.GC489249@google.com>
References: <20230329205544.1051393-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230329205544.1051393-1-hdegoede@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023, Hans de Goede wrote:

> Register AXP288_POWER_REASON is writable and needs to be written
> to reset the reset- / power-on-reason bits.
>
> Add it to the axp288 writable-ranges so that the extcon-axp288
> driver can properly clear the reset- / power-on-reason bits.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/mfd/axp20x.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
