Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAC27377B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjFTXAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 19:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFTXAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 19:00:45 -0400
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1136A10F4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:00:44 -0700 (PDT)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-5704fce0f23so56389587b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687302043; x=1689894043;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=SWhuA+eO7ox/xipfbduhdW4ptjc2Cc6qL3OuXxuXNrfO2IDj1hMj0LsCnEnQ3TzoAr
         OrN1JdTtEBH8OutJk5C/geD5GAV/nSuve+s6dfo4vfRkGsKxaQzyodD7M2Yq80W4+AJf
         l3bCGhYNMoorqKeri+zGILcG5VgVJ96rbuoCfPZ66iZr22MlLSCkrCfF1i/+Fjg7uRGf
         709jbdV+MDbXTOadyr8QH+yVY1CkjejBHvHZuN/zMBo1x8BiAci86OgSzChj2cu46CV9
         P6qiK9wtxZivvuLyOKYkUGfyacywKTDan6ekop5CxTYUc97zWZ8qE851jJaVGBoxMRvk
         AaqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687302043; x=1689894043;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z2awcT+0JgCeSvbodyRK5wx8XefAu35aN26RnKecP3c=;
        b=EO5YimRvFsYhg4MBs60jcKR1WqnprFku2TGnNMOdk+oqWZGYLa440w/SmF+XCQ2ep8
         ea3iedK5b0lGCNR6CvuERpmKMB4BB4FqJRQULkSwYOjHQyqb8Wp727Iu33LBXfDwfD0D
         PwyfMjLpO1tWBng23BtyWV/H1uQP8uUdVbs7WJbZjHvI/SwyPBxtWKehh879NU5SKVJd
         xKY8s9GhQ3UyRQAhbklXTc7cuzymRx/p7ozZXj/4d64hIOxBweuH53trqQe0QlwIjE3x
         iKu5XCthgP+jfLckj0c2tHO7WaJ9tq52H9ErAOW7Mc8AwExnqBPh1dTmKm11/XGIpoxR
         UTIw==
X-Gm-Message-State: AC+VfDwc3rgQIxX0sVhKVY8ovCuTq3NSd9udJtGMvltBm4mYKFF3vq9z
        kZxjCwZ1JGJkhomRtqAmTrHy58WBuK0qN0Xr84Y=
X-Google-Smtp-Source: ACHHUZ5tAuANqT9Ad2Vrx4ircL3mrH+cAeibcYAkPxz0Ew/b7P85GVs2O7XTlqjGs8Tf1JliyMj4xNc23uXlGX35Eho=
X-Received: by 2002:a81:a144:0:b0:570:3b:a545 with SMTP id y65-20020a81a144000000b00570003ba545mr10236445ywg.51.1687302043234;
 Tue, 20 Jun 2023 16:00:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4e9f:b0:365:7d:4e01 with HTTP; Tue, 20 Jun 2023
 16:00:42 -0700 (PDT)
Reply-To: drlisawilliams53@gmail.com
From:   Dr Lisa Williams <williamsdrlisa@gmail.com>
Date:   Wed, 21 Jun 2023 00:00:42 +0100
Message-ID: <CAJbSCCQJdP6hx8vfcdToBN70rm4mRO7D6=jTR--EOHbByHvNFg@mail.gmail.com>
Subject: GOOD MORNING DEAR.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [drlisawilliams53[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [williamsdrlisa[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
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
Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
