Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9E96D8134
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 17:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238836AbjDEPMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 11:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238780AbjDEPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 11:12:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413266E82
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 08:10:30 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id o20so34718948ljp.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680707402;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZzwtrYWSSZje7Qwx/j88PGQv9DVLTBbXoxX2uHsmBw0=;
        b=l3ThJID3BSw22BHbbzSqaanz7Ojfxvh3KWSnQko4HbDUhj20VGwXwLgTyIaPT/kZiK
         Y97cy8nwaIetBWmIHn5W1S6OiDD6Kr8b3NcWOY9faE7fA9awxSrmzYh1t2JiKUxJ4sj5
         Uj7QLKXwptQ95RTJbltapn2zxfu7zzEY6eGjJibu0DKFss08nxs3EtaUxBgODNmrwTox
         6nPBlixJ/+e1kl/8x8Gw+XcSo1bZKIQSCBKL38qtoFovGkiwTupYNNc+SS9Vyfddyv0d
         jFdlZI5ko4DW+Q6YX+hVa0HpnvagyT3NeCcDIZYV4SXpAOmqhnvqxXrx40B0lLfKrpj7
         cPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707402;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzwtrYWSSZje7Qwx/j88PGQv9DVLTBbXoxX2uHsmBw0=;
        b=3o2sL8o97FoLogHP30dO9YLviuhqx6icxPmJHfpbj9YiCrKy83LflHsYxFuGCR19lu
         kIDN5TZzNLqne7rsndyXAZhnsZMZCIpCUMRtJopQ3k5Q+RWy/ep35nHla3wYBWQJcgsv
         iI/0HkTYKWJhjefErfxUADb8sYn4JjWBVQYVYJ3mlllTP1VKFVnca7kjLrZIBZqh55j7
         jiq3tA1Z4zfrzQrJZevppibetcErsP02teGiS9l/9Lr45KgzzB8rgqNoiiqBVLEBGsnN
         B4LPMXvKVgHEOLGf29gsA/kWmK2z18Ulx2YWdvbsUtLO0wtfbBl2faKano15GvPFmKeC
         wNqg==
X-Gm-Message-State: AAQBX9duAYJF90E2LFfTd+JowILVBcmgHlojPtWpnQdM96RJcSlP85p9
        AX1EL2ch/MB8Z7ysh70Wy5Hs1t5rQQ+fLnzAQOI=
X-Google-Smtp-Source: AKy350b0+F+d7l4hejnXULnHuv4r0hjZJR9cuf29R1YB/IX3m6qRxErVQsZRHmzY1MF/3RCPqNkGa10wOwTvUcSXFGg=
X-Received: by 2002:a2e:8559:0:b0:299:ac4e:a8ad with SMTP id
 u25-20020a2e8559000000b00299ac4ea8admr2299978ljj.1.1680707401825; Wed, 05 Apr
 2023 08:10:01 -0700 (PDT)
MIME-Version: 1.0
Sender: cygood839@gmail.com
Received: by 2002:a05:6504:3092:b0:224:2a5d:ae30 with HTTP; Wed, 5 Apr 2023
 08:10:01 -0700 (PDT)
From:   Jane Lily <jane.lilly84@gmail.com>
Date:   Wed, 5 Apr 2023 08:10:01 -0700
X-Google-Sender-Auth: hnVRcAAyQzL4HFJ_UoG6RX8TY1c
Message-ID: <CADPHf7PBrokxNRjGyMp+ZR+Oc_kqvRbuEwmaeXCp1jPvn02ijQ@mail.gmail.com>
Subject: Hello, My Name is Mrs. Jane Lily from America
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=ADVANCE_FEE_4_NEW,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cygood839[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jane.lilly84[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  1.0 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
My Name is Mrs. Jane Lily from America, I read about you on a reliable
website and I will love to employ you in extending my philanthropic
activities to help Street children in your country. Please reply to
this message via my private email address: jane.lily84@aol.com so that
I will tell you about myself and give you further details. I wait for
your immediate response.

Your Sincerely
Mrs. Jane Lily
