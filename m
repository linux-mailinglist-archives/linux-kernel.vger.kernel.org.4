Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1995BFE2B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbiIUMpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIUMpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:45:39 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FDD76452;
        Wed, 21 Sep 2022 05:45:38 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id e187so7861357ybh.10;
        Wed, 21 Sep 2022 05:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=lHyH82oi+18zzc2H4/taL6dXOs/EV5Ovi5bLXN+o4/Q=;
        b=LpYnckvxq0oLd9YsMAlElTx3BLyKjDHd+zupUUSEyh9s6KQwYvEdIT/2ITntgipZrn
         m8f6xRsu0w/vgpO9yltMKFo8K/W0MhiTgB9vjYHygg6Gxjhj+4FkYRO5rZ9MHZFGucEe
         Jgjl8Qi/X17ZsQms3QCPdol8kick7aiMdEFmJ193/FixBQz2nMrdiZUhxMDv9tL9G8zr
         1hrJQwwp4wL7Dz9gs1nEHhDjoP8MD8u2MUZtRI55yiYnu0EA7734uUuRUk2GvZQc004N
         HjiaWXLec3A7MzuXMUV0O6+oPMMnwaNXAXllMwdYxXsymlIlG9kDR8eZ4R2rwGeSdZ+3
         xdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=lHyH82oi+18zzc2H4/taL6dXOs/EV5Ovi5bLXN+o4/Q=;
        b=hrYoGG2Voiw5NyLYMuattm5vc686tkrufgnB+tHEIYug7B32uzVNsB1weWIKaJjDi8
         OvoAr9YoHKdj8qA//bGMGYaypV8Fz2IdNEONFuv6oYLuAiO7GUb2+ZacQLInbyrugZDt
         xgkwntz11iANd7fteX40iXS8O6oa9gPi2FQotasf079BESqV/hOTRkj19/ilwaew8oZF
         wa+F+bd8z2BaNPNc4AEB6K69qHI+cznJK8u1ojhkKR0fxx2yR9JJvZkH/TMHB1dQpBOD
         I4vZfrGF8nnj2V1/w6gmIAjd5zne7ykK+aQ+7N8hHRl+b6TI+UhjCEBkda9wo3qPDzIS
         vQsw==
X-Gm-Message-State: ACrzQf3qtkBgEN0Yn7syoHnowaDnnmKjYyCPRxVzCKfxDMTmHdzqdCHq
        EMPy8Kjwk6Hc2Sp+MyJeviPiun8S9pDfyKuDKQk=
X-Google-Smtp-Source: AMsMyM6wGCGRelUKH+KjWmpnZ92JZdEoUZ48fCF76U/kGdrGVxBjBaduDd7HhofRiTPJKFVtpwgw39ODU4VZU2zZ5jM=
X-Received: by 2002:a5b:845:0:b0:683:6ed7:b3b6 with SMTP id
 v5-20020a5b0845000000b006836ed7b3b6mr23955691ybq.183.1663764337379; Wed, 21
 Sep 2022 05:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220921121723.6726-1-farbere@amazon.com>
In-Reply-To: <20220921121723.6726-1-farbere@amazon.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed, 21 Sep 2022 13:45:01 +0100
Message-ID: <CADVatmOZ5bw8_+7bJUhOv0Fe7E7=7_UG4OxGO76RQWd2o4o2MQ@mail.gmail.com>
Subject: Re: [PATCH] hwmon: (mr75203) fix undefined reference to `__divdi3'
To:     Eliav Farber <farbere@amazon.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        andriy.shevchenko@intel.com, hhhawa@amazon.com, jonnyc@amazon.com,
        kernel test robot <lkp@intel.com>
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

On Wed, Sep 21, 2022 at 1:17 PM Eliav Farber <farbere@amazon.com> wrote:
>
> Fix build error on 32-bit machines.
>
> Fixes: 381a86c545f1 ("hwmon: (mr75203) modify the temperature equation according to series 5 datasheet")
> Signed-off-by: Eliav Farber <farbere@amazon.com>
> Reported-by: kernel test robot <lkp@intel.com>

Fixed the build of next-20220921 for me.

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>


-- 
Regards
Sudip
