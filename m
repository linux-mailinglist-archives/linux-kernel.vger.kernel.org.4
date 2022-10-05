Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8A35F5022
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 09:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJEHFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 03:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJEHFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 03:05:15 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3E51C10A;
        Wed,  5 Oct 2022 00:05:14 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id i16so2472358uak.1;
        Wed, 05 Oct 2022 00:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8aT3ZVpi5WeAj43kYZJ6xwt+SqgOLzhjx0HSFYp6E1U=;
        b=Qgf5yxKs8Ufa3XvUUjpFVmVaScX6P5zg0PaPZfg2UkFPKzQMy9+ebsYVcIuo5j3XVN
         YdrAhsNlWvZruFT09ZwO+YlB3OoWPnTe5eN0tUyamBmkVZYabg2q+Y/IHQmpI/Ggtznu
         kc8AV2u0DVeaFB4W2ak1l/2hmJnv5228EYgcAotyzKHMSfsISM7ns4xUu8OTpFjeFsdQ
         0qRKnFyzHqAYPn56bej8b9HgEihss94SCwi+pY3Kzufupbqc5hCU+FsiWaq4kohkvd3e
         Wyr8+QeUo9wvTalZEkq9B77Jak0EigB6XKBzMDQLToBZnzyh3548iJI1smucYO/Pl0GE
         sC+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8aT3ZVpi5WeAj43kYZJ6xwt+SqgOLzhjx0HSFYp6E1U=;
        b=6rPuZbYJdDiMdGEIcv5l2fpCHDjGDOuq6Cw4jsdEguNnwgP0fZlehZWjqFEQNr+sIY
         AZjh3RRoj07MPw7DTzKOBnzwcZpkEpH+CqZHjQMH1aXVLN+og9h8uGdghyEccaywFNBp
         b3SEPSPfsdcnMnj8o+yeCii3J6+tfVbAOZjlVoREPJrnhCVdDTAvXdnrH7DbhAMKbO4V
         Pty0dZTY4fer0/inD09qHTb9G74lrIM5GPsp+9kb0gzC8hDH/qj9LrXvZamGs4fILXeW
         4iUIEHpH+dDpLwJA8qBJVRK2ySOnlcg36KIm/4KoEJPr4YI5nXZojJJtOHSa/THXopnE
         dVmQ==
X-Gm-Message-State: ACrzQf3hw6HpJi+2cPhSBrDQwnmVRNlFev89nVfrwcuG0+fqIt4Cw2bM
        dAHkiTOusrEXxejWWoEZbnFU/nSWqY03ErjBsXA=
X-Google-Smtp-Source: AMsMyM6KJdauMwanSUvHPSoa4YkBRKhlgG89W21dmwlM5F57Hud76dok8V9eod/8ydcKlGMaNup60GQ/R+vy6oAniJk=
X-Received: by 2002:ab0:6494:0:b0:3da:7cac:c48d with SMTP id
 p20-20020ab06494000000b003da7cacc48dmr3458773uam.96.1664953513845; Wed, 05
 Oct 2022 00:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20221004062333.416225-1-usama.anjum@collabora.com> <87o7ur4dp0.fsf@cjr.nz>
In-Reply-To: <87o7ur4dp0.fsf@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 5 Oct 2022 02:05:03 -0500
Message-ID: <CAH2r5mu5p4f3XqscGNPjXa7L+rrcfKHzhg4F7Zf=S_cFdbWTjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cifs: remove initialization value
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Steve French <sfrench@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, kernel@collabora.com,
        kernel-janitors@vger.kernel.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 4, 2022 at 2:09 PM Paulo Alcantara <pc@cjr.nz> wrote:
>
> Muhammad Usama Anjum <usama.anjum@collabora.com> writes:
>
> > Don't initialize the rc as its value is being overwritten before its
> > use.
> >
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > ---
> >  fs/cifs/smb2pdu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>



-- 
Thanks,

Steve
