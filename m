Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3DAD69F34E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 12:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbjBVLOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 06:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjBVLO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 06:14:28 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67D6252A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:13:55 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f16so7341006ljq.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 03:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ/K0kowGbY6g3dbyCcscwj1fTfVd2AMEZkWTtT+UnQ=;
        b=I6FGzcHrKIfpVkE6j1KCBbRu0sB9jjTfQooeNhVVrdJ+rGe3Cy4dEzIAT86i7nQNFo
         Inodhk+2fYCdkRFv7lb0QkQWwgoXLc0fk24fEkk1+zX2Z0aURWj/oD/mnuF6wpUk3TYA
         O4M2u04fZx4HxWnpWUOdx1IFunspPzWSY+M7UlY1f4zz9INA7Ep5HAhsEBwu1FyMISdQ
         dBwLrSGSieoGvnB638HJ4MYmAdWPcwtTImlZAoLxKZwFduCFNv/bMOdlp1GS52a4IO1O
         alK3uIcl0SXXTwuKKuwuR+tpB8qF5yVQr6Y9JyuMRE87ugYVdqZxdeqXQN9T8FFhcUIA
         uqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ/K0kowGbY6g3dbyCcscwj1fTfVd2AMEZkWTtT+UnQ=;
        b=1W16bqX0CNrwfngCaMfIURT0vmfR92ySFD8VJCaqEH2UV7FU2jM8ldw+MtISqFWFyA
         uyFvUtkSObCHSwT3FtTVvHhL81LoRjejMzE6rs9EyIOA4pngCZmwVWNGe9firVasCqli
         RmoP1QjldZRNK7gH7IRcv1Nndkr6Ks0sgfbFAZB0fjT3DJh8BTZppPtvHYwaXNVsZZpw
         toDmygbHDf5AxyNdDMyraF179SwaAwWX1ox5dmUkYQnaVuwaY+7NxAMfJE1aS7w3bHYv
         02NavAAzMUeizEkfX2XeobCac4rcJBY/DkcaQkfLmc/Suih7n2NObLigpadufS6Y6VyE
         Pl7Q==
X-Gm-Message-State: AO0yUKVlaFkSR3j0GhMpmA5wQGboAyrts/p2YdAiNQymU73bKNjfJE2R
        7rXrWmIc8GwlSxObKOkP8e2KlsbUSnB6z3Fbk9A=
X-Google-Smtp-Source: AK7set+0ayrpZ2zpUSZolocEbaypMOlpf+RjKp5J8NA/QuOgY5ikWjIaqCUL21j1IaKXH37sb3XiNuLMkSx69ON0JS4=
X-Received: by 2002:a2e:bc16:0:b0:294:69ba:6288 with SMTP id
 b22-20020a2ebc16000000b0029469ba6288mr2911858ljf.4.1677064431550; Wed, 22 Feb
 2023 03:13:51 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:901:0:0:0:0 with HTTP; Wed, 22 Feb 2023 03:13:50
 -0800 (PST)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <syengodavid17@gmail.com>
Date:   Wed, 22 Feb 2023 14:13:50 +0300
Message-ID: <CACKzJBueX6KOsM0u4c3XGo7oWo7Wb6xnrQk+W9zSZc3sSDnP+g@mail.gmail.com>
Subject: denarna donacija
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:242 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5568]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [syengodavid17[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [stefanopessia755[at]hotmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [syengodavid17[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Znesek 1.000.000,00 =E2=82=AC vam je podaril STEFANO PESSINA. Za ve=C4=8D
informacij se vrnite na stefanopessia755@hotmail.com

The sum of =E2=82=AC1,000,000.00 has been donated to you by STEFANO PESSINA=
.
Kindly get back for more info via stefanopessia755@hotmail.com
