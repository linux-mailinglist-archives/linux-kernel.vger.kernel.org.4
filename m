Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E518673AAD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjASNq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjASNqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:46:50 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08981613C8;
        Thu, 19 Jan 2023 05:46:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id a11so3397476lfg.0;
        Thu, 19 Jan 2023 05:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6jMrzHfUDMPhgoNY3yBd3hH0UTZZSH5iDS5mJLl0a84=;
        b=nsIQEI4Jqq5DVCmCuuojkzlwUJrC1cc+FJ0GCunSHeHdGo/1280j0Is7H0xBkfZc3q
         zhjdQOjXAkh165V9gOyN0J+8kj2Noe415LnR8C5n+qIE2+Errcxl7GbosvrSPmI4gOFw
         Fz3XUs22zAGJl1AyHQTt6afEytrsDV8WLjDDSBnO3zvJ9MfgH28rmnz3uOl9zy1D1KJb
         hrkWt+oMxCXLyNodUMWftk9E3oG2r23/YZ9f2bvF+Lx968RIarluhHjMgYEc3LfcxGaA
         SPcB88xFwqlrTc+FTrAGnl52xHj6sgtlDpn+F31Au6yoCewX+3pjyYt7SwdIU34sBGG6
         q+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6jMrzHfUDMPhgoNY3yBd3hH0UTZZSH5iDS5mJLl0a84=;
        b=0XAGhlkpUG0MiQUxJLWzBMbFrhb1JJMkaoHFdjElxhxjm24bVsEsNvGmG5GJkll+9F
         TRRBbDEIjlwSbbD9OyeoPKjuKTyl5OeFMUI9EHfft5Xtjbd+dchQdMdrBOostQ5JgbC6
         9RiMy30+ilOxkheuCI55Q8zShNO22phND1/pSbg/v8mVeTE0gVFwje7RymfwMAG2sfoH
         R6Ky5OX9HFWlOlcwTaNg83jV10yiAqfrHVY4MkO5C+8sK15UspGJ+7Ux/QqBfRtyr6RY
         gtIUvUc3GsogGO6+mnJDTsLs54Yq3h3iSAZh1XbC9vNn1vjQth4oywzhTykFwhZ4EXfO
         8UCw==
X-Gm-Message-State: AFqh2krPNZ2zgp5DOgFJTgtuiun8QYLhRnxkStkOwg6pFdGxb3r5Hp2H
        4t5WyZm/dwztM151XZIk1/eEpt2FNETggOyPLxAJpcFm
X-Google-Smtp-Source: AMrXdXs1eVnrtkkjaYXo4G/F36N2WVOQE8ZZ1Ky3bMn/HPt8/om3BFjfXu66wvpsvZpNLBr8BrCvPJvVJuw6RW/iNc4=
X-Received: by 2002:ac2:4c8a:0:b0:4cb:e53:d54a with SMTP id
 d10-20020ac24c8a000000b004cb0e53d54amr1091310lfl.156.1674136007018; Thu, 19
 Jan 2023 05:46:47 -0800 (PST)
MIME-Version: 1.0
References: <20230119111853.596560-1-arnd@kernel.org>
In-Reply-To: <20230119111853.596560-1-arnd@kernel.org>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Thu, 19 Jan 2023 19:16:35 +0530
Message-ID: <CANT5p=r+FB87Mx+Je6Xeo1-q=Cu01Mx++jR-=UegFYRtEtpBmA@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix debug format string in cifs_debug_data_proc_show
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Tom Talpey <tom@talpey.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jan 19, 2023 at 4:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Printing a size_t as %lu causes a warning on some architectures:
>
> fs/cifs/cifs_debug.c: In function 'cifs_debug_data_proc_show':
> fs/cifs/cifs_debug.c:478:75: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
>   478 |                                 seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"
>
> Use the correct %zu format string instead.
>
> Fixes: 962a0fd04791 ("cifs: distribute channels across interfaces based on speed")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/cifs/cifs_debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
> index f5f07019fc7e..2e644d926e62 100644
> --- a/fs/cifs/cifs_debug.c
> +++ b/fs/cifs/cifs_debug.c
> @@ -475,7 +475,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>                                 cifs_dump_iface(m, iface);
>
>                                 iface_weight = iface->speed / iface_min_speed;
> -                               seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"
> +                               seq_printf(m, "\t\tWeight (cur,total): (%zu,%zu)"
>                                            "\n\t\tAllocated channels: %u\n",
>                                            iface->weight_fulfilled,
>                                            iface_weight,
> --
> 2.39.0
>

Hi Arnd,

Thanks for pointing this out.

-- 
Regards,
Shyam
