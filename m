Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164C173D944
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjFZIM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFZIMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:12:22 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A36E5B;
        Mon, 26 Jun 2023 01:12:08 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qDhKQ-0003tL-C9; Mon, 26 Jun 2023 10:12:06 +0200
Message-ID: <fea36fd0-e71f-bb09-f82d-18214d038439@leemhuis.info>
Date:   Mon, 26 Jun 2023 10:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Kernel oops with netfilter: nf_tables: incorrect error path
 handling with NFT_MSG_NEWRULE
Content-Language: en-US, de-DE
To:     Matthias Maier <tamiko@43-1.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <87cz1j5tof.fsf@43-1.org>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <87cz1j5tof.fsf@43-1.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1687767128;846c105f;
X-HE-SMSGID: 1qDhKQ-0003tL-C9
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 25.06.23 19:38, Matthias Maier wrote:
> 
>   commit 1240eb93f0616b21c675416516ff3d74798fdc97
>          aka bdace3b1a51887211d3e49417a18fdbd315a313b (linux-6.3.y)
>   netfilter: nf_tables: incorrect error path handling with NFT_MSG_NEWRULE
> 
> causes a kernel oops on my side when booting my machine; see attached.

Thanks for the report. I see that the solution is already in sight, but
to ensure the issue doesn't fall through the cracks unnoticed, I'm
adding it to regzbot, the Linux kernel regression tracking bot (using
the commit ID the third patch Pablo mentioned, as the other two are
already mainlined):

#regzbot ^introduced 26b5a5712eb8
#regzbot title net: netfilter: kernel oops with netfilter:
#regzbot fix: netfilter: nf_tables: unbind non-anonymous set if rule
construction fails
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
