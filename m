Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6106FCA52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235663AbjEIPfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjEIPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:35:03 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42FEE3
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:35:02 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-38e0a37594eso95236b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646502; x=1686238502;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=SasqTVINoWJK7v9izvGdhA8dWFzxZnhGBHSGUrg+kjTd/DycxQ5HCo3QPXX0aEUelD
         VTGFAMgZJXYxTs4slgWnvHIWuClnsEu4uZ8GtYdek1lshTcBpy0RXD1GJUHNPtUvkJPU
         OkB5bzs2ylH/l8JOxC0QFyJGYG0sc5y94Ppe99eOXR9OjVt45w4Zd9+FJ4MLlF1OK2lH
         7T2TOt4q0RTxvD5chASSrImNVZtEmD5WeQLjSZMsCmpiwbt+oeniSBvmqWOcauigMqSp
         LF3m/MvoW1TYb1pXfvxwVnoR2JYju2e3+d3pS8sAUmsi15aEsixxZG6MUPBkcwc3EBJ2
         O/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646502; x=1686238502;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEkw1KmmzfmMdZjy2G/k2kJ9Rp06l3CUoffIihDDUro=;
        b=KTVwkGH7svAmATRJw7Um7Opw8uYsPjZXVb0Pez47Vc8YetuzyrIj4kpynZO9cU+5Ye
         DY1urbzOkC3Wlq7OJWTRfEN1f3m2ZwWtSSDG5rcbDioYvzA5xEso1EdJkF4s/NTZ+c8s
         jDyteLk1K1BicE35HvzhyrFMeDnOdSM2J9fygqZbgC0ipjmOJM5PV52qs9wU6LOizRX5
         4dL1TOi2T3bzkl1LQjHCxYk+n5AwXpNFHb8eOWV10HvtDNTqXIJgvCeVZFjP0TKpozlC
         iW4HP9BVXMF1PkFEf8WaeXZc3JLc2hG+nUmZVEYV63makZhdaeV1tGnYKlXs4jDb+EWP
         6LPA==
X-Gm-Message-State: AC+VfDyHtPT4GG6ps27zSUBcOsTIU1NzUuzWrLVdeXlNT+7Jqv/pkaxy
        uQdLj7DvyebZNynEoDxlwAGTpXDKbJKKUvgrawo=
X-Google-Smtp-Source: ACHHUZ7+6RH6YL7GsnNT3KgiEL8VbSOmQ8KhUHXrPHbMyAroXTNL5G9c50M9GXhw2S7HLUVmRICrkA3Ukme5M4hMxkw=
X-Received: by 2002:aca:df07:0:b0:385:d91:ee30 with SMTP id
 w7-20020acadf07000000b003850d91ee30mr5688123oig.3.1683646501744; Tue, 09 May
 2023 08:35:01 -0700 (PDT)
MIME-Version: 1.0
Sender: mrsnicolemarois10@gmail.com
Received: by 2002:a05:6358:882:b0:123:83c:c3e3 with HTTP; Tue, 9 May 2023
 08:35:00 -0700 (PDT)
From:   AVA SMITH <avasmith1181@gmail.com>
Date:   Tue, 9 May 2023 15:35:00 +0000
X-Google-Sender-Auth: 11ygK3VKJW3yMjVqTfXKSPHUlyg
Message-ID: <CAPsswJL4RMokdjupVYGvaYJZ_vaYx0eZFWxoJFSj-TSW+NpMSg@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
My name is Dr Ava Smith,a medical doctor from United States.I have
Dual citizenship which is English and French.I will share more details
about me as soon as i get a response from you.

Thanks
Ava
