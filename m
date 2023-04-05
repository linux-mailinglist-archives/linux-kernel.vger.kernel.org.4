Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D136D7ACC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237582AbjDELL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237314AbjDELLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3311C4EF2;
        Wed,  5 Apr 2023 04:11:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C097263CB4;
        Wed,  5 Apr 2023 11:11:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 026CBC433D2;
        Wed,  5 Apr 2023 11:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680693073;
        bh=XECmjtuqJG7MMdVpMzr8ofA4bkH3gapSSUKkhDgD5PU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=QxjN1rEjNQF5GHOPbgDRLJiLnEu9WLWZ7x+1wx1VdqHwgj8N/IWBgaesYSa9sR3le
         tv0/sIgQScq6xrinbQP4M84qiOA21xXgNF2GWeL0FEzJXmMdJJU6+Eq/oq5H6yf/Tc
         tYU5/t6dKPBDN4NLqiQD7h8M7e+kbwjygwFP++ngunqrWKPEBzZauevHOBYUGY1OtU
         jFgh5fdabkBS4fN/EiP68qi7E06LyIYrKT9bUHWUlFtwQn/WNsJrjAO2cGi36RVbM9
         CpE5XexFl5g4itKptCcQyvt8CA+4HkkPuwLs3ii0vIs8TItv7l06TEUIMryNAO39Gl
         0gwaQ8/ZPaejA==
Message-ID: <29b27566-a300-fa3c-6b37-0df6ee2b2bb3@kernel.org>
Date:   Wed, 5 Apr 2023 14:11:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/3] arm64: dts: ti: k3-am625: Enable Type-C dual-role
Content-Language: en-US
To:     nm@ti.com, vigneshr@ti.com
Cc:     kristo@kernel.org, srk@ti.com, r-gunasekaran@ti.com,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230330084954.49763-1-rogerq@kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230330084954.49763-1-rogerq@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 30/03/2023 11:49, Roger Quadros wrote:
> Hi,
> 
> This series enables Type-C port on USB0 for both am625-sk and am62-lp-sk.
> Series is based on [1]
> 
> cheers,
> -roger
> 
> Changelog:
> v3:
> - include Type-C support for am62-lp-sk
> - split interrupts properties for Type-C chip into am625-sk
> 
> v2:
> - rebase off [1]
> - add fixes tag to patch 1
> 
> [1] - https://lore.kernel.org/all/20230321-am62-lp-sk-v2-0-0a56e1694804@ti.com/
> 
> cheers,
> -roger
> 
> Dhruva Gole (1):
>   arm64: dts: ti: k3-am625-sk: Add ti,vbus-divider property to usbss1

This one was picked from v2 series, so please ignore.

> 
> Roger Quadros (2):
>   arm64: dts: ti: k3-am625: Enable Type-C port for USB0

Could you please queue the above patch? Thanks!

>   arm64: dts: ti: k3-am625: Use interrupt line for Type-C chip

This one is up to you/TI if you want to maintain support of
1.2 Boards or not. Feel free to drop this if Rev1.2 boards
need to be supported.

> 
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts        |  8 ++++-
>  .../arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 36 ++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 

cheers,
-roger
