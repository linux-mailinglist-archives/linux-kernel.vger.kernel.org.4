Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26DC6B0B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjCHObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjCHObQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:31:16 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C515C8090
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:31:05 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x3so66439658edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 06:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678285863;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1GASPKoO+e28mJsssh+sY4z5RAj0iPshrV7WaXjS/o0=;
        b=aoHbvW52RSVqzZQGOWRZtqYgG2FUtfYW+2htUSTTUCSv/V3ESPj+X5QHFGJ2mI4eE2
         yAGC8MvskQdnoMBKMHO/7hwkV/1VeXuJHEzwnFB5EZs2aPlhjIXMtI197LtKi+vAZHmG
         kfIDMbZx/tpbNlghynKLKBE3zZ0yANiW3YhPBHOJ5v81EhmVyQIRqyj/UngmaDOUWNmP
         U8md3vNC7paxN70GU1Jd+9MEDTXOkjv/I0Tsq1/vG7oeaEBF7TSSkH9IUEb1yXutftEU
         WgaRty8BBIetyj5L70ODOOM8I61VeOtOP469PaDpCXqXu9qO6Y7wEkZa6x6kueLc7s7o
         HaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678285863;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1GASPKoO+e28mJsssh+sY4z5RAj0iPshrV7WaXjS/o0=;
        b=AA/Qlw9/FnMpXd5aqg4ty/xjMZ27VSJ7JawezwOhYQjNJdRhSxGV/x2ysJa+tIGO9Q
         mz1H96HgWv7sbdDrzEKOq6b1NSbmgPI2z7VHa7Xd+YR+atmfb9pMD0cPnKXTv/5anTDj
         UZl09wec73+6Quexm7VPGcwf/SwF9kMxXyDm2xhSHPs7MTxtPgWCsYenSfhfTJN4wXwI
         CAk05UEsmLkrG8NGmQvjuk3B6aI6zBkdyxOu3Gkr3Auodj1xYCAzp1JU1IVAysKnH9OG
         wIWEqzt+GGy4rqDJ7/hW6iP2mq8+PppmrgqRBwtce0toqoVThhYpSLcb3TbGKLM5pq3T
         Blyw==
X-Gm-Message-State: AO0yUKUnn+RTIjH2DgdBMWHUEjp9/MvalC2+/lf5qymBPNeAtxT8BYbL
        5cRc42IWYB5IBOakt99l9fWqNgV2t0z74NOUmpA=
X-Google-Smtp-Source: AK7set8+ZMtCvOtpVjTQ74cyDX4LxBNUb6xx0q5HojwWg9bvF2wvim1AuYfZXfBZI486UbxeGcPrHCIap+0QmhsNyeo=
X-Received: by 2002:a50:d60d:0:b0:4bc:edde:14ff with SMTP id
 x13-20020a50d60d000000b004bcedde14ffmr9766773edi.0.1678285863314; Wed, 08 Mar
 2023 06:31:03 -0800 (PST)
MIME-Version: 1.0
Sender: robsonplazabf@gmail.com
Received: by 2002:a05:6402:d5e:b0:4ec:747:92c1 with HTTP; Wed, 8 Mar 2023
 06:31:02 -0800 (PST)
From:   "Mrs. Orgil Baatar" <mrs.orgilbaatar21@gmail.com>
Date:   Wed, 8 Mar 2023 15:31:02 +0100
X-Google-Sender-Auth: z9Mg4rFZ56GRxHFG67r8us5HpP0
Message-ID: <CAHO9RK_0RW8xnxy3dtkCFKq2k16skY=iMWpfqnvP2mLJQ6gm=g@mail.gmail.com>
Subject: =?UTF-8?B?5rOo5oSP77ya5Y+X55uK5Lq644CC?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_99,BAYES_999,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5bCK5pWs55qE5YWI55SfL+Wls+Wjq++8jA0KDQrlm57lpI3vvJrogZTlkIjlm73oib7mu4vnl4Xl
kozmhI/or4borqHliJLjgIIg6KKr6aqX55qE5Y+X5a6z6ICF5pSv5LuYIDIsNTAwLDAwMC4wMCDn
vo7lhYPnmoTotZTlgb/ph5HvvIjlj4LogIPlj7fvvJrku6PnoIHvvJo2MzYzODM277yJDQoNCuiw
qOaPkOivt+aCqOazqOaEj++8jOmatuWxnuS6juWkluWbvei1hOS6p+aOp+WItuWKnuWFrOWupCAo
T0ZBQykNCueahOS4lueVjOmTtuihjOW3suWvueacieWFs+WbveWutueahOaUv+W6nOWunuaWveWI
tuijge+8jOS7pei1lOWBv+iviOmql+WPl+Wus+iAhe+8jOWMheaLrOmCo+S6m+WcqOasp+a0suWb
oOS4jeaIkOWKn+eahOWQiOWQjOWSjOS6pOaYk+iAjOiSmeWPl+aNn+WkseeahOS6uu+8jCDpnZ7m
tLLlkozkuprmtLLlm73lrrbjgIINCuavj+WQjeWPl+Wus+iAheWwhuiOt+W+lyAyNTAg5LiH576O
5YWD55qE6LWU5YG/77yM5Lul56Gu5L+d5q2j5LmJ5b6X5Yiw5Ly45byg44CCDQoNCuS4gOS6m+as
p+a0suOAgemdnua0suWSjOS6mua0suWbveWutuS7peWPiuS4lueVjOWQhOWcsOaMgee7reWtmOWc
qOeahOWkp+mHj+iviOmql+aKpeWRiuacieW/heimgei/meagt+WBmuOAgiDmnInmiqXpgZPnp7Dv
vIzlj5flrrPogIXlt7LlkJHor4jpqpfogIXmjZ/lpLHkuobmlbDljYHkur/nvo7lhYPjgIINCg0K
5L2G5piv77yM5oKo55qE6K+m57uG5L+h5oGv5piv5LuO5pyA6L+R6KKr5Zu96ZmF5YiR6K2m57uE
57uH44CB6IGU6YKm6LCD5p+l5bGA5ZKM5b2T5Zyw5a6J5YWo6YOo6Zeo57uE5oiQ55qE6IGU5ZCI
5a6J5YWo5Lq65ZGY6YCu5o2V55qE5LiA5ZCN6aqX5a2Q6YKj6YeM6I635b6X55qE44CCDQrogofk
uovogIXmib/orqTov5jmnInlhbbku5blkIzkvJnkvZzmoYjvvIzlronlhajkurrlkZjmraPlnKjo
v73ouKrku5bku6zvvIzlj6/og73kvJrpgK7mjZXku5bku6zjgIIg5Zug5q2k77yM5Zyo5q2k5bu6
6K6u5oKo5a+56L+Z5Lqb5L+h5oGv5L+d5a+G77yM55u05Yiw5bCG5omA5pyJ6aqX5a2Q6YO96YCu
5o2V44CCDQoNCuWwhuaCqOeahOS7mOasvuWPt+eggei9rOWPkeWIsOS4i+mdoueahOmTtuihjOeU
teWtkOmCruS7tuW4kOaItw0KDQrmgqjnmoTku5jmrL7lj4LogIPlj7cgLSA2MzYzODM277yMDQrl
r4bnoIHlj7fvvJowMDY3ODbvvIwNCuS4quS6uuWvhuegge+8mjE3ODcNCuaCqOeahOWllueKtuS7
mOasvue8luWPt++8mjA1ODcy77yMDQrlj5HooYznvJblj7fvvJoxMTM077ybDQrmmpflj7fvvJpU
QktUQTI4DQoNCumHjeaWsOehruiupO+8mw0K5L2g55qE5ZCN5a2X77yaIHwNCuWcsOWdgO+8miB8
DQrmiYvmnLrvvJogfA0K5Lyg55yf77yaIHwNCuaVsOmHj++8miB8DQoNCumcgOimgeaCqOeahOWN
s+aXtuWbnuWkjSBVQkEg6ZO26KGMDQrogZTns7vkurrvvJpNcnMgUkFQQUVMIEdPRFdJTiDlm73p
mYXpg6jkuLvku7sNCuWuoeiuoeWNleS9jUFUTeaUr+S7mOS4reW/g++8jA0K55S15a2Q6YKu5Lu2
77yadW5pdGVkYmFua29mLWFtZXJpY2FAZmluYW5jaWVyLmNvbQ0K55S16K+d77yaKzEoNTE4KTQx
NDgwMDQNCg0K6Zeu5YCZ44CCDQrlpaXlkInlsJTCt+W3tOeJueWkq+S6ug0K
