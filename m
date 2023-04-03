Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686D86D425E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232409AbjDCKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjDCKlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:41:23 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6C212BC1;
        Mon,  3 Apr 2023 03:40:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 185so6004249pgc.10;
        Mon, 03 Apr 2023 03:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680518459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFuL6ChpVUUgBPgyIo4zUUMh6LlZPDJPlmBW1Q5qZg8=;
        b=ddMKekAjo8HdAcsOLoioX/xPvxdrkFFaA0B/cyLzxbLFI8Ln0goCY8ygu65HhlUsB1
         ikjJVip5ACJzg1hqxGMkAU79CDtu6uNxFUGwCW9t2MFWBjL28chDTjBMnyO10xZN3Htv
         i1pa0Euntl5mXtZiTBfPpS4MCQf83EDcDWNILPcC9R/baVe7S3zyJEicYsOGqAjEEVnT
         rgXZkcuvEWsJMFA3797m7ITbF8XPjs7lK/rVFnkVVIf+0zE+w3GIR5JviqkxlAlgaDeN
         fRei51a+S/c0lArUA/F7hsZ6Lh7aovQBggoEMhYqdh4N+w474XbXYbwwlIbZVSxEkd8q
         9Khw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680518459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AFuL6ChpVUUgBPgyIo4zUUMh6LlZPDJPlmBW1Q5qZg8=;
        b=XRLQmjjYPUbPKvnVAU51EEXGivmuFC5ryyELMQaWOJAy1dUHuVmTZR+Yf4QvsWoTKx
         3sz6hV0I54mjMPxqfmyutOdfVgB1VM5NO8yHHhnYiTRxxQtQONbvNlM+sB0M5oJwjH2b
         68eGuNx8hyAwk6HbxDu4jiLG4V1UIf4i9Uud+X7BYLwm615pgMQkWUyqe9NYSqG8tAmU
         ToBQMh9pRPudhJS30fm9sUufTISN9JW1INKwwy+WBt5kcGLzOu/OAzN6lmxggY2T2azX
         kD8Y0zRyxaMeBLd4Y/66NLCAKgG21G/Z3hD3bZaPq8BJC//lqHDgDHs0Z/xVONrpyubX
         ABIg==
X-Gm-Message-State: AAQBX9ePKhL63S5X87C1RGdpdfKGOEbdeLAj6rAtfmqHvzwYhyB0j8iE
        KF0+bdy0qQa4gKcKZfrO3RVNRWKw2ye3lG9Yq+M=
X-Google-Smtp-Source: AKy350ZgcbNdLWCD2SElCx52IwknONkFSjpKh+B1fGuP38l/SArhy1jlY2KFg4e89kIFLn72ByaxCAoDab+K4//dXV8=
X-Received: by 2002:a05:6a00:99f:b0:62b:113b:72d7 with SMTP id
 u31-20020a056a00099f00b0062b113b72d7mr16244491pfg.3.1680518458919; Mon, 03
 Apr 2023 03:40:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230331163058.5688-1-sebastian.reichel@collabora.com>
 <CAEwRq=q=W57W33nYe_uUDQb0cf7QkFoa0rO+EWdsuUGTN7k_Vg@mail.gmail.com> <22215580.EfDdHjke4D@diego>
In-Reply-To: <22215580.EfDdHjke4D@diego>
From:   Vincent Legoll <vincent.legoll@gmail.com>
Date:   Mon, 3 Apr 2023 12:38:12 +0200
Message-ID: <CAEwRq=rmd=m1YybLYU9zTLGjwkvQze9fkX3WQhF+2RWWWfAKig@mail.gmail.com>
Subject: Re: [PATCHv1 0/2] Improve RK3588 clocks and power domains support
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        linux-rockchip@lists.infradead.org,
        Peter Geis <pgwipeout@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Finley Xiao <finley.xiao@rock-chips.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 3, 2023 at 12:23=E2=80=AFPM Heiko St=C3=BCbner <heiko@sntech.de=
> wrote:
> If you want to check more, try
> # mkdir /debug
> # mount none /debug -t debugfs
> [or do this to a location of your choice, I guess the standard is under /=
proc]
>
> # cat /debug/pm_genpd/pm_genpd_summary
>
> and check the runtime_status field.

Here it is:

domain                          status          children
            performance
    /device                                             runtime status
---------------------------------------------------------------------------=
-------------------
sdmmc                           off-0
            0
    /devices/platform/fe2c0000.mmc                      suspended
            0
audio                           off-0
            0
sdio                            off-0
            0
pcie                            off-0
            0
gmac                            on
            0
    /devices/platform/fe1b0000.ethernet                 active
            0
usb                             off-0
            0
rga31                           off-0
            0
fec                             off-0
            0
isp1                            off-0
            0
vi                              off-0
            0
                                                isp1, fec
vo1                             off-0
            0
vo0                             off-0
            0
vop                             off-0
            0
                                                vo0
rga30                           off-0
            0
av1                             off-0
            0
vdpu                            off-0
            0
                                                av1, rkvdec0, rkvdec1, rga3=
0
venc1                           off-0
            0
venc0                           off-0
            0
                                                venc1
rkvdec1                         off-0
            0
rkvdec0                         off-0
            0
vcodec                          off-0
            0
                                                rkvdec0, rkvdec1, venc0
gpu                             off-0
            0
npu2                            off-0
            0
npu1                            off-0
            0
nputop                          off-0
            0
                                                npu1, npu2
npu                             off-0
            0
                                                nputop

Don't know how to interpret this though...

> Also you could provide a email-reply with a
>
> Tested-by: Your Name <your-email>

You can add my:

Tested-by: Vincent Legoll <vincent.legoll@gmail.com>

Regards

--=20
Vincent Legoll
