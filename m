Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4326C8C29
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:22:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjCYHW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjCYHW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:22:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D33196B1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:22:25 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id x3so16055767edb.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 00:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728944;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=saNBroOvM1I22v58z+1jlGQi08thNGmZ6cK60YX0TO0=;
        b=IuOAgocF9RzRECslaS1GFtenH6BLVeKoyK1+RPytfkjQaT5phQJrOJCPSFtlYbRXwf
         5UZ4mPY3fuC/g1CFfjb2eJyynhLsfrLDQgeD0848igaIoWyhIKqfpDxyyx4rxAPu/abJ
         qQukCJghFbqrjSGC44DQj2sLRQ45zWovXyHB5xxDfde9ro7Os2Lk9cN04+OCR7PSlbTU
         d5JJqRYwQ2gkBfBlDn2boK+2sr450oruRPWxhnIydPLmEJIZ2jrdHqTt9Q3G7KAZDpCS
         nmbe1dRp55G47ggPrVOdpkm5v5IS7vjeM+1iQPxK5jBmMhfq/F8SFuvdnnHnay8jkgJj
         lTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728944;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=saNBroOvM1I22v58z+1jlGQi08thNGmZ6cK60YX0TO0=;
        b=Or3WIWUa8C3CujrDxn4Jwd+J5TGn/xPcnkgHl2UVsV3esoknE3uZygHimKLrgyv0vk
         8UngypS3A27a9DnqSVp9yKv48L3YsPbSTjcVdLWwsWM+shkHl1SkX2mM3abVt33PR4jW
         wFZ8FtqZf/nc99y3onvuewM7ss55EgWhZwru/txCXAGcrXjNWgvegADXtuAXGmPyQ/43
         mZNwKJO/X5POdsciImgmWx8FsAcuWpuKyJEN6VIlUX3/3qyVn1zsUhsZFL3ahNQ3uc/j
         eANve00EImttDHr7/OI664sJgRqvLcmowK1k5iWfD0DVsylMkVw73sm/dsR5Ji3cIUhM
         tRPg==
X-Gm-Message-State: AAQBX9eqlSse6I3mOCYY6KRepZdmkGddjzKJ9Wkeoongrg4Kw23si+Mr
        QmGk8IBWZsJO2A+x4wm4y0OqTbJNjvE8J8FiPjI=
X-Google-Smtp-Source: AKy350a7YiY6F5g4GUQwV6NWXEJSInnzJf9PS0n+V+N4U/hVup2OrlAffRnZUSSZT9Z57unbN1x8A8nyd/GKdJvqA44=
X-Received: by 2002:a17:907:a49:b0:931:6f5b:d27d with SMTP id
 be9-20020a1709070a4900b009316f5bd27dmr2788601ejc.0.1679728944343; Sat, 25 Mar
 2023 00:22:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7412:ed41:b0:c6:cc67:5f5f with HTTP; Sat, 25 Mar 2023
 00:22:22 -0700 (PDT)
Reply-To: carteralex166@gmail.com
From:   Alex Ben <alexbigben200@gmail.com>
Date:   Sat, 25 Mar 2023 00:22:22 -0700
Message-ID: <CADqKhr4ScWF1cAvWZj+Os7H2L6vhaZZa6EXz=5U++Cz+KJ=oBw@mail.gmail.com>
Subject: Business Proposal.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 

I have a business proposal for you reply for more info.
