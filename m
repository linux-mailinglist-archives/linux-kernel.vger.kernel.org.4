Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857BD68A964
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 11:16:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBDKQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 05:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBDKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 05:16:41 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC29228211
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 02:16:40 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gr7so21716299ejb.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 02:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=P2NKI1LjDnzo+5ep033qOO6whLwW/q3JDI5h10DySPDYakHwtCYzdET9rh879iussg
         Zesi/aMpSqZ1VTRY3TSQPfTzKeDkUny4IEu3OOok3+XbnuGN5gwxq/xLFbKBhyzuWTc2
         IhMLjB0HIaxIa9nSMQ3ARLVBYFdZMx2UtYey5twwOhMpZn16nMD2xwCp2MTUmm8FlXPI
         7wl+te/ocWlfeYx5csEDGFWAwB7ULVHjpj3/oSesKRDl8eHKm53N+C7LucrA9DY6hZnt
         3o6Jbr7wTZIF3Lnef75Tvghb1ZjYbSZZ8EMMDla4vxVpbELe+TMGbkOmWovhuP75M/o9
         XFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=X5GEC+cpU3kZmCsNHP4zClJFdisc7PseAl5gNrIlBpUAqjCrgzlXiGLQiTsQ8nliol
         4JnIBIkP79HGI2W7R3gEp8zAvGACXfySlbMwUkRm6glBVmdALK35mOayXE1ECpauWjMw
         FkH8ZCjVr9QPamEuNGfFLyqGb0e0+s/zFExYHpCnXeEwi0sz9oJXNS5xbRKwzxKVn+v2
         7lu6ii/4wlgyNtLq+lNAwvSSPirhDCVGrfFZUcy4reBflKWs03AGL6VUj8u6UM2HhI/Q
         N9bocPAXp1giHazwmPq4Ak9lQ/4EpQ+ui0pHNMbayV2UTIo1gHfxSEG3gNIjbdvUq2DR
         /c6g==
X-Gm-Message-State: AO0yUKURCoOlq9gA5KnYUAbPupYsIEwNuK5Mt0J2XiGE06RWxEP4IEI/
        UqjEfckXuf0+PJayGB+K8atePpZusYCL6M+aNFw=
X-Google-Smtp-Source: AK7set8vzb9G2m+dg9+sR85cdVjwtc3u3yzB+Sl2krmr4meTEwyWqQGDSDrUQQ1K2c3WLq+U7hUwtF4DljYpoBPGqQs=
X-Received: by 2002:a17:906:a246:b0:878:2b8f:b4e7 with SMTP id
 bi6-20020a170906a24600b008782b8fb4e7mr4005399ejb.165.1675505799129; Sat, 04
 Feb 2023 02:16:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6f02:2b:b0:46:dae3:c0be with HTTP; Sat, 4 Feb 2023
 02:16:38 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <mawiyadessa@gmail.com>
Date:   Sat, 4 Feb 2023 10:16:38 +0000
Message-ID: <CABpiYTmL1f4d_+dTe9tGDEiS8P0jvCYXhEtEV0AP-jkLq5BS3A@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4930]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mawiyadessa[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
