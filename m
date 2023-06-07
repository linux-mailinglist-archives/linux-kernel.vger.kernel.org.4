Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFA7263A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236388AbjFGPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbjFGPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:04:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA9F10CE;
        Wed,  7 Jun 2023 08:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6D2E636BD;
        Wed,  7 Jun 2023 15:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF46C433D2;
        Wed,  7 Jun 2023 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686150260;
        bh=JAqckUXm4rcXg68qaoKJu3AXrPyZeSW+IQr1YsqGdBQ=;
        h=Date:From:To:Cc:Subject:From;
        b=JiRkO4dvBv17/oKzfVQaGMSxXHt8tb53roZ/Kvzw9B/rzLMouU8hhs/R1N8tVltAt
         04DpwmAsoG384ryyAX4r3rBcd+QXQNQkqDvg10pegrW/nEzXFTeD6IOjX9QP8dB9WO
         Iwnhdnpl99o84KSLTbbPP3zf9hqfNxFmsUIJVL/6yY8/BfOy8keZYjmmPgJNqUkVCO
         dT2SYutQH4qDrZ8JMMdWH5BXs64ZEHCUuaOB16/7GfErnxW31atZeXf0fiJQsBO9IO
         qNp+9WaTwzoVieUO5tDguNDdFvUXu6R3bSaBtUdGND4m5nkvXHFyCRxHbRhohqr8TE
         lv7D/VkcSAIeA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q6uiJ-0005EK-N0; Wed, 07 Jun 2023 17:04:43 +0200
Date:   Wed, 7 Jun 2023 17:04:43 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial device ids for 6.4-rc6
Message-ID: <ZICci0PIId0FlVuV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.4-rc6

for you to fetch changes up to f1832e2b5e498e258b090af3b065b85cf8cc5161:

  USB: serial: option: add Quectel EM061KGL series (2023-06-02 11:06:50 +0200)

----------------------------------------------------------------
USB-serial device ids for 6.4-rc6

Here are some new modem device ids.

Everything has been in linux-next with no reported issues.

----------------------------------------------------------------
Jerry Meng (1):
      USB: serial: option: add Quectel EM061KGL series

 drivers/usb/serial/option.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
