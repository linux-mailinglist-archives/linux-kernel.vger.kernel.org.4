Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 417EB6E4E01
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 18:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjDQQGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjDQQGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 12:06:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C28185;
        Mon, 17 Apr 2023 09:06:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C66EE621BA;
        Mon, 17 Apr 2023 16:06:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C17EC433EF;
        Mon, 17 Apr 2023 16:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681747574;
        bh=B9ICfJOWuiW03DC9EdlC24TQo3MnHjUEAGRhe5FHECw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d+oLoBMbp4bbdcvhI8hmIhWrWB1ycq0JYhh+yfAg93HMR2Jgn/IO9Unhj/qvGUCAX
         yLBQBN4O1KFVJSjmPbCYfcyatNOopb8pcajtAOxdsRBpxHdceiRCMBLlMc1gN01qmW
         2Ur0igjhg8PhOjrcim8AlQZoZNFRaVPQS0OnOLnxVzqDiSFetSK/kcsJTlh2UXqfPO
         88+2tJdr/H+FpNlj3dLQLG2WpWmuDUGa2utcGPTnvuY6l0JQmy7/UqIVc+1khK3WGB
         zKPs2PwFd5mI3lFtzQ6YugCwZpMRIXa3vBh8GTXMgIii4MWBoRNhgj75jMrQtS971b
         dhzzfQieW983g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1poRMz-0000g4-St; Mon, 17 Apr 2023 18:06:22 +0200
Date:   Mon, 17 Apr 2023 18:06:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        me@1conan.com, erkin.bozoglu@xeront.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add UNISOC vendor and TOZED
 LT70C product
Message-ID: <ZD1ufX/oyif5LRY7@hovoldconsulting.com>
References: <20230417152003.243248-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230417152003.243248-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 06:20:03PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add UNISOC vendor ID and TOZED LT70-C modem which is based from UNISOC
> SL8563. The modem supports the NCM mode. Interface 0 is used for running
> the AT commands. Interface 12 is the ADB interface.
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  6 Spd=480  MxCh= 0
> D:  Ver= 2.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
> P:  Vendor=1782 ProdID=4055 Rev=04.04
> S:  Manufacturer=Unisoc Phone
> S:  Product=Unisoc Phone
> S:  SerialNumber=<redacted>
> C:  #Ifs=14 Cfg#= 1 Atr=c0 MxPwr=500mA
> I:  If#= 0 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
> E:  Ad=82(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 1 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#=10 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=07(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8b(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#=11 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=08(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8c(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#=12 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=option

I changed this to:

I:  If#=12 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=(none)

> E:  Ad=09(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8d(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#=13 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=0a(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8e(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 2 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
> E:  Ad=84(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 3 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 4 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
> E:  Ad=86(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 5 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 6 Alt= 0 #EPs= 1 Cls=02(commc) Sub=0d Prot=00 Driver=cdc_ncm
> E:  Ad=88(I) Atr=03(Int.) MxPS=  16 Ivl=32ms
> I:  If#= 7 Alt= 1 #EPs= 2 Cls=0a(data ) Sub=00 Prot=01 Driver=cdc_ncm
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 8 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:  If#= 9 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=option
> E:  Ad=06(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Next time, remember to include a brief changelog here when respinning.

Now applied, thanks.

Johan
