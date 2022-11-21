Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F88632C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiKUSv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiKUSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:51:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DB2CFA4B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:51:55 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a22-20020a17090a6d9600b0021896eb5554so6120566pjk.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 10:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zm84tpupvmaITkohpBn02m0iZCyzot9WfjUTwDdO95Q=;
        b=TZHHW5kNwjAzkad1Zh5h9lS46JKIGDzI0CDjZhUR4ipjaOHvuj/kxUflclqyIIty9J
         ISzkI2wwBxbUewoU2rAUzbPYHweiawqutaVuI89coe9QRvGziEcY9yAz0uyDJS6tu4hN
         b4hGWZNap3cziCocVkF/WGi3J8dIgnGZLVBiWuCO8BBOznpJwuwC5q6PHGLEFy8AcYdA
         GAFbPatrorCAiEHJtag0mktSYQ873Uelh1yES5QgjKxwpaWh9jByWPpDcy5FtyClXw8v
         Gp3s1oLamUmLbyinhmRdL8vYHC8FSoUXQ2i5jf1Cx9QKoWOmCog2eHLbqtdQF3H5eYYg
         f6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zm84tpupvmaITkohpBn02m0iZCyzot9WfjUTwDdO95Q=;
        b=FRkp8bBOK2MlPxjmyu/5B5348lyZV/v8cnv6a2tcs6YwmYy4u6SPFIIWHcNO5NIjpR
         0WTUw5qJpLDCSMGd6qWC1Crh9cGSuShD++tZVFxt1ZI4JjlqKFpRBgUMbeJnZfAa2lUN
         KNh/SmrdLptNr+TXIEpNGqdPmqSNNZzStKMq23A1qt+RrkNjpPTFypPZHJFFtk0dCwUh
         1H0wdab0LTUoZWk5pWpUwOVvE9HW81ekC/VFanRgX6nls8FerwDb7LJH7AIgeQGhBSYy
         BchnoftZlDKV7yKj0d8c1ey3bmX8Djg0KioJFDaZD183pEjBOyHUJpz0v1OEgHC7gZnb
         HakQ==
X-Gm-Message-State: ANoB5plpWCLA6hsMDQy2sDka3x1lQD2BLCcgBwRlmWj8NMl8fJ0yZmBz
        yZiI2Uz2JrY3LtqswAu4QseVPsdki2OcyRNQnT9R
X-Google-Smtp-Source: AA0mqf4rpW3YO/j4tiyJM0wxI7W4oxRgQk46kvGUSnjsiDptiajWC26FP9j9VcWhsE0W9OXx4MOSRPXOCHhgb8w1HUU=
X-Received: by 2002:a17:90b:2743:b0:20d:4173:faf9 with SMTP id
 qi3-20020a17090b274300b0020d4173faf9mr27566513pjb.147.1669056714787; Mon, 21
 Nov 2022 10:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20221121142658.2e3f4108@canb.auug.org.au>
In-Reply-To: <20221121142658.2e3f4108@canb.auug.org.au>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 21 Nov 2022 13:51:43 -0500
Message-ID: <CAHC9VhR0csviPvHfh5CYm76PVz8LaAaAt38oRv+3gbFHEJP0yw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the apparmor tree with the security tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Johansen <john.johansen@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 10:27 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the apparmor tree got a conflict in:
>
>   security/apparmor/domain.c
>
> between commit:
>
>   f6fbd8cbf3ed ("lsm,fs: fix vfs_getxattr_alloc() return type and caller error paths")
>
> from the security tree and commit:
>
>   217af7e2f4de ("apparmor: refactor profile rules and attachments")
>
> from the apparmor tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc security/apparmor/domain.c
> index 00dc0ec066de,b447bc13ea8e..000000000000
> --- a/security/apparmor/domain.c
> +++ b/security/apparmor/domain.c
> @@@ -308,14 -296,16 +296,15 @@@ static int change_profile_perms(struct
>    * Returns: number of extended attributes that matched, or < 0 on error
>    */
>   static int aa_xattrs_match(const struct linux_binprm *bprm,
> -                          struct aa_profile *profile, unsigned int state)
> +                          struct aa_profile *profile, aa_state_t state)
>   {
>         int i;
>  -      ssize_t size;
>         struct dentry *d;
>         char *value = NULL;
> -       int size, value_size = 0, ret = profile->xattr_count;
> +       struct aa_attachment *attach = &profile->attach;
>  -      int value_size = 0, ret = attach->xattr_count;
> ++      int size, value_size = 0, ret = attach->xattr_count;
>
> -       if (!bprm || !profile->xattr_count)
> +       if (!bprm || !attach->xattr_count)
>                 return 0;
>         might_sleep();

John's the AppArmor expert, but this looks okay to me.  As a reminder,
the lsm/next commit only changes the type of @size from a ssize_t to
an int type.

-- 
paul-moore.com
