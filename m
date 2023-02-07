Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346A68DE60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 17:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBGQ6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 11:58:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231859AbjBGQ56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:57:58 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0AC3B0D3;
        Tue,  7 Feb 2023 08:57:56 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PB8HT2pPMz9xtmy;
        Wed,  8 Feb 2023 00:49:41 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDXq2L+guJj1WX+AA--.26063S2;
        Tue, 07 Feb 2023 17:57:42 +0100 (CET)
Message-ID: <c0ba2244832ea4c95e936674c4e818b26b511d61.camel@huaweicloud.com>
Subject: Re: [PATCH ima-evm-utils v5] Add tests for MMAP_CHECK and
 MMAP_CHECK_REQPROT hooks
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        jmorris@namei.org, serge@hallyn.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefanb@linux.ibm.com,
        viro@zeniv.linux.org.uk, pvorel@suse.cz,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Tue, 07 Feb 2023 17:57:31 +0100
In-Reply-To: <d6efb292273eee6caff9afc8b64e42984a3ae517.camel@huaweicloud.com>
References: <20230203125637.2673781-1-roberto.sassu@huaweicloud.com>
         <cd21f0d2a65f9673a0abe7f0a7219d5f1fe55911.camel@linux.ibm.com>
         <d6efb292273eee6caff9afc8b64e42984a3ae517.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDXq2L+guJj1WX+AA--.26063S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF48Kr17AFWfAr15WFyDJrb_yoW5KF1xpF
        Z7Xa4qkFs5JF1xA34Ika18Zr4Fyw4xtrW7Xa4DA348Cwn8tFn2kr43tFW5uFykGrWrWw12
        vF43t3y7uw1qvFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQABBF1jj4isrgACs9
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-07 at 11:16 +0100, Roberto Sassu wrote:
> On Mon, 2023-02-06 at 08:20 -0500, Mimi Zohar wrote:
> > On Fri, 2023-02-03 at 13:56 +0100, Roberto Sassu wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > 
> > > Add tests to ensure that, after applying the kernel patch 'ima: Align
> > > ima_file_mmap() parameters with mmap_file LSM hook', the MMAP_CHECK hook
> > > checks the protections applied by the kernel and not those requested by the
> > > application.
> > > 
> > > Also ensure that after applying 'ima: Introduce MMAP_CHECK_REQPROT hook',
> > > the MMAP_CHECK_REQPROT hook checks the protections requested by the
> > > application.
> > > 
> > > Test both with the test_mmap application that by default requests the
> > > PROT_READ protection flag. Its syntax is:
> > > 
> > > test_mmap <file> <mode>
> > > 
> > > where mode can be:
> > > - exec: adds the PROT_EXEC protection flag to mmap()
> > > - read_implies_exec: calls the personality() system call with
> > >                      READ_IMPLIES_EXEC as the first argument before mmap()
> > > - mprotect: adds the PROT_EXEC protection flag to a memory area in addition
> > >             to PROT_READ
> > > - exec_on_writable: calls mmap() with PROT_EXEC on a file which has a
> > >                     writable mapping
> > > 
> > > Check the different combinations of hooks/modes and ensure that a
> > > measurement entry is found in the IMA measurement list only when it is
> > > expected. No measurement entry should be found when only the PROT_READ
> > > protection flag is requested or the matching policy rule has the
> > > MMAP_CHECK_REQPROT hook and the personality() system call was called with
> > > READ_IMPLIES_EXEC.
> > > 
> > > mprotect() with PROT_EXEC on an existing memory area protected with
> > > PROT_READ should be denied (with an appraisal rule), regardless of the MMAP
> > > hook specified in the policy. The same applies for mmap() with PROT_EXEC on
> > > a file with a writable mapping.
> > > 
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Thanks, Roberto.  Other than the one comment below, it looks good.
> > 
> > > +
> > > +if ! awk '$0 ~ /^(measure|appraise)/ && $0 !~ /fsuuid=/ && $0 !~ /fowner=/ { exit 1 }' < /sys/kernel/security/ima/policy; then
> > > +	echo "${CYAN}IMA policy rules without fsuuid= and fowner=, cannot continue due to possible interference with the tests${NORM}"
> > > +	exit "$SKIP"
> > > +fi
> > 
> > The test should be limited to just MMAP_CHECK and MMAP_CHECK_REQPROT
> > policy rules.
> > 
> > +if ! awk '$0 ~ /^(measure|appraise)/ && $0 ~ /func=MMAP_CHECK/ && $0 !~ /fsuuid=/ && ...
> 
> Oh, yes. Better.

It seems more complicated than that.

If we consider only MMAP_CHECK and MMAP_CHECK_REQPROT rules, we might
miss rules without func= that can potentially overlap.

Overlap of measure and appraise rules per se should not be a problem,
unless additional options are specified in the rule. In that case, the
options of the first matching rule are taken and the other options from
other rules might not be processed (IMA stops checking the policy when
it has encountered rules with the possible actions, determined when the
policy is loaded).

Also, dont_measure and dont_appraise rules are a possible concern, as
they could be matched before ours and could change the expected
outcome.

A proposal could be to ignore existing rules, regardless of the action,
if they provide a different value for at least one of the policy
keywords (in 'base' and 'lsm') present in the rule being added.

For the rules that we didn't ignore, we can accept them if they have
the same action and no/the same policy options.

Roberto

