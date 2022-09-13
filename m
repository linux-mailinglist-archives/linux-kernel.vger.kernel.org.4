Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAB65B6C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiIMLxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiIMLxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:53:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B415C97D
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:53:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so20353168wrp.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date;
        bh=UOhOSIdC3eMJe+hDUOv7UNRvRuebjDG0xcvLhkB3o2I=;
        b=XceymUJY5kzZc958ByLv861GfjeAWIxp/f2JoHz1VWiEDjHXdllK2sYvRxWb7uRu1T
         zM033QvSAZKJgOfOZ9nZdikUsFA7V7+f8UuUBEBYC4QJo9+41GYpl26I8gzS8Dj7LTB/
         3tDMJz2FWFai2J4PrCJoO5eWt2Pj1QiSWniAghTmbb9rTEXLNioVGOERUdcqiDx05ZSM
         bOv5TRHEkIV4ph+ktbMtehJdR2tLballcF1HmXZ1WTmGBTXh3py1ewba0kbfVqOtZVmd
         TBUgm9uAtV/+CFyV9kI5BuyiVco3dJO9c65SHb+VxJ4xqtIcoTm6QT7HQKseSwmcO4eU
         CHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=UOhOSIdC3eMJe+hDUOv7UNRvRuebjDG0xcvLhkB3o2I=;
        b=qtf5vCGJ6uOn/cpEELk+z6Gh+2sikUDR8eayTzdDc0o7ELEOsWc5XxMUfPbaruvjVf
         zGo0SY+LuIOKGu/A8zYiCFFvWuYXLdkYlSMIfI7bu+imMz2A7SQpKi4mmmsn4PAhiQGT
         paUHBY3bXlTjYwWViaZo8onofFSkjyPlfA1iabx/zF7p3z21jU8ZFNV9UiWUlrtIwixF
         rJEjGuouWY3yKnx5YPSzeD4i/57yGTlqsjt8o1Avr6zuwtCnQvdwt3+3SLOp4eLTNAAU
         YelKVr+RkzvduF0a+TeP5l/S0L6U4Gpz2fxGOn+1mP5I+Xjn1gUyMhBsCeLrzOz59nCd
         4olQ==
X-Gm-Message-State: ACgBeo0YACTdgAcVILJ/6yfsskq0FTQbS2ePD8x5W8qHKeD2+69O/Yay
        z2hTu8tXH/l41yMFN+qE8/MLgvBdrYdGCZAr87I=
X-Google-Smtp-Source: AA6agR4m7tBEHyMUNyzf6vEA96JBIZZPW76lP5VAFJO+HAYEW5lAB8ToM6fTaqZVkAVs23nSm6oKYk+B/seul5PEEak=
X-Received: by 2002:a5d:55d1:0:b0:22a:c124:57d3 with SMTP id
 i17-20020a5d55d1000000b0022ac12457d3mr1390386wrw.562.1663069993121; Tue, 13
 Sep 2022 04:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:1861:0:0:0:0 with HTTP; Tue, 13 Sep 2022 04:53:12
 -0700 (PDT)
Reply-To: vickybensonxyz@gmail.com
From:   Victoria Linda Benson <obicasmir428@gmail.com>
Date:   Tue, 13 Sep 2022 11:53:12 +0000
Message-ID: <CABzKOhYkTLWqfE2_LnpNZbyXzi_YjSZ7eebt+KwvEuWf-PqVJg@mail.gmail.com>
Subject: From Victoria
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Name is Victoria Benson the only daughter of late Mr Albert Benson
who is a famous business tycoon here in Africa i want to be a good
friend with you.
please kindly write me back so we can exchange photos and know
each other well.

Regards

VICTORIA LINDA BENSON
