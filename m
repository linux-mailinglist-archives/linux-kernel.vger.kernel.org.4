Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE96E8A93
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 08:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjDTGmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 02:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjDTGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 02:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AE1FE5;
        Wed, 19 Apr 2023 23:42:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A87316450A;
        Thu, 20 Apr 2023 06:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109E6C433EF;
        Thu, 20 Apr 2023 06:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681972947;
        bh=GQt+GoFjABs4aceTR9MNU5+oU0X2Ai7nkgoUNChOqVQ=;
        h=Date:From:To:Cc:Subject:From;
        b=WF27kcoHaU8ZAa5js5cYFQZYk2j0xu2AVW+k1fsCMF5F84hGUlluf6xs+CV1pcqPr
         zeHMKff7UqelY1ngCN5m7lnuGOVWGzcZeYK4cmO1UVcFDtMKQcfcwdsA9QOcL3xr+b
         szisu64ICsHWQrI5KzRssCWQ6RqyFdct4ccHDiqUqUImvJVYdBrRZEcXWr5m+BN9CH
         5jWY2acXvX6motqN1YGchF6nOLyb3tOT9Lz7+m72EWwoqXNVyLU8VOQmjOsqOt8rhQ
         aRYWQsfw1sOGqS3rfmCWStfWotsHVnmHqCm4caJ+OMMd3TO/aUjCQudITZ0EstXMD5
         lQIGwSy8ST/HQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1ppO0A-00027A-VD; Thu, 20 Apr 2023 08:42:43 +0200
Date:   Thu, 20 Apr 2023 08:42:42 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.4-rc1
Message-ID: <ZEDe4o98cD8y425T@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:

  Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.4-rc1

for you to fetch changes up to a095edfc15f0832e046ae23964e249ef5c95af87:

  USB: serial: option: add UNISOC vendor and TOZED LT70C product (2023-04-18 08:43:49 +0200)

----------------------------------------------------------------
USB-serial updates for 6.4-rc1

Here are the USB-serial updates for 6.4-rc1; a new modem device id and
an unused-function cleanup.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Arınç ÜNAL (1):
      USB: serial: option: add UNISOC vendor and TOZED LT70C product

Tom Rix (1):
      USB: serial: quatech2: remove unused qt2_setdevice function

 drivers/usb/serial/option.c   | 6 ++++++
 drivers/usb/serial/quatech2.c | 8 --------
 2 files changed, 6 insertions(+), 8 deletions(-)
