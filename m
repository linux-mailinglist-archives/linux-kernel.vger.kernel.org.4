Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4B661128
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232717AbjAGStF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjAGSsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:48:43 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A0813D3A
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 10:48:42 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y1so5173180plb.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 10:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeoiu/rvKJmM+gclUENAQts555FtGpZl2d/oUTAo0Hs=;
        b=ie2/DsvWQRCi4k2Sl9EAdvDuj/UKX0HllRNgMQ13fhmOkzY7M/GyAVOrtnER4qyUeN
         nci4ylw18O5XZFpqEVqJHJ1vgbWmJD45qEXshVXxJsl5U2frZRbbUHVoqVD2d6Zxv21H
         VSffmKynQ6L5VVSx24/Y66OgwrSJNptGRhgwkH2uBNnFgrtE6qVhs/qxT8dvQe1yMYQw
         QcejIisG6UEiRwnD++0HZ2Z1c+eFD84CWUpyTiapVSOmOMVyvBdW1ThFhHVUcigFwQMC
         SASI97sqaLeTr3mSC0+qElgoM3HUf6zZBjjQY+kNgOOGEUVDPW0zrnXqbXMiQHQTWYRG
         O8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeoiu/rvKJmM+gclUENAQts555FtGpZl2d/oUTAo0Hs=;
        b=lk+JU08c5VIoULWZJvBcbEOli6hQoSFS+mX+8tQ/6LxeHoMn1nG9R/5pX5Dw2kV3Tz
         C/9Kz9oZZEqOyrwpQ2s+ezcICjEFFuYh+f3ndmurX5/oOwWPmij0/20e7mJ3tPFN7Pz3
         /U3tbejebxOlT4Px/N93+/TncCdspJnP7MHmQ4w1S5L78oCTy1pJhRi3vOyHOFFGblOZ
         hx9MXnVmAqXcEaB07pNua2VxgeOy0A1HtHDcoP9CPE2toywQvPvzHACyCaDmjumzIlMd
         Mx1ija6KH3lu4h4gQp5kI9lUVvnNYip10NPUtxv4tYJxtuhV58RI0q+twzGPNX5i14kl
         QEew==
X-Gm-Message-State: AFqh2krWckrIZw9d7VWzdkqf5fbr3/unVUVQVCSxoiYsjZr8M5bwE7Kx
        OMQJlCcelaW+ryTTXbNfkrLbJw0bQiCPGiJp9DQ=
X-Google-Smtp-Source: AMrXdXv03qQz0/oPBvG2Gx5GWwPz/NDDOAbdd4nWrhQb7NTotQqA3+ftDB0wMfVYrFKlx0fmh7b9mNj5ntOPp6vOBqY=
X-Received: by 2002:a17:902:e2cb:b0:192:549b:ddce with SMTP id
 l11-20020a170902e2cb00b00192549bddcemr1604063plc.4.1673117322187; Sat, 07 Jan
 2023 10:48:42 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:17c6:b0:364:39f7:f166 with HTTP; Sat, 7 Jan 2023
 10:48:41 -0800 (PST)
Reply-To: lisaarobet@gmail.com
From:   Lisa <bar.yannicksossoukpe@gmail.com>
Date:   Sat, 7 Jan 2023 18:48:41 +0000
Message-ID: <CAA=v2hPjdEMhKuz0xNrxqZCbPKUbOXP3F2RkR56GyVTzzE2eYQ@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

How are you doing today?

please tell me did you receive my previous mail,
Waiting
