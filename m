Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48255612C3C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 19:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiJ3SdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 14:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJ3SdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 14:33:09 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FDD626C
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:33:08 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id q5so5305317ilt.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=pGW6ajbhgaX9OPk/kkYQNCK+YHzDdaJHw80HNWBH7EQnj11o4Bcv+DuEL4tj/VEBb5
         g8mwPJryXaQvlkiKDDchywe4I2FI8sIj8uEhPdxtvYiyKecBi3gCZtvCdQdyMGk01RL+
         jJay2OXSDUG+8PhgXePkq77JPYUD4aD3cg8fZuZFtPILDmoonqN6KoEctgfWTejUWTt5
         NRR5itY3FF1Mp3QT3G0tU8Ha1DlTO3CUYHifrTjL+1yI9D2mUxO0QqM0TRVH6mY1E2f/
         q3XY4+/3eL93i4q7qBWnRa4G/X3a8vrlysc6jKIDY0bGYBuGnAnROCuqSmnDQYiYqsrJ
         rW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pSKuz9BJS/Qwel4yBJUKsJP++c1z8gtIosTtEbMtN5I=;
        b=Nu+rMwHgMK3s6IT1KoZCZdq7B26MJ3PeBbE9OAuOSkD/gVlcxogfUDxan2UaOd21+a
         P7oDGyeCDRlqrN6/RPzGsdTw9uRQYfCNF5RRl+owrm5dBArYkEYUwxahkRoUyUNKu5FF
         1CLzwgFEHsUraWJJyQZVPWg7DXpD0IFuPIED0u1MmFswKfEcZdhh2Jrd3CllS07Nedyw
         Mh9whfdmo+0dRNGOT2XmO9j2+kLwSbGIC2k4FWy6m3fjtgY0dBqumO7Zm3K0XNnsKr0a
         mFRsb1KOxWN0FCFhZrEtQDiHAWM2Nzys8VUmDPSt5lOKHqKCMLBbKaF7TCY8H1S56hte
         AicQ==
X-Gm-Message-State: ACrzQf0iwHSD82jqsS64wRmchVrj5HylTwOM9+K/iWM94+SxMNOLzEhv
        boUbbVfHjzhgX7NMlsgz19EarMga67AJ2rwaaao=
X-Google-Smtp-Source: AMsMyM4hf/jfcQATn9K9ecPTNNwucJEcAPfcAprisLkQjHtjbkGc+tY7A48hbrijiVl33HmgzWAXGqEx31ldypHY9I8=
X-Received: by 2002:a05:6e02:156f:b0:2ff:775f:1efd with SMTP id
 k15-20020a056e02156f00b002ff775f1efdmr5099550ilu.140.1667154787818; Sun, 30
 Oct 2022 11:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:16d0:b0:363:fd0d:12d0 with HTTP; Sun, 30 Oct 2022
 11:33:07 -0700 (PDT)
Reply-To: davidnelson7702626@gmail.com
From:   Zekeriya Badou <zekeriyabadou@gmail.com>
Date:   Sun, 30 Oct 2022 18:33:07 +0000
Message-ID: <CAKgROLBYedV3=EMg7C0LO7h7-sg1r2wQDCHPtK-Dk69Ss4kO5g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello friend, I want to send money to you to enable me invest in your
country get back to me if you are interested.
