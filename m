Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD6466112C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 19:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjAGSun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 13:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjAGSu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 13:50:29 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6261BF4B
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 10:50:28 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id i26-20020a9d68da000000b00672301a1664so2796220oto.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 10:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeoiu/rvKJmM+gclUENAQts555FtGpZl2d/oUTAo0Hs=;
        b=lLjJptxHkLHU03VfZEvKDnUxpOaexhPt8TdtwLMTEByKHc3rnHx8QvEyq3qd7zJobr
         f60AIVjb4bU+RdFYwOm2NjjjyMEfFkbiPkZvQ3u/wOtFDTak9y2r9WA3/ls/+VM+oCab
         iTPSZV+CKEQx9wmNmf+APqwDFwjee12KpVSmrYc7PDEwxcQypDiTTrRoPYPpYBwcOld9
         PCJTHs7qoWDPR5T8/kcWZyw7QPSiExmdauK0FWjboWnLbFvyPxNFplCiijFsnjHbezb6
         s7tgDwhpaK7ixb2vvNYm/6gTQRnOEasSjp/N4+7hJHQOYpbbRFG79IGhbHI0+j5l9m5s
         sj1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeoiu/rvKJmM+gclUENAQts555FtGpZl2d/oUTAo0Hs=;
        b=iDlG/SFxWvWAJ7DIuIxM6VljlbG68mGZADMRuTf2DLzDjnlm83bdplZyrRMqod+pWu
         Rb/L4l0pfxTuPDPX+mL/4NXO0xtgH2wKRdHZGRmZfRftXYyO4Xi2k17c8IkJY09BYj5X
         3svkkcxdEt9LNzPjl/p8Xm3H28xCUDAHGRAqfy26D8f2dZY0cgOeGuf1Inn7wHAvf6ZD
         oWz8V8tTfzglhi8uAnTazEv2CdcynOGNtrEm5FYlp0EMwDP92wZBAhRL657gyy1eyrTr
         oJDkfjDeh0GDqcJZsAjL8+9Q3aMhaHx3g3zMe17SaJvIx7n1mVmUuYRDdYPzOR5ftE7F
         sXWg==
X-Gm-Message-State: AFqh2krisuILOCq4bql5leVs1fqfRhpD3r84drmmNLv8KbdvqDmr0KQf
        rHAU4z4T/AY5n2pyPOuyfgcM5AZziRyKgPpGRGQ=
X-Google-Smtp-Source: AMrXdXvdA0xDAw1wuxsHgixJHUHThQ0BfDCT8GoqgImpEUNI5xY08hElWmlrzJvxaGyDz2HOKrRt6wKT8JHY6V8u+Oo=
X-Received: by 2002:a05:6830:1313:b0:675:b95e:9e44 with SMTP id
 p19-20020a056830131300b00675b95e9e44mr3272045otq.266.1673117427965; Sat, 07
 Jan 2023 10:50:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:7f1e:b0:ea:ee42:8dc with HTTP; Sat, 7 Jan 2023
 10:50:27 -0800 (PST)
Reply-To: lisaarobet@gmail.com
From:   Lisa <fllrptr@gmail.com>
Date:   Sat, 7 Jan 2023 18:50:27 +0000
Message-ID: <CAMxufqidhGF26E2pvQPq5jjV3pqfUWpchrAZ7gdBTYoZgMofpA@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:330 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5218]
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  0.0 HK_RANDOM_ENVFROM Envelope sender username looks random
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fllrptr[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello Dear

How are you doing today?

please tell me did you receive my previous mail,
Waiting
