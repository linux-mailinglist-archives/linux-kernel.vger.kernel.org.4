Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD65647DC9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 07:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiLIGaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 01:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbiLIGaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 01:30:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48FF801E3
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 22:30:08 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id q71so2906381pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 22:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LABSkMOQ9Yzza8nLQXMCxfx7LIyDdgQRy2QZxg82Dn8=;
        b=H7cRSPRK0zeJxFVPqsdnG7aLDWzfTATQJa1gW2uacoDLzSOgNVoLLCiJjN1vc9C2fb
         XCVW3I5HghY9yyKMX3SdiS9sDDpeS477TPe2TzIt4YXXRpLdt46cVpGfRVWpTR07Ns9X
         xxoSWhg5ZZfyXwmlP0Ml07qUEfMElDfSDg3O+qY4Rh1WZ1h+Ss6J9hchDXXBQb/9Qb+z
         CuX2VbWFvvBqCj5H2Q7vrsfuDlGl0L05rLB6bs3eVNYwKo/0vNCoTgWnsedE8pZEx4O7
         pHWfE+ZYTZIvtc0OqjAk8uCaKC+ehhe3zKQK+bQwKRKuw+M2tZy23Vxeamn2SToTg0mk
         /Msw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LABSkMOQ9Yzza8nLQXMCxfx7LIyDdgQRy2QZxg82Dn8=;
        b=UcQPgHwKsUzviKJ8ugBJ4o5ReHvboOzm3CPXRdegZ9wCfOrFqY++dguv5MESyQ7ud6
         7AwNWG6+TQy/7XduOddbn7JPifjJQchCG0hP7osl2tCyzUdP1KifwhyDd7BBfzOWxV1a
         RmYUJLeUCnwd7sWPPc9d1/ymO9Q8wvRx+66nPm0knpMELeUmqw5wgAIj5iHUv4UHsR5C
         2HnDgABWM8clu+lPBgh4FoWfwa1TjVU7ZXUKrsZa85MzRjusn2r2YJvlkl0wMV3ZKpjk
         5Smv7Qf8HhaQUB9/wg/H/5oMrtFnR6AReZY4A/rxvuw1al7prdLIv/ycjDpgVlHecdy1
         tlwg==
X-Gm-Message-State: ANoB5pnZkd5deLptl+gOUXNd+AK0qLyJaFutgWBiPTvQhklB4WFeg8Eg
        W0+yDjsObOZI20YyFQSWucx+SG6h3/+8oX/dA4M=
X-Google-Smtp-Source: AA0mqf5Tav9EbIIjwmTnDzj+l5JlnFYwUex0QzjS1ZY1ytM2BinmQRt9PTKpjkiRHrYMruCALph2BSsPf/qaYEBKXOg=
X-Received: by 2002:a63:b517:0:b0:478:61a3:7639 with SMTP id
 y23-20020a63b517000000b0047861a37639mr32425011pge.100.1670567408230; Thu, 08
 Dec 2022 22:30:08 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7300:269e:b0:89:20a3:d30a with HTTP; Thu, 8 Dec 2022
 22:30:07 -0800 (PST)
Reply-To: alex.tomnn@gmail.com
From:   Alex Thomann <pilotaziz63@gmail.com>
Date:   Fri, 9 Dec 2022 07:30:07 +0100
Message-ID: <CAGZZ8xRVLdsb-RM7_wR70PpLPMPv5r-uf=-sJZ8TvQLiBHXCtg@mail.gmail.com>
Subject: Atentie Beneficiar
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C8=9Ai-ai primit fondul?
R=C4=83spunsul dumneavoastr=C4=83 va fi tratat =C3=AEn consecin=C8=9B=C4=83=
, Cu stima.
Alex Thomann
