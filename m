Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBB367FD54
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 08:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjA2HMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 02:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2HMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 02:12:21 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2444022A12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 23:12:20 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id me3so23818150ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 23:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyQfDA5JQKapTqk95xlLXJ5aD/AVTOh+bnm0DaoViy4=;
        b=K2UuqaPoyrF7fBhVXAhDDVH6+qOvl+2czNJo25FgymwJ4uxUh/D8hEUgCADqjEbMsA
         uK34QZ6+nAAKDGOGv65kb4Xb+pN2C55bLRXu0z9i2/DytbIgjwF7V4/GexmyrJPs0TCf
         hHMYNhznjuXTX+mdE3aV6K1Ibpq4y/1N021syQH8TbN96HqCEfdOZuJdxvxMpBCrgJSt
         sieQsUgd2iOzXS326n27bXstyCqE40Wy2l4gFRLlb3LyFaM/HWrAVK9Dyo/y5jkhx3XL
         LQmwMFRDm2pdkeXlioK0kIN/58JFUTwbzjqmKbCIwtmqIri+f0rGCH96EcVqXy1DDFXb
         fU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyQfDA5JQKapTqk95xlLXJ5aD/AVTOh+bnm0DaoViy4=;
        b=0F7TOBgiDh1gdbllRV7P6efXAqRLU34vftySsdSm6o5zhg1zfGtFOjqN8xQrXqxv0p
         ZIYYCOd9AWCGJkcrwNSJ+Gq8XeMYlRLtgf85VrpV5rwfOBGJZagsRCC5zSEozsPBXE/g
         a7o7hJSTbugOVaxGZve//eqZ73/R68EkX3eG7tnbDjYt5rhi39qv8M0qVMRc+oog2Mbh
         pcHtwfSLw2scFdKB12SGNlm3qUkMxWP4Az6zvMVT+AhavC8OD5yTYGAjtdIN45c8P3/p
         8j2g5KIRcxOrHtDA+GYEqImOtvaFUJapmVAeDoJEoPGwHVgKPUWqZ6MecUzSKFHF7hD/
         s9jg==
X-Gm-Message-State: AO0yUKWGrcKxVrq5zOuJzBPPgB5rhUoEnMdt/09XVK4CkLPh1ZCorccO
        lfDm6oNImEdOi8vnAcceePjDNq05gCw3pt+HfiA=
X-Google-Smtp-Source: AK7set+jmEx/u5NqPfXYVJvniNb97eMrHlJwVRL5RWsbNYBc63pMxmn7ya50Ow5eiIqA46uFmL4pojuM7wAaL0R1ksQ=
X-Received: by 2002:a17:906:9ea3:b0:887:9adb:da53 with SMTP id
 fx35-20020a1709069ea300b008879adbda53mr80401ejc.166.1674976338323; Sat, 28
 Jan 2023 23:12:18 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a98:a106:0:b0:1a1:b8b9:fadd with HTTP; Sat, 28 Jan 2023
 23:12:17 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <harikunda1116@gmail.com>
Date:   Sat, 28 Jan 2023 23:12:17 -0800
Message-ID: <CAGEpkWrSWKqk5RUOrc5DhmTfeJ=vXMObvAfnaJJZQtWt3eCxhw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [harikunda1116[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [harikunda1116[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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
How are you doing.My name is DR. AVA SMITH from United States.
I am a French and American national (dual) living in the U.S and
sometimes in the U.K for the Purpose of Work.
I hope you consider my friend request and consider me worthy to be your friend.
I will share some of my pics and more details about my self when i get
your response
With love
Dr. Ava
