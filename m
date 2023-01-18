Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC47467248F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjARRQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjARRQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:16:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7EC58290
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 09:16:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AA4BB81DA7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 17:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F59C433EF;
        Wed, 18 Jan 2023 17:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674062181;
        bh=7Rm4jQdN1OkFflN97SFAbA4tT29tk5E2fWswez94coM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fjz+B5WxgjkfjR6nAztq5No92inuDPAf6rMkn0T2Vaz0E1nc9JTl41HUXItM+/cX2
         Ayqc5eq84USh2Wbyv1BgNaJOKQliXBGRXkMDAgtuBYhCtvDYxlA/ldVplW1Yp5igKS
         bcFUk+uQ0RbAkRqr21G4Sd9VTqnOv/bM5nHVWni6hH60KIKFFU1ZeSwDQaHUkzfJSQ
         XeCxE3lJdrMDOm5IlB8SfZioGXRJsYqhmZlHKTdmPvVbFpWwAY2R00BxNcgQ1ahFqO
         SDUoVqJrfLBwA1M9osIp5iYc2a8h+z6amBJdeW6kHlPkXUHo+Fql+oXp2/9At32uP1
         z+TmUYWiwkV3A==
Date:   Wed, 18 Jan 2023 22:45:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
Subject: Re: [PATCH V4 0/2] phy: ti: j721e-wiz: Add support to manage type-C
 swap on Lane2 and lane3
Message-ID: <Y8gpQExHEVPe0g9j@matsya>
References: <20230113150615.19375-1-sinthu.raja@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113150615.19375-1-sinthu.raja@ti.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-01-23, 20:36, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> Hi All,
> This series of patch add support to enable lanes 2 and 3 swap by
> configuring the LN23 bit of the SerDes WIZ control register. Also,
> it's possible that the Type-C plug orientation on the DIR line will
> be implemented through hardware design. In that situation, there
> won't be an external GPIO line available, but the driver still needs
> to address this since the DT won't use the typec-dir-gpios property.
> Update code to handle if typec-dir-gpios property is not specified in DT.

Applied, thanks

-- 
~Vinod
