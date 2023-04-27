Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D4F6F0C46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 21:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244596AbjD0TG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243215AbjD0TGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 15:06:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1886AC;
        Thu, 27 Apr 2023 12:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B2E063F1C;
        Thu, 27 Apr 2023 19:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC12CC433D2;
        Thu, 27 Apr 2023 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682622383;
        bh=meRmtF+VNeB4Pc8rYOa4sXL6FrHOtpNmnhaYiUGkgn8=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=ARiSR0CRMIuKzsAyx0opyr1J1B9tgfbMgZVGA1DpExcUESaZmKGDjJs7T9QZZSZPD
         jw2OPVpSVwlU5gAUFdsuyWO8IHj1mVB7GF5LlRiaCPApwc3LVhVi8Ehf+412BA3Kk9
         /DQGnd8/8rRz/SHUMU50at2UKVex2e7RykIik1aYBLBOeayFaeK2QYRdB847Shyo5+
         hTuYT7b9PNyyO9LRYCOswQCQ9lyEMYM+U0xWTQXZhpXPcciMykX70yuvidsjOJzn8p
         KYzk+3cNZmlX+kCoAJhglmmRDQW0tUPDQVM9/nXiRj8dZSdiwSQ9i+eDnB4Dk7jcOP
         7BXqB0sb+HUeQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Apr 2023 22:06:11 +0300
Message-Id: <CS7RUM74FG7K.3N64FJ4295TYG@wks-101042-mac.ad.tuni.fi>
Cc:     "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tpmdd tree
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     <broonie@kernel.org>
X-Mailer: aerc 0.14.0
References: <20230427125506.43348-1-broonie@kernel.org>
In-Reply-To: <20230427125506.43348-1-broonie@kernel.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Apr 27, 2023 at 3:55 PM EEST,  wrote:
> Hi all,
>
> After merging the tpmdd tree, today's linux-next build (arm64 defconfig
> and others) failed like this:
>
> In file included from /tmp/next/build/include/linux/tpm_eventlog.h:6,
>                  from /tmp/next/build/drivers/char/tpm/tpm-chip.c:24:
> /tmp/next/build/include/linux/tpm.h:285:9: error: redeclaration of enumer=
ator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
>   285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:284:9: note: previous definition of '=
TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
>   284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:286:9: error: redeclaration of enumer=
ator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
>   286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:285:9: note: previous definition of '=
TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
>   285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[5]: *** [/tmp/next/build/scripts/Makefile.build:252: drivers/char/tp=
m/tpm-chip.o] Error 1
> make[4]: *** [/tmp/next/build/scripts/Makefile.build:494: drivers/char/tp=
m] Error 2
> make[3]: *** [/tmp/next/build/scripts/Makefile.build:494: drivers/char] E=
rror 2
> make[3]: *** Waiting for unfinished jobs....
> In file included from /tmp/next/build/include/keys/trusted-type.h:12,
>                  from /tmp/next/build/crypto/af_alg.c:26:
> /tmp/next/build/include/linux/tpm.h:285:9: error: redeclaration of enumer=
ator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
>   285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:284:9: note: previous definition of '=
TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
>   284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:286:9: error: redeclaration of enumer=
ator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
>   286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/include/linux/tpm.h:285:9: note: previous definition of '=
TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
>   285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          =3D BIT(7),
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[3]: *** [/tmp/next/build/scripts/Makefile.build:252: crypto/af_alg.o=
] Error 1
>
> Caused by commit
>
>   e2f14081c6839 ("tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM dr=
ivers")
>
> I will use the tree from yesterday instead.

Hi sorry about this, I've dropped the commit.

BR, Jarkko
