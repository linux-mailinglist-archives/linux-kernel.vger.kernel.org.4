Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEF35B9FB6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiIOQgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 12:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiIOQgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 12:36:40 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB51E3F2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:36:39 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id ge9so6799357pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 09:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Bya1RG0oExfDfV/RNQQVlFWpnUEDKrN8oNZxHjwTDWM=;
        b=beMcfXIgIlQ37Rw00Boy9/emgcBbDamWMbRxCl6vQwVF0XXcB5L0cw7kKtX7qCraMj
         c8TO/bh+ipD3jyw4NGCIWnhWF0xoRNEZimvheMXhG3JJ+zfghwoleA+L81iELNWvsmuH
         KzATbijxHtv6P4RamBBQNK6u/DHmmeqNQRSAZU0KLC5AttJnHnHzW+rzeAmdBx+whNHT
         WjG4QvVJ5McStg4N4yF1eonJ1R4MutHUa+NEALtd86CzubUEMG5tZlWXeYfDQZKmfy18
         Rpm9GwdkSs+z75Wr/Cd69CweuoIo9XOQA5rRuh8VwAr5G1UTQAxdPG3ZjXam6dfGdIzn
         fmKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Bya1RG0oExfDfV/RNQQVlFWpnUEDKrN8oNZxHjwTDWM=;
        b=VWQf96LWvopFnThuwv1adGVJzd0ohFM0Zi5DrXI/5jhiNx4a+GZN7cx7hvFOLM3oSR
         auQoEBm63TZTa3dlX/iykhxBO0i+Hn0v7jLxzIczbeZzXVoGt0CtTy31z/++qkzxpRKx
         mKtemC3BdPV4nAAxZjn+fgw0nmH80S6wYa+yznxwfufwR/yVDCUaNCAWQLJqNqiGNNoH
         1esFQ8DBDBWYN0K3JMEowWjAppimNyA+HEEsfMGMMHs1bVw0SNCEUU/6X87nT17hzD9Q
         HFYJG12JFCxbjKS3pSrjHTp8SafXClnooxNRKp3DzENKzWaOq/vyUjlKkP+/SnGMV99z
         dCBg==
X-Gm-Message-State: ACgBeo3Te4K7p+M0KegidCinyCdIcJAS9Mn6PgPF2Y1U+CJgze0x8o9F
        UZfsey3yWHTHOYrH2JHY1Zk=
X-Google-Smtp-Source: AA6agR6BXHicLXK2Y8HcyH/GmEIUiIV5gJvZtxMO9SPzo8ZFrbBT3kK77GuwTTwIlCxsmJkPVfiCRQ==
X-Received: by 2002:a17:90a:5783:b0:200:4aa8:a18d with SMTP id g3-20020a17090a578300b002004aa8a18dmr11735159pji.38.1663259798570;
        Thu, 15 Sep 2022 09:36:38 -0700 (PDT)
Received: from google.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id b37-20020a631b65000000b00434651f9a96sm11611043pgm.15.2022.09.15.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 09:36:38 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 15 Sep 2022 16:36:36 +0000
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2] zram: do not waste zram_table_entry flags bits
Message-ID: <YyNUlEGwooXzpF9Z@google.com>
References: <20220912152744.527438-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912152744.527438-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:27:44AM +0900, Sergey Senozhatsky wrote:
> zram_table_entry::flags stores object size in the lower bits and
> zram pageflags in the upper bits. However, for some reason, we
> use 24 lower bits, while maximum zram object size is PAGE_SIZE,
> which requires PAGE_SHIFT bits (up to 16 on arm64). This wastes
> 24 - PAGE_SHIFT bits that we can use for additional zram pageflags
> instead.
> 
> Also add a BUILD_BUG_ON() to alert us should we run out of bits
> in zram_table_entry::flags.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
