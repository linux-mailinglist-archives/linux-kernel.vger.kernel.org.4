Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD569853B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjBOUHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBOUH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:07:28 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6A3A842;
        Wed, 15 Feb 2023 12:07:26 -0800 (PST)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id A247F3F382;
        Wed, 15 Feb 2023 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676491643;
        bh=vtVE8Ky3NneEt+Iq5R+IRSpqPwVLHIVdo8Ja12YWLOY=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
        b=aj0erkBhEPu4XhrfVhI79HNtbG1wy5S0kwwrJDrEJQAJBjU5Wf45TBLuntu28B9Yc
         NYhLnlbagfkltjpEiSYA0PAXXVSNROaQ6SnzuOrxxr7kZ5cXbnJEFTcuko17iVbA+z
         mzVaiGQi/73aC0D7vfv43b501LizCSv/Ed7QMv1U9t9edTUWLW43BJNKXNM6BgC9ad
         gNagSo/vDAAxBzkxBUMm4QPa1Mg2E7hlRuarSjpdDK5DG5MxdHjZo4kk//doOH0Him
         hvQZOXM5tq4MxyM9ks01eLOPQFfEwUUNGvx9T1JYcg4ALGRl+h/CFYgjanj5eqGTVp
         xUVUi1moo5uPQ==
Message-ID: <442b2890-7b94-e2a1-91c6-6dac18d67463@canonical.com>
Date:   Wed, 15 Feb 2023 12:07:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor fix for v6.2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Language: en-US
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the apparmor fix for v6.2


The following changes since commit e1c04510f521e853019afeca2a5991a5ef8d6a5b:

   Merge tag 'pm-6.2-rc9' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2023-02-14 09:38:33 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-v6.2-rc9

for you to fetch changes up to cbb13e12a5d3ecef400716ea7d12a9268b0f37ca:

   apparmor: Fix regression in compat permissions for getattr (2023-02-15 11:24:38 -0800)

----------------------------------------------------------------
Regression fix
- getattr mediation of old policy

----------------------------------------------------------------
John Johansen (1):
       apparmor: Fix regression in compat permissions for getattr

  security/apparmor/policy_compat.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

