Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EBB640C93
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiLBRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiLBRt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:49:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C185ADEA66;
        Fri,  2 Dec 2022 09:49:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CDD862357;
        Fri,  2 Dec 2022 17:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFDEC433D6;
        Fri,  2 Dec 2022 17:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670003393;
        bh=CblL8ydwbBdpAe/5HVIIDsm/uKqgdmAcAKbunAtlkPU=;
        h=Date:From:To:Cc:Subject:From;
        b=IeWELsnLABBDt7Z8JO82tcTQxXq1hQURYtDaoJG2OkeYfzsKpqjiDbIxoZEMqFgN6
         dhwSjCW86oukSljarLeN9C7dD3PuNYwdYYb2cLBE45/EMMrL1oK5/F1mQkGeKFzE8w
         THJm0wlWbb1RMOaM9VKSSzc8rT79yFqe1MtaF5ODxM1z259+pJ9dTo9lg8DoFSmGV4
         K+QrZiKPt2P8u5KLp8uL8EyXK3ornv9OyLGkDp481ZgJfpwtOGPcU0n4Td5tIPbOn1
         d6dcur7ij8/tNwYdZECTQbbCtrY/GzAfgPTLwCgLwdbmMhtDutR8i3Ua2HcFXTm0hl
         JUV08JlPMHzew==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p1AAk-0006py-T9; Fri, 02 Dec 2022 18:50:02 +0100
Date:   Fri, 2 Dec 2022 18:50:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.1-rc8
Message-ID: <Y4o6ypWhDfI8DPuO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b7b275e60bcd5f89771e865a8239325f86d9927d:

  Linux 6.1-rc7 (2022-11-27 13:31:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.1-rc8

for you to fetch changes up to 188c9c2e0c7f4ae864113f80c40bafb394062271:

  USB: serial: f81534: fix division by zero on line-speed change (2022-11-30 12:27:59 +0100)

----------------------------------------------------------------
USB-serial fixes for 6.1-rc8

Here are two fixes for a division-by-zero issue in the Fintek drivers.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Johan Hovold (2):
      USB: serial: f81232: fix division by zero on line-speed change
      USB: serial: f81534: fix division by zero on line-speed change

 drivers/usb/serial/f81232.c | 12 +++++++-----
 drivers/usb/serial/f81534.c | 12 +++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)
