Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63EB710B59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbjEYLq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbjEYLqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:46:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D23B2;
        Thu, 25 May 2023 04:46:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F4C64508;
        Thu, 25 May 2023 11:46:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047B1C433EF;
        Thu, 25 May 2023 11:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685015211;
        bh=hvQvKT4nAPviAmC/IZz++HRsgLSVOvED0o4k4Xq/toc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ogcQpLf86n17xXQzW/VqrM28cLDGgD2JrFIajG5QccN1k3K4MFeYljdYX4uxgI7NN
         6D6CPHA+tXJ7ceP/7psDikRj6tSJPk5vakn78grRo8h0kMV3slFpkJ8kv7GZru+gC3
         qGIYIK0zR4qHasSkZ8LBK8/GHtzmzN64PgToEYp6cnBJNvFR9Qu+ib3FMDLVn4e0Wx
         KAlhzH230pc76xH6TTZOudnF3gq9amcnpeNEZTm0arTQVgxB7Ob3DKmga+lezrqPL+
         cNe6BJHyDkMGPL43Q4vKuiu/y9+R9wkbwed5EQaPpccILgIzZMxbP8BykbVvaEKVll
         gwXpQ/vQazOFQ==
Date:   Thu, 25 May 2023 12:46:46 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: stpmic1: fixup main control register and
 bits naming
Message-ID: <20230525114646.GK423913@google.com>
References: <20230516132225.3012541-1-sean@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230516132225.3012541-1-sean@geanix.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023, Sean Nyekjaer wrote:

> Fixup main control register and bits naming so the match the naming from
> the datasheet.
> 
> https://www.st.com/resource/en/datasheet/stpmic1.pdf
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - None
> 
>  drivers/mfd/stpmic1.c       |  4 ++--
>  include/linux/mfd/stpmic1.h | 12 ++++++------
>  2 files changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
