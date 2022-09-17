Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29785BB974
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiIQQhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 12:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiIQQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 12:37:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3565530555
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:37:05 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 130so36821189ybw.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=gmLtpZyDhCoapA9r0Gn9w+9NMSiTApaWi0GAjYNSPZM=;
        b=AVVjKcldcnE6A0KV1YXdSrZDsKCeBFvcQUIR2tHGnkC12D/DHC0D9ke2earZT54GsL
         4uIUKmI6igFFCn5E6T5rDVLpP0CRs1AtjMsrRG9Scsn5IS5cbqSJw6hoEWDETWn+HFWb
         pMQPn8tj48IxGmqdwE9z/XpW4qBOdLupSlg4Zbzns48no6Mz2Io5h5VtqLjcP2sVEezW
         oqaNN/AMP8SpnJQqJwahswi70UiRYFFrtGHaHkNNOz0JrGeOck4NHbz/fKwpn4IESj8b
         wU2Ffhnm16ObzGnioWP9bXrRClwEc9GnOK+hVf9EKwX7Hm5dKoIZkZai0jDTswLWfgFR
         E+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gmLtpZyDhCoapA9r0Gn9w+9NMSiTApaWi0GAjYNSPZM=;
        b=dUimU4ss0fyPO0dAXgSAne3SNXR7nhPMMlIb7vgv6hXqtEOxO3sS8dw1Ao4ONscJhp
         +OiY/APrA/KCZE9byVK3LmTm86imsz5ujvIMmAUaiy73+K/5+KHEQh3aSAy8nP5+WHPC
         K8VGHUXNjuuETdKJI1qX35UPgTKIcdVeGgq2xjeER33JWqvfji/i3X9fCtABHTZ55a2T
         7nPCQkxuv0srXIn5cQUiXFGbBoSP3MLGeXY0+Xwfmpkki8bd2P3PGp1xJLB8wXUJkt0G
         Eece69q06O/UXa05DemQjRNakHj1+CniZomRLgRyzL76Zwj2RYIla2fatJp4I1QMwENN
         DnRA==
X-Gm-Message-State: ACrzQf18Ct4rKt++lpvtREaCsoOdoCK2m+dfsx4IB9Vh+7+Cke1k3eVs
        0AtNnNd54MomQ+lNwnppNmLOfSDBPeisAUTqfhs=
X-Google-Smtp-Source: AMsMyM7Tsfegpv6gDv5PqV+iRsNcDABCidGwg8Dy9b6EyOLJdwdFKYD3Vw1Q4OIVYDSVuiJsOFElKgQoYfE1r8Bje8o=
X-Received: by 2002:a25:4286:0:b0:6ae:6f2b:a8d4 with SMTP id
 p128-20020a254286000000b006ae6f2ba8d4mr8889602yba.530.1663432624398; Sat, 17
 Sep 2022 09:37:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:65c4:0:0:0:0:0 with HTTP; Sat, 17 Sep 2022 09:37:04
 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <amoussouakele@gmail.com>
Date:   Sat, 17 Sep 2022 16:37:04 +0000
Message-ID: <CADaibaV4zaaFbim-nePFkk2u-+ccwMgOcekG8y1MhmW2FwniTg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4957]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b36 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [amoussouakele[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sgtkaylla202[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Bok draga, molim te jesi li primila moju prethodnu poruku hvala
