Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DAB6040B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiJSKKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiJSKKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:10:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A8014D8F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:49:18 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id g10so18618152oif.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QVwK6BJas5dsH+X7/x67OgWXeXCjicgS7g7JP00oQkA=;
        b=oBQlB4bXuPtm+ovgKHzBHpuwLEhUvhUJKNVAd/IHlr+gj6M5EhTZP0rsIeUJLhZgvS
         mYWlR48q/oF1vWfrpzrEWht5Bb6BiqWKUMw9ax4y+Zebs6sRseWZnTf3XmaKdMbyuC6u
         yHE0gyupyT+b1fznilUFyLOobh5azdtM5GyyQZ+JyW7ZMn9lSYeOx8nQbFV6Z9ZQfgDQ
         Nqz35nvcW8cUYxCK3ZQ0oYFTXZDDuCGcFbiUbn6pqGuU9Ke89Q38Rdk2VbD0p6t7WYLq
         lfGO/JfKZS7xyXJY0GRN/WkAHHEsa0sMwuaBfsxyKUaYZqCW/gFyc0c5zHm7r3Jk52Nw
         absQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QVwK6BJas5dsH+X7/x67OgWXeXCjicgS7g7JP00oQkA=;
        b=qTL7hLASgi+XqpTUuyMSPwZ+cm0IhPkELsnydU1AvAwqPcREioLQ1lxROVWzMkUQEw
         Uz/HwAbL32zIJp/bxP1HLnXWLOKbmbh9Yx9iyMftZs4rIc+UBlhTD0F2u2hCPlskQO/C
         yPf1UGOasuUcfHAQy9o+kaOszQagoKiwLp0Bzyrw8qNUymD6+NF4clrHSPmaIoUBAWxX
         hIatbsPosXw/Nve1FziEs4khNctVQ3Imdfv5VnYrhsBJm9ALAywZ6HUD2Yko60MrSNVZ
         aWHuyR/yE/uvZR3PZkby25bR12+zskqH7oU/RVL/vakr//HckSTRnHnty0tfbgmsGhuN
         JyLA==
X-Gm-Message-State: ACrzQf0HZ2L2Dc6FcihPtkM3cYZ1FKcO30cXbdZvgwJYIPyfqN1+405w
        GLjLH1wxPwtB9McHxkmSkOAJ8JspgHBJZWE2fw07PiOTResF90vY
X-Google-Smtp-Source: AMsMyM5wGfrsvsy51z7TaoD0HmjWME7eFN58+AwWFc8yOpSR2jRZjVT4eufVSwqGFx87rgq9ryV8rr02cE7n7op1q7w=
X-Received: by 2002:a05:6808:1a1f:b0:354:b33b:8b0d with SMTP id
 bk31-20020a0568081a1f00b00354b33b8b0dmr17231669oib.171.1666172853643; Wed, 19
 Oct 2022 02:47:33 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:675b:0:0:0:0:0 with HTTP; Wed, 19 Oct 2022 02:47:32
 -0700 (PDT)
From:   "Dr. James Mark" <delfaveromas@gmail.com>
Date:   Wed, 19 Oct 2022 17:47:32 +0800
Message-ID: <CAKDVxK-Ety0bbjXN=gaqrwYU_ymec78_4JL1SnGH3deSjF=qTg@mail.gmail.com>
Subject: 2 000 000 $
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.8 required=5.0 tests=BAYES_95,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2 000 000 $ vous ont =C3=A9t=C3=A9 donn=C3=A9s par le Dr James Mark qui a r=
emport=C3=A9 le
jackpot Power-ball. Contactez-moi par e-mail pour plus de d=C3=A9tails.
