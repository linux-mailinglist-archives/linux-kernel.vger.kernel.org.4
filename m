Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07822746FD4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 13:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGDLZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 07:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjGDLZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 07:25:12 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE33E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 04:25:11 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc54caad5so50057755e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jul 2023 04:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688469910; x=1691061910;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=pER8jA954EMpk73ROPTYCsMq2eJ1mGC5ObMF19MuHCb1K1qcSXN3Xbm+7yuyOu6E37
         3Ihq1wyq5Xa7hz2z6R1XOf3YpLqkA8K/YvU3oXIC0vblb90HI9CZLXvba7STvgNqLzq0
         qd9POnJBLs7Vrx/8BXC73Q9glYUX7Cg/aa+iwbow+XEhlNiH3Qi9ICajKFH0aG3O23IK
         sfhI0CIvUsai+wxePlnTy6sBSKLnXZQkFslPL6SPeoYg/wCRHkaczz1/ogKDSv3AEPcI
         vy7a+LCJeaje/PU4WEPADNad4UQ+ZUJRSldNYLwwbItJIlLdIfF1IxXRPD+VTJcBn9oG
         RQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688469910; x=1691061910;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=QMaj0dd3xKcjt+Z5PIe8vpsyp4arOhqgeNMWBx9FXqrk3w2EM+WAmaljj1zU5OXkto
         tz6StnImCb60nkX2JG/oND3kit55RD/UTuXFdUeiDhKDeCAmq8SZ9dTsMsG0q3TWe8YJ
         nOlRxR48ZrINA+MB6bgftaq/YhO70itIngDGtQDbAAdKCUYhtoj1IbYT89hOZ8X1N4gl
         ufgr2f52z+VX/bxfnDcwetO+uhCr/Pe0oN2JJAEiqZaDijJipbN/knPe2Odnnt1Xta1+
         jKk3q+reHtUf12uCVznYJKgOLWf5UaDexjvvR1/cnRxbKBogYvyDJcdkMBZ8Xv6nwb2n
         VlCA==
X-Gm-Message-State: ABy/qLYeYw28sUP8xLBng1ZYJfEoQVMzfjimM8J2y4YlaDKfZvkJqO+V
        dOljjAnJopH9/41oTG/aPjI/XoNUgB91Nn4Z0M4=
X-Google-Smtp-Source: APBJJlFphZfohEFzn9R63Jm8RtjCzeyAr6Znz8Lq3c1prEl1rW+II9DADb1yespXSKJqesJ2EqYZbOPw91jrbnEdSN0=
X-Received: by 2002:adf:fd43:0:b0:311:1aee:4e1d with SMTP id
 h3-20020adffd43000000b003111aee4e1dmr9448163wrs.33.1688469910075; Tue, 04 Jul
 2023 04:25:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:420d:0:b0:314:104e:50d with HTTP; Tue, 4 Jul 2023
 04:25:09 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <hammangoni5@gmail.com>
Date:   Tue, 4 Jul 2023 04:25:09 -0700
Message-ID: <CAFMkhkHumBi=7+Ad4DCKbqNWgQs_UWi+ygsSMZ+0uYrTJUd5FA@mail.gmail.com>
Subject: =?UTF-8?Q?Ol=C3=A1=2C_ainda_estou_esperando_sua_resposta=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:32e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4971]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hammangoni5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hammangoni5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


