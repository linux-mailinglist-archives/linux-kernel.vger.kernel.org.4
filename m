Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AF26A824D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCBMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCBMfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:35:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE323643
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 04:35:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DBBB615AD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 12:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F079C433EF;
        Thu,  2 Mar 2023 12:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677760503;
        bh=4yJ6t/0ClhBa8bwuHY+d2XTJwrP7Rug4sWp9olwcghc=;
        h=From:To:Cc:Subject:Date:From;
        b=PNGP7C8MVifB+qCpcsvkUXASZ/4sgTXu5R7UuiBjz0FQOCTt/xeO98AD4w4Kcf9Tn
         cNIGKZzv8SU/LeqImAIdtJooHj5ZmTo0l4ehktZmI6MHfE41u/42LgdIAcMlhKUYPK
         THUgM7fbj0JLfnOTjNO7Xe9tsTyzhYbtAaN5ATcn8/2nwdcwdCSO9axctbCG3OZjz6
         AeKRV24V9JbNtYaHFc6Bll45RPWRxHBVYUbb1uxLzyAe6fCLAXV//5NOWB97B/VazX
         DfTVrRhGeEumhdhymRel6IYqU0ybThA+H2rFTJ83geqKpiHDRtbRZKze31v/zai7Lu
         B5VpscR18nCHA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] auxdisplay for 6.3
Date:   Thu,  2 Mar 2023 13:34:13 +0100
Message-Id: <20230302123413.211900-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I intended to send this for 6.2. Please pull this fix for auxdisplay.

Thanks!

Cheers,
Miguel

The following changes since commit 830b3c68c1fb1e9176028d02ef86f3cf76aa2476:

  Linux 6.1 (2022-12-11 14:15:18 -0800)

are available in the Git repository at:

  https://github.com/ojeda/linux.git tags/auxdisplay-6.3

for you to fetch changes up to ddf75a86aba2cfb7ec4497e8692b60c8c8fe0ee7:

  auxdisplay: hd44780: Fix potential memory leak in hd44780_remove() (2022-12-12 12:21:41 +0100)

----------------------------------------------------------------
An auxdisplay fix from Jianglei Nie:

  - hd44780: Fix potential memory leak in hd44780_remove().

----------------------------------------------------------------
Jianglei Nie (1):
      auxdisplay: hd44780: Fix potential memory leak in hd44780_remove()

 drivers/auxdisplay/hd44780.c | 2 ++
 1 file changed, 2 insertions(+)
