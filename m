Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C849B5B5A49
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 14:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiILMlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 08:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 08:41:05 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80526240B8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:41:04 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id 134so4138078vkz.11
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 05:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=kVJLEvTQjCVtMF/qEALQM2zlZ9S2bfQcHYzqRRaNIdnhgili1IouMM+7RZQGmX3CAq
         +GEwZk64/zTPKOdnUsR9Z5c/GfbUgHgQAKilFBmfZbL83OBn0CGQdeb3hQfZfgSBu8p6
         SpaoT5YBN502DSHanF3pmQddbf2S8+55nmFniY76FzfaGiqhpQNFoS5svfWj5koA73Cj
         /6/YXqgzbawHk9s2UxNhV2Z2OrFhHeFiltwxx/pFXZIP/Kn3eQpyEbUpvqbLzT8Z6tLj
         jkj6KViVRdEOkBpT0Y9U0wVoBrFOCIliTCGP44n87C7LAn1Cr53isO6W+1RodWogh4B3
         dUVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=FcyQcUXi9xALQQ6Lm7VNXiWYStBjH/LCUTADg6v4m+k=;
        b=CoUPnGf+DTr47YYeXwLyqLvSPGsh1CXlJsxpk9taWOgkI9ga8GYmsnuIOv70HD0Ox9
         KomfEoI6PCg4qwCSuJlE/+utZ1TpaAsnxnZakw6nvHOKX4LBt/kcwKw0Uu0wg+WbJTDz
         xTXqGFuYpTd66CJQ8jWHvffuoWDD+LLVbyYbPRfw3CFapm7GMuJhtahSC36Zn93GauJj
         5on9MSlGS3rh5YA4ZRg+Xcs+BZDqPQq0cjO92I4HeGef8B+Ga/S6cL+6jWlXgkvwp3Y3
         PCZz2E5nXCrcJSdAclxQqazVttN0ZFeoae3XEhM8ShMudBUdIBAdxrI+eshyqQ16NGkx
         TGOw==
X-Gm-Message-State: ACgBeo3PU5MGmOHORYR4AjrugzwkXR/HIoYCNuSD7iHB5LBHHRG750o9
        A9SLZzwKoKSLJNFhCt04jmzpm527INY69JLkcQc=
X-Google-Smtp-Source: AA6agR5GJKlYuXs1QwstaoMneD069pul08zDc50/lf3ftdVjZVYfz9nuBw3tUuYF71np13MYPMCJAZ2hdf90ApoFAPs=
X-Received: by 2002:a1f:ab01:0:b0:37d:2a0b:b010 with SMTP id
 u1-20020a1fab01000000b0037d2a0bb010mr8251398vke.33.1662986462966; Mon, 12 Sep
 2022 05:41:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:1289:0:b0:2f5:88a6:bb8b with HTTP; Mon, 12 Sep 2022
 05:41:02 -0700 (PDT)
Reply-To: maryalbertt00045@gmail.com
From:   Mary Albert <leguezim@gmail.com>
Date:   Mon, 12 Sep 2022 13:41:02 +0100
Message-ID: <CAP8wXGsKqOpZkN=t9gW1RdckL1fFfucP_DRXg_BZMAHL3ktT0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4988]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maryalbertt00045[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:a2e listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [leguezim[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,
how are you?
