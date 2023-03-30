Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6331B6D0852
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjC3O2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjC3O2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:28:47 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB92CC0D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:28:38 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id e13so8377054ioc.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680186517; x=1682778517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Suf7F5Ot9u5BanXJLGAuWzI2nJgTXB4l/VJRGV98nU=;
        b=NFDMDJmzddEBSzn0vv/MN2MzJibflVBIDnciMLl7pBLVrvPJtmqL/EQD5jE5ztD8pa
         HGOEntwnAUTpsYsBLSit1ZqyBKeNwQTjivhuqVasAtlEfDCF8N56xmjonLSY7mQ4q2AA
         qbsniumQWmr9BlOjB7/ZgJJVogVB1oCLU+d8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186517; x=1682778517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Suf7F5Ot9u5BanXJLGAuWzI2nJgTXB4l/VJRGV98nU=;
        b=FHv+llwSLWSESJuv8+DUekjAQeVeBmoodxGOOBcw06HGGBp9pB8l3JO4Z0joHIT3ol
         5ju9S2OcuffUeB1a9xcJv/MO2Q+c0kUhygPIV650tqp1IrHOiG6FR9wH1Hf/IXJExVVG
         5vtXOLJwu+6UTRK8jNrSl0k7CF3AqVHKXICiKljFbuIzS5nBBbfFPkxXpQQA+xK11yYY
         FQwmmC9x38faxRQ0tqzJC+oVYbmO3c6vEgDj15tBQFdb/4JnSLi8IGELLMdYqePFAXbU
         +y64imNMGFAYP+MDs3lHYkOW++P1Dh54iJWSu+4Pt9jsE/H/PcVUpvPWbTYiXl8jWeXh
         Db4g==
X-Gm-Message-State: AO0yUKVn9QtxLTkX2zHrcbeZls9bHReF5fuB3xNkGqvN1vX5e1uoWxUu
        zCDAVPhQediUCO5yTuvnGdoOQ+V/krfInVYZ3TYmpXwXAeZhJKaNNU8=
X-Google-Smtp-Source: AK7set+UC8TAnQAjplV9msLDwOsKaMouu2/+pKt3IuG6bQDBe8ZnZJfz3e/UYjyZqrEhoAl/EZMkHqpHB1WJ9Mvjg04=
X-Received: by 2002:a6b:f215:0:b0:745:6c2f:61dd with SMTP id
 q21-20020a6bf215000000b007456c2f61ddmr8809080ioh.2.1680186517458; Thu, 30 Mar
 2023 07:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230330142818.7efb6d05@canb.auug.org.au>
In-Reply-To: <20230330142818.7efb6d05@canb.auug.org.au>
From:   Rob Clark <robdclark@chromium.org>
Date:   Thu, 30 Mar 2023 07:28:26 -0700
Message-ID: <CAJs_Fx67+VQwveGE3i7Nyp+5R2+Z5mEeDJ9ZMTZEY_gnYtc5Sw@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 8:28=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the drm tree, today's linux-next build (htmldocs) produced
> this warning:
>
> include/uapi/linux/sync_file.h:77: warning: Function parameter or member =
'num_fences' not described in 'sync_file_info'
>

thanks, should be fixed by:

https://patchwork.freedesktop.org/series/115871/

> Revealed by commit
>
>   d71c11cc79d2 ("dma-buf/sync_file: Surface sync-file uABI")
>
> Introduced by commit
>
>   2d75c88fefb2 ("staging/android: refactor SYNC IOCTLs")
>
> in 2016.
>
> --
> Cheers,
> Stephen Rothwell
