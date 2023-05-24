Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3EF70F590
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 13:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjEXLqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 07:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEXLq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 07:46:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FBE13E
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:46:23 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af2db78b38so11261291fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 04:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684928781; x=1687520781;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PlIvlh/Wu/Gdl3bc/cwkv0nvaIs0VGs7tRG/WiHzhks=;
        b=gONwD/1DyEEl84bjbyW6hkwGonZs3RmtQn+9j8r/qZuO1brd0cBDaW3zzOwqNPl1jd
         FXewDz4jcUdKK3hOV0KKWXyI3cHWdAHcIJ0YO2abpiIxhvzFkEs86ATSqdDAs7x2LDCt
         71kYE+LmTlfvujzroBe2Ms4seRjadOTVHIi1rBQRTb5ACOvA6BIvHl3sLU4OiHMbUn7j
         SlxxC2DN/NHYt08DyO2aOjqROyR4p/GYFeKjOXaOzLCqofLasvY/eGgTV92WsiVMmw/X
         NwJ/FNo0Qsc/NOUlVxwnSIr55LPfMAeOg3uodlSZy1yXthT/zT6fU98lHvrWWkgSQfqy
         X5IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684928781; x=1687520781;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PlIvlh/Wu/Gdl3bc/cwkv0nvaIs0VGs7tRG/WiHzhks=;
        b=a83SoCwN1/0dwbn4jlgLXEDADiuMgDUnbrqPzeK2pL7yh8a7Q0Y0ZkFMhVFLHz7HZW
         /NA7TbrtspY7Bb/RRDt+pP3cKq3Loo5QV63+UKbKz0dkTt95f66D9KWJzE96vDjVQonI
         iBzw4Q9mZKPXAmtc1lYDvJBUizT6LvhYPN8ioIxc0W3seFoKW5qVu2Wr7G6YWq+1+Ew2
         2UXaMRA2vKk5yFXuLEOT7IxOGbfgmw80ME5rl7l31KIe2705ZASP8YoWPrUXkrkUv2TE
         b1CqIkdUqF7PvuFaU9hw4x9vGZtO6aAh90KpSyp/alrFcVRc9CH2sDbNV4LsWp7SkcaD
         ddhg==
X-Gm-Message-State: AC+VfDz01858hAZmAz5jceBWqJh6Li7qXhuXCZO7E5gEXqciVIGqShsH
        0A9AbWWfSa8YtliwsxnDm5fsDbdsK72khy23ZtE=
X-Google-Smtp-Source: ACHHUZ7PiqkEhrB9yPq5e+rs4Oi8EaXqIseWEM2LB42j7UALs4PDsHWJJ3x+dMtQQGshX4V1HB+B5PpF0jkXTS/sGP0=
X-Received: by 2002:a2e:8601:0:b0:2a8:c858:fb9 with SMTP id
 a1-20020a2e8601000000b002a8c8580fb9mr6355970lji.29.1684928781297; Wed, 24 May
 2023 04:46:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6520:3426:b0:263:eea5:5111 with HTTP; Wed, 24 May 2023
 04:46:20 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   wormer Amos <rolsbaraye@gmail.com>
Date:   Wed, 24 May 2023 12:46:20 +0100
Message-ID: <CAGkCXQibP29iMue_tpjESM4v0_dfLORr3r+gF6tV_JTnSs1ECw@mail.gmail.com>
Subject: GOOD MORNING.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:232 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rolsbaraye[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear. i just wanted to know if you're capable for handling investment
project in
your country because i
need a serious business partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this same email?

Thanks and awaiting for your quick response,

Wormer?
