Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823EE653828
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 22:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbiLUVVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 16:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbiLUVVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 16:21:09 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F82A2034A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:21:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u10so14444qvp.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 13:21:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wLTluME75UDM26wMyJB90Fb819f9R2iPWOK1x6G1kUs=;
        b=lJ6UwyXL8Oxx6TgbRkaYmZdqK+Rbz5pxztm7EHy+8H1U3DuwA0QcxlA/daqD0nqLmo
         7KvuRyN84EhHEZ9D4pZvKvXHncSVuEW6G7LLXmoi5usUp+Xz7FLPdGsP562erjN5z3BN
         ih1tB7WVVkYYRhd25X2MOkZS8NUclvPJqrwcoptxkxhZkKz635opnxuI6YUap6artoa+
         EjzqgV8Z6Vnc0zuQoChOhhKJjrJIcvpEo3SmuEtVHM9JK/YQb2J2k1LEkD55vvbwVhBU
         3qXYSKDsIbfZnPNdi/lMpZ/FZZ2Ik9czPAT1TuQ67BzP1vRuB5mnR8uSc4yddsCI0H8V
         sDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLTluME75UDM26wMyJB90Fb819f9R2iPWOK1x6G1kUs=;
        b=fK4SzLPKEkYLfOjYBFcH5SJ4RgW60HcnOyYbMhh/A3ZKHWr08c8rdPQ7nYBPmBte5l
         nrbkCMpFy7HcFFanPA+Jfz9Tp4SWJRitm2YyQ8XwR3K6UEXrJUgD8fFwrDQXuTiF4NFX
         nAjXCcKyzTxI6NF3oJM4VRofFWiYhMpQGkf1d0LgJviZgaAvtYvhyk4NYmJ1B3fF1hws
         3so7bpTAYpB6QOizMkXWLTlh3PTrBssZpDwR36EGYIcPVv65H0ll9+W4alrfKoftL74E
         F6vPEgcEw9L1PTGxzwBuMftVlrWLrBKlAxF2J096LIhVjNam67fejBx4lNFDzi5ZBxHV
         dK6g==
X-Gm-Message-State: AFqh2kphj3ivmeMj37k3pIDoHw0Z65O/nv2b6rFYQ5c+AuxCoCoLrXRg
        6WiMulVYfYe2v4aNcgGaiW6ynAnS2edLd2wOfSo=
X-Google-Smtp-Source: AMrXdXuvcH/ZKCvNaCKpkMTSNLc7d92H7Ek1++T/aLPAC5hf4awK4yPxIcfrqvuhinJj0lYRDebMlykBBonqyGQIdSA=
X-Received: by 2002:ad4:5986:0:b0:4c7:79c4:91c8 with SMTP id
 ek6-20020ad45986000000b004c779c491c8mr141117qvb.92.1671657663600; Wed, 21 Dec
 2022 13:21:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:8dcb:0:b0:52a:be48:9f47 with HTTP; Wed, 21 Dec 2022
 13:21:03 -0800 (PST)
Reply-To: Cliffwebster92@zohomail.com
From:   Cliff Webster <hafsatmane@gmail.com>
Date:   Wed, 21 Dec 2022 22:21:03 +0100
Message-ID: <CAJDGAm1KWYq7WANy8jbiG4g836hcPCOAvanv5sf9J+WF7D9gGA@mail.gmail.com>
Subject: Payment Invoice
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello,

Kindly inform us if you have received payment!
