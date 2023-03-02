Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036F86A7DF6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 10:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCBJjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 04:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBJjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 04:39:45 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201725261;
        Thu,  2 Mar 2023 01:39:30 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9DA1421BEC;
        Thu,  2 Mar 2023 09:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1677749968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5Eko+WcrMxC5t7d8GKXpWvxo3Yahw7e+tVwSxLpopQ=;
        b=IN/qE7OkrB4Hmr8cwo+9t0IR5oew+qfmK06LOC8isvgwUMnIFPAI+LplWKu1EQcJBcWPCb
        C1eLv6nbu8MzUPSk6pk5ztBFrQT1PpYIsyv4aCEOA8pa2QE1ITGi/NkOC0RMqf2v3glEjy
        jvEb5v2anS/2abEt7Sf/6QS8FljzW9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1677749968;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5Eko+WcrMxC5t7d8GKXpWvxo3Yahw7e+tVwSxLpopQ=;
        b=0U1AVYw6al6TQ3XTjxUcsakH4+Fls+/amTeX3okzsVywWAVOxcVqUuos3knvjCP2/mfnEQ
        6EEpRV3W60MYkxCQ==
Received: from hawking.suse.de (unknown [10.168.4.11])
        by relay2.suse.de (Postfix) with ESMTP id 071322C141;
        Thu,  2 Mar 2023 09:39:28 +0000 (UTC)
Received: by hawking.suse.de (Postfix, from userid 17005)
        id BBB3D442EE6; Thu,  2 Mar 2023 10:39:27 +0100 (CET)
From:   Andreas Schwab <schwab@suse.de>
To:     Xingyu Wu <xingyu.wu@starfivetech.com>
Cc:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Samin Guo <samin.guo@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/3] clocksource: Add StarFive timer driver
References: <20221223094801.181315-1-xingyu.wu@starfivetech.com>
        <20221223094801.181315-3-xingyu.wu@starfivetech.com>
X-Yow:  ..  I think I'd better go back to my DESK and toy with
 a few common MISAPPREHENSIONS...
Date:   Thu, 02 Mar 2023 10:39:27 +0100
In-Reply-To: <20221223094801.181315-3-xingyu.wu@starfivetech.com> (Xingyu Wu's
        message of "Fri, 23 Dec 2022 17:48:00 +0800")
Message-ID: <mvmzg8vlcfk.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/clocksource/timer-starfive.c:117:13: error: conflicting types for 'timer_shutdown'; have 'void(struct starfive_clkevt *)'
  117 | static void timer_shutdown(struct starfive_clkevt *clkevt)
      |             ^~~~~~~~~~~~~~
In file included from ./include/linux/workqueue.h:9,
                 from ./include/linux/srcu.h:21,
                 from ./include/linux/notifier.h:16,
                 from ./include/linux/clk.h:14,
                 from drivers/clocksource/timer-starfive.c:12:
./include/linux/timer.h:188:12: note: previous declaration of 'timer_shutdown' with type 'int(struct timer_list *)'
  188 | extern int timer_shutdown(struct timer_list *timer);
      |            ^~~~~~~~~~~~~~

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
