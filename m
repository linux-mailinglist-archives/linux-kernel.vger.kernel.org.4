Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309FF630CF0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 08:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbiKSHZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 02:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiKSHZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 02:25:08 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6CFB9736;
        Fri, 18 Nov 2022 23:25:01 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id a6so6788356vsc.5;
        Fri, 18 Nov 2022 23:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pBdMJNbSH8U8r3sDotTSzBIJa9GdWBR9o8sXjNY/x8I=;
        b=QneZXLTu/TV8Zrw0Vs8fqN62kXxM0ofhET0pwOh3uIjPAu02hOdd4dXZXR2towYCV7
         VWNyqv8eRp/XSY5b26St/+ch2z/LJ7oxVk7pFbGvfmYe6TezAR/MUe1VhuAMk0gAJxZN
         KwtyG82Gj4zGut9f9xbX6YbI/EOYgG+3AqYvA1BpOLTYJzu+colIarHQKCJIPD3rfLT1
         qf1eEujz2HsYv43WdEJxsQJ/dbPjPGstEgPMxKJkS84D7inypvpN5D/104wNMaVzLxS4
         olGLbsCpb7a1L9cuCAaNIc/zlJp2TPc9orOCQUp0sWHpA0ppRQLPxJxTE90LslVyC+XM
         EW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBdMJNbSH8U8r3sDotTSzBIJa9GdWBR9o8sXjNY/x8I=;
        b=q6ToNR+bU1mSvnQFtjYF/krn2tws0UUK1WJsPkkJ+9pZugW5tFhPIARhFleDSWq2Xp
         WmDDwZGUclc/UGumCRuwLZoROH25JuJiQLkN+7qkrntbruBLz+8PwDMTu54tYl+gAATs
         JQNSjHGwvC343/V0OrdDre/pT8J9Nkic/cCUUyn2R2D1LcvfEMk6PqwJfX1/TLJq26tR
         dWEBUr4rm+Jbb9KAGBujuJK5d6cYgMCz1Z+2rapsliaStYZ3OeHxUiwGzgFU3iK3RSFw
         1veHmUhl6UTCxJ1lr0zgEEwrVmwU0ZF/Rnd6v8WCHoDVqPh1IXlLP9PGzf+ryssgqTTJ
         Zy3Q==
X-Gm-Message-State: ANoB5pnJBfdXQqblehJ22i5aBxX9dvyXvjSr1NZklYFP43umvg3KVZ1T
        djBsdJqYh4sLXw9r2QXOY1GB9RYynRu1YhtYxAk=
X-Google-Smtp-Source: AA0mqf5kgwvTQxQ74Nr66JB9hCXZ02yfsW/5qDiD+30udm8BlLYIhz/OZEWt8jfdQgtbP1H/yM/1XXJoxms9hhDtp5s=
X-Received: by 2002:a67:1006:0:b0:3aa:5e8:3a19 with SMTP id
 6-20020a671006000000b003aa05e83a19mr5333896vsq.37.1668842700581; Fri, 18 Nov
 2022 23:25:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114040441.1649940-1-zhangpeng362@huawei.com>
 <CAKFNMomu3Sf4_QHOm=zXM-QiLaVxASpMqpjek0F3SQnXwje4KA@mail.gmail.com>
 <CAKFNMonXdyMw9mrQeGe_KtSfMDPSC_jNai8FZGceVyV9Nxw8AQ@mail.gmail.com> <422d9c54-a119-b2a2-f381-11f83af3d9ea@huawei.com>
In-Reply-To: <422d9c54-a119-b2a2-f381-11f83af3d9ea@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Nov 2022 16:24:43 +0900
Message-ID: <CAKFNMokh1fQNyqVCMWoQVnRnXf65j__Op9p+a3Prz_qk-YnoVQ@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     ye.xingchen@zte.com.cn, chi.minghao@zte.com.cn,
        vishal.moola@gmail.com, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 3:38 PM zhangpeng (AS)  wrote:
>
> Hi, ZhangPeng,
>
> On Tue, Nov 15, 2022 at 3:39 AM Ryusuke Konishi  wrote:
> As for the current outlook, it seems difficult to eliminate
> duplication of the virtual block number, so I think we will call
> nilfs_error() as follows:
>
>         nilfs_dat_commit_entry(dat, req);
> +        if (unlikely(req->pr_desc_bh == NULL || req->pr_bitmap_bh == NULL)) {
> +                nilfs_error(dat->i_sb,
> +                            "state inconsistency due to duplicate use
> of vblocknr = %llu",
> +                            (unsigned long long)req->pr_entry_nr);
> +                return;
> +       }
>         nilfs_palloc_commit_free_entry(dat, req);
>
> In that case, I would like to modify your patch and send it upstream
> as your patch.  Is that OK ?
> Or do you want to fix it more by yourself ?
>
> Thanks,
> Ryusuke Konishi
>
> Thanks for your advice.
>
> Please modify my patch and send it upstream.
>
> That is really a complicated problem. Duplication of the virtual block
> number is not easy to fix. It is necessary to prevent further operations
>  of the filesystem when the filesystem has a fatal flaw. I will continue
>  to follow up.

All right, thanks!

Ryusuke Konishi
