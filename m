Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B3FB667C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 18:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240650AbjALRC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 12:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240908AbjALRBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 12:01:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57FE65AA;
        Thu, 12 Jan 2023 08:43:48 -0800 (PST)
Date:   Thu, 12 Jan 2023 17:42:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673541761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QCzsbhTLzC2qtVf51+C0cYLAWf2NacHEGnNMmW1UjiM=;
        b=Rlk9NyaS5mHcFxktwrMoWoKV8TYV9zSu9qCjJD2qmYicBinFPikHpzWimU0WTOIsloL7KH
        fuwV5B1Gpv0nAgzYt+9bz7ivbjhUC670q6fwJ9vK/wEnC2X9mP1NwsNsig3Hk6TdYCfJHB
        zTjropHxTfINdXMa31HrYofg/qcocKPaYjYsTmsAYEZjgwVYcz9MsiX8ogMPbEzfPPzXEr
        dPaYcF0FOIKj6Ctc2D+wlHiimr7njzAi4DJOiTaZQkP8cjGJ/7+VeJELkCktaf4rduqgyp
        PROzhPU1o621k99r3qAVJalQ4pujf6yoZlOde2RqRrEngSLxmihCWLL5Buqmiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673541761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=QCzsbhTLzC2qtVf51+C0cYLAWf2NacHEGnNMmW1UjiM=;
        b=uZd5+5NupRvsCC1TKIZw8UCJvNlBswwAlAsxp/i83Pvy1pX+DzTfmJu+azk1puDXNbkrDf
        dG/RL2Gxws6w80DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.2-rc3-rt1
Message-ID: <Y8A4f9m/ddIUwfZE@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.2-rc3-rt1 patch set. 

Changes since v6.1-rc7-rt5:

  - Update to v6.2-rc3

Known issues
     - Valentin Schneider reported a few splats on ARM64 in arm_pmu, see
          https://lore.kernel.org/all/20210810134127.1394269-1-valentin.schneider@arm.com/T/#mf05c04376f59a543da6cceeb72e162af2de2b648
       It is worked on
          https://lore.kernel.org/all/20220930111844.1522365-1-mark.rutland@arm.com/

     - It has been reported that the ktimers thread may not be woken up
       and instead the timer is handled in softirq context.

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.2-rc3-rt1

The RT patch against v6.2-rc3 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patch-6.2-rc3-rt1.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.2/older/patches-6.2-rc3-rt1.tar.xz

Sebastian
