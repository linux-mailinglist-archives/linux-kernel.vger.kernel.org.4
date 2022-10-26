Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FAE60E526
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234639AbiJZQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiJZQAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 12:00:20 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315761837B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:00:09 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so42338466edj.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 09:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=QoQAODsoTnYOvxUDi5YXiPpnWxYm77u7pwY5za0I9yQxKCIcqUQ9ABqGWzMrBvZ1Xl
         zy8fTb7bFjbHyozBsXcz+Imixt+aAd1YX0RqRDDsyuE9apCkDMkhUMhR7gMyWdgaUPCM
         jYmKoLCXCkPLH2bDy6nqEd/BvmbH1I5qlhwE4FV7r1htA7Tn8EP6JH8p9nk8njbJFkJ2
         SjGdPxSQwFHVxfVMLYuOpxTp1/qHKEivfc5LT0Gn3W9B9zBBup0eKRwAonNIov8gfk5W
         A0DKSSFGBeWnix64IHao2YiH1NpKjnevFt/BE8W7pZZAdsqPz61FHsep2Mz8VFfDfVds
         hwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=kuGGQmGIXhuH8DL5BcxKFVNFuAFrm87M83z333TvOTAfGHqGNVergHfxlXL6ru92z4
         TJRAZyLx1yHlPcb2IS/KB7dhbR4yAdLUhjhl/eK+aCtQQk41I2ZCnv5/3tDlcgyNm8H6
         VnJnyLfnSdwY9FSniP2MchvoRYtaopATEpSFzk40Gmts/Hg/Bnf8ElkIKXq8QcFnu7G6
         gcT7OM2Gn1hCs+bagE0JrPxfmk6UWPUhbpbHVgnclhEIsdUTxrUEi6JqG81g1YCLUcTs
         bOlsUxosR31BthQfbGMPBsNTfS2Q05JOFSPzA4ZbF405oxsjffmNVMinAb11a9R2JOqq
         X0JQ==
X-Gm-Message-State: ACrzQf3lml6t2qUVPQX0ICf91Gp6IOgmgusTuGlU+N4P4agOf8a7z0VC
        ssJIb9eCK6FVrEzhqaCx0cAfhXw1DVskDJqcewQ=
X-Google-Smtp-Source: AMsMyM6bpVreqzB6hkaiuBQWVpHXs7MHK4t7lP1dhCVrR3UK/X0YE7pIgrra90vGB0YUUFcCWN8Yt6hy3KfWXcfeQJ4=
X-Received: by 2002:a05:6402:3806:b0:450:bad8:8cd5 with SMTP id
 es6-20020a056402380600b00450bad88cd5mr42789912edb.305.1666800007692; Wed, 26
 Oct 2022 09:00:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a50:3a44:0:b0:1df:c710:8442 with HTTP; Wed, 26 Oct 2022
 09:00:07 -0700 (PDT)
Reply-To: tatianaarthur72@gmail.com
From:   "Mrs.Tatiana Arthur" <anitadeerow2@gmail.com>
Date:   Wed, 26 Oct 2022 18:00:07 +0200
Message-ID: <CAL-fvu6_=c0WqF8k4xvOY2g4YLUbVo74jnLoZvjoL0zJmWNHUw@mail.gmail.com>
Subject: Did you receive the email I sent you?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:535 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4706]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anitadeerow2[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anitadeerow2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tatianaarthur72[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


