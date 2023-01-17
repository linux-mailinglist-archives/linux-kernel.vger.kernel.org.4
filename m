Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7068566D5B8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 06:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjAQFnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 00:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjAQFnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 00:43:08 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819141EFDA;
        Mon, 16 Jan 2023 21:43:07 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id i28so1883589qkl.6;
        Mon, 16 Jan 2023 21:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=10fg20WmnP4mWOYcGw2ELSTfNyC1aYUzasENYBg+S6s=;
        b=Z48+V+FonNrENMrfv6Uzm6hPkqHaQMp9vyrgkkg7CDgs1rajGNGLf4vD7AgjbKNTUA
         bPLeJvkPIlBVnjLRPLuNyHnX05pIcqz1AovVSeAGSgZp7iNSeXXToMXkB9EwpvmfIVRM
         6ghPrXMCLmVlUe0Pt9uZWbkLosudBgaUlSFbYu3bgcjTJKwGX7UTRGQoFnN1LCkwPX5c
         PQRclFx57uh9rzJD3GxIw+Cj3pzkcnUVkYLsHAUnlkFH/W3qQ8Hf8KYRObSlqGDrhWVq
         LS7bVwlUK8p7K+OBEIRcHNXrE5/E0ODMoYs75BA6VXMSL7WXDLs1SM7XR5Gc7+j5p9Lo
         5L4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=10fg20WmnP4mWOYcGw2ELSTfNyC1aYUzasENYBg+S6s=;
        b=xl3LYQZRxwLrqzxzxSNAZKGbMZ6pAuEUUuJ2U9LNPTh4KivhT8QZnuH841gKQ9LaYB
         4/P7vLFtsMzkFzJdf09yxngR5f3o2tZTQhV9t/Ap7yMXV8/ksFbfQIKh+6K6tbjzHl4T
         m38S2P8FoWmcNfleAGJm/XblKoQM/o/mYCo5xRt+OEOnygCZG/ZQURmXMZ4Bzfm1zZTK
         1HO/Ixa7cpGI5M5D1rkY2ey+z0kW5UxE/C3EFZmh+AY9X6aT7TdQ+l8uNXgqBfvOCIqh
         1jdmo/ykAz+ZkNuRyblP2YH3CZzCRDWwcvA3dSZWVGhl31qcuiwb8tfWtCvkhR4JmN5z
         2O2w==
X-Gm-Message-State: AFqh2kofLTOL5nEsxABVFLY7MheOduYIiWxOdY1m+wQ2wHHZxUuq4aHa
        oRezYoMJYY0VMwUliGtuKdijiaDLy+LMc9n56g1s01rabL7hG1+iZAA=
X-Google-Smtp-Source: AMrXdXsiG3nLbyq0OQonXYvwUpYbN97DeSptXwQL30DhfTywlNZ9k4IZrkDk/96iy+UACwwO2fXqdJYPdRHynfjejko=
X-Received: by 2002:a05:620a:667:b0:702:be9:9915 with SMTP id
 a7-20020a05620a066700b007020be99915mr95345qkh.400.1673934186333; Mon, 16 Jan
 2023 21:43:06 -0800 (PST)
MIME-Version: 1.0
References: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
In-Reply-To: <CAHbf0-EHP0cRDhOD_3Mf4aRzndoVYGbd3j3vxwUOh9_cHp+h1Q@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 17 Jan 2023 10:42:55 +0500
Message-ID: <CABXGCsMz6qs0qSMoF6F3B_kJt+UwULtfpp2pCNxUuWAqAryniA@mail.gmail.com>
Subject: Re: [6.2][regression] after commit cd372b8c99c5a5cf6a464acebb7e4a79af7ec8ae
 stopping working wifi mt7921e
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     nbd@nbd.name,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org, lorenzo@kernel.org,
        sujuan.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 5:33 AM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> Hi
>
> I'm struggling to find these patches on Patchwork, or apply the saved
> raw patches to rc4
>
> If I'm missing them, would you mind posting the link

https://patchwork.kernel.org/project/linux-wireless/patch/20230113105848.34642-3-nbd@nbd.name/

-- 
Best Regards,
Mike Gavrilov.
