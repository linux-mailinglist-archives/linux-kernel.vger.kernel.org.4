Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435AE74B5D5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjGGR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjGGR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:29:01 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121281FE0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:28:59 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:56172)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHpGK-00HIAl-AI; Fri, 07 Jul 2023 11:28:56 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:60874 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qHpGJ-00Ek6z-5y; Fri, 07 Jul 2023 11:28:55 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     "Li, Xin3" <xin3.li@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "brgerst@gmail.com" <brgerst@gmail.com>
References: <20230706052231.2183-1-xin3.li@intel.com>
        <87v8exgmot.fsf@email.froward.int.ebiederm.org>
        <SA1PR11MB67348D11385F584354AB84C3A82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
Date:   Fri, 07 Jul 2023 12:28:13 -0500
In-Reply-To: <SA1PR11MB6734F3F72095C4D6B9C12C9BA82DA@SA1PR11MB6734.namprd11.prod.outlook.com>
        (Xin3 Li's message of "Fri, 7 Jul 2023 04:16:47 +0000")
Message-ID: <87sf9zfx76.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qHpGJ-00Ek6z-5y;;;mid=<87sf9zfx76.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19MFWwAxB9up/uPIKvfkqhggKcsdpx8Cdo=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;"Li, Xin3" <xin3.li@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 588 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (1.8%), b_tie_ro: 9 (1.6%), parse: 0.93 (0.2%),
         extract_message_metadata: 12 (2.0%), get_uri_detail_list: 1.49 (0.3%),
         tests_pri_-2000: 11 (1.8%), tests_pri_-1000: 2.5 (0.4%),
        tests_pri_-950: 1.22 (0.2%), tests_pri_-900: 1.01 (0.2%),
        tests_pri_-200: 0.85 (0.1%), tests_pri_-100: 4.2 (0.7%),
        tests_pri_-90: 266 (45.3%), check_bayes: 261 (44.4%), b_tokenize: 7
        (1.2%), b_tok_get_all: 171 (29.0%), b_comp_prob: 2.2 (0.4%),
        b_tok_touch_all: 78 (13.2%), b_finish: 0.90 (0.2%), tests_pri_0: 263
        (44.7%), check_dkim_signature: 0.50 (0.1%), check_dkim_adsp: 3.5
        (0.6%), poll_dns_idle: 0.99 (0.2%), tests_pri_10: 2.0 (0.3%),
        tests_pri_500: 9 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] x86/ia32: Do not modify the DPL bits for a null selector
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Li, Xin3" <xin3.li@intel.com> writes:

>> Thus 3 as a selector is the same as 0, and it doesn't matter to change it or not. But
>> when IRET sees an invalid segment register in ES, FS, GS, and DS, it sets it to 0,
>> making 0 a preferred null selector value.
>
> To clarify, an invalid segment register value includes NULL selector values.

Perhaps something like patch below to make it clear that we are
normalizing the segment values and forcing that normalization.

I am a bit confused why this code is not the same for ia32 and
ia32_emulation.  I would think the normalization at least should apply
to the 32bit case as well.

Eric

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 9027fc088f97..e5f3978388fd 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -36,22 +36,47 @@
 #ifdef CONFIG_IA32_EMULATION
 #include <asm/ia32_unistd.h>
 
+static inline unsigned int normalize_seg_index(unsigned int index)
+{
+	/*
+	 * Convert the segment index into normalized form.
+	 *
+	 * For the indexes 0,1,2,3 always use the value of 0, as IRET
+	 * forces this form for the nul segment.
+	 *
+	 * Otherwise set both DPL bits to force it to be a userspace
+	 * ring 3 segment index.
+	 */
+	return (index < 3) ? 0 : index | 3;
+}
+
 static inline void reload_segments(struct sigcontext_32 *sc)
 {
-	unsigned int cur;
+	unsigned int new, cur;
 
+	new = normalize_seg_index(sc->gs);
 	savesegment(gs, cur);
-	if ((sc->gs | 0x03) != cur)
-		load_gs_index(sc->gs | 0x03);
+	cur = normalize_seg_index(cur);
+	if (new != cur)
+		load_gs_index(new);
+
+	new = normalize_seg_index(sc->fs);
 	savesegment(fs, cur);
-	if ((sc->fs | 0x03) != cur)
-		loadsegment(fs, sc->fs | 0x03);
+	cur = normalize_seg_index(cur);
+	if (new != cur)
+		loadsegment(fs, new);
+
+	new = normalize_seg_index(sc->ds);
 	savesegment(ds, cur);
-	if ((sc->ds | 0x03) != cur)
-		loadsegment(ds, sc->ds | 0x03);
+	cur = normalize_seg_index(cur);
+	if (new != cur)
+		loadsegment(ds, new);
+
+	new = normalize_seg_index(sc->es);
 	savesegment(es, cur);
-	if ((sc->es | 0x03) != cur)
-		loadsegment(es, sc->es | 0x03);
+	cur = normalize_seg_index(cur);
+	if (new != cur)
+		loadsegment(es, new);
 }
 
 #define sigset32_t			compat_sigset_t
