Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1A7D64260F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbiLEJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbiLEJsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:48:10 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8220531D;
        Mon,  5 Dec 2022 01:48:08 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 483972C5;
        Mon,  5 Dec 2022 09:48:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 483972C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1670233688; bh=PA9hQFJgCtk68OD5hAoWj68bJSPD076D1QMQekUjfk8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mduFeciCq2cjBgjg9O4xkyN1ZlKg4Ql7zxIg3vBwJ4oV3NMOBgCeUVSuET31ImvZy
         Ntgner7meSZBiRGe7vSZ1gt92p6m9NCgKc6tumKKMkixNLxTepUkJ3jWxZXjDRSXlr
         B7K6NgmZUoEwCpoGywSvCR5D9lQ4VUDQxJbzX9soD+dJRHxEbZrNVnHfgr0/XiYZGl
         opuY4sUN94fwsKUdV+w1p3YZkA0NzpO9ss2PDr/Tx2s1NJeZimpIIeGeYqYWfzybuR
         xMfIq3QLlhFLezICS+TUoNBNYmJRHJhxxPOT2Gs4ATPcm4E/M87TeI+oEbL2Xb2pGz
         zyjsiN926B3xQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>, Wu XiangCheng <bobwxc@email.cn>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] docs/zh_CN: Fix '.. only::' directive's expression
In-Reply-To: <20221205032622.8697-1-akiyks@gmail.com>
References: <20221205032622.8697-1-akiyks@gmail.com>
Date:   Mon, 05 Dec 2022 02:48:01 -0700
Message-ID: <87r0xembam.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Commit febe6c2f859e ("docs/zh_CN: Add translation
> zh_CN/doc-guide/index.rst") translated ".. only::" directive too much.
> Use the one as found in the original doc-guide/index.rst.
>
> Fixes: febe6c2f859e ("docs/zh_CN: Add translation zh_CN/doc-guide/index.r=
st")
> Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> Cc: Wu XiangCheng <bobwxc@email.cn>
> Cc: Yanteng Si <siyanteng@loongson.cn>
> Cc: Alex Shi <alexs@kernel.org>
> ---
> Hi,
>
> I came across this error while grepping ".. only::" under Documentation/.
>
>         Thanks, Akira
> ---
>  Documentation/translations/zh_CN/doc-guide/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/doc-guide/index.rst b/Docum=
entation/translations/zh_CN/doc-guide/index.rst
> index 5151953c196f..78c2e9a1697f 100644
> --- a/Documentation/translations/zh_CN/doc-guide/index.rst
> +++ b/Documentation/translations/zh_CN/doc-guide/index.rst
> @@ -19,7 +19,7 @@
>     contributing
>     maintainer-profile
>=20=20
> -.. only::  =E5=AD=90=E9=A1=B9=E7=9B=AE=E4=B8=8EHTML
> +.. only::  subproject and html
>=20=20
Heh ... that's only been there for a year and a half...applied, thanks.

jon
