Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314D6894B4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 11:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjBCKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 05:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBCKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 05:04:36 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E5D2202E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:04:27 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g21-20020a9d6495000000b0068bb336141dso1195299otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 02:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBYjhjPWDIeW/liWUe+wiuocZI9Tazf3Ctcc4Qyz83o=;
        b=n/mTmdg5dhWgN7ABp0Mt641md+CMSIhU49oyBVYJ8bvsJuWifg4e+5Ni0V+hpjEKRr
         IrizY/D0AgWbuWXQxwD6vSY25nwpCOpZ/iUSN23zqhxPodoh4OWTvIQ6RIr9TCemDweU
         qwGwmUXw2jVf44iQMjAN4vuLNo+dNezRMd2Wp6Aqxpf9j2eq8tGmZpSWVGWx03EI0vTH
         2VlP0dBt0VeSKIncnvFcTM9eQJybbMECWn0TjcdHVkmUSosH86zoGX3Jrp84sCaz5Llz
         uXcEF7ByNi5ESZArQ4HJ7+WSzjEbuLdvejfHRSJqAjkojURUNPYpKDEdfC+7R94pQyVh
         wXrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBYjhjPWDIeW/liWUe+wiuocZI9Tazf3Ctcc4Qyz83o=;
        b=ogvEMiX45l/nxnIjSarRUcbkn9OW1mjuqgun2yfI3TS7ESGZ3H+TMGnEVK2zj1V9v/
         WIovvE/bLdN8zEGaQCwFjXAoiuFpneEMESP1kns6XpvG8iTdJFH/wAHuhbuUDoRTUOb/
         0UiDb53LyYuDki6J0N5O+WR/IY58YDu29i3H+/BdVNwa5Qi1P40JGFNaJtFjmL9zTMv0
         wKm2nmGpKix70FK6jKyrW1LUSHWDDmM8663oICfP5OrV69Pm6v9Se1bHt1SvhqGg82lU
         RUhH7JCZwrrphKctfksJziI6XzoKQOxm9uGlCDLpgwWWX9m6SMRfk1vXAB6PCkN0psI+
         6aRQ==
X-Gm-Message-State: AO0yUKVydFX6sxWd2ilWLjQdcFCXn76tKONvCDVqxPDQx/2uBSoMPXUs
        84IZFYIanPqbXgDlpopgPWzNu3xse6R6FMydX90=
X-Google-Smtp-Source: AK7set/lq5fz2x747YB22DTIaCxKETl3X2Dz8t22Lj35baq3cRVirTL6p9zZixi3x9O2+L7WusntW74smdyAuJbnEgs=
X-Received: by 2002:a05:6830:1d52:b0:684:9679:acb3 with SMTP id
 p18-20020a0568301d5200b006849679acb3mr503305oth.79.1675418666432; Fri, 03 Feb
 2023 02:04:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:7e51:b0:df:f2b2:81e7 with HTTP; Fri, 3 Feb 2023
 02:04:26 -0800 (PST)
Reply-To: cafod@mail.com
From:   CAFOD <wilsonbrown3070@gmail.com>
Date:   Fri, 3 Feb 2023 02:04:26 -0800
Message-ID: <CAMb6Ek7yWSw+iWX9nNy0-M=-FRboqTdBVbESZ7Ah+3hODq0MPQ@mail.gmail.com>
Subject: CAFOD
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CAFOD Christian Aid London
35 Lower Marsh
Waterloo
London
SE1 7RL
United Kingdom


The Christian Aid London is on annual forum program of selecting
individuals, groups and organizations in coordinating to reach the aim
of assisting the Less Provided, Widows, HIV Patients and Orphanages.

We have this ban to select irrespective of faith, as we work through
people of all faith and none. You are been chosen as one of our
coordinator in your area to reach the aforementioned under privileged
ones.

We have mapped out sum fund for this program which is to be giving to
you for the assistance of the people around you. We trust God that you
will work with us accordingly. Reply for your interest.

Thanks and God bless you.

Ms. Chine McDonald.
