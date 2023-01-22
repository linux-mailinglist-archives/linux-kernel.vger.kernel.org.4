Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C81676B30
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 06:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjAVFPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 00:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjAVFPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 00:15:46 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165361E2A0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 21:15:45 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bp15so13590279lfb.13
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 21:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LaJ0pOpNRWAW4u4WiMs6V/9gJsiYUBUKhGV/64DZPcY=;
        b=fsYLe25DlODkwoUJbNK0JDedTuF8UGj7usSAtdOZZf3Nwe9hq4+bP0ZgE0sOSOTTys
         OUqdJs6i0TY7C7QaQ79WVlV3rhM54i4gX+WyzAJnkHYSTwybMztnw7fokGqxLHfnGXzO
         GJeWU/q2Knpelc0rvEt9HcWDDwaPEfKEGB/Yi47kTr2muldbrcST1kXb4+w6VuD3dyAZ
         5qyi+LfPEd5wWWeKyCOzccNXPOJfleSGKsIkR+WkVyYAOoUD5P1Npj/YnLLywG7oFMos
         VZPy0Z22RNYfPDNaPJDl7zcOSti/UHF8O7SCTlOtG9+1cKSzNZSaqmPsCK8AIF3WVwys
         +xUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LaJ0pOpNRWAW4u4WiMs6V/9gJsiYUBUKhGV/64DZPcY=;
        b=Qqs/wlm/RW5hn+xJBsVOIVg/1iOkWoGXTEMkH80It3aZlyf1KMIiY1jl1rADLqQnwB
         dqh5B3PKVaBmYde6/PsZB746AiIuEgVYh3FSZjrXpPjRDVp8oQFjIXRALrm1DW7rT9EX
         pTO2v2iey09qOW4dgjZdRxc9G2OwgrVIPwYKBgBi903En75sLznbJxIkuLHRDD+M3+kV
         2eJniM5utfj7YLBp6axErAwquLy1bKFbngikeneaos/YMSrzQr9aguO6uJVbE9bwibBC
         /ZX+9a3BYv9UHzLsZEh0SyjX7xDiVNosZ9avgnw1CfTiKR6tVz7A13zWI5YSp3rhKZvL
         URxA==
X-Gm-Message-State: AFqh2kpZ+4f8VIhrSutJ3kMXdn06P/Vzi4l4cIg3GvBzEdciv7YL9yRn
        05x9SXZbf2PDhiqktUuGqRcoonuv2t5NYjIUids=
X-Google-Smtp-Source: AMrXdXuhCl2v5mSYaHJagbIc/LSopm9P2CcVOnE454mGu3wz01w7Z6mX4qg5SrAo6BR8usqM5KUlvuBa3+UJ+6+hxt8=
X-Received: by 2002:a19:7406:0:b0:4cf:d5bf:75c3 with SMTP id
 v6-20020a197406000000b004cfd5bf75c3mr886307lfe.170.1674364543372; Sat, 21 Jan
 2023 21:15:43 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:4d4:0:0:0:0 with HTTP; Sat, 21 Jan 2023 21:15:42
 -0800 (PST)
From:   Frank Hughes <diamondbk9@gmail.com>
Date:   Sun, 22 Jan 2023 06:15:42 +0100
Message-ID: <CAPrdMJBAAqcdWvimUE0Tn0t7Db1nbOYV-PGacQbook_nGwxtXw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=ADVANCE_FEE_3_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_5,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am Frank Hughes. Former commander during the American War in Iraq. I
am currently in Syria for more missions because the US has completed
the mission in Iraq, but I will soon be assigned to the Joint
Multinational Readiness Center (JMRC).

In 6 years here in Iraq, I was able to earn a total of 25 Million
Dollars. This money came from the oil trade. Second, I have to present
someone as a foreign partner because I am a uniformed person. I am an
American and intelligence officer and have  100% sure way to ship
money through diplomatic shipping companies. I need your acceptance
and everything is ready.

The only way to be safe with that money is to invest it in your
country. I'll be there for a while. So i need someone to deal with. If
you accept, I will move the money to you as my foreign partner. 30% of
the total funds will be given for your help and 70% will be for me,
from there I will invest the rest. Before leaving Iraq, I package all
the money inside a trunk box and sent it away through assistance of a
United Nation RED CROSS service to security company London. with an
agreement that I will provide with details of my partner and recipient
of the shipment.

When we agree to work together, I will you to the company in London to
complete the shipment formalities and introduce you as the partner and
recipient of the shipment. Where we are now, we can only communicate
through our military communications facilities, which are secured.
Please send me your personal cell phone number so that I can call you
for further inquiries when I'm from our military network. I will give
you more details when I get your reply

Regards
Commander Frank Hughes.
