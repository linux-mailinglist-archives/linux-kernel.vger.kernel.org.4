Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558D26C3C96
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjCUVWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCUVWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8391A442C9;
        Tue, 21 Mar 2023 14:22:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1378061C52;
        Tue, 21 Mar 2023 21:22:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7652AC433EF;
        Tue, 21 Mar 2023 21:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679433756;
        bh=7g9jByW3d7CzWFzHWigjSdnscnxSJPVdQ5hsZ3Zmn7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VkMDL3nIm5kUOSRD/buVKCJ+1nTHRaAA51zdV+71eREQOJSKkjhQFGbPZFy1wcYiQ
         9WKsfpZkn5s2GJTZrlslPF/D3tTbvfeBDanQPvrqhXGH5BiqOtM1JfiOT++OcS2SZe
         Gvwsd/yYNWxuyD4lvCALSdDYANG+9+HxGE+tddn3imCL8pamdnQXa3x5B75sVd0wKk
         0u2vX+yCEp4SZ8UCKEXQzCvPE6ASdf11ucBmNWUhp40qQEXji941ioemG8STlfWKQG
         rRRnMB4gF8MdFVmkUlAYxU3BAgz6W49OlQPtVhLQKq3HBhdqlIHYAeVq14AnqSiB7u
         vT0rjCCtEqmgw==
Received: by mail-lf1-f42.google.com with SMTP id bi9so20827466lfb.12;
        Tue, 21 Mar 2023 14:22:36 -0700 (PDT)
X-Gm-Message-State: AO0yUKU+VDdIkC/DJTG/rG8pBbfq2riv+MNQa/UCCmp8Y8kk2tQrWbS1
        JML/MJPDSbunAsBJe/SN1F53VAjLQRzWWSBoKS8=
X-Google-Smtp-Source: AKy350bjsgHx59NmZzrYuKAFGunhyn6AkWLtJFZw6gBNaWQPCchHrRzcNTgi7VUFjf4uR8mp7mqw1LW5R/jXsF94BVU=
X-Received: by 2002:a05:6512:1090:b0:4d8:86c2:75ea with SMTP id
 j16-20020a056512109000b004d886c275eamr11003lfg.3.1679433754869; Tue, 21 Mar
 2023 14:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
In-Reply-To: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Mar 2023 06:21:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMRbEX3ZW4MLjPS9CJeqJt2NaUkL7cLT1PfwJ8uhu9bw@mail.gmail.com>
Message-ID: <CAK7LNASMRbEX3ZW4MLjPS9CJeqJt2NaUkL7cLT1PfwJ8uhu9bw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: deb-pkg: set version for linux-headers paths
To:     Kevin Locke <kevin@kevinlocke.name>
Cc:     linux-kbuild@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 3:36=E2=80=AFAM Kevin Locke <kevin@kevinlocke.name>=
 wrote:
>
> As a result of the switch to dh_listpackages, $version is no longer set
> when install_kernel_headers() is called.  This causes files in the
> linux-headers deb package to be installed to a path with an empty
> $version (e.g. /usr/src/linux-headers-/scripts/sign-file rather than
> /usr/src/linux-headers-6.3.0-rc3/scripts/sign-file).
>
> To avoid this, while continuing to use the version information from
> dh_listpackages, set $version from $package.
>
> Fixes: 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enable=
d packages")
> Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
> ---
>  scripts/package/builddeb | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/package/builddeb b/scripts/package/builddeb
> index c5ae57167d7c..6fd590437f47 100755
> --- a/scripts/package/builddeb
> +++ b/scripts/package/builddeb
> @@ -229,6 +229,7 @@ do
>         linux-libc-dev)
>                 install_libc_headers debian/linux-libc-dev;;
>         linux-headers-*)
> +               version=3D${package#linux-headers-}
>                 install_kernel_headers debian/linux-headers;;

Thank you for catching this.
Can you pass it as the second argument to the function?


   install_kerne_headers debian/linux-headers ${package#linux-headers-}



>         esac
>  done
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
