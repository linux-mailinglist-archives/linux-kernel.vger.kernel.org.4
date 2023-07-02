Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60F8744E0C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 16:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGBOEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 10:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjGBOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 10:04:23 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891D21A2;
        Sun,  2 Jul 2023 07:04:22 -0700 (PDT)
User-agent: mu4e 1.10.4; emacs 29.0.92
From:   Sam James <sam@gentoo.org>
To:     regressions@leemhuis.info
Cc:     Jason@zx2c4.com, andy@greyhouse.net, bagasdotme@gmail.com,
        boqun.feng@gmail.com, boris.ovstrosky@oracle.com, bp@alien8.de,
        dave.hansen@linux.intel.com, david@unsolicited.net,
        eric.devolder@oracle.com, hpa@zytor.com, j.vosburgh@gmail.com,
        joel@joelfernandes.org, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        manuel.leiner@gmx.de, miguel.luis@oracle.com, mingo@redhat.com,
        netdev@vger.kernel.org, paulmck@kernel.org, rafael@kernel.org,
        rcu@vger.kernel.org, regressions@lists.linux.dev,
        tglx@linutronix.de, wireguard@lists.zx2c4.com, x86@kernel.org
Subject: Re: Fwd: RCU stalls with wireguard over bonding over igb on Linux
 6.3.0+
In-Reply-To: <10f2a5ee-91e2-1241-9e3b-932c493e61b6@leemhuis.info>
Date:   Sun, 02 Jul 2023 15:03:36 +0100
Message-ID: <87sfa6if4x.fsf@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#regzbot link: https://bugs.gentoo.org/909066
