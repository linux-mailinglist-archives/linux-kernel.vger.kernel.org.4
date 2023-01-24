Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD9E6794A1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 10:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjAXJ7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 04:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjAXJ7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 04:59:41 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BDE37F38
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:59:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id ss4so37420813ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=iMKrlJXviCszF1VUVBmsm5CK5p2awv0Sf6HtG8lU5iguq/WnKGd62Zd4HnOMBMmARB
         XdIdKTBocmUtFiVQHd3hgLfrKw0aa6sdbZkqF+2IeWQJ0+khuWabmRupyNR+npGw3JZr
         rI6Sm7oSCI1pAhBFfN0/hPZAHIkr5+Pnv7dpbevCtd/+KpRa4+vfo2VThrYefjPXsu4p
         SMQajrTi8f4w1GU0MRptL3BBcxJEV+btiP/giMVAWCz59Qb7tIwlMGkcf9KIfe/LjQ9Q
         tim8dstZmbHDHeVNu6ey4zkxcbTNPTPU60Wbq/bdD/RPOYo6qDgh07e3U6rYz0OcX0wY
         W1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56U3L/n2SWLavdhRRg0Yc0+2596Qz1l4ZkRdkLejoUU=;
        b=M7gn+zlDd8CgPgQkdY9tyweWZNGslUSjcHb+gvIP/q83YfZXQ/6toZwZ1BuUzwbMzH
         1PvOx4BN4FAntUG/1tZ3NfzOc1hLLre3ugz2dvMh/e6rIsBvbZesAssIIu2VVs7uNhq4
         n7SFl3pf5r99HbzKrweZeUNT/2rFUj8rsa0QS5gEurrvNKgylAqtAX8kHY5BTyldwq/R
         bpAoB8jtjRy5UxPXnyEIdTLJKqlKvtrp2ou3S9yys/D8SPuCcau5YQT4t6rqzU4QpodL
         2zQ+xVPmh0J2BWxgnWlYpPPRucYRdRRTicfFUMYFGHV7Qz8lpzWSKt8HAyTb7Z5IZKbN
         7hRA==
X-Gm-Message-State: AFqh2kqA5bacb5lgRd7a1YCEp4mNKT7+B1wKjmryuxSdyMCoF8FNpHgo
        UjstX9h1lsoFjJDSZfN8lJKHRR1RvhKaNDgot3I=
X-Google-Smtp-Source: AMrXdXtr51xBDP65a3YZBDg57D1YnCciIZwt659ImSwOsveHjZ0XkhQrQxmQOh87Cd6zVzATGjIVNFpdXzMt7o2wCrk=
X-Received: by 2002:a17:906:190f:b0:7c1:4f19:9b2 with SMTP id
 a15-20020a170906190f00b007c14f1909b2mr4163357eje.289.1674554378761; Tue, 24
 Jan 2023 01:59:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:35d2:0:b0:1f1:ff3c:cbfb with HTTP; Tue, 24 Jan 2023
 01:59:38 -0800 (PST)
Reply-To: westernuniont27@gmail.com
From:   Western Union Togo <stanlife198@gmail.com>
Date:   Tue, 24 Jan 2023 09:59:38 +0000
Message-ID: <CAA53Gp2e9EXOTj0Wpp6gePsqDRCg53n1PfBa0t2w0V-bSy7__w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Your overdue fund payment has been approved for payment via Western Union
Money Transfer. Get back to us now for your payment. Note, your Transaction
Code is: TG104110KY.
