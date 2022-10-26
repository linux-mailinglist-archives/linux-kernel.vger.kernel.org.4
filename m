Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F660D8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 03:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiJZBNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 21:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJZBNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 21:13:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678CEE4C28
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:13:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso2638442pjn.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 18:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gggPBAdhwzHx2K1mydrKo8NbjmVha3/Mzmm/f3GMSRU=;
        b=TrJkrw/wSHS5X3vvLUaKxFJtrzPtH5iTzVd7Vcjqm9q+T40od8a4eYZJ/tdXYPXti3
         X2CD6GMeTxCHU9skHFuPbjb0De5yMEaMtfbMzKuQ4oAG7grxMIsgF+oWxoHhQFu3e5it
         +/haYeMQxrDLQmdWmELgZoaKC5+zqg3EzlDNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gggPBAdhwzHx2K1mydrKo8NbjmVha3/Mzmm/f3GMSRU=;
        b=QTibjof18yWUjqSq7zTkSiPoCAdSmTTq3iWjHxHK5MMlRr/0CwJIONAfegMOBV7Zzd
         Rgz86Gz7m6WY4EMQg0IJKeWzkr5LL0JCe5TCIu7wwRlEaJT1zYA9MDDlrgOffBIRXAam
         XI0HuMvVrg4NZ6ucFBmaQYQ2mtcWHooyYZom+91k3pcd1gcGzLIjBUHPK9IEA2BNFvZE
         8qazwLl/3j7K8tNHFuxshEz7WAbiTiJ4erzJ+N3/YHpNXRpWf+Lsjha9A6qnQvUrQWBM
         lnM+lfxvmVcZZY960BMvSnfLGo0R6pMLIxxoatUjMWusXcF9ad/7g5VitBPgdtEGuSfZ
         syvQ==
X-Gm-Message-State: ACrzQf3M5dBPrpIJZlLUB69mC9MlexGqVqsOx2K0Od/OC4KfKp6NxOC0
        QoPkc2hp6Hj0m23jEZtnfMc66Q==
X-Google-Smtp-Source: AMsMyM5JEmI8MymPbUu6llAYi+U3etJHqlQZAkTVnxE/sJy0QUl7WqIthyrxmdjrIhdstLQHrYVdMQ==
X-Received: by 2002:a17:902:6bc8:b0:178:81db:c6d9 with SMTP id m8-20020a1709026bc800b0017881dbc6d9mr41814359plt.56.1666746826901;
        Tue, 25 Oct 2022 18:13:46 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:faf6:e503:6cac:3b53])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090a158f00b00212d4c50647sm189268pja.36.2022.10.25.18.13.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 18:13:46 -0700 (PDT)
Date:   Wed, 26 Oct 2022 10:13:42 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <Y1iJxiAky+k7Tgaf@google.com>
References: <20221026115748.24b57082@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026115748.24b57082@canb.auug.org.au>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/26 11:57), Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/admin-guide/blockdev/zram.rst:304: WARNING: Title underline too short.
> 
> 10) Deactivate
> =============
> 
> Introduced by commit
> 
>   410119cc7a63 ("Documentation: document zram pool_page_order attribute")

Will fix. Thanks!
