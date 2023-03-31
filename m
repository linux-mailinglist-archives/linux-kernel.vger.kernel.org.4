Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CB66D1851
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjCaHRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCaHR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:17:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3378F754;
        Fri, 31 Mar 2023 00:17:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DA3C623EA;
        Fri, 31 Mar 2023 07:17:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A39C433D2;
        Fri, 31 Mar 2023 07:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680247047;
        bh=AXwxn0d1JWq/d/6g6xIlQAfzy1Farq7DPkBu8ZLqI8Y=;
        h=Date:From:To:Cc:Subject:From;
        b=Uu1P2EX0364gzGtW9VEXpbVqQkxFrWlfWaZOFIUgPyOOFcBhdEvbrFp4XBNda86mX
         uLxO3eL46QqSVrheJmWRReEdKZzLfe4Bxcz2bJX/HD5pwW2C75YfNbGpnYAjt56dcP
         JkpGFay9jjiZJHpLAoypjbQuHLZEVJhBZpHLsvnhVS2P+/kCeDxcnElg1T2At5I0Q0
         gNZaGlkT/frQgeRGYX4ntKp0UBEnZO4625zeNad4S8O5d+WhADpg+r9Wx+gohYCT/k
         BCAuN/Iy9xoPdysswYfOon15mINqYUq2eF8yOgOSBHokLJoHlHjbKEUcwqctpzcN58
         OV91rayHGgRhA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pi91B-000668-68; Fri, 31 Mar 2023 09:17:49 +0200
Date:   Fri, 31 Mar 2023 09:17:49 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.3-rc5
Message-ID: <ZCaJHdTl6HwpzOBd@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.3-rc5

for you to fetch changes up to 7708a3858e69db91a8b69487994f33b96d20192a:

  USB: serial: option: add Quectel RM500U-CN modem (2023-03-29 11:46:04 +0200)

----------------------------------------------------------------
USB-serial fixes for 6.3-rc5

Here are some new device ids for 6.3.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Bjørn Mork (1):
      USB: serial: option: add Quectel RM500U-CN modem

Enrico Sau (1):
      USB: serial: option: add Telit FE990 compositions

Kees Jan Koster (1):
      USB: serial: cp210x: add Silicon Labs IFS-USB-DATACABLE IDs

 drivers/usb/serial/cp210x.c |  1 +
 drivers/usb/serial/option.c | 10 ++++++++++
 2 files changed, 11 insertions(+)
