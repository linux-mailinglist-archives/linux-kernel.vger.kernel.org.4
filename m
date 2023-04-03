Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF496D53ED
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbjDCVsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233626AbjDCVsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:48:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1286CA;
        Mon,  3 Apr 2023 14:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18F2862CC4;
        Mon,  3 Apr 2023 21:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D179C433D2;
        Mon,  3 Apr 2023 21:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680558469;
        bh=8KWLJjSZIZj1GfIA0VE1J8hGTHhJxpfeC8mL2Td2i4Q=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=P2KWn31KxBb4Gb6IsVqg0SCxuS6b2Gpl39PPYCssv4PpOVUEwBMGQ2DhvRwy3Omz9
         BVtQgz0nxtOAfXooZbSTA0MyQE1K0oLZCtZECRwMZAqJMiwLNlHraJaalfiTN5AORY
         MwQyusyJTWnjwf3lZQZKAgciIHEyxqS9XmsXbKxlbZZCTeeA18C+iZkiPe/iVDplTp
         x0arjpGBG6hcuUwg7/r+UTGjsUmnCEjH7jN3nQ625K7fyipRvizpEaUrbbQWFxYueD
         o9bi50SflnPXOT8i53k9JgV3TkATX4j1/SxJLJXxN+It18BOMzSE10FrlOBQ2UDnvS
         NbHEXZvZBzwLQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4A9A4E5EA86;
        Mon,  3 Apr 2023 21:47:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     aros@gmx.com, regressions@lists.linux.dev,
        konstantin@linuxfoundation.org, bugs@lists.linux.dev,
        workflows@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@leemhuis.info, tools@linux.kernel.org
Message-ID: <20230403-b217297-6bf5914fb55d@bugzilla.kernel.org>
In-Reply-To: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
References: <gmnswy45efztvcyc3xqymm52h7cdfwjz64go2wy3zyeqcqwb76@36fva4hyip4q>
Subject: Re: Introducing bugbot
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Mon,  3 Apr 2023 21:47:49 +0000 (UTC)
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217297

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

