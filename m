Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15A4622CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiKINxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiKINxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:53:44 -0500
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034626140
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 05:53:42 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id j1-20020a4ad181000000b0049e6e8c13b4so2416881oor.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 05:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=happydataprovider.com; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ga01pyyVzFmLgU+IDG/n7dXGUM2coIRN0T9qfEp/9s=;
        b=HytlLUprTzR6CoFaxca0ehk27yIJ1WPgOH0k9P3TmtqS7fbFc4qOHi6rsKBlbugYO+
         5i7k4EcORwLJSRZDu+I/hFlFc/bnjP1/F3IrJpxA9L7DKwuQRZBjqBooMWQFuYGNyKbe
         ltifiYAQxSVCN3A7PlyC6Knc7BaB8BA4HD+RCJe+8ndIVp0/GU0PhIdRC5c8KYpYzHHh
         TiIOU6kTqA5fymfqa+vyQh7REAabF1K+nqokGxpXGMGKef3tZqdsul9upzYvToaMiDB4
         bVJ9Gdk3s1Z37V7Pb+ZF8cSieDAf6kSc5fE39AOUjjLvGrWRkBkwoJU3hx9YiU+XJNfM
         hTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ga01pyyVzFmLgU+IDG/n7dXGUM2coIRN0T9qfEp/9s=;
        b=w3xt1jGwyFvjwOLQIBoee6TWPyxMcViHETQgFm30uEgNelKNqV2Psav9zo010mIfzb
         qqgjsKTy8YgqScpLY4o5uOLBMeCGvvTR2t+qQ18CRNuhyzzOyXGWyb2bWgS63/uWci6G
         J4Ciqrhd62MK0kxn2+7FGcrk0Af0gchH3R454Jb4LqXarUXG3JJ1fPPCLio9l/oWAQgA
         +F9Ax7eCSYofv93W5S67zFg5T9xnfVzlvQoUnrj/SXa28VYa/pagyfvSbDae1+xVu/9V
         6tTwQoKJYO0Ap5SEnubzeaqhrI3QPfd2cWjfqmjcpNxHq/KiR8f1qGFm1GDRz+ggOD5x
         YlFw==
X-Gm-Message-State: ACrzQf3caW6xaUE98HkkG8CTI3NDmnCFEj38PIieZh2R5FO6ZyaA4PUQ
        insC+yAiDRLPNZv9P4Q4OS5neKLN/U3MAWHO0Yvm
X-Google-Smtp-Source: AMsMyM6OscEwLX19PTvXivs+cID1sWmLcqLOyoREP0rQ/UMzQ0dMPuuLjxIqjPy0uyTXtKEyHYKLxZNPePu/h0axOZ4=
X-Received: by 2002:a4a:e54e:0:b0:44a:fb57:7022 with SMTP id
 s14-20020a4ae54e000000b0044afb577022mr25695616oot.91.1668002021262; Wed, 09
 Nov 2022 05:53:41 -0800 (PST)
MIME-Version: 1.0
From:   Isabela Moner <isabela.moner@happydataprovider.com>
Date:   Wed, 9 Nov 2022 19:23:30 +0530
Message-ID: <CAEFFemm-T0GNG1JwWXS5Wr3O3x6ojh+cVTcgfNb6gSqEZCRdXg@mail.gmail.com>
Subject: RE: Dreamforce Attendees Email List-2022
To:     Isabela Moner <isabela.moner@happydataprovider.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 Would you be interested in acquiring Dreamforce Attendees Email List 2022?

List Includes: Company Name, First Name, Last Name, Full Name, Contact
Job Title, Verified Email Address, Website URL, Mailing address, Phone
number, Industry and many more=E2=80=A6

 Number of Contacts :46,968
 Cost : $1,829

 If you=E2=80=99re interested please let me know I will assist you with fur=
ther details.

Kind Regards,
Isabela Moner
Marketing Coordinators
