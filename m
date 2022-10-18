Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952C3603026
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbiJRPul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 11:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiJRPuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 11:50:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D535F9A;
        Tue, 18 Oct 2022 08:49:53 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6D8F32E5;
        Tue, 18 Oct 2022 15:49:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6D8F32E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666108192; bh=NOxgx7BtFnHINskyyKpzmOTvVWPQ4I4y1Aba7C75zpY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=s3aoq48rfPqgwH3h+/pOiWE3h4sfgQUQTfViJ2ani5S5z10Bub4q1zNw576KHq2Nu
         QiaUlHmaJ0DozIYVErUtS+STruCHfsdLLvpYHtE3tEsF1qyA/5j8dMN3zqgmKxKboy
         l5Q50by9QyrbOtAzNYMlPXpkWysGL+mwbzOYNEW/zMf3Z5eqdS0gixYKFmqNcd3ULY
         6dgjkHSEnbmgtuu0Nvzf6L/21cMgUzqnUmqtTxwOraT2/EMo+7iISs4T2FYeI5F115
         NYddf1Lr//+vb9B8SYMWWB0gepz2lg/R2oXSY9eCBnO63uOglwGYz2vCm2pzShrKEM
         NM1jKYKhD0q/Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tom.zanussi@linux.intel.com
Subject: Re: [PATCH -next] tracing/histogram: Update document for KEYS_MAX size
In-Reply-To: <20221018113558.73790f54@gandalf.local.home>
References: <20221017103806.2479139-1-zhengyejian1@huawei.com>
 <20221019003134.cc24bd624cc6fca06a05206c@kernel.org>
 <20221018113558.73790f54@gandalf.local.home>
Date:   Tue, 18 Oct 2022 09:49:51 -0600
Message-ID: <87a65tdtcw.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Wed, 19 Oct 2022 00:31:34 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
>
>> On Mon, 17 Oct 2022 10:38:06 +0000
>> Zheng Yejian <zhengyejian1@huawei.com> wrote:
>> 
>> > After commit 4f36c2d85ced ("tracing: Increase tracing map KEYS_MAX size"),
>> > 'keys' supports up to three fields.  
>> 
>> This looks good to me.
>> 
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thanks Masami.
>
>> 
>> Steve, do you this this document fix should go into the stable trees?
>
> We could label it as stable. Sure.
>
> Jon, do you want to tag this for stable and pull it through your tree?

Sure, I can do that.

Thanks,

jon
