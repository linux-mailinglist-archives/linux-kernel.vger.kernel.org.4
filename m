Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997CD5E63AA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiIVNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiIVNe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:34:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028F9481E7;
        Thu, 22 Sep 2022 06:34:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C618B836C9;
        Thu, 22 Sep 2022 13:34:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E72BC433D6;
        Thu, 22 Sep 2022 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663853691;
        bh=+My+Fy2IEDmbNTy7T8HNxYYgJowz92MhqyGRMiqJV6o=;
        h=Date:From:To:Cc:Subject:From;
        b=DnbzjENuc3OsMdOKj1NBCvu0nD5yXopwHjgT1w9EoUFOXUvcliNFiRL0BeqRQ7etA
         nqKcojqalTNfYbWYmVLnRCEIf0OUKGJtQZsLADdi7RD8JtILZ5nJCm4hVK1D2mFo6c
         4tPgPnJepTYCQdE+OHIjfGYux8UmExUSBvYUOs6mDthRwr20HP2LQ7Peq/Vj7Bq8Sl
         AsCgwYvq1TDwG0wm0bgv7zU0JivNl/jLSTZbXzjtXBnI/HjR3IKcn/6LVw8mnuZszH
         CJ/nC4h9GzU0ptNhFWfDcaPiIP6xonarxL8foqEAsw+64Vk3fII2YB81p4EhD+ZKNp
         vEP3aTZvNvo5A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1obMLw-0005Fb-PD; Thu, 22 Sep 2022 15:34:56 +0200
Date:   Thu, 22 Sep 2022 15:34:56 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.0-rc7
Message-ID: <YyxkgPNrbp7g/+w5@hovoldconsulting.com>
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

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.0-rc7

for you to fetch changes up to d640c4cb8f2f933c0ca896541f9de7fb1ae245f4:

  USB: serial: option: add Quectel RM520N (2022-09-13 14:40:59 +0200)

----------------------------------------------------------------
USB-serial fixes for 6.0-rc7

Here are some new modem device ids.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Carl Yin(殷张成) (1):
      USB: serial: option: add Quectel BG95 0x0203 composition

jerry meng (1):
      USB: serial: option: add Quectel RM520N

 drivers/usb/serial/option.c | 6 ++++++
 1 file changed, 6 insertions(+)
