Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1992969D791
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 01:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjBUAiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 19:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjBUAiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 19:38:09 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808011A67B;
        Mon, 20 Feb 2023 16:38:08 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u15so3779605ljo.5;
        Mon, 20 Feb 2023 16:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jRi7x8B0wTg1qDueH6Ewqy1ECh24eC9Mbf2dVuLE/Eo=;
        b=gpsbAy8MhRGPz+sBACcBT3G2/g1vNdqqd7R7tRQDAge9C8WD/NkbUn4Sfdis9YkEUv
         jdiAovcmNbyMLcRKeFBFlGbfs8/ZDPwhWnnNuM7blcqQCph+oYQmT41HqqMSBF8bw2BN
         uapTV7y8hehGLpSxg0j4d7GiP+LYKg0Cw4sYLdcBqgnBinxwGwHAa60nQ2HxMQuolXL5
         4uNo3i22GrbYQjMnAPT0/huexdaZheLQHA40FQ59ONVSK6nFYa96g5BTTnvYbxkiGA71
         IerxlL+t77aWux9xdpl6rOHil7a5qUg+3AvHaFtSMmIk29p7mnD30bxmqULCF16iyN1p
         QhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jRi7x8B0wTg1qDueH6Ewqy1ECh24eC9Mbf2dVuLE/Eo=;
        b=H5dfkK8iTNzWKzpRdtQb4CZFS4kjpExwjQy02k5CG3ryMLYzWnMrx85tzgevB0qX3F
         W2TbmIE+S3kkNQp2bTw4m3wlpt0SjV0G75TOoGQsIy0Y3moSQ+qsptLvYat10WI/kfcV
         CRjpqj40W4a/LzwPHkz5/une80HkqG9hTuX5gR1Cxs13jx3buwK0wiQQEMW/8DKBowB3
         x+/mswGmCUn9TUI5B0VHKp5/f/4frirOQEIA/pLGzxWfeN+mF4hnQDSuoec5vlhQjp5v
         askVmAQ59AaS/bFufBSEiM4gtJiu88OWxVKJ5f0891qjKeS4bEQA2FTBQ6pdpgJc/2ln
         d9ug==
X-Gm-Message-State: AO0yUKX27Nh+gpcWYYy5OnO2hr0wpd9dgJsVSm+uJoRyYno0QP31duwt
        V3s8/65G/4bNJZAsAn0tJNpLB+EMttcnDcqTKNFHDra0
X-Google-Smtp-Source: AK7set/646b9DqZoJ7jH7ZDM0ZS5qyAiwgudLa6V7WPnddYsDAEq4eduMuJNysnMuHAaFDB+5MJpVl3LmeLaO/GvXD8=
X-Received: by 2002:a05:651c:1987:b0:293:4ab4:3bb1 with SMTP id
 bx7-20020a05651c198700b002934ab43bb1mr1787708ljb.4.1676939886470; Mon, 20 Feb
 2023 16:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20230221103427.2aba1c37@canb.auug.org.au>
In-Reply-To: <20230221103427.2aba1c37@canb.auug.org.au>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 20 Feb 2023 18:37:54 -0600
Message-ID: <CAH2r5mvW76vBc1ZrpxFzcUkYf43xwbGewjAADMg9DbwQWX0wbQ@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commits in the cifs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
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

Fixed

On Mon, Feb 20, 2023 at 5:34 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Commits
>
>   87788bad1133 ("cifs: DIO to/from KVEC-type iterators should now work")
>   043e4d17b6b4 ("cifs: Remove unused code")
>   3eb2bd2275e1 ("cifs: Build the RDMA SGE list directly from an iterator")
>   6b188cd64831 ("cifs: Change the I/O paths to use an iterator rather than a page list")
>
> are missing a Signed-off-by from their committer.
>
> --
> Cheers,
> Stephen Rothwell



-- 
Thanks,

Steve
