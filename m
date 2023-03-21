Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905E46C2AFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCUHEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjCUHEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:04:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0741DD32D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:04:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t11so17901595lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679382247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7tbyVoCIUkuwnDzcG32W4OdMDrXEIavgnsGn9li74v8=;
        b=yChraET9/arxywpaBm0uIpGnJjZC7VyiDllMVup03dJnlPiufNi9e3Nzj2lf+ZHniA
         sfwe1q/uW22fPn+PDlUaZSzwboQs/dLxeD6coJsXjg1Vc6agsTpqORr3LtFwF6JzIPwS
         bqM9PvVbLgTH5uQBOty43tuqXiJXsgs4tN907D7qyHAw+cT2oOYwX7soOdk+dRUe1u5H
         5rA5sBjs4q/+BUOf9PhruG/zel79U8rHZVf54CyRIyAXuyRBJoDYrXZAHiEZ7OZBa87E
         Odw6OVcnAPoed2CfhtSRhJgjoCweO0W2ieWzkyFD8CzN+/R9DNN9s9h4WXnPc4u+Ydme
         JK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tbyVoCIUkuwnDzcG32W4OdMDrXEIavgnsGn9li74v8=;
        b=npAjJQNiT6+/75dllVZ99nZ6J1WTnSXXLfJDVjkEiBBw6c13YN6WUpdGqdUuOFjaTu
         KmTjKqoaGoA9FdYTUXHOa4490TZb87fcfnTw0CcvNwN85voVGgdFJ/sNFEcHs7I54sZE
         h82bC7PCtLizoH7gaGXzHBp9gXTVojFUKXK8QkfropCFB0PLjRBqmhpSEw+b84bjy2dV
         lBtW6MY1W6YiJTHA4s4Yvv5d1gIMgD3LaKNrztGJvQ9+R1GCf8uAefWQYxjlNo+YQHpe
         /WRccfRYZ1raehKF34zi+tRfdTGugtuR+NRgKbgDJSqKZB9yDX1pk5nTJXvqDdfdESWF
         n8pQ==
X-Gm-Message-State: AO0yUKWjET2/PlfeEXuY/4o2WPgm6UkJ/VnZsPToPs8grIGp/zx01Tk7
        rHk73U1G9FdQvSsfekrJdYgkMh7NVs+Fi1KO2+k0Vg==
X-Google-Smtp-Source: AK7set9T3I8GA2uJOUQygr+w4BX+oII8CcfEQqUcpktFtsWlC8MeRy03+La5618HVmKpwn5tRsvyiGGX13XsEv0bYdA=
X-Received: by 2002:ac2:41c6:0:b0:4d5:ca43:704a with SMTP id
 d6-20020ac241c6000000b004d5ca43704amr476391lfi.13.1679382247216; Tue, 21 Mar
 2023 00:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230319133732.1702841-1-trix@redhat.com>
In-Reply-To: <20230319133732.1702841-1-trix@redhat.com>
From:   Jun Nie <jun.nie@linaro.org>
Date:   Tue, 21 Mar 2023 15:05:07 +0800
Message-ID: <CABymUCMha=XE_=LDNXiJDzhNCpGU4bckuNkoCAmb_bWO8bPu0w@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tipd: remove unused tps6598x_write16,32 functions
To:     Tom Rix <trix@redhat.com>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        nathan@kernel.org, ndesaulniers@google.com, sven@svenpeter.dev,
        agx@sigxcpu.org, Jonathan.Cameron@huawei.com,
        u.kleine-koenig@pengutronix.de, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rix <trix@redhat.com> =E4=BA=8E2023=E5=B9=B43=E6=9C=8819=E6=97=A5=E5=91=
=A8=E6=97=A5 21:37=E5=86=99=E9=81=93=EF=BC=9A
>
> clang with W=3D1 reports
> drivers/usb/typec/tipd/core.c:180:19: error: unused function
>   'tps6598x_write16' [-Werror,-Wunused-function]
> static inline int tps6598x_write16(struct tps6598x *tps, u8 reg, u16 val)
>                   ^
> drivers/usb/typec/tipd/core.c:185:19: error: unused function
>   'tps6598x_write32' [-Werror,-Wunused-function]
> static inline int tps6598x_write32(struct tps6598x *tps, u8 reg, u32 val)
>                   ^
> These static functions are not used, so remove them.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/typec/tipd/core.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
Reviewed-by: Jun Nie <jun.nie@linaro.org>
