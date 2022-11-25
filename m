Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6EB63899E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiKYMXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:23:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKYMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:23:46 -0500
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136F2EF03
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:23:44 -0800 (PST)
Received: from pop-os.home ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id yXk6oYM8Mbw2uyXk6oXmQy; Fri, 25 Nov 2022 13:23:42 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 25 Nov 2022 13:23:42 +0100
X-ME-IP: 86.243.100.34
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/5] octeontx2-af: Clean-up some bitmap related usage
Date:   Fri, 25 Nov 2022 13:23:41 +0100
Message-Id: <cover.1669378798.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main point is patch 4.

The other ones are just minor things spoted while looking at the way the
'id_bmap' bitmap was used.

Christophe JAILLET (5):
  octeontx2-af: Fix a potentially spurious error message
  octeontx2-af: Slightly simplify rvu_npc_exact_init()
  octeontx2-af: Use the bitmap API to allocate bitmaps
  octeontx2-af: Fix the size of memory allocated for the 'id_bmap'
    bitmap
  octeontx2-af: Simplify a size computation in rvu_npc_exact_init()

 .../marvell/octeontx2/af/rvu_npc_hash.c         | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.34.1

