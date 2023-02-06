Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA468C824
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 22:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjBFVBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 16:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBFVBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 16:01:39 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1FF24CBB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 13:01:37 -0800 (PST)
Received: from ipservice-092-217-084-033.092.217.pools.vodafone-ip.de ([92.217.84.33] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1pP8cF-000876-Tc; Mon, 06 Feb 2023 22:01:31 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/3] simplify suspend/resume functions
Date:   Mon,  6 Feb 2023 22:01:21 +0100
Message-Id: <20230206210124.150142-1-martin@kaiser.cx>
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

Here's some simple cleanups for suspend + resume.

Martin Kaiser (3):
  staging: r8188eu: make ips_enter static
  staging: r8188eu: make ips_leave static
  staging: r8188eu: remove change_rfpwrstate

 drivers/staging/r8188eu/core/rtw_pwrctrl.c    | 23 ++++++++-----------
 drivers/staging/r8188eu/include/rtw_pwrctrl.h |  3 ---
 2 files changed, 10 insertions(+), 16 deletions(-)

-- 
2.30.2

