Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96E6A96F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 13:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCCMFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 07:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCCMFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 07:05:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E2318B12
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 04:05:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C95A617DF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:05:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2CAC433EF;
        Fri,  3 Mar 2023 12:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677845131;
        bh=e/0JSlFhNci0Pfyw5L2eLHuauFJ2NVbf5e1PUmw9sPk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YN4NK9SSyEA6RNV7YzFmyqlS6KbFqymrAn6E90wlvHNoKeDWEj9MWH1iW8QOWPwnI
         k6RW7UxFZltjpCj+P8Y0pHqm4wn/E33d7iiN116tX0AaPBxW/MG2R5PXdwOqJFpxF4
         AEhZellRmukN72UBhiHlqVpM1muErn+KqGFLEAGVBaNMRkbb4XxmHiDg7CiqmCvDnw
         +YrCCUBuiVMMreQsdTs42+VM1+6Ww+8B1ljdLvlzQFX1inIMtvycSS8A7OaZ2lVOk1
         RjVRGgMSTMyPNv5yUP43thLOB0WSgnAiTpo/RYKuEKXZrD9yrONcw2IrQXJrarIXva
         RQOPv9tKMzt5Q==
Date:   Fri, 3 Mar 2023 12:05:27 +0000
From:   Lee Jones <lee@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com
Subject: Re: [PATCH v2 3/3] mfd: tqmx86: correct board names for TQMxE39x
Message-ID: <20230303120527.GL2420672@google.com>
References: <e8300a30f0791afb67d79db8089fb6004855f378.1676892223.git.matthias.schiffer@ew.tq-group.com>
 <aca9a7cb42a85181bcb456c437554d2728e708ec.1676892223.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aca9a7cb42a85181bcb456c437554d2728e708ec.1676892223.git.matthias.schiffer@ew.tq-group.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Feb 2023, Matthias Schiffer wrote:

> It seems that this driver was developed based on preliminary documentation.
> Report the correct names for all TQMxE39x variants, as they are used by
> the released hardware revisions:
> 
> - Fix names for TQMxE39C1/C2 board IDs
> - Distinguish TQMxE39M and TQMxE39S, which use the same board ID
> 
> The TQMxE39M/S are distinguished using the SAUC (Sanctioned Alternate
> Uses Configuration) register of the GPIO controller. This also prepares
> for the correct handling of the differences between the GPIO controllers
> of our COMe and SMARC modules.
> 
> Fixes: 2f17dd34ffed ("mfd: tqmx86: IO controller with I2C, Wachdog and GPIO")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> Notes:
>     v2: add Reviewed-by from v1
> 
>  drivers/mfd/tqmx86.c | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
