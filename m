Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CFA6DB329
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231864AbjDGSrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjDGSrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:47:21 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2456BBA3
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:46:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a228ce9731so2049355ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680893216; x=1683485216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLTo2/pbqaGdaUlRr1PWbdRNZcxUWCLaiksPX42/Bv4=;
        b=OB+ByxAw4BkURK4R+G8bm8Rs6drt6DfimRLhJzLOJYEnl87KmHZQnbq/QqEVhTs2e+
         RAX0flUogBejdNbx1QrzTHFePAbd6fGLBT9ZpAQjIOtc65per7KsF3c3JY6CLOokJQnI
         rEl3ZllHlvQIu3vsnDGw0pxDFl11NJuw8E25F8XuVgHoLZpeK72KXQpbFntowhLYOf4H
         KVD44/LoempTYGAHa3PEFDO9qDQhdS2CCxe4k/In4afRHbWWotoYXj5yaIxHZsL/hdkC
         iNqrcPYDAgo3JOwZ77yh/C5fOZVlFGTX09kzPc66et4S5IHNlMTxHZmNfGgg2ww1iOgc
         iQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680893216; x=1683485216;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLTo2/pbqaGdaUlRr1PWbdRNZcxUWCLaiksPX42/Bv4=;
        b=1qYhJSmbUaH6G24oikZgV+GhDs4/mpR6yZMMWSHF8r1Im3icznNsmCo5419q4hWAY1
         HFJ5QEmcnrI3vxzey7a5ve+65uN+MaosWh9it9+jrIGi2LZ/P+S7Sa5xo9o+fZ0/kq+s
         YV6ULWZOr7oSVMwwZ6IF2TzRw2GDCqjOPn/gVIKZQfYBspQj9ht0n+Mpdq+kJAjABpwf
         PCLA8w0QVphzTWfrYvjWlmQpSJIdgg/iaKgaLoIzTY5B3EptFvZQvbWdn7ZYgSmaaGps
         0B18Y/C0fv0EqINAyXwWxqDt4kF3z+GDaS1bKWNunbiAXPQAeq1bRca+iLJNIxjzYhEk
         WSMQ==
X-Gm-Message-State: AAQBX9f/pNVC0IvrB24ghd9lUwcfYVaWi7p1ZlRe69plxOU9avovrujy
        NLtMwNZVjPvROgbkEss5upEsjFH9MBVSxhZ47DqIGQ==
X-Google-Smtp-Source: AKy350as1CQpweA9VqnR4D8sSPwD3L9mpCdajcNXDnqTT3PiapjkTkWgQH+wLiakf2X4XKTFibbgixAcMIBA+nxofrs=
X-Received: by 2002:a05:6a00:2e23:b0:62a:d87a:a375 with SMTP id
 fc35-20020a056a002e2300b0062ad87aa375mr1682910pfb.4.1680893215506; Fri, 07
 Apr 2023 11:46:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-2-masahiroy@kernel.org>
In-Reply-To: <20230308115243.82592-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 11:46:44 -0700
Message-ID: <CAKwvOdk+7ODHh=fC+=1bky+XEZH=idAsCkymn8Ex0TN8sC7SVQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] scripts/mksysmap: remove comments described in nm(1)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 3:52=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> I do not think we need to repeat what is written in 'man nm'.

I agree, but the paragraphs following the one you removed refer to a,
U, N, w, T, t, and W now with no context that those are the nm
formats.

I'm ok with this patch, but please consider adding a sentence along
the lines of:

The following refers to the symbol type as per nm(1).

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mksysmap | 19 -------------------
>  1 file changed, 19 deletions(-)
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index 16a08b8ef2f8..697fc6653953 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -10,25 +10,6 @@
>  #####
>  # Generate System.map (actual filename passed as second argument)
>
> -# $NM produces the following output:
> -# f0081e80 T alloc_vfsmnt
> -
> -#   The second row specify the type of the symbol:
> -#   A =3D Absolute
> -#   B =3D Uninitialised data (.bss)
> -#   C =3D Common symbol
> -#   D =3D Initialised data
> -#   G =3D Initialised data for small objects
> -#   I =3D Indirect reference to another symbol
> -#   N =3D Debugging symbol
> -#   R =3D Read only
> -#   S =3D Uninitialised data for small objects
> -#   T =3D Text code symbol
> -#   U =3D Undefined symbol
> -#   V =3D Weak symbol
> -#   W =3D Weak symbol
> -#   Corresponding small letters are local symbols
> -
>  # For System.map filter away:
>  #   a - local absolute symbols
>  #   U - undefined global symbols
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
