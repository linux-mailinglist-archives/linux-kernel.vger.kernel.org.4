Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935686C3050
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjCULZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjCULZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:25:10 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CA219A0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:25:02 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r11so58254020edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679397901;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HN3Oi2RRcPkWMRDuusk7M3mqXJ94D/CZwd0itLUrxRw=;
        b=mUEarl4Up09C5OAsBy8v8gOAHXCo5E2ybiOaqJ/d0y00OlA762xVCq4j3zKBzM3AQd
         VuT4fijd1JuI+CwDGv1U5N1JJxGH6b/N90E/kB0Vu2TbDevCJwWsrQC/iAswZTW95VZE
         3Cz5uJPdd+JgKSxTuf13LSaQTBDa7DnHpYJj7pOqApxtZno8w9bdNgzddKuDf5V0LgNW
         CzZbiCr5taCLtJART9BHD1WUVchFiPLD30V21C1+f81jLbP8cxJMQfYXAt7V/oHX7L3i
         QKcJNW7zl6hD0Adpxn/2zjzqDYO6lVVMZD+x4MFxatRRBT4B2kmRYWQYxeSyMYmUPRlE
         LI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679397901;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN3Oi2RRcPkWMRDuusk7M3mqXJ94D/CZwd0itLUrxRw=;
        b=aJlrWFk2IczHJy8YY2EvAkbIQ2WrD7fJil0Hb3R60r6i4RrSUoCM90H222EZ606+do
         +1htAFZpOecLB7mvPwIMFVQ5BODdIl1hlg9GiAius1S+RO9NnR/2OEVGE3Ioc5Lqjkwp
         5+LcEGnOLvgarzZ8kkY+zX4y4wb3ZA+jUqY0me5+9VtU5kY9otYiT/uB0jI5Zh6J1b0B
         GKU7e3SVNYg0jqhWOCk/yViaEdJhlWDk3c7dn2Qfr03sURqrlrU2JCg3mtuylnFKQoZG
         bhTGQ6BY7tBVGRiU+L/znB79iKGwnsdBVbX6uVD3LHQXkPPSFlfeXojdpDm0cPv17Z3X
         Odqg==
X-Gm-Message-State: AO0yUKWSNwvlrDbYq2wXzh+G/sDHCRfcbIhMeU8C2bqHwlpGie2ggbHT
        8WuRRO4PNs0zPeR+MlXKvpbqSBB6TTbcFWKlCZM=
X-Google-Smtp-Source: AK7set+fIDdEVpoDTw8kSUFT/eeiDxFffyAKs/SZEsiAome3CJwXPGL78HqjTw5UGr1D8NLTgvlM8AIw3gM8S8N2hwg=
X-Received: by 2002:a05:6402:2986:b0:4af:6e95:85e9 with SMTP id
 eq6-20020a056402298600b004af6e9585e9mr10287788edb.4.1679397901329; Tue, 21
 Mar 2023 04:25:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:31e7:b0:4ac:c7f8:602c with HTTP; Tue, 21 Mar 2023
 04:25:00 -0700 (PDT)
Reply-To: mrs.antoniewilliams@gmail.com
From:   Mrs Antonie Williams <maryakin675@gmail.com>
Date:   Tue, 21 Mar 2023 11:25:00 +0000
Message-ID: <CAF90XJkgqdsuepn0+XK+12_yKg-zV8FyzR6CXy4BRkDVagWSWg@mail.gmail.com>
Subject: Dearest one
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maryakin675[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maryakin675[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Dearest one,

How are you doing today? I am Antonie Williams, I am a sick woman who
was diagnosed with cancer six years ago. My Doctor told me that I
would not last for the next Two months due to a cancer problem.

My main reason for contacting you is because I want to entrust a
charity project to you, I know this may sound so strange to you and
also extremely risky for me to offer such a proposal to a total
stranger via email but this is my last resort to get this done.

I am looking for a confidant, someone to help fulfill my last wish. I
want a good person that will use this fund for orphanages, widows,
propagating the word of God and to endeavour that the house of God is
maintained.

I will appreciate your selfless act towards the less privileged, I
don=E2=80=99t mind if you could be of trustful help. I will be waiting to r=
ead
from you urgently as time is of essence due the limited time I have
and my ill health condition.

Thanks and Remain blessed in the Lord.

I am waiting to hear from you soon.
Mrs Antonie Williams
