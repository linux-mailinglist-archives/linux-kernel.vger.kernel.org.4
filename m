Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13AF667CD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjALRmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjALRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:41:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C06DB81;
        Thu, 12 Jan 2023 09:00:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C437A61FE8;
        Thu, 12 Jan 2023 17:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0A9C433D2;
        Thu, 12 Jan 2023 17:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673542849;
        bh=26KhBu0kRKblxOrkqakXSpo0g6L8nPlodh5vrUxhSDg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SR/XJKvvDLUetccH084IvpAOTyh4nH4JbPM+r6SYbya5AgOVdGjxKQCAyelzK2kCv
         gXzp0aok0HCeE1Fo2sUw3vvbg51bbUivH7Hk0jIOBlu6SsNTkqFIgfkb5uRJGW5SYa
         k8gaTrS3LhHHBEc1gF2OS4zHy628Ry21Uqoy9L9kd6qv0tlBh9dhr7X66wk0hB8DfO
         8tCukKEU1rVcU/7GIX+XQjJkwpHUgm9iK/8rZcDYkU90y/5hQTefkiC/TeS2Q3JU/f
         L/+O88d2IMS0S9vP2PDuV02mLEC11AR1K14oxo2kUiHzE3per79WwecDRhCJpNXU7E
         iNWuRJ3xW4NXA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pG0wj-0005bc-0q; Thu, 12 Jan 2023 18:00:57 +0100
Date:   Thu, 12 Jan 2023 18:00:57 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: add Quectel EC200U modem
Message-ID: <Y8A8yZXqg0usMEk8@hovoldconsulting.com>
References: <20221228113847.8550-1-ali.mirghasemi1376@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228113847.8550-1-ali.mirghasemi1376@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 03:08:47PM +0330, Ali Mirghasemi wrote:
> Add support for EC200U modem
> 
> 0x0901: EC200U - AT + AP + CP + NMEA + DIAG + MOS
>
> usb-device output:
> T: Bus=01 Lev=02 Prnt=02 Port=02 Cnt=01 Dev#= 4 Spd=480 MxCh= 0
> D: Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs= 1
> P: Vendor=2c7c ProdID=0901 Rev= 3.18
> S: Manufacturer=Android
> S: Product=Android
> C:* #Ifs= 9 Cfg#= 1 Atr=e0 MxPwr=400mA
> A: FirstIf#= 0 IfCount= 2 Cls=02(comm.) Sub=06 Prot=00
> I:* If#= 0 Alt= 0 #EPs= 1 Cls=02(comm.) Sub=06 Prot=00 Driver=cdc_ether
> E: Ad=81(I) Atr=03(Int.) MxPS= 16 Ivl=32ms
> I: If#= 1 Alt= 0 #EPs= 0 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> I:* If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=00 Driver=cdc_ether
> E: Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=84(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=83(I) Atr=03(Int.) MxPS= 512 Ivl=4096ms
> I:* If#= 3 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 4 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=86(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 5 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 6 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=88(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 7 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=89(I) Atr=03(Int.) MxPS= 512 Ivl=4096ms
> I:* If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E: Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E: Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Ali Mirghasemi <ali.mirghasemi1376@gmail.com>
> ---

Thanks for the update, looks good.

In the future when you send new revisions you should include a short
changelog here below the --- line (so that it doesn't end up in the git
log).

You should also add a version number to your Subject (e.g. "[PATCH v2]:
USB: ...").

And for my enlightenment, could you spell out what AP, CP and MOS stands
for (or what they are used for)?

Now applied.

Johan
