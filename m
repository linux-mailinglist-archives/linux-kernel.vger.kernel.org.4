Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9ED7469EF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 08:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjGDGry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjGDGrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 02:47:49 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C90E42
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 23:47:20 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-40353537485so14713711cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 23:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688453238; x=1691045238;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n0u1N5dRwVcuYybSxNuNUChkJY+wKLb3Vnafjt5MuDA=;
        b=U7fd9Sgz/S4FhLZX/yynMlRiq+Nn/oP8dV9dqt/tTXz+T7G95R/mJdok2eb5eLo8y3
         8W2iXhkqtL3CVKsiPNXUban2/tjx1diEb+mhtXQRgGLdqCPq8HnfeDUu3PbmeI0lIpMZ
         I+nhcGRGiB0g9ZOLGR9kZLB3RvAi539dn9kqAR1+v+eyVhlZ/awLsyBWezvK179nA6iN
         N+ibIGX+3uSexbDGalovTZMeKwh/9FtDOxBZCBPzMt77OU2DuxDSXMy/38ZHI163RKzn
         HjAalMUXynN0WLRRQapjqu641m7Yx3f554CXJduc6Yiwcw49qCUqPBaFpTV6sJ1BfmTH
         w1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453238; x=1691045238;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n0u1N5dRwVcuYybSxNuNUChkJY+wKLb3Vnafjt5MuDA=;
        b=eUjZufqxI4uKTaXOcXy35sOWOaGQFMa3oCgpEIww5HoP2pDFP8wxUEFPNbZVU/zgKX
         3xux+FFmE4GQlStKZvWRv7tBXwnLkifVSiPEPfrpUu+Ufb82/xWsQxw6RM5oPbu8yGYi
         wSC+qCbMmolVtqwSUoz8APKHNr1Su40QN65fe45QMR4fYLxMfuhhJIRVh8e66OL1k7tm
         d9EbBU7+MKqpx/YqY/SP/ALnUzvf5pSLimln2X8xtG1xN/LnqRlr8WmEdYR8HoRXCDyk
         XfnrTdThir0L81nDwvt+1VUFnBli6tXMhCVB6FEwqmqb+XwigpvbMOKR7PBXzt7/QY8m
         BQIQ==
X-Gm-Message-State: ABy/qLYE6AyNU6pKqmcQfvL6nXgRDtVwu8nzJmNCiIfdlo10atwxUVNW
        cVP1L3AcD9deQMDtnESLMs4NuKED6WjycGt4kkU=
X-Google-Smtp-Source: APBJJlEQ3jXyCZxqcUsmY9fRCRVDX4HJRALICu6UrkFEhZE5ZqriuvjJWFlx6FbpDIBVmh2lO/j+2qtO7SNLyIiZ2Tc=
X-Received: by 2002:ac8:598e:0:b0:403:5e74:e81f with SMTP id
 e14-20020ac8598e000000b004035e74e81fmr4836794qte.0.1688453238228; Mon, 03 Jul
 2023 23:47:18 -0700 (PDT)
MIME-Version: 1.0
Reply-To: salkavar2@gmail.com
Sender: cminstervertho@gmail.com
Received: by 2002:ac8:58cb:0:b0:3fd:e5ca:ea24 with HTTP; Mon, 3 Jul 2023
 23:47:17 -0700 (PDT)
From:   "Mr. Sal Kavar" <salkavar2@gmail.com>
Date:   Mon, 3 Jul 2023 23:47:17 -0700
X-Google-Sender-Auth: mjY4ORkQ5TUcjKx91-ggUi_jenM
Message-ID: <CAAaoeD7s=ViM_2Qcm6Pdh7fSFyPJ8XT8wxHiJ7pLbEy03zfdJw@mail.gmail.com>
Subject: Yours Faithful,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MILLION_HUNDRED,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:830 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5085]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [salkavar2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [salkavar2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.9 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I assume you and your family are in good health.

Overdue and unclaimed sum of $15.5m, (Fifteen Million Five Hundred
Thousand Dollars Only) when the account holder suddenly passed on, he
left no beneficiary who would be entitled to the receipt of this fund.
For this reason.


Yours Faithful,
Mr.Sal Kavar.
