Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019C5EFFFA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 00:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbiI2WRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 18:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiI2WRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:17:38 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE10FCA6D;
        Thu, 29 Sep 2022 15:17:37 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56266)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oe1qa-002lKm-T6; Thu, 29 Sep 2022 16:17:36 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:57822 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1oe1qY-000QBy-Up; Thu, 29 Sep 2022 16:17:35 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220929203903.9475-1-lukas.bulwahn@gmail.com>
Date:   Thu, 29 Sep 2022 17:17:28 -0500
In-Reply-To: <20220929203903.9475-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Thu, 29 Sep 2022 22:39:03 +0200")
Message-ID: <87tu4p3jwn.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1oe1qY-000QBy-Up;;;mid=<87tu4p3jwn.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19PmXCMvq3dJ4UVR1Zc7W458rz2Nb6AWpM=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 377 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 9 (2.4%), b_tie_ro: 8 (2.0%), parse: 0.75 (0.2%),
        extract_message_metadata: 11 (2.8%), get_uri_detail_list: 0.98 (0.3%),
        tests_pri_-1000: 13 (3.4%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 0.97 (0.3%), tests_pri_-90: 171 (45.3%), check_bayes:
        169 (44.9%), b_tokenize: 5 (1.4%), b_tok_get_all: 5 (1.5%),
        b_comp_prob: 2.8 (0.8%), b_tok_touch_all: 152 (40.4%), b_finish: 0.95
        (0.3%), tests_pri_0: 160 (42.4%), check_dkim_signature: 0.50 (0.1%),
        check_dkim_adsp: 2.8 (0.8%), poll_dns_idle: 0.92 (0.2%), tests_pri_10:
        2.0 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt: remove taso from linux_binprm struct
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> With commit 987f20a9dcce ("a.out: Remove the a.out implementation"), the
> use of the special taso flag for alpha architectures in the linux_binprm
> struct is gone.
>
> Remove the definition of taso in the linux_binprm struct.
>
> No functional change.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Alphas binfmt_loader is the only use I can find of that variable
so let's kill it as well.

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Kees, please pick this patch on top of the commit above.
>
>  include/linux/binfmts.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
> index 3dc20c4f394c..8d51f69f9f5e 100644
> --- a/include/linux/binfmts.h
> +++ b/include/linux/binfmts.h
> @@ -43,9 +43,6 @@ struct linux_binprm {
>  		 * original userspace.
>  		 */
>  		point_of_no_return:1;
> -#ifdef __alpha__
> -	unsigned int taso:1;
> -#endif
>  	struct file *executable; /* Executable to pass to the interpreter */
>  	struct file *interpreter;
>  	struct file *file;
