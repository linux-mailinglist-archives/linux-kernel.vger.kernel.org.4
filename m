Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D85F5F8607
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiJHQSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiJHQSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:18:00 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E424198E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 09:18:00 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l127so7722851vsc.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 09:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EY4qOPHf7RYg8ix6/iJMuNMtc57OSN/VOcyt7Dw0D/k=;
        b=EK39j1vC3L3tQzP1OqhXnAQx4jR4xtJ2ma13bzhukaklHG2eYCCVxipg0CQAZdnuio
         jSklCUigE/WvuKGZ04HhGlr/esPZBUEoaeil0Evfd4lJQ9QKXQ1MErMM1XNojEhzGOmK
         +y+FARfnC4Zf9DsTchrMJhlC7zZVoVHWfrv1mBz0kbBzApRQ6o1T5j7BUhi7BkN2WLM1
         yBpZjn0tye2w0wozgLJ8UVTl/iY8D+hqswdayh6TDuWKFD1G8Xot5KCzMne8uNwlWeEi
         +vpx4qSeZJEHYEeQkU1FJtZIFaKidfydCKfwcdQGGeQl3qgnSomgTdII81RbEplUWqnk
         hjPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EY4qOPHf7RYg8ix6/iJMuNMtc57OSN/VOcyt7Dw0D/k=;
        b=OswPJGHuA6XkczM3zCBhE80MzIDgNrfLwPmQtYFxY+3E7cgMCKTQi/iEFprERHL7tk
         MbR6junorN/sHOXgJ/SGLl/y8Raar3zRl3N4KA4/dmnNoATVZaGOvm1sTNXI+ZTUvex7
         Yupg0khPipmelrYFe+rDMx+Y2KfcL2ZRHdMakhqH3cIQ+JimLm+tXmpwt5XT+Z/6Tar2
         8W1tKqJiHU5quu4k99tLcuZ62Iq11ahfgnOI3QP9EsGXHxjt4vA41fcAhYpism1QAslK
         cKgPHuTG1axUyIIRLuODqhMGX48YyRHryKr3GozPUihtdVWB2EZcd4G6mVCQfg9H2MIa
         dwbg==
X-Gm-Message-State: ACrzQf3cgaUuF1Wdh8TPCHuOSg02Dk76JcPMhF6QNC02Cs543S4NwjqB
        ygYMfN4BouH2UsGOBC7T7H8Dnl/6L4UgeIgboSk=
X-Google-Smtp-Source: AMsMyM5prAmiCjXlmDn0919vjVqoACxg4xsXb39On762h063Axxo/JIMYB1vFT0Oxnwp/kP1K37h6e9y8r5LQeWy/1E=
X-Received: by 2002:a05:6102:3ec7:b0:356:cbdf:122d with SMTP id
 n7-20020a0561023ec700b00356cbdf122dmr5154827vsv.9.1665245879340; Sat, 08 Oct
 2022 09:17:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6124:2415:b0:31e:b5b0:9dcf with HTTP; Sat, 8 Oct 2022
 09:17:58 -0700 (PDT)
Reply-To: financialdepartment094@gmail.com
From:   "Financial Department U.S" <meekwilson77@gmail.com>
Date:   Sat, 8 Oct 2022 17:17:58 +0100
Message-ID: <CAEBQFkfsotdKDDOhSor0FjJ9nEQnH1AMhGZB5dc7Oh9WWnjskQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [financialdepartment094[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [meekwilson77[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [meekwilson77[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Dear friend,

I have an important just get back for more details .

Sincerely,

Mr Jones Moore

Deputy department of the tresury

United States.
