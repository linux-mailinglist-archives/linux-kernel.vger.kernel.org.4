Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA1762D9AF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239722AbiKQLlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239870AbiKQLl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:41:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3151F19C04;
        Thu, 17 Nov 2022 03:41:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1C0F60B8F;
        Thu, 17 Nov 2022 11:41:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29362C433C1;
        Thu, 17 Nov 2022 11:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668685281;
        bh=WphV4BiGGuQqGN4b0cOIfXIPPOBlEwuMai1atk2YE+k=;
        h=Date:From:To:Cc:Subject:From;
        b=a+68R2sxxE4JabramqssF9v1bk3Ah547dW85ViBSiYAGAvnlIZJEy/AB0+DpqJszX
         XGuBgWMpFn5wb72qfhlfXwqcOq9htFRb80tupmx5kS/MH+6LBwFoILM+n6XXl1q60R
         ZN9k7Sc8xKSyUcmxk6px8vpMgkDZLp4lJIoLGQPzH/INdlufN02sTsJCoMvFFSbySj
         O9uPghjC6SBECdx5hBWgz+jQi99qIV5NTO9F+KcqVRjN9zmx6Zmdh2jgex4EE6X+/+
         nNlUM5PbfCmatto4qi3GhkUicFCRlK9b4HVDuRUwnZqIvL/MvTOm8E/YCtZKMUK1m/
         fYVqJWDBpYvTA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ovdGH-00041b-JW; Thu, 17 Nov 2022 12:40:53 +0100
Date:   Thu, 17 Nov 2022 12:40:53 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.1-rc6
Message-ID: <Y3YdxR2djUf0ibBC@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.1-rc6

for you to fetch changes up to c1547f12df8b8e9ca2686accee43213ecd117efe:

  USB: serial: option: add u-blox LARA-L6 modem (2022-11-16 17:19:43 +0100)

----------------------------------------------------------------
USB-serial fixes for 6.1-rc6

Here are some new modem device ids for 6.1.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Benoît Monin (1):
      USB: serial: option: add Sierra Wireless EM9191

Davide Tronchin (3):
      USB: serial: option: remove old LARA-R6 PID
      USB: serial: option: add u-blox LARA-R6 00B modem
      USB: serial: option: add u-blox LARA-L6 modem

Reinhard Speyerer (1):
      USB: serial: option: add Fibocom FM160 0x0111 composition

 drivers/usb/serial/option.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)
