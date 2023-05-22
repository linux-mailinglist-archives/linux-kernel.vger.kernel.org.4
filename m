Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C0D70C29D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjEVPio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjEVPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:38:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B28D2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:38:40 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-510bcd2d6b8so7534091a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684769919; x=1687361919;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GvVTeBSLO8lbk4EhvUhYlIKfYwORs/tPqNiAR+sY9ic=;
        b=M7nc3S1a2OT9rtDHQdgpv9i3pevnCLD9cvCV57UoLMIXB2zt0t6CheKEeEJQHt5L+O
         V/XVCnU0bNV+OpGDLAAq2H/xC4sGB8/ZgaZZFRuESJIK5WBSZSNS4yxWiijOTs1OU9xx
         pC6BS3i+Af9SwLiLP87HcSB5tMD25HVBHyg+x910Kuv6/g4XiRiHWFka2eOyKHGkvefi
         5all9uShlQrsonXBqnyKNOcvWsx2M0Of2KMOfs3i/R5qSNOMCzU2fy9yKHV8DJ1YKIFz
         uVyjjXauIpvSNdfug8p3rfg6rV5j6dLEyNvXFd8NXmQyF0AQfqxBDc/L62bvar9X+at1
         V8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684769919; x=1687361919;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvVTeBSLO8lbk4EhvUhYlIKfYwORs/tPqNiAR+sY9ic=;
        b=SYfuB/6G4QDLjKCh/64QbXmQA73uZkd4/aUYwGRNwC/wNfqcQRfO15VBsmuyfB4QNr
         elai4aoDVXUJcRuRxi2AJDx2fXvClb40aDMWVs1t1n0lg1HnimvBaQk9FOjrphh7B1zH
         nbYYZQ8N1Fx/FykeCw76o94JKHGf5J3egNn97jW0Z5K/7F1UYFq8FeKoiK5fGm+JsY7/
         fQT2i4KRbMd59onF5OUNW34elAOLtxLVsANZKyZVyOTCCxMNRFEvJq3YflzwHmrOPAdr
         mKIKwnU19rS0fcihEBUdyWW7gAn0/cZtbSJwlp+Fh7Vdou1bK2QnBJNxhH5zL+0h71PC
         l1RA==
X-Gm-Message-State: AC+VfDyzTZWt87DqbzIaQsCnwCUkC8Z/3vWD4fA+Y4MFkeu0hUpn8AGv
        ObxEaN1V050ZxKPMghUV32ib4Q3GrL4PHq7HV0Q=
X-Google-Smtp-Source: ACHHUZ7BHly9DdIzicag1VcspwZRtbd9axI/msoaE7K2WvB34EVEaH+f/Kt3KBcO2S2cbxaAMWyaHhQLaj47EutxeL0=
X-Received: by 2002:a05:6402:42c9:b0:506:c2e6:f69 with SMTP id
 i9-20020a05640242c900b00506c2e60f69mr18827887edc.6.1684769919015; Mon, 22 May
 2023 08:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:6718:b0:d2:e56c:f8dc with HTTP; Mon, 22 May 2023
 08:38:38 -0700 (PDT)
From:   "0671568055@orange.fr" <iwasakiyuji18@gmail.com>
Date:   Mon, 22 May 2023 15:38:38 +0000
Message-ID: <CAMW3LMyObdRKjMFGTkZTxXFouG7-USrLUcbCGfKeDHZ41Q1UtQ@mail.gmail.com>
Subject: Bernd Weber
To:     jeans luder <jeans_luder@pantiesparadise.de>,
        jepar <jepar@hush.com>, joanaxxx <joanaxxx@pantiesparadise.de>,
        kirsche <kirsche@pantiesparadise.de>,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_40,BODY_SINGLE_URI,
        BODY_SINGLE_WORD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_2_EMAILS_SHORT,
        PDS_FROM_2_EMAILS_SHRTNER,POSSIBLE_GMAIL_PHISHER,RCVD_IN_DNSWL_NONE,
        SCC_BODY_SINGLE_WORD,SCC_BODY_URI_ONLY,SHORT_SHORTNER,SPF_HELO_NONE,
        SPF_PASS,TVD_SPACE_RATIO,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52d listed in]
        [list.dnswl.org]
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.2275]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [iwasakiyuji18[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [iwasakiyuji18[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 TVD_SPACE_RATIO No description available.
        *  0.0 FROM_2_EMAILS_SHORT Short body and From looks like 2 different
        *      emails
        *  2.5 POSSIBLE_GMAIL_PHISHER Apparent phishing email sent from a
        *      gmail account
        *  1.2 SCC_BODY_URI_ONLY No description available.
        *  1.0 SHORT_SHORTNER Short body with little more than a link to a
        *      shortener
        *  1.2 PDS_FROM_2_EMAILS_SHRTNER From 2 emails short email with little
        *       more than a URI shortener
        *  0.0 SCC_BODY_SINGLE_WORD No description available.
        *  0.0 BODY_SINGLE_WORD Message body is only one word (no spaces)
        *  2.0 BODY_SINGLE_URI Message body is only a URI
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

https://bit.ly/3MItwsA
