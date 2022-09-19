Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A565BD4F1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 20:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiISSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiISSyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 14:54:31 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A03C1A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:54:28 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1278624b7c4so743103fac.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 11:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=w33pPDCD1aAOGDcHMeuqpnuOb/6wJdl4+wJdfUS6lPU=;
        b=dl5JCIDnAH0WNZPP7AXJKzEkpEjFNrQtVc0zpeo6JqFuO3PcCHm70ZEw4d1E64xR/O
         EbXrtumHFnU4aIhPLcHp1Uni08OQ8Een8oSNZdK55hwa0eZ3J0mqwZIsLok8EO2N0S86
         Cu68DbMNIy0sQKkV3uaBK4QLwyHUfamBySiSFHKLaOWsWjUSG1DrMlcgPAouXOJ0nAHZ
         8pTyICqox+ml2WU/ECUTnwWWawtro9N9Mh4WeEdVCXLsjr6a0bkBsy6QF1xei5T2NfCk
         ivrjIipNfpWdq6LT6f/b+xCMmL/0JIVjH0XYQaqPfWCofN06rCh7N1oV+o38xsudiwkL
         F1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=w33pPDCD1aAOGDcHMeuqpnuOb/6wJdl4+wJdfUS6lPU=;
        b=jevB4XohiazoCfBSPDmctiPnGBqZDolv1A29WgdgebCqNE7Jl49APUGPBydcqjyhKE
         YI0nvfu09Jqqs7RkhAzmXZsI+LGNLIc64brwVMoBHpN9bF56q3I3x64cGIlZy0sAXQ7A
         1ScpW9JQ9SDUAChYl1HMkiSgSDynxhTMnyyydxNq+p69oxwulB2S8m9ca9+i2uKuLpAZ
         mpKbLGqZc6RhV/mu2cSMaMmrJ7bLavmFqE6ZoMsfBf1AKduQhvqUw2Gt4NMrrDgIKduB
         QNpiBRh6yNv6CEChg308FdkN5qq9ihIddxFRhGod+QnX4vm7N0VgApBqAXU/JxTdIYJJ
         FPsA==
X-Gm-Message-State: ACgBeo0LReo25cfu3dP0tlQaSobMdt4EX+3EFYCwx1fHV0dSUwIzQViE
        fChox3a9Wbtz2TQpjIBAoZ/VnCz2uzDTp/nxVQM=
X-Google-Smtp-Source: AA6agR7RKrsWP0o80KqRPTxHM43wTN2OPHeWqW/uQRVcW/daJkFUt4Prn2gsm2qVzCxMFTDI1l3srE64RLAChO7YH/8=
X-Received: by 2002:a05:6870:96a9:b0:126:dbc4:76db with SMTP id
 o41-20020a05687096a900b00126dbc476dbmr16103967oaq.174.1663613667523; Mon, 19
 Sep 2022 11:54:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6808:209d:0:0:0:0 with HTTP; Mon, 19 Sep 2022 11:54:27
 -0700 (PDT)
Reply-To: pastordavidagentdhl311@gmail.com
From:   David Ekenna <janevivian878@gmail.com>
Date:   Mon, 19 Sep 2022 18:54:27 +0000
Message-ID: <CAGd23ZoEJAsq+QTgvFFn9D_5psy1-a_VRBPmsS71bV8hCb4vkQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [janevivian878[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [pastordavidagentdhl311[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [janevivian878[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friend , your funds are here , reply now for more details.

Thanks.
