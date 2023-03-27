Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEDA6CA13C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjC0KXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjC0KXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:23:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1258BC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:23:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id iw3so7957942plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infob2bdata-com.20210112.gappssmtp.com; s=20210112; t=1679912633;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fd041Km9JR+rEbkknkSS85NuSHr4TlfBRZ9hZBTdfGI=;
        b=CxbgeiuvFWwARtL1+qmvaGUQ3t3DVEO3MVCLWY1nsrYxpss2CwrPNw3u6gX9rNHsgo
         Ap4qVQUuQI7CXWUlA+lcRs9QydTnDcHDQlI3+pjtYkLv+z8GNyJOHTaOjgVmS/Vujxth
         NbbJyrbkFoiIzCq8MkGOxiRFdlnIgcB0PtPOBEmVuCL8BCLADouR7KXLOCjPT1Ld7AeH
         yvCvZZlLhb80TgjXp3QpQgM6FE1xYJRWuOD8DRiWmL2XieyX9JdcsB4is0V1AgtmiJOd
         uYYVgsTB0XYvwJ3jcmQsF/0dcVQsVZItGBdhz7ig2Pcp3kW3TmYipqsBqvt04pvQpvg9
         M3/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912633;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fd041Km9JR+rEbkknkSS85NuSHr4TlfBRZ9hZBTdfGI=;
        b=Cc7Rwj0jehREOQwpG6C+VK3qwCRAiWqjCUGl/ynE3xhUggVm85QwXWjgXw23eoDm8A
         pe+3Rxd0/RhYA7U1Oj2psfo3H6eQnVG7AnLCMnMi/ni6ZWOxZZUBhkXVGg4RU7T0xlyd
         Us+3LLxKseiF2GDmp6eqakUiBnAkivlJ3UsERVos2nToICAaK47uJTynl6hgGqdgHOww
         IvmLvb0JDT6frFEDB6xpQXx+1a2LyxWqFNbrkNMpepAqK4IDVZ40pWlJJP4bJ8qjlF9r
         GLb0iIRW/uCjfKS7HXqNPDM9JVnDsz6QofnBctd8yej17zxS41lkfUZrQanQMKiFapPR
         ZX2A==
X-Gm-Message-State: AAQBX9eWYJpmCNCncSEtKQfxd+BKw/y33c4al0GaVjhdhUkZLD6CbPyk
        zB0VGehUyr1mRoVm0WmcNsM2369Blw15ur0THSvD4Q==
X-Google-Smtp-Source: AKy350aVtV7Gyeq0ZlPh2S/bbwFGxuWbfIGoO1kuUDGrvw4W0IXtKWqSQVJAgUpZg3PRSoSGvRMd2nAPtT5co6FAePI=
X-Received: by 2002:a17:902:6948:b0:1a2:3436:4119 with SMTP id
 k8-20020a170902694800b001a234364119mr2229296plt.8.1679912633215; Mon, 27 Mar
 2023 03:23:53 -0700 (PDT)
MIME-Version: 1.0
From:   Stella Jacob <stella@infob2bdata.com>
Date:   Mon, 27 Mar 2023 05:23:42 -0500
Message-ID: <CADH7MrEs0PJyG0QV+-cUfZDB+jOfrSTc1qwjxXC2WCrpY-ynNQ@mail.gmail.com>
Subject: RE: 50k+Verified HIMSS Healthcare Email Lists-2023
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Would you be interested in acquiring HIMSS Global Health Conference
Attendees Email List 2023?

List contains: Company Name, Contact Name, First Name, Middle Name,
Last Name, Title, Address, Street, City, Zip code, State, Country,
Telephone, Email address and more,

No of Contacts: - 50,964
Cost: $ 2,652

 Looking forward for your response,

Kind Regards,
Stella Jacob
Marketing Coordinator

 if you don=E2=80=99t wish to receive further any email please reply us wit=
h
sub line =E2=80=98leave out=E2=80=99
