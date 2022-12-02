Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29D640349
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbiLBJ0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 04:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbiLBJZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:25:37 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C255F9E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 01:25:36 -0800 (PST)
Received: from ipservice-092-217-087-074.092.217.pools.vodafone-ip.de ([92.217.87.74] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1p12IS-0001tn-Lr; Fri, 02 Dec 2022 10:25:28 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 0/2] staging: r8188eu: issue_probereq_p2p
Date:   Fri,  2 Dec 2022 10:25:23 +0100
Message-Id: <20221202092525.403887-1-martin@kaiser.cx>
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

Clean up the issue_probereq_p2p function.

Martin Kaiser (2):
  staging: r8188eu: merge two probereq_p2p functions
  staging: r8188eu: remove unused da parameter

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 40 ++++++-------------
 drivers/staging/r8188eu/core/rtw_p2p.c        |  8 ++--
 .../staging/r8188eu/include/rtw_mlme_ext.h    |  2 +-
 3 files changed, 18 insertions(+), 32 deletions(-)

-- 
2.30.2

