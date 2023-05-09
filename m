Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121146FC9D3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236032AbjEIPFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbjEIPFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:05:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE223A9F
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:05:31 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-965d73eb65fso903473266b.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683644730; x=1686236730;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCe3ZOjjTbf+wP2a5fgUhlX5SNYuErMBZeZTwzbH6kg=;
        b=dZoSNHrjGPLBI0DWMee/1NYyifgQqNlbdMvS1CV2suLq93OCKQMynETM/TXkBM78p8
         RaKH041A5WsdiT3etoomgFIRwVbv3LcUrgIIWy4ssI1wHKr0RNPE7R/DJaAp7ddORHIr
         4VRgBbs5BiWQrORwwVBv/e1SfmzKmjuVV7SfDann8iAwKBoep82tZFUmoT47UesIkYjK
         WMAzgFjmj+UH7XJd8B3ju2Z6nGA5X0Huz5uESUKGL/UdWZLaqOu+VhBjQ4eNDOdo9t6F
         3XyB362nevkO1DCstlT/nVBVwCppvvW9akNW2y9IiI88oE1VvlPyhMv6L9qe4GO58BHV
         Y+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683644730; x=1686236730;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCe3ZOjjTbf+wP2a5fgUhlX5SNYuErMBZeZTwzbH6kg=;
        b=dCWP/omHrc3GZcf9Fm+ilE0fpbo+0gz+z1e0nFXA9blOTpPB7Cz/x9BI+krRT5B0KG
         2gYi0jLKl6k+LH2jhMhcD9dLJztvXJU4rPAgaKAOGrw1QSax4Ugxl4JPZIIcPvbR0qoy
         1C6BxHTz7xLMtRtzWmfuRQFBVfq4P3+KVQeQeY+v29pBRjqn2/CGgcTIQdf3LFCf2gNU
         yXjBBHhgDSPE1/Sq7D7DtSU66r0YGxbvhyB+Vz+Y+UWOsktRfKJyzoSCyFAItIQ2Jd+T
         0beAU59zynQDASi9cE2d56LvRm+3OS8ln9kG9Mp7L2+kuEGYPmWvVuwpkEgB8V2YY1V/
         0lqg==
X-Gm-Message-State: AC+VfDyavOyRqkczU710x63AdTh/Tqq/d1g5pD8qp95ujamzn38myDr1
        iYRMINGKhG+8PVY2p37EsFNU4rtDI9UN2KqEhVk=
X-Google-Smtp-Source: ACHHUZ58j3hKJXZfP/IGIgwZOnxBNtjFWpZXvNQ8AQIqAs7wIvaCV/njEUZlHktFOLozj3A4KaCmfrenmaJXozVIiEQ=
X-Received: by 2002:a17:906:c14e:b0:953:517a:8f1a with SMTP id
 dp14-20020a170906c14e00b00953517a8f1amr13245343ejc.58.1683644729539; Tue, 09
 May 2023 08:05:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:2a03:0:b0:211:89d9:dd79 with HTTP; Tue, 9 May 2023
 08:05:28 -0700 (PDT)
Reply-To: elydm65@gmail.com
From:   From Elena <rl2791414@gmail.com>
Date:   Tue, 9 May 2023 16:05:28 +0100
Message-ID: <CA+HscTmxpsBhvOnYGJf7yfveiNKF5bH=Z-FWxnXCUs=JCZkhgw@mail.gmail.com>
Subject: re-reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_FROM,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:629 listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rl2791414[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rl2791414[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [elydm65[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_FROM No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings Dear,

I'm Ms Elena-Domnita from Romania, i was diagnosed of cancer in 2019.
I have some funds which I inherited from my late husband and needed a
very honest and sincere Individual that will use the fund for the work
of humanity or charity, Please if you would be able to use the funds
for the work of humanity as i have stated, this is to fulfill my late
husband's wishes.

Ms Elena Domnita
e.domnita@hotmail.com
