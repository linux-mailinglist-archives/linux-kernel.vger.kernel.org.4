Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6366B5F7B57
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiJGQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:23:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836FE102532
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:23:33 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so4083870pjl.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVKfZA3SwiGf8qlPzooH70x5W9OPocalRMd2pDz1Njs=;
        b=p2/iQy2rmgnIEXndt1c2isSc528d1W0zf8zkAfgqNNIl5UA0prvbJAsSh7vGwFQM/0
         4bR6mo4ZdZ8xl1o1XciNISLkeYTSgYbfTvjTDDOwlrNZuZ/5X/kU9bgmcnPUEC3n0r8c
         GusLDh2umCN6OKQqwHZQApqruIhHANWWSGXx9J68P+SuOpjXsdK21rgSL3Rk0gTtzdgA
         9VciZozMJ6WZqF5PHv7zRUiuVReKM2VcGq6PUlnDv+QmsVHlb0wrAihiuy9rn1cHNWSJ
         BskEWzzqJ4s3Umuv6V6W51Ea0YGoeCtlS33EayGiVwGjl0ixsOvfxvZec4OgHHeZ94D+
         ZTvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVKfZA3SwiGf8qlPzooH70x5W9OPocalRMd2pDz1Njs=;
        b=FF1lBirya67fglpzDEP4vZuzcjUFaBIKaMd8JTfKG8VU6ghjXYwtj9ZTV6J2X62Rw6
         L1YkteAjinR0uGRFSOxPdVq0bXAB2gKpmRwe1LlC9XocBqjG9OQ/wjhoAACQ4Hhtb0tJ
         6/5z6e2vmOqZtQKIzU03EZS5BHp2V4wyYSRc+8ND46VM5GWTjzdHx/DH5nCpVUKm9l8H
         /X25pH+JpXnvtsh2WEuafLtNJdh+5W40T5brP3KUj9lkfOCWGi/EgNVv1EU819LvJeHa
         wEgiIiya6K2kds6R1/yjmYjS5OAGxmbq06AXqSOpYTo3h7/nYrlMbz3ShzxFjPt35krZ
         +JNw==
X-Gm-Message-State: ACrzQf2XdUPm1nWZkJ9CoM0mRJ3exeH6oGdbJFyoAPa/2cMk4pwUK+FO
        vj3MIDe0XLv7J/5JWXdEcyamKXltZegVr+kuMX8=
X-Google-Smtp-Source: AMsMyM4aNBOg2ixK2Ti0iz9E/9RVTENMJ07GV2dAkCNAb+dyKVlrCjBfxPMdCqWIQ4OR+51pVLKtY9y3EHVDJ1tA6vw=
X-Received: by 2002:a17:90b:4d0c:b0:20b:c983:2d85 with SMTP id
 mw12-20020a17090b4d0c00b0020bc9832d85mr3153480pjb.45.1665159811878; Fri, 07
 Oct 2022 09:23:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:10e:b0:45:df8d:92fb with HTTP; Fri, 7 Oct 2022
 09:23:31 -0700 (PDT)
Reply-To: mrs.feleciajonathan001@gmail.com
From:   "Mrs.Felecia Jonathan" <salifdene5@gmail.com>
Date:   Fri, 7 Oct 2022 09:23:31 -0700
Message-ID: <CAC0oiJZaJ6zkQTCyu5MfoaAN_pdJQvFjhWBTDQVyRWNJ1WW1sQ@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salifdene5[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [salifdene5[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrs.feleciajonathan001[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how
dealing with Gold Exportation.I Am from Us California
I have a charitable and unfufilment

project that am about to handover to you, if you are interested please
Reply
hope to hear from you.
Regard
Mrs. Felecia Jonathan
