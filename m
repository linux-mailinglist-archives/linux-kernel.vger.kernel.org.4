Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B3A6909A9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjBINP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjBINPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:15:48 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E125FB45
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:15:29 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id n1so976291ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1IKJhZd2cFwm3AwDsdva9q0/F7bF3scCaYJXkjQZhk=;
        b=osmYPTj+yAvF7Ioz4qCuBSIR0L46/St0UIIZo5pPX9xqGwSs9dI63S+Wb9ffpc+a2l
         xWdGwgv6S4pOUsME8FnWKoqYNp7U7ZL+FLGkcnQPTanEwILRXqQUEe4M2tK4hSl1/6gG
         7eKs8SHeb/bgG/D7tsHG7gHDb9Zl+htKe/I7OMrb5PCOc25oG7sifMd9TEPykGabWoHB
         fBydtcVwCrpojMrFDcLMUYCQ9hqUaZanndW4vYYqrj/0CtF1HVqTKZJCN5D6vBJszxMQ
         PhumUGUvMQ9sb9w32L3JDP76he8Tv5+eOIiRO6VxNLZLrz8H2lcm/ZA6qFOgFrMEDKOl
         pD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1IKJhZd2cFwm3AwDsdva9q0/F7bF3scCaYJXkjQZhk=;
        b=bCCZXyfySfWBz6Td9jQofUgmvhbP35sjsX51eVjMwwtrSAgTxnqobCEHPTNdNqegoj
         Z8m6g1QL4pOOtjNTRGn3udhPFNDfrUijIJo2WFvi9wrDttX3O0XmB1SwE1UYM2GPMu3l
         6k7YAqSukAbC6HPedC7UoKQSPzWUlI7sysH5k/ZCCK5BNrsBKibSatsfvueUbvvegJaq
         kpT8U+BEy7eN/nELARx9cmUjh46ipq1nCGg3oO8d4adaD9HGSHOHAU0Kl91a1zIAqQ8X
         n8tefLIsO1yX586WLSn6ImaHMU1pyjoU9w1M3h6XmrKsabVYcM7KWMKCQcKMBf/CUsh8
         wqKA==
X-Gm-Message-State: AO0yUKXRN2s7zIXGZ5L9TyBT51Nsz9Ic5bJ2xsRqS/is+bm5g3S4xTWg
        R04QXBD8iKTLYKxIpC4mkt5G7KWbIiYnGmaQt50=
X-Google-Smtp-Source: AK7set/UTUTYWJsoOhjRmxoZvXl0e80ir4QxLugRQPDnZ2xc5EIgS+WNgT/PxQ827Oz4k2SXYN5Cqtx3j4BI61N2w5Y=
X-Received: by 2002:a5b:604:0:b0:8b6:2d1a:4c31 with SMTP id
 d4-20020a5b0604000000b008b62d1a4c31mr247730ybq.558.1675948516173; Thu, 09 Feb
 2023 05:15:16 -0800 (PST)
MIME-Version: 1.0
Reply-To: mantheykayla29@gmail.com
Sender: amewoanoude@gmail.com
Received: by 2002:a05:7000:bda2:b0:468:cdbd:a35d with HTTP; Thu, 9 Feb 2023
 05:15:15 -0800 (PST)
From:   mantheykayla <mantheykayla29@gmail.com>
Date:   Thu, 9 Feb 2023 05:15:15 -0800
X-Google-Sender-Auth: BSkQhixq_Glr7KSQhRr4edXlFFs
Message-ID: <CABDmscDjdYaZjrhTh_fQ9aexgdaxdhzFm4m-sv3eKQ7ko_eRQQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo, heb je mijn berichten ontvangen? controleer en antwoord mij
