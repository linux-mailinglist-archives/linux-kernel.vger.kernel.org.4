Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D131E65DC47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:38:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbjADShe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbjADSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:36:57 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD3413E1E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:36:55 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id j206so37586353ybj.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 10:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+snawIMTMBolspw3BDAlTGveZS9t9iJ4T+sy2Y0CZU=;
        b=J0InUqCBOMWSzgRcM9swdz4DisM80OgZW1yWeQgnIctiJ+h8axEuzUQ7OklSXMFvbY
         yYyAe4jr0ry0wUBcT2Bl/o9rYvPdr9dDZc3qCTBWtdl2E9BUZrJtlhFwUZQX/CW8VHjF
         tsm9lVcD1MVhB9RRK31O60/30IvQ+zkBWwomc8oTqA0n/Jy68uXmeDx9jE3qQjxAv+6R
         YKoDfXZoiS1lJf262InhWBz9QRvXRMXIbqm21OAcUudiHgmJDdh9QncDl/1lBfusAjl6
         oAfRPS29LulP6R75I+5czfY/s1yL3+IZke29dRT0MFMZPvhz4jHAeJnZhUOdg4UI6JI+
         BTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+snawIMTMBolspw3BDAlTGveZS9t9iJ4T+sy2Y0CZU=;
        b=DfUXQSbug++JiX/fekGYLIbwDtBdvO3WYz8S61yEXIcY+UxhIRTsQBfVWsSsJGqHQK
         WL+Uxkt4XdJNkWbCb8idRoQb256eXGiXLbXGlvHRCQSwKbQgEaKfSt4g8L2IzL0e+pmd
         8j4E183LlKuU3D033uueS5IcGnhAf38oi5/P7FQ7zui1DjKrPDHS/vkOoTbfXkGBviRK
         +G+WMbHb/MHQIrlqwymxttYpUnt2/MOUz0F33x0xNzGsfExXItogcN2xx0LqWHnz+xOV
         e3lH8ZR8LcefosP973Snl5cDkZDjhNNuCXG22pm/a9rl6BDauniYYvyYtNqgCqsT6kLZ
         wHwg==
X-Gm-Message-State: AFqh2kqwTnuO6eth+KxmMn6a2IxCXRddGikgk5tgjCcgv/yNN9xOMYmo
        OKLMTOGU/FJIXolBp8PBHdcwYcD3/G+9vrDQaN0=
X-Google-Smtp-Source: AMrXdXtIg3tNxlV5A5XsBqRB+FYAh4yPSipju3DBHbmnGBf/kufjHyQq/eSJnwcrcX00R7If1eZXNIQlb2oPOTvT6Fw=
X-Received: by 2002:a25:f40d:0:b0:797:1fb4:22c8 with SMTP id
 q13-20020a25f40d000000b007971fb422c8mr1319831ybd.62.1672857415129; Wed, 04
 Jan 2023 10:36:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7000:1315:b0:3df:af57:5c0e with HTTP; Wed, 4 Jan 2023
 10:36:54 -0800 (PST)
Reply-To: georgebrown0004@gmail.com
From:   george brown <gb727550@gmail.com>
Date:   Wed, 4 Jan 2023 19:36:54 +0100
Message-ID: <CAGPBiJcp240nba2tz7eXgEN8ahoFnethU3v_EgRKW1VpcYB2jQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b35 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gb727550[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [georgebrown0004[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gb727550[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo

Jeg heter George Brown. Jeg er advokat av yrke. Jeg vil tilby deg
min klients p=C3=A5r=C3=B8rende. Du vil arve bel=C3=B8pet p=C3=A5 ($8,5 mil=
lioner)
dollar min klient la igjen i banken f=C3=B8r han d=C3=B8de.

Min klient er en statsborger i ditt land som d=C3=B8de i en
bilulykke med kona
og den eneste s=C3=B8nnen. Jeg vil ha krav p=C3=A5 50 % av det totale fonde=
t, mens
50 % vil ha
enten for deg.
Ta kontakt med min private e-post her for mer
detaljer: georgebrown0004@gmail.com

Takk p=C3=A5 forh=C3=A5nd,
Mr. George Brown,
