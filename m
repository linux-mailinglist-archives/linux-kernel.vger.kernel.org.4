Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A61664DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbjAJU4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbjAJU4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:56:47 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FF8DEB3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:56:44 -0800 (PST)
Received: from dslb-178-004-206-224.178.004.pools.vodafone-ip.de ([178.4.206.224] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pFLfg-0001pw-Vx; Tue, 10 Jan 2023 21:56:37 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/4] staging: r8188eu: clean up usb_write_port_complete
Date:   Tue, 10 Jan 2023 21:56:22 +0100
Message-Id: <20230110205626.183516-1-martin@kaiser.cx>
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

Clean up and simplify the usb_write_port_complete callback function. Yet
again, this is based on the previous patches I submitted.

Martin Kaiser (4):
  staging: r8188eu: refactor status handling in usb_write_port_complete
  staging: r8188eu: reformat usb_write_port_complete
  staging: r8188eu: remove unused function parameter
  staging: r8188eu: always process urb status

 .../staging/r8188eu/include/usb_ops_linux.h   |  2 -
 .../staging/r8188eu/os_dep/usb_ops_linux.c    | 46 ++++++++-----------
 2 files changed, 18 insertions(+), 30 deletions(-)

-- 
2.30.2

