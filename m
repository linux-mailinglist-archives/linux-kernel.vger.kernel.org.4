Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CD573ED09
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjFZVpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjFZVpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:45:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584D410DA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:45:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6adef5c22so1795141fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 14:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20221208.gappssmtp.com; s=20221208; t=1687815938; x=1690407938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWBO+8U/421C6qnZFfBRFVQ2khXkfAf7hW4FaCQeGOM=;
        b=yJBWUfxCjg0SGkUb+MDPHVLnhBEpjlDqsVZMIj5h7fYkh42gdUNLT13T0Bl/fqIb6h
         BUsJzzrQVLzKbhV3utLKPCMfbiN+cQgYMFOdBcKGbhkAMdBWjLcRwhcUn3JctDGKL9Ri
         wCyfRPAeUWz15KMQe8rQrt1FMszvTTmdFWGS3tiiHSq3TjVD3va/Q1HfuJSHAB0pTVD1
         lJ4iHb4WErMK5vNyGINbCyY3IqNKhk9RDdsQy7Yxs5oQYBN3Flm3G0SXYYKj8blGvVWP
         KEylZZdsx1oIJc/IMgsX7DVK514/qRnfKkIU4J5YUAohPdtxkQCQvozz0fLDgYbUxEDu
         f6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687815938; x=1690407938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWBO+8U/421C6qnZFfBRFVQ2khXkfAf7hW4FaCQeGOM=;
        b=WnzOhe47mJNyk2K1UFp7Cdjz5P4CPpjB+XLX1o89fpChG2m7pMukBr9avl2fgPQ1ea
         ihX5WNUhlCr8d6da5ORF100JJ40o+j6u/lNJPkbAPQjIBkddwgVWYfsEZu33AdG/6N2F
         nu4zQIymHVhsYX3MhtfzEPD9YBCZMkf2pjzgJA9zchuKf6HWwCvnY+1yYCvH8ZRvIWGP
         qb3Q1atJG9FLwc1P5CM2pTENsHgI2U+ppyrUOZFG3hPaJeqlhSqXcBQf9zJ1T8GRzK1J
         T+AdpzOVJxWQJKb1Ooi7sxONxjBfuBZXt2kH1qqJkDKCy63LWlKe6uv2t9fiJWKxdA9m
         Aqyw==
X-Gm-Message-State: AC+VfDx6JixlZaYeyIMCUbkhLFZJ5xDpGVsd4pm3fsDMXQZHiHpS/B7S
        KHP3Y5fJ7tRAbJrPjBxO47QCqe4oQNAls2N89dU9YOtVdzfG+u2KsrLPEg==
X-Google-Smtp-Source: ACHHUZ5PctXyofVpDpMVcdMvk7s3zAN9obrjWz7rL+8IRls2UO+zd4DXxIYv8DVersHvxUlzuuDxBI+OzNYA5lXCiAk=
X-Received: by 2002:a2e:9f56:0:b0:2b4:4c9f:e742 with SMTP id
 v22-20020a2e9f56000000b002b44c9fe742mr20835469ljk.37.1687815938270; Mon, 26
 Jun 2023 14:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230626180800.476539630@linuxfoundation.org>
In-Reply-To: <20230626180800.476539630@linuxfoundation.org>
From:   ogasawara takeshi <takeshi.ogasawara@futuring-girl.com>
Date:   Tue, 27 Jun 2023 06:45:27 +0900
Message-ID: <CAKL4bV4w=Ygz72E+qtj570S3-nooWyXsRu78sC0j+C925CMNrA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/170] 6.1.36-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

On Tue, Jun 27, 2023 at 3:28=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.36 release.
> There are 170 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 28 Jun 2023 18:07:23 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.1.36-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.1.36-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64), arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
