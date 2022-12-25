Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E80655D9A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Dec 2022 17:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiLYQIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Dec 2022 11:08:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLYQIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Dec 2022 11:08:22 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A82DEC
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:08:20 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j17so3141261wrr.7
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=FPGMvd6ycy/DVoukakccjqVpVwpmaFpEdiWorn7nG/ecxljNVmYVFoCUxVKoUYCWmh
         LqsfJKIyBB1nGMaEAyPBq+p1/N5qXneDl2fiF5BkMe+t7P8ZuwX3k0wyJi0RFY05xYwL
         1k9UsUvoZsL+GGRDHb/+rPcNi9tfaKFgLONAkRzIzAc+vevndauE/dqne8eoqSWxAmTg
         +iPRApnS9NHVmRzpkj8nOy8Oio4JSYis4LCc9EHOtfmkgSOEiAbGQrVAFkuqH9FQcmk0
         5Rok7W7LuwKbv5BmWfNAA6YY8t9exYcmHcZHdZ0+hwbqF0xnpKFeKU0AYV5S6MK4pUXk
         oMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K1DFvd/qB2iPwiRdxjvsshI/YDS4Nv+p2asGKuDLehw=;
        b=F3snhE32j1KhHiO9fiw2gvdw7A7QC+plmrnqMITEiam+UxEoGVXqMcTIQI+EsqM9BO
         54evxOZaxCbELDtsrlUKbiGUkd1EnWpR5ozEpjjE/B1n7Epx7PRIb2eGYJGoFcwlAO8s
         Lzgd5P4LgTCUfAP5nlguxKQtV3yY/Izqx9XRyHHoO+i4pwdSwwO4SaynsDu0vTOHeRNb
         WgnVqARXt9UXyGPVJPIjhPSMhNcoUk304A60UxhYlOhR8Tq93mycOoLCpYN2EhVJRD3C
         pz8J1TlAn+bEloHyVbIQchMZQStPiwHgaLjWTSbUVRsHKW2Vm5ZhDFL7ieRQLjYpQeIu
         llpw==
X-Gm-Message-State: AFqh2kqBhz8IfYfHuy+2M0QZsC2QOiEGlSs5McmNuKXOm0VHryQjPHc9
        T6HKyIzYvxKxVbmHkmlZrd2ArBexLF8XFTzgf4A=
X-Google-Smtp-Source: AMrXdXuF3gbk+gWs5BSluoV6iqWDFvC7ULadlRazruLVPp1Y5pz2sj+54mU7/xAOjUBZkywO5USBLOPyUXCbSooPLP4=
X-Received: by 2002:adf:f351:0:b0:241:c595:9f05 with SMTP id
 e17-20020adff351000000b00241c5959f05mr750757wrp.439.1671984499471; Sun, 25
 Dec 2022 08:08:19 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:400d:b0:22f:eab8:86e8 with HTTP; Sun, 25 Dec 2022
 08:08:18 -0800 (PST)
Reply-To: thajxoa@gmail.com
From:   Thaj Xoa <milleymilley325@gmail.com>
Date:   Sun, 25 Dec 2022 16:08:18 +0000
Message-ID: <CANf+LmtfC+3a13w22G+2H_-pS+TQWZBxLJP3qEoz4PSkKP=Q9g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good Day Dearest,

 I am Mrs. Thaj Xoa from Vietnam, I Have an important message I want
to tell you please reply back for more details.

Regards
Mrs. Thaj xoa
