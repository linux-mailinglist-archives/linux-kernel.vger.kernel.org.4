Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED25E697E93
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 15:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjBOOnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 09:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjBOOnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 09:43:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2188714EAC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:43:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id lf10so16854055ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 06:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=BPWBtXLJU8/K7MnmuGYBd5YKImci4poEidjDnCvt+FOW4XJi/qcp9QRyzdnfeygsul
         gIukKDRLnE6tmLIjifpKRKkZokiZD1PgpZ8Ty/1OKC/9np+lVjScFCP0tYmEjbNGlUcv
         UWi082WR5mGL6+Eb+75RMs6htZ237jZkYzlnuZZHSZV4uNJMprbGgCA8M17Lo9635LCe
         FzwZCmFM3s1jvYAxATmgPdC1gIdCvCkQSJxzCmyIP8aaxpEG+qFHpgoemOQ63brtQ4pL
         ub5UhZbT7AUZ6ckPA9RD741mSfEN+RpLKwyN3EFUfMjXpiBy+qLKJsdufb343kJCEBM4
         T/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YxWgvIJdD6AE8Ce+eEDzrC0gSnd+arQ9utE5ORXuyI=;
        b=3cpBlpu0hmFE2k9CIJnRvHcINIRfjHyjyjPYJEpQNzMVTxD02a7dDW/NCbJtqCtU5K
         G+PPOGLdixqnsArD3UCeBcwPQlGoRCrxEf9oFvwNfZsKt5RODNS3UeIGOtjnqPAE6B8S
         uHuSrpv3GGewxtG1SnlxglQ+4/WvDjTaazQoiIatBh2je+AxmjdRFX+oD2fk/GxPIDnF
         viHgWSVOOwRrB2rXkruV8AH86qPru9802iXbEATSQ5KZMieFi+VS7JHTECd5EbEobYjU
         cCK9t1mbAASrbxP27epeuOoliKLixYdLvcRh0Yko7dRAq2Jjn5oQHtJ04mX4gfiHHXn5
         092g==
X-Gm-Message-State: AO0yUKVrhQsRz9QewCgtlgwHhMaz+LvOokJqtZPP5y5aa5AS4wYRXacU
        VWMSTYdvmHDoNvBHb0aH1vk41AQfq/OnGqArG9k=
X-Google-Smtp-Source: AK7set9BTU8HGLG4e06U8lzvrrvnC0DEnwi/7m5YqqcYSVkVM0mbFr9e6c7MemyIhyvbiLql/HrcJ+9Xm6mPoF84bW4=
X-Received: by 2002:a17:907:7ba3:b0:88d:ba79:4317 with SMTP id
 ne35-20020a1709077ba300b0088dba794317mr2110221ejc.7.1676472182609; Wed, 15
 Feb 2023 06:43:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:2296:b0:4ac:e0fc:e43f with HTTP; Wed, 15 Feb 2023
 06:43:02 -0800 (PST)
Reply-To: elvismorgan261@gmail.com
From:   Elvis Morgan <jeoheo92@gmail.com>
Date:   Wed, 15 Feb 2023 14:43:02 +0000
Message-ID: <CAES27SHxgiKRw5=AmYYR=i-Obb7hCBWZH7RqmP6CAWykXcSGSw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:634 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elvismorgan261[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jeoheo92[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jeoheo92[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
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

-- 
How are you?
