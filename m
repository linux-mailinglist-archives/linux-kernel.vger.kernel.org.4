Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E4E60CF6B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 16:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiJYOnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiJYOnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 10:43:43 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E37B18F0F1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:43:42 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id j16so2794117lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 07:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aPgNrYKriz2tlxwbo8vdeB9vHKXHF71ovMUPdSkwybM2sX3C9mbtEOU5Kkh+mObT1k
         w41d5JMo1IvEfKaxJxc3J4m1+XkKFG+ThFN7N0DK0OtuxFk5eRrb0FkzOVkmoMt96x8k
         8csXD/Znq5iaBU+8k0DQzfqlkLxcpabvaqYpEsBeFH1UC8q4LBuiTsWH/242X65159o9
         k+wBLfB8Ctw56YvdP5vJ2sO0C6x3j0LQlE87gpXRlA/seSlE+oU1Ufq6MPxT4YA5YMs3
         /VYpBcFxrUFlQRMBSAkZ68DawTUReI+ZW6pGlW+4kVWefY8elTIIBHsiC4Jkiz5JoWDU
         q6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=aAxhtAjG/DqlfW+Ak53LwLL7444jQVq9NiIihNCOO7KivH9vwaWLzQAY+kn7kPMgJ7
         y/xrM3Nuv8vgw54zYfR/TFr/7VMoYFvx5rlayPV2SohDRNhI2P9HZeD4qAZkrkLkPLdD
         +J7GO/RhUJ5NLLw9gg7ekjDC132H+mh8i2lQSHgXMPFaW15Lm3lV2PER6kqd8v+IrjcA
         iNGDQH/FvCiWMHq2LjWzCLDct26WGxSe3d7FxwueUoDUgOIirZXNer2j1kZCoeg3aVVD
         9KQueXC+bayHmaXiITtUf7Zr0O+fhSTBHD7EE8W28iIqhaAFk+ntQrFoN2OnZlELK/9G
         0frQ==
X-Gm-Message-State: ACrzQf0s0OoWa3yGxFl1OTKo+4g2/lGU8cAJeUl3PuY/46+V0gJVEWms
        cubQP2W2nXTz6BS+87y8SCUEiYwQG4boMJe41ic=
X-Google-Smtp-Source: AMsMyM5/obq8L2OqQ6lsqf7cPFwohaKnp3v1FD12TgpQdXQRu4EjkyQ4xF91F58Q0ZMof/iyskOT7OawT5YmefLfDIM=
X-Received: by 2002:a05:6512:2342:b0:4a4:81e4:374b with SMTP id
 p2-20020a056512234200b004a481e4374bmr2583694lfu.502.1666709020762; Tue, 25
 Oct 2022 07:43:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:1ba8:0:b0:1f6:1b25:a795 with HTTP; Tue, 25 Oct 2022
 07:43:40 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <mjude4116@gmail.com>
Date:   Tue, 25 Oct 2022 16:43:40 +0200
Message-ID: <CADLcUi7KxqRFt6QOPWNOckA7rYNW17zcMwGYeOhx+fi3XG=EyQ@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4886]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mjude4116[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tatianaarthur72[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mjude4116[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


