Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BB85BDB23
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 06:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiITEDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 00:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiITEDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 00:03:45 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6065C2DD4;
        Mon, 19 Sep 2022 21:03:40 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id q26so1740243vsr.7;
        Mon, 19 Sep 2022 21:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9p3vxJkL8RheHt7HmOzh/lIGQhD2BoRvtqGyfowdj8E=;
        b=THBlQ+1cFNQAVS1QfnzfbeC2nXo47pElTnE0D+OpEfYecuzQsa1JD8aMC02cDcJPal
         YNC+V/Q+dEqxxDCSxim1w7qf3KXlWjdZu/0b5QL/eT6Iicqyh8u86C9sBKvb1Tkdn/yp
         m38VomC6rgkA4zcP3InZJPBER0FtmDPdZ87viOdDq5403fo5m6cHhVvQUwlmSTrwixRr
         2YtxKp5MDkYtxmR384m/U1ZnkduuqYAqUGMWCYSdg3Hj6h8JnORyvTSfqKur1spRnfyY
         9iY2KHFFh2uS+A6v1IGWkTUSagUVGx16nD9hpykvsKhoNAlFZZKUuWVzL1xfXM50+wAH
         lwFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9p3vxJkL8RheHt7HmOzh/lIGQhD2BoRvtqGyfowdj8E=;
        b=ElbqzDh4WSmkfYPYK3VpCTda0irxkiaxJ82xqur0NnFKFZKYyeKzsDQadEeSxneMzy
         1cMWixeWyoydsRBt7MmAn4rFiX5ig6gKbYaStssAoCkTi5ntl9ytWPbuOQpVgiB38w2b
         im2sI+dtPxoPg/FfgVsNuXo+s5V+9lpq8ivKP4bcn+G6aq7B1MeuenZo6yvuOPOvbJs9
         FOXvSn0vFS6uSuMLkignomVb+P5eFod2+wjop7JYbYhFVFPOpIl1Diaav05EOqr0dJmM
         BFahEUQOSTjGJt5V/mDC8M000SUv+VdmorA35+kbVIO/64/TyuWmVYqXMPvCG5Dllaos
         +3bA==
X-Gm-Message-State: ACrzQf06CIHZb2yVM0H6GXBQYtDyeaNicCaEFgF/zjfNh4XkMPpVdPRv
        EDrl1Ts0u74PjcLIS3ky2QcBAJn/kFoUQmlRbcY=
X-Google-Smtp-Source: AMsMyM5OLjPVlyDmbcFZXVFLFn/qjtrCjidXLl8EJBGPLWirDOanB0DlnvAT425b9eSqVvk8+m0m9YfzYW5ttWyWsU0=
X-Received: by 2002:a67:1d87:0:b0:398:6d94:dbf4 with SMTP id
 d129-20020a671d87000000b003986d94dbf4mr7045221vsd.6.1663646619247; Mon, 19
 Sep 2022 21:03:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220906032435.932451-1-13667453960@163.com>
In-Reply-To: <20220906032435.932451-1-13667453960@163.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 19 Sep 2022 23:03:28 -0500
Message-ID: <CAH2r5muzL_wNVKxzoeQ17rMmbG8Loz8H_REWWysOV2qy2JzyzQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: misc: fix spelling typo in comment
To:     Jiangshan Yi <13667453960@163.com>
Cc:     sfrench@samba.org, pc@cjr.nz, lsahlber@redhat.com,
        sprasad@microsoft.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
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

merged into cifs-2.6.git for-next

On Mon, Sep 5, 2022 at 10:29 PM Jiangshan Yi <13667453960@163.com> wrote:
>
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>
> Fix spelling typo in comment.
>
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  fs/cifs/misc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
> index 87f60f736731..c6679398fff9 100644
> --- a/fs/cifs/misc.c
> +++ b/fs/cifs/misc.c
> @@ -824,7 +824,7 @@ cifs_close_deferred_file_under_dentry(struct cifs_tcon *tcon, const char *path)
>         free_dentry_path(page);
>  }
>
> -/* parses DFS refferal V3 structure
> +/* parses DFS referral V3 structure
>   * caller is responsible for freeing target_nodes
>   * returns:
>   * - on success - 0
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>


-- 
Thanks,

Steve
