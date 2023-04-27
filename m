Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4B66F044E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 12:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243575AbjD0KlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 06:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243094AbjD0KlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 06:41:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DAEFF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:41:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f00d41df22so3050295e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 03:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682592074; x=1685184074;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cHhTd4WQ5jW3liGbje3krk/dFm+1ccLit5tZIHiKpw8=;
        b=X910xCax/ukpQVc/c+0G6R/a9qPGPBxODJ4Ygzoz4IUrPOT92JPtUZZxWDr4J8y156
         /asqnA+RdWLbsqUgTmzyHPO1IkUi1P36uYi1JwLOP83EoGgPrjgKxgYBx9MVkyza5djc
         MUU+5yECYifqXyRUEKYygZwHSdXs8aTKRyei1Qbjic6ESLjZA7md0VtFN5E43XwZl1EP
         9zoX11TrtOwOzHf5L7amr4I4egrJ/pLXD4rsdQBJmqkVvKedxi7lTvVCTD+KpNqLUFxM
         ZPbjNPbefWZzMZPyFP8/tqLs1mgUNR4Xg27HsJ3HFgSFHutQWfo5uo12H+pooAI7vXII
         qwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682592074; x=1685184074;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHhTd4WQ5jW3liGbje3krk/dFm+1ccLit5tZIHiKpw8=;
        b=IOz+61F+WZJnEep8rmHR0TxkiW/Pl5wi5X2Ft4fW6AfVLBKGYEim2hDXai343c//Ue
         vprOoWs4Es2x60duSNk5ixsbWJ1cbMFnsK8xPw/SsvNjHGkMSJhH47Zo8CdMvkhXBLUx
         avAjYkMUwsQpG+TsIo92n/0xezIJK1dbiUrqk3y6amtXdgJIa794m3Y98SCa1wovcJtx
         IzjB+c1AguHjlOV9K3PlAOWu4W9nDlOCh0hsHJE7MIGijXB/I88swRzooNHwA3mqDKLJ
         kInZknnzWN9Il7HXFmjoxB7bPpBH1NBEVDq7gYl5A/asBkrbADl3IScDGMzA8FiJ31E6
         NqBQ==
X-Gm-Message-State: AC+VfDz4w63APw+lRVOEhu/hDQwB1bsnP3doouaZqsJ6paEXs14sN95F
        FJ3D/0ydNduejhoiQxOg2PdFnANywd7ot6bQ6/A=
X-Google-Smtp-Source: ACHHUZ5n+YDK/JayLtjfLvShgQpAvr74HJWvrzl5Us1xdR0QMWfnJ5YvdCCJkFjcnCzzL9vPXT/2kFOe6NjHv2opq1Q=
X-Received: by 2002:a05:6512:3e0f:b0:4e8:5c66:e01e with SMTP id
 i15-20020a0565123e0f00b004e85c66e01emr1654737lfv.21.1682592073575; Thu, 27
 Apr 2023 03:41:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:34a:b0:25f:d371:2806 with HTTP; Thu, 27 Apr 2023
 03:41:13 -0700 (PDT)
Reply-To: mr.alabbashadi@gmail.com
From:   MR ABBAS HADI <mrs.annabruun071@gmail.com>
Date:   Thu, 27 Apr 2023 03:41:13 -0700
Message-ID: <CAEEmtG4pKjFCKOrq9k=cQX-XVouDWOke2pcfkHOMJMCY+iynKg@mail.gmail.com>
Subject: WITH ALL DUE RESPECT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:129 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4928]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.annabruun071[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.annabruun071[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Good Day,

I am Mr. Abbas Hadi, the manager with BOA i contact you for a deal
relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr. Abbas Hadi
