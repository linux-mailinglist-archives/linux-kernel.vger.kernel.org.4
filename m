Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7836D5363
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjDCVVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbjDCVVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:21:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE53940C7;
        Mon,  3 Apr 2023 14:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CE8862B19;
        Mon,  3 Apr 2023 21:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2994C433EF;
        Mon,  3 Apr 2023 21:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680556840;
        bh=szIfHF2gzcvGyxGWpacrc5AJ1h4Xmv5fWIWGVXSVy4k=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=hyK9LzxiwpZAk0ES5/xctJgiuI7l3A6QCuaPQT5NjA6qCj1jJl1sptAx0XsVfx07B
         jYTSQTDhiAdoRaqcxrUsO4dOm3npvYwEq7E7mOngPbrqTF73GwUebq6htWTTZ3PlVC
         Ox5hdFWUEatqsGWp+xLHK6P5hmxuZPApFMNMh0gy/+Y2fqTnTILge6rlt/tCWrIhH2
         LknggoNMPtniWY7B6IdfjKGawORMkOphrwXUFcOYFkXntYrAv6Mp1uwb3BtOw+S1qZ
         CDz6ouK1FKyy18wQSA1FtnCQGPDOMztAEAE7vvPfnuv7AxXRvd9WBgEN3pT2eDEPkD
         FWMJUjjxL9GHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C494DE5EA88;
        Mon,  3 Apr 2023 21:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
From:   "Kernel.org Bugbot" <bugbot@kernel.org>
To:     song@kernel.org, jbaron@akamai.com, bugs@lists.linux.dev,
        mcgrof@kernel.org, linux-modules@vger.kernel.org,
        jim.cromie@gmail.com, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Message-ID: <20230403-b217296-67d45b5fbc27@bugzilla.kernel.org>
In-Reply-To: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
References: <CAJfuBxwomDagbdNP-Q6WvzcWsNY0Z2Lu2Yy5aZQ1d9W7Ka1_NQ@mail.gmail.com>
Subject: Re: kmemleaks on ac3b43283923 ("module: replace module_layout with
 module_memory")
X-Bugzilla-Product: Linux
X-Bugzilla-Component: Kernel
X-Mailer: peebz 0.1
Date:   Mon,  3 Apr 2023 21:20:39 +0000 (UTC)
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_FROM_NAME_TO_DOMAIN,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This conversation is now tracked by Kernel.org Bugzilla:
https://bugzilla.kernel.org/show_bug.cgi?id=217296

There is no need to do anything else, just keep talking.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (peebz 0.1)

