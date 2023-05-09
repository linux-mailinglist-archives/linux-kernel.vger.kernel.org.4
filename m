Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD44C6FD088
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 23:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbjEIVIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 17:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEIVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 17:08:14 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B98826B8
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 14:08:13 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab26a274d6so9146415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683666492; x=1686258492;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=THgBa0Jgh7iBCI6rg7neZrBpOR6Tduc6QPtkaF1BU8zgjBkfDwvJLpUZ57CPnZYjso
         z7JA0SfynnA3MIo1sVMcB23HKsI8yKKqaAGl0HEkhyjdBEGV7nkWBI1cPgpGgBkzdrqq
         WpwHuVfE9u8ht5QeIZtNglY8CZRIgcbMR+FV4bL6meEKwBOA97dGms0qphUhJ0piFoEH
         s5nbId7kdrItEvPkYL9vHvIBAHbaVJ//9GTuWfLMZBTkT99CaFXGcBCWgwj0DttasJDK
         b0fljoAroQe29bgV+mOQBTggm/asRUeplYWRJZ7FeoQtMC9Y1Z1zAOedM+FQIe37cvsY
         UkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683666492; x=1686258492;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opeeHjTpE8hf7IkSOrjrz4V6UTxg/7z0lzjIXtvA3kY=;
        b=C1vj3bQoiav0pqnuxgObr7sr62viKYhs6RYNrMAPt5tCCk43+IYKU2H61IcWLDKb1W
         Tq+ZI600fptrcgTP/qt0/j7p99r7kkaWfgFGWVBW60EcylEy6MWQjDo9AuMCBxuXjONT
         shhyF7GryuWGBA6/jNs37hhpOD110pqBfYkruEXOGW2J7M9zJFiQucP3tTNW3e8uaFqE
         nQDgVK1VIGFaLoLccKv+ezheiXUYpVxQdDk7k3wN/hzKyUBMSz83E0v1KkfF2zlUenVz
         c+LhSdYqLqpx/GwIMl5Dl0CMmVAs43Sg2kwyUYAPQjiZ/3c1pSkvwmFtVrGBDQT5e9Tu
         jn6w==
X-Gm-Message-State: AC+VfDzGwVN02CT7pmo0J0os20b2IEMU0xd5KvRkyB2XboqusTAUuqT/
        qENgsPfH5nlBV8Zas6V+uU6TL/PAGk/vUvkn2eA=
X-Google-Smtp-Source: ACHHUZ7JdI1HopN7F0X3AdP4991OHt2Y4FOX0QADX/tqnlZBnG0UvgeqsqmO3sUOmIdxdq0fVCXFsGQxx/F6Qhbtbu4=
X-Received: by 2002:a17:902:db0e:b0:1a9:98ae:5964 with SMTP id
 m14-20020a170902db0e00b001a998ae5964mr18737817plx.3.1683666492626; Tue, 09
 May 2023 14:08:12 -0700 (PDT)
MIME-Version: 1.0
Sender: mathildebatchassi0@gmail.com
Received: by 2002:a05:7300:324d:b0:ba:ea52:d830 with HTTP; Tue, 9 May 2023
 14:08:11 -0700 (PDT)
From:   Kayla Manthey <sgtkylamanthey73@gmail.com>
Date:   Tue, 9 May 2023 21:08:11 +0000
X-Google-Sender-Auth: KJsr3ZALbCTNiBhkO84hlSfAaGI
Message-ID: <CAM2YJmahHyT8mf+KHSzHLEkWjrNyc1UNMOVhPrR_S6qXpE237A@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, please did you receive my previous email?, thank you.
