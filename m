Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605AF641D4D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 14:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiLDNzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 08:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiLDNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 08:55:21 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1169113EA8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 05:55:20 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id f18so14951560wrj.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ska6TcnCsHh18hDzT75JBNFPy6gHNuvSOCpDNo61KFU=;
        b=EfLbdpMidStzMx8knb8USFBX/Jkp31Efue8m6oW84hSdffdF1vAT9b9xodMyj6S7dP
         JevTDiHMoC/piSZ+K4C2RGcwHutQCRxWzgs/L7/TsA1BL2qYkxAG66NBVs5Kb0FD/CIn
         G8E095n1zgbxJvQbefMssFwa1oONLDWJzM88ztCo7TlS9FKh6LIPLUpb+hiKCpmSjT4o
         cO3AAUpPKHjtSdpQEiIv/hfRQG1BUgchWOhAzNLUpoLiET2DvHgoN3pKgrtOKos5gljE
         wOS6Zr0tWT1ynqp+htCgZLpffAk4qrWg3jSaowipytHN28UNl35bDx7Qp8Ft8pVgu/Jb
         tgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ska6TcnCsHh18hDzT75JBNFPy6gHNuvSOCpDNo61KFU=;
        b=zktVQSoI0mx5BMgTEAQt8LOYZoj848T7Yg5BbckcuvMkKWqK6bObObGDx4pGBMd28E
         I5HBRv8n1nuHWBklqFXmTUbnT22G95c1QTLk8ZT2DcdiFoAxLVaREwq6XOineClvAva6
         IuQzFQQuOASsq6jFljS2s9Qavz/vmlIk5gBJcOx0qN3qNWuzab7bSe7kYLdrzKiSSM+/
         Lb0G6kaTn3+AttS2k5TITNCXVM1mOiJrmApHHTAMs/YJj1RSwYAnQOB9gj2K5H0UZk9c
         W1EkuzOkDk6/YA0hFA9YQB5Cy77qDMesF+bfpkiK8z99FaUhuTFh22in37NFNotylkb9
         pC7w==
X-Gm-Message-State: ANoB5pnhzF1NUNMb9fYfN6h46phjNi3L3Di9kBYlZkn/31yO2cfBTvtW
        6GbUKO34vk1AboQaesxZS3nidsxFtHwZiIeG
X-Google-Smtp-Source: AA0mqf4yrgSHn6+OCXRvUPqPLi80hqzsMSWuOm3G4mIg7NQz66yD5yPkZ61yDQ6PcHsBfepYVdwwSw==
X-Received: by 2002:a5d:4d07:0:b0:242:4ab7:5a19 with SMTP id z7-20020a5d4d07000000b002424ab75a19mr5289115wrt.389.1670162118380;
        Sun, 04 Dec 2022 05:55:18 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:74e8:6da0:c93c:6bcd])
        by smtp.gmail.com with ESMTPSA id x11-20020adfec0b000000b00241f029e672sm11646137wrn.107.2022.12.04.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 05:55:17 -0800 (PST)
Date:   Sun, 4 Dec 2022 14:55:11 +0100
From:   Marco Elver <elver@google.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     paulmck@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] init_task: Include <linux/rbtree.h> in the right file
Message-ID: <Y4ymv/BxtulPrM47@elver.google.com>
References: <f06e810735c49a611e7dc75715f0689b5f7e87c6.1670153931.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f06e810735c49a611e7dc75715f0689b5f7e87c6.1670153931.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Cc Ingo, who had been working on lots of include improvements.]

The Cc list is odd -- it appears that get_maintainers.pl is broken on
init_task.c:

	$> ./scripts/get_maintainer.pl init/init_task.c
	Mark Rutland <mark.rutland@arm.com> (commit_signer:1/1=100%)
	"Paul E. McKenney" <paulmck@kernel.org> (commit_signer:1/1=100%)
	Marco Elver <elver@google.com> (commit_signer:1/1=100%,authored:1/1=100%,removed_lines:5/5=100%)
	linux-kernel@vger.kernel.org (open list)

What's going on here?

On Sun, Dec 04, 2022 at 12:39PM +0100, Christophe JAILLET wrote:
> There is no need to include <linux/rbtree.h> in init_task.h.
> Move it to the right place, in kernel/cred.c which uses RB_ROOT_CACHED.
> 
> This is a follow-up of commit 4e7e3adbba52 ("Expand various INIT_* macros
> and remove") which moved things from init_task.h to init_task.c
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Let see if build-bots agree with me!
> 
> This patch depends on [1] and [2].
> All these patches are related to init_task.h simplification.
> 
> They are unrelated and can be applied separately, but as they modify more
> or less the same place in the same file, there may be some merge conflict.
> 
> [1]: https://lore.kernel.org/all/1a3d5bd51b7807471a913f8fa621e5a4ecd08e6a.1670100520.git.christophe.jaillet@wanadoo.fr/
> [2]: https://lore.kernel.org/all/94c8f2123a8833b61d84a662ec35f9c070cdf4dd.1670147823.git.christophe.jaillet@wanadoo.fr/
> ---
>  include/linux/init_task.h | 1 -
>  init/init_task.c          | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 6d2c4ea4c97a..e18a6c6f6fd9 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -9,7 +9,6 @@
>  #include <linux/ipc.h>
>  #include <linux/user_namespace.h>
>  #include <linux/seqlock.h>
> -#include <linux/rbtree.h>
>  #include <linux/refcount.h>
>  #include <linux/sched/autogroup.h>
>  #include <net/net_namespace.h>
> diff --git a/init/init_task.c b/init/init_task.c
> index ff6c4b9bfe6b..2392c0a67fb7 100644
> --- a/init/init_task.c
> +++ b/init/init_task.c
> @@ -2,6 +2,7 @@
>  #include <linux/init_task.h>
>  #include <linux/export.h>
>  #include <linux/mqueue.h>
> +#include <linux/rbtree.h>
>  #include <linux/sched.h>
>  #include <linux/sched/sysctl.h>
>  #include <linux/sched/rt.h>
> -- 
> 2.34.1
> 
