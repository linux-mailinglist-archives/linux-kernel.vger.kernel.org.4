Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE256BD076
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 14:12:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCPNMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 09:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjCPNMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 09:12:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A5BDD3B;
        Thu, 16 Mar 2023 06:12:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97E6B62020;
        Thu, 16 Mar 2023 13:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13FBC433D2;
        Thu, 16 Mar 2023 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678972353;
        bh=fopWkLpSnZTX0FEg8mYFjEU/ugaZSPEHBzKyo5L9Kgk=;
        h=From:To:Cc:Subject:Date:From;
        b=MEa8k25ssldbbRFL9/nGrrbisPzmhXZPJIJ0Mvlwcr223HvzAyGFshgD2yIBAx3V1
         Af4ZWNud9+ckGp7MEI11uPy7mcVPiGO8wlkvXPDQATAIWbx/7/43ZQtkgm49EhpJ+r
         fBsfXw7uXkhw9Pz2lOEPSYf43bMue0NGp2sQlWlJIhU4u1WZhogHOEN/wsShbyraKI
         OzaQdnqdZo42JH3tMeZ86O6OOyg3UJEuCNQKy5OrpnBxo/1mvlI0OvZaJLDS8K+G+m
         DbG0lNWOR9NqwI+Bi/5E14EBJywrxzdmnueC8AmEBYXWgj70Iiz/z4nS+yKmFJnaIa
         9wkbgvvuQmzcA==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 0/3] usb: dwc3-am62: Add system wake-up support
Date:   Thu, 16 Mar 2023 15:12:23 +0200
Message-Id: <20230316131226.89540-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series enables System wake up support via USB events on TI's AM62 SoC.

cheers,
-roger

Aswath Govindraju (1):
  usb: dwc3-am62: Add support for system wakeup based on USB events

Roger Quadros (2):
  usb: dwc3-am62: Enable as a wakeup source by default
  usb: dwc3-am62: Fix up wake-up configuration and spurious wake up

 drivers/usb/dwc3/dwc3-am62.c | 54 ++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

-- 
2.34.1

