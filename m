Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA0962953F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiKOKFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiKOKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:05:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26F9F07;
        Tue, 15 Nov 2022 02:05:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 959ECB81719;
        Tue, 15 Nov 2022 10:05:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4828FC433D6;
        Tue, 15 Nov 2022 10:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668506720;
        bh=0VWOnD5ES4ByShes0ha9JcpP/u3C1DtCeKcpMZ9qbeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HJKzWxzGrb+NVL+TI9+5ibIeW6ntrlARjKfyKVIPcrruYpaU5SY9wvpvB7qVkCWI9
         W00X2cb7tqrxACaIyni3QYxlSO0E72CDI2//o8dpUp2ys0ONUE1LwdBWbK8TgvK1WG
         ERkit0Veq1NolCy/DA8/ANRdREmj9UyJd/4vvBxuOIc3up49Y46L0cMTTZiLpjBvNJ
         PJTk+hEfs5xFpmDdxofg4ALVnLC7MG5NAehGF2e+Ll/91zyvUTC3J1p30Pcnt4y0s0
         mkGWLo+8H3AjwjeO4zYIYzIUzlzQ0lfZXxLuWipQV+y7UbYwUV1lanXkKJIN1XeEqK
         MXLI+H2A6BgrQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ousoE-0005rH-0G; Tue, 15 Nov 2022 11:04:50 +0100
Date:   Tue, 15 Nov 2022 11:04:50 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Duke Xin <duke_xinanwen@163.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH]     USB: serial: option: add Quectel EM05-G modem
Message-ID: <Y3NkQnwQcVYXLaG3@hovoldconsulting.com>
References: <20221111035631.7723-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111035631.7723-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:56:31AM +0800, Duke Xin wrote:
>     The EM05-G modem has 2 USB configurations that are configurable via the AT
>     command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
>     the following interfaces, respectively:

The commit message (including Subject) should not be indented like this.

>     Signed-off-by: Duke Xin <duke_xinanwen@163.com>
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Johan Hovold <johan@kernel.org>

And I certainly have not signed-off on this yet. You must not add SoB
for anyone but yourself. Please review the process documentation for
what a SoB imply and how it is used, and try again.
 
> Signed-off-by: Duke Xin <duke_xinanwen@163.com>

Johan
