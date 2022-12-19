Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDE06512D8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiLSTX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiLSTWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:22:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D472F2BE4;
        Mon, 19 Dec 2022 11:22:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7975D61128;
        Mon, 19 Dec 2022 19:22:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330F3C433EF;
        Mon, 19 Dec 2022 19:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671477719;
        bh=BsVW7nBW0JyR1X51GuVCbY5VjNsqrXE+JuPEVVvwtdM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBY3cCf3ym6j5r/I/4YZRaVH8/hgz/A48VUKHvrrQwIXxvb3pTXxTf5OgcpMSVFqr
         r/6+zh/UtDTsYlrcnuD7lnpd2yogkC68NWUb3uDHXI250CLDnop6rhKB78KReZf2k0
         AJF7kNtOdZast0c0y/15hu0dWUht2DsBOVGwgA5c=
Date:   Mon, 19 Dec 2022 20:21:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v8 1/9] imx: Fix typo
Message-ID: <Y6C51KVSviGrLmsb@kroah.com>
References: <20221216221703.294683-1-allenwebb@google.com>
 <20221219191855.2010466-1-allenwebb@google.com>
 <20221219191855.2010466-2-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219191855.2010466-2-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 01:18:47PM -0600, Allen Webb wrote:
> A one character difference in the name supplied to MODULE_DEVICE_TABLE
> breaks a future patch set, so fix the typo.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  drivers/soc/imx/imx8mp-blk-ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/imx8mp-blk-ctrl.c b/drivers/soc/imx/imx8mp-blk-ctrl.c
> index 0e3b6ba22f943..344a0a71df14a 100644
> --- a/drivers/soc/imx/imx8mp-blk-ctrl.c
> +++ b/drivers/soc/imx/imx8mp-blk-ctrl.c
> @@ -743,7 +743,7 @@ static const struct of_device_id imx8mp_blk_ctrl_of_match[] = {
>  		/* Sentinel */
>  	}
>  };
> -MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
> +MODULE_DEVICE_TABLE(of, imx8mp_blk_ctrl_of_match);

What commit id does this fix?  Shouldn't this be also cc: stable to
resolve this issue for older kernels as obviousl the module device table
for auto-loading is not correct?

thanks,

greg k-h
