Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED1369968F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 15:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjBPOCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 09:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBPOCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 09:02:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2633CE0F;
        Thu, 16 Feb 2023 06:02:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8BE36102F;
        Thu, 16 Feb 2023 14:02:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C35AC433D2;
        Thu, 16 Feb 2023 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676556140;
        bh=dHP7afTMssAraR/AP33Ri716VNh8iI75EwxUlYOCQrI=;
        h=Date:From:To:Cc:Subject:From;
        b=d5PDJhr0zNsMxp6BcH6VJudfNzUtf1a5jjEffQQGffIYg14IlMZw3mc6UsVk5n6y9
         kaJzq3gNqUa1wfh9ikAhlQ2fGhnZXciP3DuWRVOCG7SuBRMQYwHEcWtjE3FZNMjT4f
         bagMILzXO0reE0Q6hladfGj0vdobcZv5w1SCHnt0uLlE0/iMrbrsrASf2A6qEPMF8c
         KEyBVse8xorTZNHVuulzZZ5MVcTDQAfBSJE1RATres+hbXuRBKpdKLpf8z9WksWKLB
         6jGXdZY9m7hgurKnETM5lFPkyp7OoWn0/6zQuu6kjFffAAo7WlLAtStC2A/k327JrR
         qGz3Yh3dWT3Yw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pSer1-0003r7-Rb; Thu, 16 Feb 2023 15:03:19 +0100
Date:   Thu, 16 Feb 2023 15:03:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial updates for 6.3-rc1
Message-ID: <Y+43p6kp0kJN/slK@hovoldconsulting.com>
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

The following changes since commit 4ec5183ec48656cec489c49f989c508b68b518e3:

  Linux 6.2-rc7 (2023-02-05 13:13:28 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.3-rc1

for you to fetch changes up to 617c331d91077f896111044628c096802551dc66:

  USB: serial: option: add support for VW/Skoda "Carstick LTE" (2023-02-06 09:16:32 +0100)

----------------------------------------------------------------
USB-serial updates for 6.3-rc1

Here are the USB-serial updates for 6.3-rc1; just a new modem device
id this time.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Florian Zumbiehl (1):
      USB: serial: option: add support for VW/Skoda "Carstick LTE"

 drivers/usb/serial/option.c | 4 ++++
 1 file changed, 4 insertions(+)
