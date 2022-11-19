Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19061630EAE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 13:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiKSM2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 07:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiKSM23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 07:28:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B05C1A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:28:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF49260B68
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDB2C433D6;
        Sat, 19 Nov 2022 12:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668860905;
        bh=wE5OEvsthhALiWj82z3FTGHoJwibmtNBVW6RpZKEPTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e8xb/bFoMKPcdDTdUndazLOIPlFWtx82eSSFaOWsk2jxglhOiQ0bV4wTd02jhQrv1
         7MsN5LHIlMISHv57/P5gA6qYR8GtX/9MNTfEkqCEsM0mBpsxowaBESy0BLEDDsm2Zh
         /zh7a+sUa1lA8OKKdW3h7a46NXA4vx6vGx1zC2iU5G/1uxxr0BeHxLddqTtE24Lms4
         RsXTtVa3QOBRGhKBB0Ltv9QJW+WsBYubq5f21Dv9F+zfOdSAAZqNJMvIKMeXso0wng
         PRnBm+TUTt7y443jzg4e0beRHkm8T7ItN7on+hlw6mh/YVktT7kf56PhmFzizoPYG8
         8ZGSyzU60Trxg==
Date:   Sat, 19 Nov 2022 12:28:21 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] riscv: defconfig: add SERIAL_8250_DW
Message-ID: <Y3jL5QAI3c/joB3o@spud>
References: <20221119121953.3897171-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221119121953.3897171-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 12:19:53PM +0000, Corentin Labbe wrote:
> jh7100-starfive-visionfive-v1 DTB was recently added, but all my try to
> boot it in kernelCI failed.
> This is due to a missing serial driver in defconfig.
> So let's add CONFIG_SERIAL_8250_DW which is needed.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

See here also, StarFive guys posted the same patch:
https://lore.kernel.org/linux-riscv/Y3d0tL6UoAbdhHKE@spud/

I'll try to harangue Palmer into picking up one for v6.2 & if it
happens to be this one:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> ---
>  arch/riscv/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index f7f32448f160..9a35ff88bec2 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -123,6 +123,7 @@ CONFIG_MICROSEMI_PHY=y
>  CONFIG_INPUT_MOUSEDEV=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
> +CONFIG_SERIAL_8250_DW=y
>  CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_SH_SCI=y
>  CONFIG_VIRTIO_CONSOLE=y
> -- 
> 2.37.4
> 
