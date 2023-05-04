Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B7B6F671E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjEDIRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEDIQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:16:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665304ECF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECCFE6321B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:12:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B469C433EF;
        Thu,  4 May 2023 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683187978;
        bh=lw5bGqmQmlqX8tgBw7ja1cDkM+Gc6V5MlhP8g2TZBng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F8OxTNd+lz/QfW0Hy6B095VVDbNcaE/rWJFD5fkO6Zbpl30M/DmZKxyAjm6BWKinr
         /ooRbnD11pN5PryselhUk+LjMG2tF7NlyzUiOleQReuvmi9aGEKP43WaFiHphfAbV2
         dJVCAIlif05C2Gjgk9P8gDvGObCCtR3fh5wO0n51j9U6rIZgU+HBEeeEiYPpBxXL59
         I2aBXuqymUbqoZWYVetYrSrZT4IS0qxSrmL6GXjW1bLOElWk3o2Mz/FZ4wtMil7DIg
         eu3ZW86fXPiI+tnX25L/gOT9vF0bckzn2t5X+JPeXnituxejk2cV0qXyy5BzQYsP6S
         5ZlQ/JHCdXXUQ==
Date:   Thu, 4 May 2023 11:12:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     wei.fang@nxp.com
Cc:     claudiu.manoil@nxp.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: enetc: check the index of the SFI rather than
 the handle
Message-ID: <20230504081253.GV525452@unreal>
References: <20230504080400.3036266-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504080400.3036266-1-wei.fang@nxp.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 04:03:59PM +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> We should check whether the current SFI (Stream Filter Instance) table
> is full before creating a new SFI entry. However, the previous logic
> checks the handle by mistake and might lead to unpredictable behavior.
> 
> Fixes: 888ae5a3952b ("net: enetc: add tc flower psfp offload driver")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_qos.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
