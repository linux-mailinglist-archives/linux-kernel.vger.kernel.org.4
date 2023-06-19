Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CF73581B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjFSNLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 09:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjFSNLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 09:11:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB339AA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:11:45 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 5b1f17b1804b1-3f90ab8e841so3764415e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687180304; x=1689772304;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=D8EYqLMjhoOvhNXxrkPLTjlTxNflKweygAd7DnCi6RxxQ9jBvZNertsF4/hFrSGr8f
         cnl69NeZx8WBVYXVon0g9r3CfM33FXbbkimukMLExFEX+zygQD/8amqlC9tUC3Gj3+EB
         GTWjKjztsfWs19KpeEKrtz71/vPZTlkGHkFgxqO4YgkeykuCAUQfidk5zBN0s5g/gqEB
         uD7dgF0PKkc+kedpnXaF1QWrRhaD0PHVXJn/8bl7f07nj+ReKaksTpT3LER4UMgsN/TR
         PW8dV8KcmKotnsLijnfD075SIk5l9wGHgjYPkrZiTYcONZZ43mBJnl0FB4bvkI7yD1d9
         4yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687180304; x=1689772304;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Bo3YKfRSKbn/wlVKv1VyVk+/ArZ+bnYO5hthJLAatZufh3t5tqMjlBxiDJmJK0+O3f
         EdohoAjxEyxVt4rgLoBt2auVldYSB4n99Z6TS/Rv7PrWpX02D2f46ljyHGMWxBNSAfLh
         +kDPgnqtGEIT40yg+2rt0tqq1cLU32T/pQtBntNjeaNKXFMuVz1M9fG6QtuOGHrzbMyK
         qQy+Z38/8hd+5vjzCgkwID1Q21l0KdPWiYD7fFyonZ1BVlsilgVShrY2y5xw8vw53uy4
         zbbc7xYdrFAO/ivQaHkwDBk8MO8EieOTzLs2C53RbtXMGtE+ZzBIRaEY6vOfQqvZind2
         EKuw==
X-Gm-Message-State: AC+VfDzVi6tlTwwVuRhJpc0lVHtkLJv1qilFlgngZ+IuNFfKqAJ70cab
        otZ+R4V3AV7fxAHKe29uaP8bFOhD7BYrFeNUGNE=
X-Google-Smtp-Source: ACHHUZ758V+hBJaPVBOqTXKZrkmX6DZ+F5MNaKRnhq91i6hMBDf8VzlOcX14KZxZZDoGY357Zfb+6QUKCZU1vcyMtPs=
X-Received: by 2002:a5d:4811:0:b0:305:ed26:856e with SMTP id
 l17-20020a5d4811000000b00305ed26856emr6967619wrq.4.1687180303946; Mon, 19 Jun
 2023 06:11:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:ecc1:0:b0:30a:edba:b4f2 with HTTP; Mon, 19 Jun 2023
 06:11:43 -0700 (PDT)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <hku222173@gmail.com>
Date:   Mon, 19 Jun 2023 06:11:43 -0700
Message-ID: <CAKZmc+9KTN_-OOA6Gyk2SOuOtN8E_CcsJv5CbAdN2mspiHOifw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:344 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4964]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [hku222173[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hku222173[at]gmail.com]
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
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
