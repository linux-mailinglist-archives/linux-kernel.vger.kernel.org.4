Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D6E5ED599
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232927AbiI1HBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233291AbiI1HBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:01:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CB65245
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:01:09 -0700 (PDT)
Date:   Wed, 28 Sep 2022 09:01:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664348467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVQQlU3/HsnQBwSPRWGk8rWCPw+RBoaolgbO3+3ZBW4=;
        b=DEmWg1M4qZQLsDqq1e6m6+4z3BgbVq6VG+AwQNte4MpdvPLR4TPsQFTIVzs71OBQMBtMAX
        g4aug6lzuuh3ra4M+gm5ZVhNLL+jpA4/umC4CaDZPSuc0eAcR6TpAFywej0VLzb2/VeEqL
        dnbKzSFCqlr/sVJ/DIYz7+/goDqucxSldRQF/zGUoJ+X6byj4So5r4FSPHOwNaUxtcU79k
        VQw3XZ1zORm+/lzbVmSEzjkl+lhWP4oNekO7yEjNhcGHlALuDVm1ZezBxL0p9iUPc1HI4w
        rHD9DGIjh2Oc4bta4gk1WBX68OwIayJyH+v52d+ahDirwfuYB/FqKNEuWgmzKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664348467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVQQlU3/HsnQBwSPRWGk8rWCPw+RBoaolgbO3+3ZBW4=;
        b=s94B8mybI5gDrSAm5mJQIyJv0LJRBXS9lBChzj2Q/wk+Af3zK7XyZup0cd1WVXVm+AD+qP
        98JKZ3v8iTAHoBCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     akpm@linux-foundation.org, ndesaulniers@google.com,
        nathan@kernel.org, vbabka@suse.cz, masahiroy@kernel.org,
        arnd@arndb.de, seanjc@google.com, hannes@cmpxchg.org,
        ojeda@kernel.org, mhiramat@kernel.org, dmitry.torokhov@gmail.com,
        atomlin@redhat.com, ddiss@suse.de, christophe.leroy@csgroup.eu,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
Message-ID: <YzPxMvjdjVEK1/b1@linutronix.de>
References: <20220928064934.70867-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220928064934.70867-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 06:49:34 [+0000], Ren Zhijie wrote:
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1273,6 +1273,7 @@ endif # NAMESPACES
>  
>  config CHECKPOINT_RESTORE
>  	bool "Checkpoint/restore support"
> +	select PROC_FS

Couldn't this become a depends?

>  	select PROC_CHILDREN
>  	select KCMP
>  	default n

Sebastian
