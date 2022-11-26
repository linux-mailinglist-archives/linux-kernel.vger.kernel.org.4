Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D14639710
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbiKZQUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbiKZQUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:20:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CFE714092
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:20:13 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id z18so10073281edb.9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:20:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YG9QMvPKbl9yQ7KMhJt3phwl0JH4HvZZNq5Pdq/RzsA=;
        b=SUPbgagmgO1/xY1mlqQxEHDO+5VhjKvw0uJOR1UCfc2CsjeDwoZwttVzAUNvy5Bolz
         69VfFh+YcvkvgKj1R/YY4i6jZ5EBtq+Uoi0TyNxvlNb1DG+sEgEtUg/We2UEmOOV3uyE
         +ptLRpMzgc4jBsxwLrg0doRXhMSD93439g3Y4+ti9NmKr3tk6CJFPe2Lgm3RQrwenpGY
         u68rEJIIdKGTtESerqSe11/uMibSpdWK8hXCC5SqFG07DzY9uFZUk5Ik9EAG0Yy8u7I0
         OSUUO7eO/NbCaJjxQx2mxvVd6PQYZd47rkmbkKNfWxhsh9FcfKTrI+7yQbOl8xw+Hwpk
         X30A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YG9QMvPKbl9yQ7KMhJt3phwl0JH4HvZZNq5Pdq/RzsA=;
        b=gLjn/5tA5zuz8TV7UmRGGeqRgUXfmwnJ0LTyqkfuleLYX2qUI63W9PLmVc4bOrnv25
         lWuxYu0D8ivnVdnIgXvNClUH2veZEFBsM1V0zSKPqIBzmGasCj5b3ar4L2GqQLp9wHZO
         G+2dEB9p4ggJsOzb1wT20SUiZPSSZuweHIjJ8p5udeuEbqdopecdicgkrd3YVr0qmAB4
         AQ5CqMpTacd0SqkmhUKboAPejMbRJiRB1n858VaL/hBRPbIaPZ7Xg1bWOBUENlr2VJZp
         VJ3ZNShA2JGTtGOkOc8XwQWBMMFeWOlOSQoyGkAsCjIzRIeD2SXQGLrXI31NnZOFWlyj
         xq1A==
X-Gm-Message-State: ANoB5pkscCDx4iMnrFtjunkZ1+ulaU7fY59ZPH671UX723nYnrt94tqK
        xpHArJXsy6iBfGdn7ShFxHHScWwnyHTVaF/C4WE=
X-Google-Smtp-Source: AA0mqf65fcSasOsAbX3vK9/xEwsyernQ7sXUlO6m/AC3YrLQWpp9wR63EdDMftXRqAoGf3MxLMFEw25/rQcbfWhU3sA=
X-Received: by 2002:a05:6402:1655:b0:46a:80cc:d5bd with SMTP id
 s21-20020a056402165500b0046a80ccd5bdmr13663537edx.210.1669479610705; Sat, 26
 Nov 2022 08:20:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7412:e3a6:b0:8f:945a:9b39 with HTTP; Sat, 26 Nov 2022
 08:20:09 -0800 (PST)
Reply-To: a2udu@yahoo.com
From:   "." <1245oose@gmail.com>
Date:   Sat, 26 Nov 2022 17:20:09 +0100
Message-ID: <CAK5_6Vimstgf0OXP5aL=z51v7tTPN5oVYdNwSwfVAy9NQ4AbzA@mail.gmail.com>
Subject: =?UTF-8?B?5L2g5aW9?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5245]
        *  0.7 FROM_STARTS_WITH_NUMS From: starts with several numbers
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [1245oose[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrkvaDlpb0NCg0K5oiR5piv6ZO26KGM5Lia5bel5L2c6ICF44CCIOaCqOacieaUtuasvui0
puaIt+WQl++8nw0K
