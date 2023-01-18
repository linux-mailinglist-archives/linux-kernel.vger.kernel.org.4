Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3216D671FC8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjAROiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjAROho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:37:44 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0DC5F3B1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:27:00 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4a2f8ad29d5so469100467b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=og2L6w+kQvl9Uq+vwJYWeiDKVWceTRJ73B01AM6s06zqdNoDBjcKiaEsSU81dJ2CSO
         XifyV/n4gT4JP5UxwwmudR7yp+oTWUKC4Xywiw7l7ikzR1onRcLxQcZUw2FEve33hWnm
         R719jbxQNdJwCc7Bsf+pH0XeysRdtYdJbqJIpOEAvHQXIX9Aa+q7G2+mY+i/k30DfpOp
         Rn+id8BC/3IAAjNk4gOksMrYUVZFhd3vjxnlgKNqzf4g+gJ5gtoUeg4ZPzH4UxGReNEe
         T72KKpMxU8HVFqBy78sPmoWpLqfiZwwcu7X8VczXldhilrrHd/J+NSNgFvZXyBpENXsS
         6QGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FocuR5aXn3z28LzYD0rCmA/t4By4lcIW0G986gs+i74=;
        b=LZYNt9h3CBZrl3F13iR1527vQLszPlEAolaa2MaeakMw2nUqPuLevT9tJg1fCoHj69
         xOHEDgXYH1e1ygICgHu81k7lfMYA5VO9/gX20ROQrNLDaUtrfXxQLPUMEJXHfIKvYE2p
         8y+QyA7J6pqXkYwHhCbp7JMH71qRO7oyMxxLayUuQMGGJwZxJ0Yj4mFaGf53h83bD4LB
         /jXJpu6YS8I0LtKWyxTXxfVD5vgITcifWhrusccQ4jmBdQVe6F5Se2LSu3ALSomN40cS
         QOq/YmJBeHehfWyZOR/p7G13Dkq7DiDIQb6Xe6olxytFdjm3L41THX0wxNvfihe4eVuv
         mrfA==
X-Gm-Message-State: AFqh2krqx5UmwDsJAyk+ssLzu/5wOMYKWH277+6X3+YO4l2xMFi4FdMo
        ApFhlfAbciR9+jairkDZq0vWKMREuk813T2eawc=
X-Google-Smtp-Source: AMrXdXvM2LE64rFtZMd2FFaTRU1ensJ9NXika8xYnRZOc94RlQjhw5f0khyIV+6nbt1XoVlkBsU6AijRdgBLMH40KKg=
X-Received: by 2002:a0d:ebc7:0:b0:4a2:6e4:ca84 with SMTP id
 u190-20020a0debc7000000b004a206e4ca84mr980514ywe.270.1674052019757; Wed, 18
 Jan 2023 06:26:59 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:180c:b0:322:5ce:f8c2 with HTTP; Wed, 18 Jan 2023
 06:26:59 -0800 (PST)
Reply-To: khalil588577@gmail.com
From:   Abdul Latif <anthoniushermanus1966@gmail.com>
Date:   Wed, 18 Jan 2023 14:26:59 +0000
Message-ID: <CACiMciZFmFdYf4NDyLwhF6yG51m3qhRGvUfMMbxevfTZcJ=PfA@mail.gmail.com>
Subject: GET BACK TO ME
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [anthoniushermanus1966[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [anthoniushermanus1966[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [khalil588577[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am Mr.Abdul Latif i have something to discuss with you
