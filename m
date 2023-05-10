Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74906FE162
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbjEJPPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 11:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjEJPPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 11:15:31 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5116D449C
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:15:30 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-530638a60e1so470708a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 08:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683731730; x=1686323730;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f6t36tXFlS1ZUF7gx97JL2KZPC8A16NWFFPw5GhjDdU=;
        b=CL3kxD9y0A7PNAV1je/U0bFejU4/SGY0J9rXEDhNTrk4GGoxsLgE/KvIfG+tJrmFuJ
         qpwAnGEUZto9B3QLKEG37SJadSnxTLFXWDyGDal449fAMAp1PyXWAUMGqYudwZmVhqc+
         uFHEvouKcnjQnwEXMrsl/wLPiIJlFGh9CzlWuDuJd1YeJdVbKWBjoEmOScOpYiiYA9eG
         HlxZmGwL+GeBdhapciu5hx8/POdFxjRAlPGGrLreSPXxZ6okw9Q86OB6L3zh4nH81EpZ
         i36yh9fYByWGp6zE7V+gsJHNUB2J4krN/xq6bV4KGbZveOa8oBC2M7mYF2Pllt9qVbIQ
         /AEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683731730; x=1686323730;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f6t36tXFlS1ZUF7gx97JL2KZPC8A16NWFFPw5GhjDdU=;
        b=HQt7Vfqfx3kCsGifySOF+9aRlaAU6gLH/xySG521JSmDZQea6UHE8/k3wLrvLh7L8G
         b7idEcCvjHyJ45IIVP4gU+XwGFJqCm0sl6/3xqrPlxMStjDmB101Kgox0U3aYa4BLsYk
         /bPwTm+eki8ITu8Lx+AESM4d5p9k1+DO2dhJkA4TZXYMUoryIg3wmUwlSC13tDGrpU89
         xRNPiSGtrZGxdO/dGM3d5GvJqid7YDDl6WPCZTDVSLSyupuofevFBOo5x1DGAE4sr2ZZ
         TUtL9eh6TsiLhAZqMHX3/PRKBAm7cRjWSMojSViv5YRrq40n7RaV7+8U9KnomcIgnOHr
         pf5g==
X-Gm-Message-State: AC+VfDwOxgpet84rAVMg0GPvgeL+KiCmsYHQhvosEIhId0Ug9ia5mhU4
        DQ4mTYMZ5BSOCZbMGX1GuTld5iI+J/NkzNIHUic=
X-Google-Smtp-Source: ACHHUZ7pmWjNnyr1f/fDjZge442cIUu8CxRg+1USBHonOH9uB4FJBHGND9BLsOyZhg6Ul7ES6PlsBEatQaN6/540Ab0=
X-Received: by 2002:a17:902:f7d3:b0:1a6:dfb3:5f4b with SMTP id
 h19-20020a170902f7d300b001a6dfb35f4bmr16968801plw.55.1683731729758; Wed, 10
 May 2023 08:15:29 -0700 (PDT)
MIME-Version: 1.0
From:   Lisa lee <lisarealmarketing07@gmail.com>
Date:   Wed, 10 May 2023 20:45:17 +0530
Message-ID: <CACxyjTHqHwJNpF0PhcpGcq0oh6YkiKe1uPc+Y1U-d++T51s-5Q@mail.gmail.com>
Subject: RE : American Association of Critical-Care Nurses Attendees Email
 List 2023
To:     Lisa lee <lisarealmarketing07@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring AACN-NTI Attendees Email List 2023?

Number of Contacts :-11,689  Verified Contacts.
Cost :-$1,568

=C3=98 Perpetual use of a lifetime license.
=C3=98 Two tier tele-verified and email verified contacts

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Lisa lee
Marketing Coordinators
