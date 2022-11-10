Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFF8C623CF3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 08:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbiKJHxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 02:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiKJHxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 02:53:19 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF82B222A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 23:53:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id o7so978814pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 23:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PqGMk/XG3aXOYy5I5CRkI+EonIV4UA20sJ/q6wzok1k=;
        b=FyeL2pd+UI7MXNEwJAJnHcObNqlv4Pgl5irbsPLFqazAx9LxifF+ZVvX0et0i2Mqvi
         3yanEqOnC31xYTPvCHqy455O0qghMpLaR3xe9vJCHAoAvW2T6QtRAen0zE4MS+2/oRnS
         Rlc3yftINmKl66/RbSivrPodoOknR9NQNOAL4K44WBNq1ymUvUJ6LPqZYQ5his1dDIyi
         ninZRiaML/1+W1mYvZdQC5bxdr6KzPCFYEtVyQQ+4a6RJavbe1G/DxUHbcD4GSDTbwqJ
         kda8juosekbFWRJuEJRzYQZgpQqYnJZVCnZSuObz0KoNZCQ1rnP7UAmvMhikg7FoUcYc
         8GtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PqGMk/XG3aXOYy5I5CRkI+EonIV4UA20sJ/q6wzok1k=;
        b=WkY9yuxoKOF9esC7jCisy75i/3E3UeuihWBb1M6jHeuLoe73I1TxpJLdXm0IqlRjbO
         eFUKM2LhRhcg1F0yW8vhFSC1Wy3ITLaiOkw+WmTTeYwr3EKeL+CehNIBzxXNDA2il+0K
         mv/PEDRhpYlkLEAz7dtPt1Izf20xwaoDLYnO6b3qhsZ8nF8UaoWIh9Qx/t3SHq73+Fy/
         QU79bST/6iI1krFj4AHnzqkqedeIG+GtsTWGgPCYclMPPQaH6fjOl/eorQP4ld9VKBTA
         W8VAXt7wWItPwJl7zmfEdhKMA2II3OeSRAmgNElnAyAanR6SNlgqF7O+szbrKkKnlgvo
         2hfg==
X-Gm-Message-State: ACrzQf0whkoObR78vYk+uKgKd3SQ2LmMLChwU05L/Db9zSWr7y5I//eg
        06kvH/RHTaydU59x/R6m8cI=
X-Google-Smtp-Source: AMsMyM4Pl7aUvQSZw9rdxm1t+NMgI3bo4cIXFh45xCB1cjpczgGo3FODOtf4fi/KRXBHLRINk4950Q==
X-Received: by 2002:a17:90b:e86:b0:213:8092:e19a with SMTP id fv6-20020a17090b0e8600b002138092e19amr72906994pjb.56.1668066797156;
        Wed, 09 Nov 2022 23:53:17 -0800 (PST)
Received: from jacob-Ubuntu (126.224.215.218.sta.wbroadband.net.au. [218.215.224.126])
        by smtp.gmail.com with ESMTPSA id o8-20020a655bc8000000b0046fb2a58f11sm8556376pgr.29.2022.11.09.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 23:53:16 -0800 (PST)
Date:   Thu, 10 Nov 2022 18:53:12 +1100
From:   Jacob Bai <jacob.bai.au@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] staging: rtl8192e: rename r8192E_hwimg.c/h to
 table.c/h
Message-ID: <Y2yt6ERX3szKn2W7@jacob-Ubuntu>
References: <cover.1667723306.git.jacob.bai.au@gmail.com>
 <9bb563727915e3f3edd863837608336b99564462.1667723306.git.jacob.bai.au@gmail.com>
 <Y2p0dNLBqiWFPzB9@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2p0dNLBqiWFPzB9@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 04:23:32PM +0100, Greg KH wrote:
> On Sun, Nov 06, 2022 at 07:31:17PM +1100, Jacob Bai wrote:
> > Same as other rtlwifi drivers, use table.c/h.
> 
> You say what you do here, but not why.
> 
> Why rename the file?  What's wrong with the existing name?  It's not
> causing any problems, right?
> 
> thanks,
> 
> greg k-h
>
No, it's not causing problems. As we are trying to move this driver out
of staging folder, so I checked how current drivers naming
files/variables, turns out they all named those two files as table.c/h.
Maybe we can do the file renaming as the last step.

Jacob
