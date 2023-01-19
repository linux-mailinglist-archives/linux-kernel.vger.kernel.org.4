Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5105F673F87
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjASRHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjASRHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:07:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702E3A5CB;
        Thu, 19 Jan 2023 09:07:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B47D61CE5;
        Thu, 19 Jan 2023 17:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9DBC433EF;
        Thu, 19 Jan 2023 17:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674148036;
        bh=dy2HQg065wkbvQBN59EGg0efxbySx94VB4zoBym3aX0=;
        h=Date:From:To:Cc:Subject:From;
        b=Zxtfm8knK25V+i2iygIrl/LwqGZyjnBVSBksqPA50uy4OWFR5P/2dqp+Sfs4MilYe
         pR+O7YuyeVmFthVaaEJqC4jop9hTD02o05b2se0dz8m9+RQvQ0GoCbJOwwHtyRGiuo
         mAy4hciaTThgiKBR/A/eABgesUv7O9n8YUzs4erzarF06qdhIghFE8/ZlyQ2fsfUlo
         L/8h2Eq6Y84V0yi/oyN/bvHKIaGh54oWc0/nFSdAnToO9zTkiBfadL6q8eWv65Ivc2
         1GIL0JvPeGcwnN4nAjksocfooE4S64tBHN9l1hSlGif48JjB/g6SHmtyZdZdQmBXgt
         Si6q35rjn1QKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pIYO3-0007wJ-59; Thu, 19 Jan 2023 18:07:39 +0100
Date:   Thu, 19 Jan 2023 18:07:39 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.2-rc5
Message-ID: <Y8l42/yYoPZNiJa4@hovoldconsulting.com>
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

The following changes since commit b7bfaa761d760e72a969d116517eaa12e404c262:

  Linux 6.2-rc3 (2023-01-08 11:49:43 -0600)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.2-rc5

for you to fetch changes up to 71dfd381a7c051f16a61f82fbd38a4cca563bdca:

  USB: serial: option: add Quectel EM05CN modem (2023-01-16 08:47:47 +0100)

----------------------------------------------------------------
USB-serial fixes for 6.2-rc5

Here are some new device ids, mostly for Quectel modems.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Ali Mirghasemi (1):
      USB: serial: option: add Quectel EC200U modem

Duke Xin(辛安文) (5):
      USB: serial: option: add Quectel EM05-G (CS) modem
      USB: serial: option: add Quectel EM05-G (GR) modem
      USB: serial: option: add Quectel EM05-G (RS) modem
      USB: serial: option: add Quectel EM05CN (SG) modem
      USB: serial: option: add Quectel EM05CN modem

Michael Adler (1):
      USB: serial: cp210x: add SCALANCE LPE-9000 device id

 drivers/usb/serial/cp210x.c |  1 +
 drivers/usb/serial/option.c | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)
