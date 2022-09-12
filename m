Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3E35B57A5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiILJzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiILJyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:54:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62751371A5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:54:13 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127f5411b9cso21929179fac.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=DsakfoHHvjkCzFmrXswEp7xEl2vlHecZUQLc4AeBee9qTkBuz7JW8GjUYBFDygDbGg
         SJZHfs8zhC0TDbr2MxYaLmmCAM8gMVQX08/4bDTXEomnCckKoAoOgb2EcXSVSXcte7IZ
         WtK4534RRAq1I5IjbGN/Gh5tOUG75wqToFeWl2IK1oVF0+T5Hu2L7JUAapRNmnqmSyVW
         QBCU8MKDENYIJKLmAuQ6toOkEPUWP5qobeYB/20qwOeRvn6lE4+wZyAiQI+/OQIjxbCd
         4UnV7QW/AEISrqn30CmubVJAN+HEyQtiin+kjotgbNH8iHcB3iiK0CkBfyIt9gZPL18t
         qstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ddKdS4x8c4ZSI9PbKdla4xMHlbecpUYnHnf7KqPY/v4=;
        b=tLO4ctpJdyNwlwsrfKcqJP97Wc+Ap96oc4usEtRwYaXlIXW/Zf3rmrCuwhkhYbA4l/
         Hc1oxuj2pqm8B1yQcUooFCfunDJRfbwd/TLQobmx7kmHm00/IVjLnDqCrfBzntuuEPvO
         YmoM9mTXc6CBTL4+0SWNF4FK8E4xpeSyFaDjx0W2QozIIhnlAu1KkTRuq2DiOEFcxgyz
         gY5SPhyUMp2iLMKmcDqyjldDRmdcB5YeL1UvtLKUjMqrQ41y/NYkcIbnySVZM1nPqTs5
         Ni/WWymQYz0y+EkyjBOgNo3WpMEFZ4esdgIQstcOdyi5OY8OJxNYOyd08DBp1MwPEAfX
         Wung==
X-Gm-Message-State: ACgBeo2R/c6f6ggx+6vIf4QTJ2igLEZ4aXliBK6Bp9DsvtgBACzDrMPw
        qmV3QOzo3GcW6NTe1WEjMeZJIwCCpcUsOc9/LUE=
X-Google-Smtp-Source: AA6agR7+m1HbyJV4ki1kjoSYA9QLm/LD8votEjFZJy78nGw4Ac59Z8KvjYPBj2+/ehEfbiiwDxabrSq63WSPY5/IieE=
X-Received: by 2002:a05:6808:1717:b0:334:9342:63f1 with SMTP id
 bc23-20020a056808171700b00334934263f1mr9115886oib.77.1662976452752; Mon, 12
 Sep 2022 02:54:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:52c7:b0:b3:4dd7:8c58 with HTTP; Mon, 12 Sep 2022
 02:54:12 -0700 (PDT)
Reply-To: sb9174937@gmail.com
From:   Susan Bikram <redw07882@gmail.com>
Date:   Mon, 12 Sep 2022 02:54:12 -0700
Message-ID: <CAND8bMJQrg9BuUmu4gCqHhjEHneSZaQVVSsnky4nKhQiCbsMDw@mail.gmail.com>
Subject: Waiting to hear from you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:31 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [sb9174937[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [redw07882[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [redw07882[at]gmail.com]
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

Dear ,

Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.
Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Susan
