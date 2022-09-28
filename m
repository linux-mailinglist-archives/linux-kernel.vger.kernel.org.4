Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515345ED378
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbiI1D1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiI1D1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:27:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AF16F9600;
        Tue, 27 Sep 2022 20:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ztIwlXBuabYWjyN1AHG6dexuE3BWpNDnCpEvT9Xlvt8=; b=4xjxfYQmwnxCmQhUT8KQKoLQeX
        wtfrPz2xvEvJxU0qt4Fj+2a/I/KCBUh+CJ3Ef30Zfwf9uXmAkm9ngkfQwrI1r51JujcZAmHpHNYRb
        ATpHZNRq1vUgukWmdOX2XGZkpH7l1JhD6Ko4B9wlDWGZJ8WE17Vpie9SvuXI1MO9CDsznMCHloFtj
        QnXnnfZV14mUDh+8lbxE5RllbtBIOLZzGZgMxIk925usF7BzElGSOUhBAto522N0tmDOlwx0ESJdC
        97JchbK+nqwKbzbwIpWbiBievJ5EBV0WfMK4SisshOBvF080xdrBzmhEWfoo5c/O5Ei8RsyMqNNYL
        yltKA5Rg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odNjA-00DlRk-Lx; Wed, 28 Sep 2022 03:27:16 +0000
Message-ID: <ae367f0e-424c-d026-23fb-5eafec93cfb1@infradead.org>
Date:   Tue, 27 Sep 2022 20:27:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
References: <20220927201053.518736-1-broonie@kernel.org>
 <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
 <20220927212821.GX4196@paulmck-ThinkPad-P17-Gen-1>
 <1d54d4ff-c8a3-145a-7ec5-f32107eda21e@infradead.org>
 <20220927224234.GY4196@paulmck-ThinkPad-P17-Gen-1>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220927224234.GY4196@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 9/27/22 15:42, Paul E. McKenney wrote:
> On Tue, Sep 27, 2022 at 02:33:19PM -0700, Randy Dunlap wrote:
>>
>>
>> On 9/27/22 14:28, Paul E. McKenney wrote:
>>> On Tue, Sep 27, 2022 at 02:13:29PM -0700, Randy Dunlap wrote:
>>>>
>>>>
>>>> On 9/27/22 13:10, broonie@kernel.org wrote:
>>>>> Hi all,
>>>>>
>>>>> Changes since 20220923:
>>>>>
>>>>
>>>> In file included from ../include/linux/notifier.h:16,
>>>>                  from ../include/linux/memory_hotplug.h:7,
>>>>                  from ../include/linux/mmzone.h:1244,
>>>>                  from ../include/linux/gfp.h:7,
>>>>                  from ../include/linux/slab.h:15,
>>>>                  from ../include/linux/crypto.h:20,
>>>>                  from ../arch/x86/um/shared/sysdep/kernel-offsets.h:5,
>>>>                  from ../arch/um/kernel/asm-offsets.c:1:
>>>> ../include/linux/srcu.h: In function ‘srcu_read_lock_nmisafe’:
>>>> ../include/linux/srcu.h:181:26: error: implicit declaration of function ‘__srcu_read_lock_nmisafe’; did you mean ‘srcu_read_lock_nmisafe’? [-Werror=implicit-function-declaration]
>>>>   181 |                 retval = __srcu_read_lock_nmisafe(ssp, true);
>>>>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~
>>>>       |                          srcu_read_lock_nmisafe
>>>> ../include/linux/srcu.h: In function ‘srcu_read_unlock_nmisafe’:
>>>> ../include/linux/srcu.h:226:17: error: implicit declaration of function ‘__srcu_read_unlock_nmisafe’; did you mean ‘srcu_read_unlock_nmisafe’? [-Werror=implicit-function-declaration]
>>>>   226 |                 __srcu_read_unlock_nmisafe(ssp, idx, true);
>>>>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
>>>>       |                 srcu_read_unlock_nmisafe
>>>
>>> Could you please send your .config or tell me how you generated it?
>>
>>
>> For x86_64 SUBARCH, ARCH=um:
>>
>> mkdir UML64
>> make ARCH=um SUBARCH=x86_64 O=UML64 tinyconfig
>> make ARCH=um SUBARCH=x86_64 O=UML64 all
> 
> Thank you!  The diff shown below clears it up for me.  Does it cover it
> for you as well?

Works for me. Thanks.
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

> ------------------------------------------------------------------------
> 
> diff --git a/include/linux/srcu.h b/include/linux/srcu.h
> index 274d7200ce4e..565f60d57484 100644
> --- a/include/linux/srcu.h
> +++ b/include/linux/srcu.h
> @@ -52,6 +52,8 @@ int init_srcu_struct(struct srcu_struct *ssp);
>  #else
>  /* Dummy definition for things like notifiers.  Actual use gets link error. */
>  struct srcu_struct { };
> +int __srcu_read_lock_nmisafe(struct srcu_struct *ssp, bool chknmisafe) __acquires(ssp);
> +void __srcu_read_unlock_nmisafe(struct srcu_struct *ssp, int idx, bool chknmisafe) __releases(ssp);
>  #endif
>  
>  void call_srcu(struct srcu_struct *ssp, struct rcu_head *head,

-- 
~Randy
