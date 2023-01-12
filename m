Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7B7667EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239769AbjALTJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbjALTIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:08:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9ED3DBE1;
        Thu, 12 Jan 2023 10:52:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C65F0B81FF6;
        Thu, 12 Jan 2023 18:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E57C433D2;
        Thu, 12 Jan 2023 18:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673549536;
        bh=Jba72/DAGxvyvB/sulJwb3df9Ztjep6VTULXL2Mp2T8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Yd5HXsToHcdoezIX4SGuBAqXLHxjyL5Y3hEHADg2Zqi3bflccWcH44fATHn8lLuOD
         IElQXYCTuz3yseoTtr+0ptDO/p9M4T0n/YPJ+U/VDUqcESBDFiYeAVbz/pTAx3XWws
         KpQ9fbS3B8pO4lWlR4FwBFqCJgPMPahgG0XYpjPOeCOne+u7O6Kjh5YIUJ/edjLoes
         PFt5Dt4sgn2xRv9EGbHt5NutMI+3cE6pNpDFgnzLVefhLWe6Oorys0c3DB5nKcI5+a
         OoUfNHR6/ibKIl/5u6snfO6wKosAT8DhpZznd2UNN2cLr3vIb07JIcbMaMeBQsaEvZ
         08k4m9Yedp/lw==
Date:   Thu, 12 Jan 2023 19:05:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrew Hepp <andrew.hepp@ahepp.dev>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: temperature: Add MCP9600 thermocouple EMF
 converter driver
Message-ID: <20230112190551.4d9ac5f6@jic23-huawei>
In-Reply-To: <20230108234503.2803-1-andrew.hepp@ahepp.dev>
References: <Jonathan Cameron <jic23@kernel.org>
        <20230108234503.2803-1-andrew.hepp@ahepp.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Jan 2023 15:45:04 -0800
Andrew Hepp <andrew.hepp@ahepp.dev> wrote:

> From: "Andrew Hepp" <andrew.hepp@ahepp.dev>
> 
> Add support for the MCP9600 thermocouple EMF converter.
> 
> Datasheet: https://ww1.microchip.com/downloads/en/DeviceDoc/MCP960X-Data-Sheet-20005426.pdf
> Signed-off-by: Andrew Hepp <andrew.hepp@ahepp.dev>

Driver looks good, but now I realise we don't have a device tree binding doc.

Please add one for v3.

Note that the binding doc is describing the hardware, not what the driver
currently supports alone, so include the 4 (or 6?) interrupt lines (and interrupt-names
as any random subset of them might be provided) + VDD regulator + anything else I've
not noticed in my 10 second look at the datashet.

Thanks,

Jonathan

