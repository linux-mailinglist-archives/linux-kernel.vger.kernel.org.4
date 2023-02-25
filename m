Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58706A26FD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 04:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229485AbjBYDgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 22:36:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBYDgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 22:36:09 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14458106;
        Fri, 24 Feb 2023 19:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=hxzZrMhq5Nl8tebFnv43EJhbVIwu8W1+9GxPxjkfc/Y=; b=CqMfSqQHKGCVdrrxIsf0sIq99w
        3Kcap9HVLA+6PCSZjKT9BT1gH7pFXLAphDueZ39oIZTuUJqREch54yI7aHQd/KHLA/Xx3ynbFhdMi
        89AvtVnmuuPEddUuPQCdOOyDBOrO715Xc/PhCBZcIpUCUC9QY8k/5LRl/qGtlXIiBGGE0T6ncnbPL
        IqTzl2HxcLt/q9pCM1DhFIjKmc2/7ia8tgeRVPt8Mr0z8pkbz8GYP61GCIB7081DMcEcSUEcqKikz
        uaFRkGxpQZ0in3XVh1agTK/FEnAfShOoXP1T6KiMuAcmSDkjcS2RquhsE/Y8CDielcoY7VDZtr8gX
        GBKcx+PA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pVlM0-004kB8-JR; Sat, 25 Feb 2023 03:36:08 +0000
Message-ID: <f39334e6-1f2f-e574-483f-d70d73963ded@infradead.org>
Date:   Fri, 24 Feb 2023 19:36:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Content-Language: en-US
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
References: <20230225033421.3323164-1-joel@joelfernandes.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230225033421.3323164-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 19:34, Joel Fernandes (Google) wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 2429b5e3184b..0943139fdf01 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5085,6 +5085,10 @@
>  	rcutorture.verbose= [KNL]
>  			Enable additional printk() statements.
>  
> +	rcupdate.boot_end_delay= [KNL]
> +			Minimum time that must elapse before the boot
> +			sequence can be marked as completed.

+			in milliseconds.

> +
>  	rcupdate.rcu_cpu_stall_ftrace_dump= [KNL]
>  			Dump ftrace buffer after reporting RCU CPU
>  			stall warning.

-- 
~Randy
