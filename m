Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF736D356B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 05:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDBD5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 23:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDBD5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 23:57:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90B121AAD
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 20:57:38 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CFBCB3200A1D;
        Sat,  1 Apr 2023 23:57:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 01 Apr 2023 23:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1680407855; x=1680494255; bh=5a
        mwOPaxC92wzRYxQ1JVx2WftbFO9nBcwXCPE0iFBO8=; b=VF9aqMCeFRQygL/ne8
        MipRK84Xwz6nJAYRO9LGXXfr5Av6eDwBh9frwI1HTfoxkPWE5hmVblgSQpQ0LiH/
        vWKnPWGtyHn3wUPvQa+n6gS9y36BwMBvZ2/5LaT4hcwmtm3XphOCSIsy0HYH8RSS
        RWtmlVGvsbKtrlCKeKDloXmlvlo0v9Pez0L9VV3ERaK0OUInO4Dj91jBA28o7yfx
        Lj99nr9NCeRe3Iu6Ut4SvAk3QAOh6sZKWx4DvaW9uSjiAiKZVhoDJ5BVp4dTntyV
        leLWcYR7GFYh3OMcv71nryXIYuBTh6LA2jgX9AAaka1DjCUpZ4/+Y1KIzBdOgf3M
        4Skg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680407855; x=1680494255; bh=5amwOPaxC92wzRYxQ1JVx2WftbFO9nBcwXC
        PE0iFBO8=; b=IzGUC9nefIiqZGndgS+++xFjU/94qy7T2Cy87f4p4VSOV0l+NyD
        0JtwgwdFJwoP1nHMGs49ITbvioNL+nQTzk8Z43BWlWTszDb6qQHJs8NO5JUoOoHC
        0WsXkHP2e66JszO1HojiI/lW01AfnOXMUzotqbQDY2YheVrUxS8CecitZiFvBycQ
        AfQPa9XWtxq1BqiPc28LRbd+z8gAbXJ77WR70cFnrxPQg1mAPVJa+7C9s2jNirO0
        b3TFHodRXG9s9oI+EvPrkBjmY7+2GZsnDaaiq47RGA1FfLCoKBzZEKPAOdPPHAWx
        8TseTYVP7sLr831475S93EeR1Kv1ecOGlXg==
X-ME-Sender: <xms:L_0oZDL0RtCUlERyOY024LQwQ0pTMu_w32x-6dva63EMKnu1g9bB2A>
    <xme:L_0oZHIBqS8dPPzOqF-oVcKzX_vnf0rwBIHWYvgVI4b94YTVm-I2Clyf4sfIKHQJH
    8aJEq_Pew1ZvSw5YFc>
X-ME-Received: <xmr:L_0oZLthukp9ON2NuRSiETXAg5eKr0I0Jh0UIzP2I4O3qsfI8LQn_Ju8N8-ZvUkkNsDfu5R3PkMRXA2CON-A96etuurEeH5lPEKflxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeigedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesthdtredttddtvdenucfhrhhomheplfhoshhhucfv
    rhhiphhlvghtthcuoehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgqeenucggtf
    frrghtthgvrhhnpeduvdelheettdfgvddvleegueefudegudevffekjeegffefvdeikeeh
    vdehleekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhg
X-ME-Proxy: <xmx:L_0oZMYKcczQN-hPxbon_f0CtcU_aor00ZiBB2uKkpUnOaLC5PRPwA>
    <xmx:L_0oZKY-m3qhLPWgCDPfITCdvetDYUlZI5_TlMhpPPqStBKHVeMouw>
    <xmx:L_0oZABtUeQixdaQDC5-E03i8ihKFzTMpllXoY0cBaYNGdV83GbLiQ>
    <xmx:L_0oZC7M_cU3QwL3DutT4xRHY4HRAGxsiRdH-Nokqkmv7m0UC6jckA>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 23:57:31 -0400 (EDT)
Date:   Sun, 2 Apr 2023 12:57:29 +0900
From:   Josh Triplett <josh@joshtriplett.org>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] sysinfo: Saturate 16-bit procs rather than wrapping
Message-ID: <e32ea9a03d0797ce2b8e7a82ed59c0dad9431f2b.1680407255.git.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct sysinfo has a 16-bit field for the number of processes. Current
systems can easily exceed this. Rather than wrapping around, saturate
the value at U16_MAX. This is still incorrect, but more likely to
help the user know what's going on; a caller can then (for instance)
parse the full value out of /proc/loadavg.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

Not sure what tree changes to kernel/sys.c should flow through. Andrew,
could you take this through your tree (assuming you agree with it), or
suggest what tree it should go through instead?

diff --git a/kernel/sys.c b/kernel/sys.c
index 495cd87d9bf4..ba05fca26927 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2699,7 +2699,7 @@ static int do_sysinfo(struct sysinfo *info)
 
 	get_avenrun(info->loads, 0, SI_LOAD_SHIFT - FSHIFT);
 
-	info->procs = nr_threads;
+	info->procs = min_t(typeof(nr_threads), nr_threads, U16_MAX);
 
 	si_meminfo(info);
 	si_swapinfo(info);
-- 
2.40.0
