Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A99D5BFE9D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 15:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiIUNDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiIUNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 09:03:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFF68E4F3;
        Wed, 21 Sep 2022 06:03:43 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3450990b0aeso62795917b3.12;
        Wed, 21 Sep 2022 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=UVpgbc6z6u7aULVGmamBgP30vjvIPcGwjxGcmyBqZIE=;
        b=EufqYzy0j6caFNfzmW71qoXuO+ZPf4hqFc7ugrIBCxX+Ea0mR0sv2AZAgQ6sNzJOYV
         bO0LeDoUL8u6pUC7J8ef7tbABcOnF8IPiAI7/V8t+WfoshvU2ASKnhBN0dECwb4rwNqP
         r3s58sDMQQl5jy4xG5ch+J5EDYuc+4Nn53bCfkh7J/yQtQHbZ1VHGuP5KD6cHpaMZXQq
         lOPvX7rZcToheosrP9Lo6kK6BoxUbUsMMmU7X8HLBRkXbE5bzKCoFSmzmmObhsSAXZy4
         Kl2vLP5izcXfnb4fGFVkxqFTjiEGclQ9OkAbxl27E2ERmHS9AimLcYRZZKHA7y+dU5Q9
         ngNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UVpgbc6z6u7aULVGmamBgP30vjvIPcGwjxGcmyBqZIE=;
        b=L9DeWzqOEkX6BX+7UOhZ2rPHLmB9AD326JXdgWAkB7dSlKGCZ6LKrCLMYhyyemvFwN
         Ja+o4HL4xesPnabvyqY/XxeALDraSIKIGyVHW9xnZ0jozTp5FWkpsOuiKrfpSdrGKNFk
         H6Cw/i5Y1Nm5loJ+CXqQi8GJva920/R2PsOpC4wd6RwOD/Wcer+31I+fQ/dIxWoUUzsB
         0cNmx1Y+h7M5vkRYL3b+NXsgADjnafImzSlcKkblALSh2dQB15E68wijgTkWM7z23VZv
         vgBskOp7qvAKIBe6hxAEwrRjIQeIHS5BL9+4lPo7aW4KpRdfY3HOwZhYqWrGBPBXx1vz
         Yadw==
X-Gm-Message-State: ACrzQf3sUd/kPamK8VQRHoID73MRATnpDrPws8Cap3FUYt1+jkKS0LJG
        MEjRaQ7MX1N6IWmdP+FjpgM7lCCYGSRyplq/2c8O4y5QX/w=
X-Google-Smtp-Source: AMsMyM7eToEExArj+xTESfDo7+jS4ZhKkeSGDV0gJgqdJpwjVMiiJfILhsT6atCukBTwnMk/WARrYk7HR4hrI3ij5fI=
X-Received: by 2002:a81:1e97:0:b0:345:5eaa:ff99 with SMTP id
 e145-20020a811e97000000b003455eaaff99mr24756536ywe.194.1663765423042; Wed, 21
 Sep 2022 06:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220921121844.8059-1-farbere@amazon.com> <20220921121844.8059-3-farbere@amazon.com>
In-Reply-To: <20220921121844.8059-3-farbere@amazon.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 21 Sep 2022 14:03:07 +0100
Message-ID: <CADVatmMKKXbQ43KLqGt5EbsfBP3qiH8qdmWCQz+_UoabBq6dTg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] hwmon: (mr75203) add support for series 6
 temperature equation
To:     Eliav Farber <farbere@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        andriy.shevchenko@intel.com, hhhawa@amazon.com, jonnyc@amazon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 1:19 PM Eliav Farber <farbere@amazon.com> wrote:
>
> The current equation used in code is aligned to series 5:
> T =3D G + H * (n / cal5 - 0.5) + J * F
> Where:
> G =3D 60, H =3D 200, cal5 =3D 4094, J =3D -0.1, F =3D frequency clock in =
MHz
>
> Series 6 has a slightly different equation:
> T =3D G + H * (n / cal5 - 0.5)
> and a different set of coefficients:
> G =3D 57.4, H =3D 249.4, cal5 =3D 4096
>
> This change supports equation and coefficients for both series.
> (for series 6, J is set to 0).
>
> The series is determined according to =E2=80=9Cmoortec,ts-series=E2=80=9D=
 property in
> the device tree.
> If absent, series 5 is assumed to be the default.
>
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reported-by: kernel test robot <lkp@intel.com>

Only build tested on top of next-20220921 after reverting v5 patches.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--=20
Regards
Sudip
