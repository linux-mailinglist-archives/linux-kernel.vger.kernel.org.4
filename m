Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C90D74CCA5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 08:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjGJGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjGJGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 02:08:36 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC71EFB;
        Sun,  9 Jul 2023 23:08:35 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6240678e87.2;
        Sun, 09 Jul 2023 23:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688969314; x=1691561314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXia2U3SWywM/hgPSo6QNGfwgRNgV0ikhWDqRGHWyow=;
        b=HKCxpGZnD2pgMSzpbNh8IquC6IK/Cs60+egpUYi+JkMiQE9ZL8uUawtO1FhUHTMCTM
         kh/aR1gWDTUL77+cCgzKpna3F8uDKnXrALx7Gixrv8jOxSHZM5fnFTkjKUSWhgSuV7WG
         CSbct344kxPAt2xJQdMUeiSgfmKGF4Y4htpY09KOD3bOBLnkZuQE+wPweeb4YpwgCd+k
         w1SvQxA9hSXmf++bwvxDlIhJ2wg3Gx87uVLVT0TwSBytOZWc2NNyMQ2/HUChfWKmWaMI
         w1VSv8JEfoPf4Hc8XCaJ4c/XVG6xG8pb9iijIUFuFteBnhN9vKjRNiv0E7EtrOCViET5
         nZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688969314; x=1691561314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from:sender
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXia2U3SWywM/hgPSo6QNGfwgRNgV0ikhWDqRGHWyow=;
        b=YXpa5mub5uUIWHyXTZxgeEEaRe5Oa4apmTU16HR1oj0C3fA6iRG31LbmMP5VyrLxS6
         8hGeJYvSQ5LWx8YgGggsNB/kn7XoE1YZ6Ikd2T0qXgYbHyF17zuKOXUt6jaieNzI/B1L
         9p+xtyslICroCIgglsX6hp/h6+Jp4qE9hdcTw8UBsPX3xZFP2W7Xy0L1iyfhiGbIK2gW
         ID/Co7wIR4FNq1O5Z2ogc4cnK7/wqm0teJxYWJTh3fuqmzS08n7RzM0RSn1+eexatimZ
         Irr5GyVCqatbBStZzNJ8VjOUKxRZwSjlx+4XenC5PPwxRvgnAx3UatILAgEnTjv39c99
         QYvw==
X-Gm-Message-State: ABy/qLamoGsNx6rBWdxhmiicxUq25fXdWKUeS2KPslzoDW/dCCndCPqg
        HwIpdJVlvBs5yebS2QZDJDZlbK/ISqN05bPwPys=
X-Google-Smtp-Source: APBJJlE8XIYfjCdCDXPrHG6nw7Sgw5sSnfiFWvlGRkezdt73Fjqia4/P0t1EsaNJnFEs91knAXPndHjlDk95M+E/dNc=
X-Received: by 2002:a05:6512:3d8e:b0:4f8:7568:e948 with SMTP id
 k14-20020a0565123d8e00b004f87568e948mr10523457lfv.51.1688969313700; Sun, 09
 Jul 2023 23:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_54C2A2746A83BA29EE92248CE9683F0C6509@qq.com> <f7fab4fc-a8db-d2f7-52e9-3522f7c298b8@web.de>
In-Reply-To: <f7fab4fc-a8db-d2f7-52e9-3522f7c298b8@web.de>
Sender: cl1ntlov3@gmail.com
X-Google-Sender-Delegation: cl1ntlov3@gmail.com
From:   linke li <lilinke99@gmail.com>
Date:   Mon, 10 Jul 2023 14:08:22 +0800
X-Google-Sender-Auth: Y3flxkSIwAbIAD5U_PVxyV6si1E
Message-ID: <CAKdjhyAtxk21YR-wxZn5Ga_+3HuHfxuJX7_czLBw8tuJFmXgsg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix undefined behavior in PAGE_MASK calculation
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mips@vger.kernel.org, kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linke Li <lilinke99@foxmail.com>,
        =?UTF-8?Q?Thomas_Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> How do you think about a wording variant like the following?

What you said is exactly what I want to express.

> Would you like to add the tag =E2=80=9CFixes=E2=80=9D?

I agree with that.

Thank you for your feedback and suggestion.
