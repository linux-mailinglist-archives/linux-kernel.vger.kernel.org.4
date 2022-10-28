Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0072610C50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiJ1IgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ1IgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:36:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4E1A9112
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:36:10 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p184so4008138iof.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9Y1p+qlCnBvED9zzTgvEOAvn502VsmGTh3U1RRB9d4M=;
        b=Ih3yYh9FIJXwEuCshZuNKX/cwFfmlEZRmef7ihrBclwuNPvkIm50GzcGBi+SXi3CNi
         j9A7byZVlFMtYx6LiOMrEukdU26TWj5WzQXnQb5H1PX5DUBVRS0wk7y6YzZlQnGNhnKt
         u5B8kNiUGFrHurNUMWeU6F++3LOA0BNNzP+FR/ymOd8CJKKyhChg+QAGYjeF1qyK5eun
         woqKcvlEe5Dcm4cDQrEDYQJUxeR0pg0U9bBzAPVDMYxdW+BSq3sHzkQwwN7VtDL1fCng
         bRRqp3rJJ1nwruNszDvZjSHCQA9vT53UcgHMozpztEb+bOz50XwPk/77mn6orkT8lip4
         MeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Y1p+qlCnBvED9zzTgvEOAvn502VsmGTh3U1RRB9d4M=;
        b=ceX1oDpQoSW424KtUX6rCoHUSqcG4frUWyat4NW6kt3E1NYlXi5pCV/OZLfv18zchD
         Ndm93+srTzX1YLTSstjk9j6o5d5fs979Ry8R+zi+cipc2pzhk3SThWa7iuJ7zQHZWhGn
         nURH/dlWRqG4gG1hb1cGgAcsm9x9LfWy0dQ70AtLEFBubUN0G3Y2QGSh5JdLmywFfvej
         SIuDrzzbF69D9ZxGVhSPMrkbUw5dBbQpNKCovCOk7ou2XB/75Xv+gfRFPrWxC4sRcj7H
         gp23i2QM83/Mo6z2H5NI3vZuucx8qrPhpy74DXsQuQ438Bbv3MdNasrjK7Yo9SUe1N6W
         q0VA==
X-Gm-Message-State: ACrzQf04Tfslc3xdMd7F9QpfzshW1sYRZtlisJbLsrUOctms80sgjpzR
        8IhfGvImIuhqef1dw5L6mSgve5HVmz9EcML5xhxM4pkxx0bgfR/r
X-Google-Smtp-Source: AMsMyM4v8P3eh9JcJMr/U6H9IOtksx0ADf18qvqW7OJhHTf4xyBA1TEwmH2d/EJyqYcj4+SLfNk9iUprf9VUwVrtYtM=
X-Received: by 2002:a05:622a:147:b0:39c:dc0d:7d0f with SMTP id
 v7-20020a05622a014700b0039cdc0d7d0fmr43237667qtw.281.1666946159569; Fri, 28
 Oct 2022 01:35:59 -0700 (PDT)
MIME-Version: 1.0
From:   Tanju Brunostar <tanjubrunostar0@gmail.com>
Date:   Fri, 28 Oct 2022 09:35:48 +0100
Message-ID: <CAHJEyKU8YhVLg2k4c6H_B9YJo=Va=V8ea+vkgDKH8aUZBou0wA@mail.gmail.com>
Subject: Outreachy first patch wiki modification proposal
To:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After setting up my mutt with Gmail, I tested it by sending an email
but it did not go through. After some research, I realized that Gmail
no longer allows less secure apps. The way around this is to set up
two step verification, then generate and use "App password". I would
like to add this to the wiki, as this will save others from the
additional work. Please let me know if I can proceed.

Thanks,

Tanju
