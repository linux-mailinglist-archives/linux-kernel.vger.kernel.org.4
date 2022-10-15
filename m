Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE3E5FFAC7
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiJOPLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:11:31 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD391402C7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:11:29 -0700 (PDT)
Received: from ipservice-092-217-066-135.092.217.pools.vodafone-ip.de ([92.217.66.135] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1ojios-0006sp-LB; Sat, 15 Oct 2022 17:11:22 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/10] staging: r8188eu: led layer fix and cleanups
Date:   Sat, 15 Oct 2022 17:11:05 +0200
Message-Id: <20221015151115.232095-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here's another series to clean up the led layer and fix a problem with
leds during suspend/resume on some devices.

Martin Kaiser (10):
  staging: r8188eu: fix led register settings
  staging: r8188eu: handle rtw_write8 errors in SwLedOn
  staging: r8188eu: fix status updates in SwLedOff
  staging: r8188eu: SwLedOn needs no padapter parameter
  staging: r8188eu: SwLedOff needs no padapter parameter
  staging: r8188eu: remove two unused defines
  staging: r8188eu: don't include rtw_led.h from rtw_cmd.h
  staging: r8188eu: remove padapter from struct led_priv
  staging: r8188eu: set two more state variables
  staging: r8188eu: summarize tx/rx and scan blinking

 drivers/staging/r8188eu/core/rtw_led.c    | 62 +++++++----------------
 drivers/staging/r8188eu/include/rtw_cmd.h |  5 --
 drivers/staging/r8188eu/include/rtw_led.h |  2 -
 3 files changed, 18 insertions(+), 51 deletions(-)

-- 
2.30.2

