Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF71B6D7FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238406AbjDEOmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbjDEOl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:41:59 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E774D5FDC;
        Wed,  5 Apr 2023 07:41:46 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id q14so37535264ljm.11;
        Wed, 05 Apr 2023 07:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680705705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OrPnHM6kR07tQpQhjwYQFPsQYzV9Yi9Okr9ge4OtXWY=;
        b=Y6XW9Eor55qHHGh9dkFtt3Xvy98hvF32Ayr5ibjrJd8L8A9B3ddu/ykIvGxNp6x3XB
         xAAnssCqt7nFmQhONLg1R4bRmUBjFdmIUk4A+o0UTfkAlaFJ7acZGykT+rdbSkG5I2qw
         JDOTDueTu7YyhJB3X37Edaqz+M8Q17WLUOGk9kBQNpnLxPvkGXX+4cYbJxqnURT0+hTA
         wnbqXw9GeBbsHv3POnHu+Z+cq1OPENhvRr+rKOEPS0feVeTxIk/Hhy4Dl0KnTFKzecoc
         Ni36qGbhyetiGBde6UNs/cm6y7n4GSCyym4vSxrYIgRNZQAYax3hGhgdHqzA9XoQMzPN
         /Y5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680705705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrPnHM6kR07tQpQhjwYQFPsQYzV9Yi9Okr9ge4OtXWY=;
        b=KFIw/a4zZUr4nsML8mmXQES4GbYPVHwf7kSPAZkELmbultyUoDMuiHUPEdBLLpzi2R
         MLjhkEMm8/43uoOHlC2GB6NqU+xldQVPLwsiSWA+apBIN03tSyU93/9MpXXySEdbeNol
         qbXVuhHksxOnHCXRcf+pEKgZkm2E9ioUP45ExZ2NmbTyj+wUShVfn93E0Ks2gBtpNR3C
         ErokFRf3YySnbkxNDZFk5avieBnPcxHoM6tx9Zn2WDt7quEYohSNgCKmZua/tGN5dbPd
         /3RnCHxNdeSMsuv47VOxKcuXcUNIPAmYZEAn0BGbjb6+xLDANvB8Nh9uquQa3yQNN0yT
         yDVA==
X-Gm-Message-State: AAQBX9fn9y+k8F19RUvU0vrRsdYTQBtFme+omf4EkEf7pkFBoA4VdPaZ
        +3zKm20/ryZyEx+W4QiI6IY=
X-Google-Smtp-Source: AKy350bWnufP/jBagnfX16UQ9PaTzblcl0/JCus6iY6SfZ5mY8xLEDazVjN73F8XIGJ0jRybIvPMjg==
X-Received: by 2002:a2e:b992:0:b0:295:b10f:7c9a with SMTP id p18-20020a2eb992000000b00295b10f7c9amr826333ljp.4.1680705704844;
        Wed, 05 Apr 2023 07:41:44 -0700 (PDT)
Received: from pc636 (host-90-233-209-177.mobileonline.telia.com. [90.233.209.177])
        by smtp.gmail.com with ESMTPSA id c11-20020a05651c014b00b0029e5448e752sm2866434ljd.131.2023.04.05.07.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 07:41:44 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 5 Apr 2023 16:41:42 +0200
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     urezki@gmail.com, paulmck@kernel.org, frederic@kernel.org,
        joel@joelfernandes.org, qiang.zhang1211@gmail.com,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/kvfree: Delay the execution of drain_page_cache()
Message-ID: <ZC2IpnVzW6pjjqbk@pc636>
References: <20230405021342.606264-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405021342.606264-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 10:13:42AM +0800, Zqiang wrote:
> Currently, in kfree_rcu_shrink_scan(), the drain_page_cache() is
> executed before kfree_rcu_monitor() to drain page cache, if the
> bnode structure's->gp_snap has done, the kvfree_rcu_bulk() will
> fill the page cache again in kfree_rcu_monitor(), this commit
> therefore move drain_page_cache() after kfree_rcu_monitor() to
> drain page cache.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 35be35f8236b..3461fc2640b9 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3424,8 +3424,8 @@ kfree_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  		struct kfree_rcu_cpu *krcp = per_cpu_ptr(&krc, cpu);
>  
>  		count = krc_count(krcp);
> -		count += drain_page_cache(krcp);
>  		kfree_rcu_monitor(&krcp->monitor_work.work);
> +		count += drain_page_cache(krcp);
>  
>  		sc->nr_to_scan -= count;
>  		freed += count;
> -- 
> 2.32.0
One question. Maybe we can update the put_cached_bnode() with
checking if backoff_page_cache_fill was set to prevent cache
growing?

Thanks!

--
Uladzislau Rezki
