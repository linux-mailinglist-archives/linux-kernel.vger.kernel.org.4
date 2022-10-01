Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8465F1ADB
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiJAILP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 04:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJAILK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 04:11:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB8A76969;
        Sat,  1 Oct 2022 01:11:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17B42B8006F;
        Sat,  1 Oct 2022 08:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47DCC433C1;
        Sat,  1 Oct 2022 08:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664611866;
        bh=Z091UAXrpKH5/kBflzNLmEzEJdR9xhwSN9GYTFLWca0=;
        h=Date:From:To:Cc:Subject:From;
        b=HWpe1Xse/Romad8TjqHsrUoPVXxkmMRAjWlUXX22Q64NMwp4NR6Cm6hqF5QKp3Mmd
         /NYMZNvyQ6AfAQGDTPF7hJZupn/ehKUM6DlQ6qkT3jLRsfzdkOufXLH8z3xt4YNaTl
         5/uwyCMN9it8XqOnQORfPAAZYpkQwbq07pVlTKunSkVIG6Tcxhe3mZPkOFnURrvAxp
         ZSEeQJ2yzgHWVF8IKGKH0OJ1kNtV2jcDKAi9baViunjJpawt82BdZIoyuBbkss4w6C
         anTR04QEk69gzei0xqaDs6WNzRLHw6c5Vo8Jziokz0ipGPldpL/+KwL9vM5uNzXzRN
         8iRG1XvJIQNqw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oeXaZ-0004Ka-9L; Sat, 01 Oct 2022 10:11:11 +0200
Date:   Sat, 1 Oct 2022 10:11:11 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] USB-serial fixes for 6.0-rc8
Message-ID: <Yzf2H3iLp2g01Gsw@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here's one more modem device id for 6.0-final or, if you prefer, 6.1-rc1.

Johan


The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.0-rc8

for you to fetch changes up to eee48781ea199e32c1d0c4732641c494833788ca:

  USB: serial: qcserial: add new usb-id for Dell branded EM7455 (2022-09-27 09:04:28 +0200)

----------------------------------------------------------------
USB-serial fixes for 6.0-rc8

Here's one more modem device id for 6.0-rc8/final.

All have been in linux-next with no reported issues.

----------------------------------------------------------------
Frank Wunderlich (1):
      USB: serial: qcserial: add new usb-id for Dell branded EM7455

 drivers/usb/serial/qcserial.c | 1 +
 1 file changed, 1 insertion(+)
