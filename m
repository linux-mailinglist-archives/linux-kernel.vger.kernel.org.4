Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B545B5ED41E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 07:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiI1FHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 01:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiI1FHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 01:07:39 -0400
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2B21191B0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:07:38 -0700 (PDT)
Received: by mail-ua1-x930.google.com with SMTP id i17so4253719uaq.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 22:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ErZDse3sguqUpUw6XzgHpiTQQNzhuXNPkKhtVfnhZzQ=;
        b=cJoCqi7OhhrFteCkAl3QOi+diI9ocxp4BGJryNt+NU+k5kWgt0od7HFzIO4aQXkyM5
         par1fQjmM6sZfZFG5ZyJdpOLD2gcEnIa81XbuYjTodPjgmmqRnzXGmApyQZFDpopJbiw
         g5G5sukzgqfnZziXnJiWlUQJiLP2Rsfw3+n1jo9Ufc0qI1A4TReCP40CEULmJiqSiJiX
         HEUVK3h9z08aLeb+jSQu1IZbjNJMGn20+sdscz/m9QnyWiEYGYfP21G4pK/m2zOPzNQV
         RdG4DEHaZJzT8Vl1EYlhNOfaL7ASzerbUmZk6Rzk1ydP+Qn9aUyZP32m90rhKCnePZDL
         7tLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ErZDse3sguqUpUw6XzgHpiTQQNzhuXNPkKhtVfnhZzQ=;
        b=P07ao1b/UjRqb5j+FCutsHA2d3JKYNglUgAzGsd6vFUgVqmzn/YHopW3OayXjOQ51h
         +I4dbUobSz9Dhr/oS7ffHAzkL2xyVrMRkXNeS2LmWgan5IWA42pQivRWVs1mFW7tyWVH
         32YPgZHkJnK3Fy7iHPVU3eIakRAOgEnHKM9YFP+0wG+OIkfWU25Ql9sELOib7tE2i22C
         DLHzw/Z4GDzA40OmGRa6Vw34OF9kpNokPHfnXSXol4VDwiBD4TB1j4ndsQTtwRuXQker
         qXW1rtQEG71IZrRDys+uYy6cNegarLZuP1BHjWLnmgZPcInbnLl3kitBHfOoA/3i0I1u
         AtGQ==
X-Gm-Message-State: ACrzQf3GK2TlSmRydAhcU3jNLoStg50Wo9lqIGM+Zkubove2jVIKE0NR
        D9BkxofijuRvL1caaEsZTDAp5DZfOLBPtUvflWoUlQ==
X-Google-Smtp-Source: AMsMyM6yixgpzCvngqJxON6nnQhrKkEWCafoj3zuW5xGZVvP6vf4PkG32geboQC2adDTJPLNE12e1T2OoI/GhlTx8Nc=
X-Received: by 2002:ab0:7412:0:b0:3d1:c2f7:3250 with SMTP id
 r18-20020ab07412000000b003d1c2f73250mr2949564uap.21.1664341657124; Tue, 27
 Sep 2022 22:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220928040058.37422-1-khalid.masum.92@gmail.com>
In-Reply-To: <20220928040058.37422-1-khalid.masum.92@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 28 Sep 2022 13:07:26 +0800
Message-ID: <CABVgOSmiO9f6DdXCfg91714WBJkJ4Cdm5FewCtscxMa_Cv+8Bw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Kunit: Use full path to .kunitconfig
To:     Khalid Masum <khalid.masum.92@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
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

+CC Sadiya

On Wed, Sep 28, 2022 at 12:01 PM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>
> The numbered list contains full path to every files that need to be
> modified or created in order to implement misc-example kunit test.
> Except for .kunitconfig. Which might make a newcommer confused about

Nit: Spelling of "newcomer".

(I wouldn't bother sending out a new version just for this typo in the
commit description. If you need to do another version for another
reason, though, please fix it then.)

> where the file exists. Since there are multiple .kunitconfig files.
>
> Fix this by using the full path to .kunitconfig.
>
> Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
> ---

Thanks very much for your patch. This seems sensible to me.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David

>  Documentation/dev-tools/kunit/start.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> index 867a4bba6bf6..69361065cda6 100644
> --- a/Documentation/dev-tools/kunit/start.rst
> +++ b/Documentation/dev-tools/kunit/start.rst
> @@ -217,7 +217,7 @@ Now we are ready to write the test cases.
>
>         obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
>
> -4. Add the following lines to ``.kunitconfig``:
> +4. Add the following lines to ``.kunit/.kunitconfig``:
>
>  .. code-block:: none
>
> --
> 2.37.3
>
