Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1920261E521
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiKFRyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbiKFRyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:54:33 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DB9FD7
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 09:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667757254; bh=+YpV4K0Qx3G5hgqrE/gyL8EiAycq1OSpWbGx90RSfOA=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=bfmHtdUlwLH9/fDOoioVlkBc/FBsq0wWlvK9nbaiYpmPzuK49UNkUN3vq2AUCJNcx
         XrOObHF8eMv/PoX+zQ/lbeEPbRq0Repb6F8ZbGbcqxB9obTmA0FOUzGJzWL+K9XIJz
         +ZZTtMM9iOEpMa7j/rfJ1BFuvy7EV+Qxva4t4SFo=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun,  6 Nov 2022 18:54:14 +0100 (CET)
X-EA-Auth: H9GvGZlEnTujI3iKV7ccXlyHipKEAXZxpWcUvtv1TdY8Rknx9nI+/dv+53zizp0lisVP3vi/Rv5ABwcy3cqvQtFwwd1akCyg
Date:   Sun, 6 Nov 2022 23:24:01 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] staging: r8188eu: casting simplified
Message-ID: <cover.1667755987.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch set proposes variable casting simplifications. Change improves code
readability and appears more maintainable.

Changes in v2:
   1. Patch set introduced.
      Changes associated with pointer casting and variable casting are
      split into separate patches. Hence the patch set.
      Suggested by gregkh@linuxfoundation.org


Deepak R Varma (2):
  staging: r8188eu: simplify complex pointer casting
  staging: r8188eu: remove unnecessary casting

 drivers/staging/r8188eu/core/rtw_br_ext.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--
2.34.1



