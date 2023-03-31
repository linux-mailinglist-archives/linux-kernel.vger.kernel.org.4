Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0562C6D218A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjCaNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjCaNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:39:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81456B459
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:39:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 136CBB82F78
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D640C433EF;
        Fri, 31 Mar 2023 13:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680269938;
        bh=9Ont13GCZOGcHqmKRrh5cFvPZ59+SXkgaQM1wrfLLz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TC5vimUVWe9dr2dpx3CZ5QghYIyL4v/LknOzZWt6UFn+fX0JXAlDLipCoBeNbC+kc
         im3UN8alv8woUfpsP3h9p0+SJ8yHH1O9bcjTqqie3qxpd5DJRAr7K2EG/AlGewi8Vw
         M9BZqmQUp0U6HCnVvaZMIJqdX1iO/l12ueihtxBXLrRKxVR0Fmyu8CAasOPMKIAjOI
         GxPWVUciJI2rQ7qqyPAnLMBnpcRd3b4+7jPF4JBmljy2XllEO+P79yRK+aFQVJM2i9
         PXVKrDAtVYUzXa1arXXZ2lw0G5VZK/secucFxDZdvvgJvdgRpjXtsOGUe4voD0rRxE
         7hcHsf3wgDy0w==
Date:   Fri, 31 Mar 2023 19:08:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc:     laurent.pinchart@ideasonboard.com, kishon@kernel.org,
        michal.simek@xilinx.com, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com
Subject: Re: [PATCH v2] phy: xilinx: phy-zynqmp: mention SGMII as supported
 protocol
Message-ID: <ZCbibnS856BjpBwS@matsya>
References: <1679940407-13131-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679940407-13131-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-03-23, 23:36, Radhey Shyam Pandey wrote:
> SGMII is validated on kria KR260 robotics starter kit. So modify the
> comment description to include it in supported controllers list.

Applied, thanks

-- 
~Vinod
