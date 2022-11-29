Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4284463BE9D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbiK2LHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:07:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiK2LGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:06:46 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AC66206C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:04:56 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 6so12658258pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rs5ueIfO7VLRLL2mOPAVZrEalM8O4FV33h7G2H9cfDk=;
        b=qIlhqgFKK7RyKy1sJ8MbUAoLf50qQIl3WPnnXLG45KrZPymynarbfBaIeTa3ISXBcu
         3CTx/piHwwxNeLVpTI/WfbMbLRSk5daOpmkwdxUY66j74DW3Bn8An/OFVJKEUsBgnwjA
         SWAIxLw1Z4r3dfaOZCvWTWYD3gQ/XcFWkEcxdagktGnNErDCTXGCJIcyK3BQdvOLwo7R
         uiVE9LIU8yfbdwfeIo2rH80afGyzARQ8dmNJjFrokbAOjLXHvMM7tkp9d4N3ONhA97i9
         ASJBrdhyeHVkFAN0Pc4/6fInQKA+LMWe8qKTXEojAJOs5fWsf2UB/ynB6TtoRhNMV+Ce
         1NxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rs5ueIfO7VLRLL2mOPAVZrEalM8O4FV33h7G2H9cfDk=;
        b=29WWovN7/2+GYyA/NURkCU8skAtfOg1a25MxX+6VwXFidWRh+MUhwoSDe06hdHuS9R
         T9keEiQb6Fa068TVJhV8OlFvPAHl1idoMt6iJwUOOO3l03jr0lI5obOueyi+jwVbzpqH
         DG/YDSaBHtwKV+6yUaRPnQhvgvAmZj3s00zQdnejL6Uy4ytVSz44wYRqxMT31q2ek+tI
         XpKiKsHsG7iKKd19RNwFeoEa387xjxkgCxkIsG9ML5BP15uFR4eR85wM5qjowuvtrqFL
         OJCczMa+DMAB2nd1TuEiV2ifNX9aeQLQ8Z23Alp5hfrcmt7vWw1QCV8jmxabaCseVswa
         7rnA==
X-Gm-Message-State: ANoB5pnv7QCT4S7lo993irj9KvrceK2nDJ6TSKIqjh2erwKe/wvRyLX2
        j4tzN2MTxVmv1k7K6zmtWIXeYMaWkJA+xCZMfTU=
X-Google-Smtp-Source: AA0mqf5/5ogbljaYllitIk7U5/2lYXT83zEfb5I3UPh96UeJBeZQb2aB7e9Ju6nkKae7PNm7ckzxKhjf3NAioT4HJ4s=
X-Received: by 2002:a62:f252:0:b0:572:30f2:cbe7 with SMTP id
 y18-20020a62f252000000b0057230f2cbe7mr58194139pfl.46.1669719895691; Tue, 29
 Nov 2022 03:04:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:903:134a:b0:188:c939:fb78 with HTTP; Tue, 29 Nov 2022
 03:04:55 -0800 (PST)
Reply-To: miltonleo137@gmail.com
From:   Milton Leo <rubayoki5@gmail.com>
Date:   Tue, 29 Nov 2022 03:04:55 -0800
Message-ID: <CANUZKk-VmSnZd2nv=rimzGU=kHu0vnRKKrQ_2CZzg2+S2c8vyg@mail.gmail.com>
Subject: Hello my good friend,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

How are you today,I hope you are doing great.

It is my great pleasure to contact you,
I have an obligation that I would like you and i to complete ASAP.
if you dont mind.

Hoping to hear from you.
Regards,

Mr milton leo
