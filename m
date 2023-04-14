Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC69C6E2B11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDNUYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDNUYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:24:42 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7EA19BE;
        Fri, 14 Apr 2023 13:24:39 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id h198so26677417ybg.12;
        Fri, 14 Apr 2023 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681503879; x=1684095879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mcJm5hLKyUNL7+RYyxgpIIZn6r4c17VTxrbdJol2s3Y=;
        b=nt2sDuFdcDgz86mh7WqO565n1USL59YnmMgoURsDdbPpto3rycnpwOOBUeqSnG5Jib
         6tZ+mlupDHukSv8/1iic5MTyjpVZkDEXfq1Mbui4CHuTZ3H752NQu6NmASw6vLZ5Fnrb
         S2IvZPdboW0ELvkFVGd8RTrPHYFbsHg8b9U9T0QoW94bSBu5+6d00O+AwihxSjI6Oene
         JCTffG+aU+EwT3tIibXmkD7qJ6yluWlYPogY9dj6yMWBl/hkEV5ArWch/KcsMzzquIbZ
         TFBVpULvQ/kMt59AqeWqGRNAfWyZ465JQUguuS59l8YewGzSJrj2UFjE6RiE0iY4zriF
         9jJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681503879; x=1684095879;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mcJm5hLKyUNL7+RYyxgpIIZn6r4c17VTxrbdJol2s3Y=;
        b=B28QUJeaKOaWtGkbZ9BBVpDGk092tLY5yifnXLrc/nRzj3Wgew9w8rsrhxPnEIrnhM
         paRGtfII0pQy7XJsy9nFRmlMxx4J6Wc51WHsTyIJBi3aBnMWNjg9YesaUicXwez+gJ+H
         pxpmbunhx01SivhY5LERqK9NP2/NZUktzRzVecQZ6w2YKFp5bOPWEtUIiKg8mGwqH1A2
         01HdgZJ1zmTF7Z/HHCO4jQazl4jOUHaSg0rglsVZA5L9M13yYKCIZwwTjNvRWaXD29WF
         5LcEwf/r1T5gnrrrbZBFsd8vPPMRnOZ5efUgbsLuc7iY/G2QiBQXmn/KtH14+mUHIN6F
         tRlA==
X-Gm-Message-State: AAQBX9dfNKcwTWZUxwDvfB8XKMHv+3/xa2Wp/tJ1nOCloo0Ou4mejGEO
        gd5lKp8RUO6NZzcNUSYoPtnMYSDwyyq2LqpA1o3FhI25zY8=
X-Google-Smtp-Source: AKy350aFSvFTy99MFR/kvT4awySB5exmsZcn2Ik/7dAPL6x18HXOcqvEg5C+sj0jhGrr7tQ+kWBg37HjPnxmyz6S3ww=
X-Received: by 2002:a25:d6d4:0:b0:b8e:ec30:853e with SMTP id
 n203-20020a25d6d4000000b00b8eec30853emr3779823ybg.4.1681503878648; Fri, 14
 Apr 2023 13:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230414045747.5499-1-bruno.thomsen@gmail.com> <45602a7e-9385-296b-d704-64cdf727f5db@linaro.org>
In-Reply-To: <45602a7e-9385-296b-d704-64cdf727f5db@linaro.org>
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
Date:   Fri, 14 Apr 2023 22:24:22 +0200
Message-ID: <CAH+2xPBe8Ef2YedghsxBwxUEiS_M-eVxyC4oScs2HeTM=4M_yg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: vendor-prefixes: Add KUNBUS GmbH
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Stefano Bossi <stefano.bossi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Den fre. 14. apr. 2023 kl. 09.58 skrev Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org>:
>
> On 14/04/2023 06:57, Bruno Thomsen wrote:
> > KUNBUS GmbH created the modular DIN-rail mounted open source hardware
> > platform called Revolution Pi for automation and IIoT projects.
> > https://www.kunbus.com/
> >
> > Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> > Reviewed-by: Stefano Bossi <stefano.bossi@gmail.com>
>
> I do not see it being used in current next. We do not document all
> possible companies in the world. We document prefixes used in bindings.

I am going to use it in the board compatibility string for the Revolution Pi
DIN module device tree(s). So I send it separately to avoid spamming the
mailing list on every iteration of the board DT. But I can resend it when there
is a board patch that uses it.

/Bruno

> Best regards,
> Krzysztof
>
