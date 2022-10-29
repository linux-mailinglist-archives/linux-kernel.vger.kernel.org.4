Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763A61249B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ2RXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ2RXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 13:23:49 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146CE40009
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 10:23:48 -0700 (PDT)
Received: from dslb-188-097-213-253.188.097.pools.vodafone-ip.de ([188.97.213.253] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1oopYe-00074v-3A; Sat, 29 Oct 2022 19:23:44 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 00/13] staging: r8188eu: clean up action frame handlers
Date:   Sat, 29 Oct 2022 19:23:24 +0200
Message-Id: <20221029172337.1574593-1-martin@kaiser.cx>
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

Clean up the handlers for action frames. Summarize common code, remove
unnecessary return values.

Please apply this on top of the "remove the last get_da calls" series.

Martin Kaiser (13):
  staging: r8188eu: replace a GetAddr1Ptr call
  staging: r8188eu: remove duplicate category check
  staging: r8188eu: make on_action_public static void
  staging: r8188eu: make OnAction_back static void
  staging: r8188eu: make OnAction_p2p static void
  staging: r8188eu: remove category check in OnAction_p2p
  staging: r8188eu: replace switch-case with if
  staging: r8188eu: replace GetAddr1Ptr call in OnAction_p2p
  staging: r8188eu: clean up on_action_public
  staging: r8188eu: remove return value from on_action_public_vendor
  staging: r8188eu: remove return value from on_action_public_default
  staging: r8188eu: rtw_action_public_decache's token is a u8
  staging: r8188eu: check destination address in OnAction

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 116 +++++-------------
 .../staging/r8188eu/include/rtw_mlme_ext.h    |   7 --
 2 files changed, 28 insertions(+), 95 deletions(-)

-- 
2.30.2

