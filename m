Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE96CC1CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjC1OOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjC1OOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:14:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63030199
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:14:09 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g19so2891720lfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012846;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yWlURloCQdY0Hy8wg8AXrxBRCH5H4zwk8qo4ipH4fZg=;
        b=Oy2Zr4IozzUM73mJBX2YyHdgGc/McTddEu4NGhHEWbnz5o744KT3lQtdAfW8lk3Z66
         8/dU/R0frqmJ/NNW/kZinFSlcG157ndmhSyfX6fDI0BiFHR6N0q/K3ymQBaZRidxBrAm
         MI0Hvv/HWK9Hw+4NEriLHs89KfzKSxgNycj871FwqOmPMdNvHlXyy1jrJ7dROCR/flhv
         6e8MhEqwhrWd6hNCwmC4jkn+3/0OcfFGWJ7levwhS/TbbBGvy6LDw1fBVHYo5vHR/kY8
         uTUabxO86+/ZNe/wDIABVWXw1iaNs68I6j6cagZCqrQlD+FD5k7mx2Dq0KBO/qPkPIc1
         xTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012846;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWlURloCQdY0Hy8wg8AXrxBRCH5H4zwk8qo4ipH4fZg=;
        b=TiCybqWpvq/+JUXRkGH9/PfDjKzBoasSyL4BGstHe1DgGtLqhs57m6KaJ1UXMzFjA2
         F2N0UAG8iOH4QpYJPNeEhFY8yKVrWaRhluKBasBtETnTNOT+XSuHEZIVFYsjR8GUJ1uL
         myfyRB0Clb24ZkNd/VT1l4EZ158staEGFU05FzKgcWSBnIw1WojCReqfGfFeKcOIIf4F
         tjkFk8s8DWOnhrPfaUi4byD7547cl/xGdXXvY5JGW5VdQ2D3D3ezA3kjgw7VKc+XDJ/w
         9NKzBXLrrwScjVXd4Rtot59j6/mW80ORo286jZMZfZ/EKnusfyhvXFTz2rIprm8oNt68
         3kXQ==
X-Gm-Message-State: AAQBX9cIQyaWRc/FLxcKmwYPSOFuvxv8iXNIAzyvKMpa17y1SEtSS5oP
        AumfpsT4ohVJVAkIlYORRDLmZJur9KN2ZeaFTtI=
X-Google-Smtp-Source: AKy350axq5bJ7CDRvKuC/ewzNSGx7c5x9OCopb4WWYO58b37C+lLeZjup27TYni3cwVoaSjNyy3G50+MML7FZxkZPzw=
X-Received: by 2002:ac2:5e83:0:b0:4ea:8659:6deb with SMTP id
 b3-20020ac25e83000000b004ea86596debmr4380552lfq.0.1680012845734; Tue, 28 Mar
 2023 07:14:05 -0700 (PDT)
MIME-Version: 1.0
From:   Nancy Taylor <bigmarketleads@gmail.com>
Date:   Tue, 28 Mar 2023 19:43:53 +0530
Message-ID: <CAGhJ51gCet4Y08Xw3Yj_UbFbvPL87ZCaqi4LhvamxMB7Yk7MnA@mail.gmail.com>
Subject: RE: NTI - American Association of Critical-Care Nurses Attendees
 Email List-2023
To:     Nancy Taylor <bigmarketleads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,FILL_THIS_FORM_LONG,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring the American Association of
Critical-Care Nurses Attendees Email List-2023?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

Number of Contacts: 12,639 Verified Contacts.
Cost : $ 1,638

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Nancy Taylor
Marketing Coordinators
