Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AD06D41DD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjDCKVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjDCKV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:21:26 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C51119
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:21:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m2so28769353wrh.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680517284;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFA0m1UkYAx6dZtIKVvzXGW8g05kXBsSRNkEd3Ei8W8=;
        b=VcoJbKdExhVYCMVLIhHY0mkKGob+vUuT/nmvtcUCTvYNr43vxX+ytyOVQiN3pSlmXB
         uwSyv/liREKZTLU81A2qo1DtEqt8igFwvmJrmykb6FuokO6GHCRSmuD0mXwz5Q5PsSwe
         avQSAWCaZ7TxWDYE75kJHcjSyOMaWoPlJ7had32HVzxblxFi3RdCiAMRYXsj9NFwhmR5
         KgpdMtRBP8N+mvPvxvfUXhCtKGfIAKQtavJvQ+g6ZEPRg71FS8nPkOEEiFmZEf/I8Nxn
         Io2KAenp5H80v42Uk68hlZFFo2jf4fyey2ByreUHwXiLMDi+gB1UQC5RD+W0Kz1+L/Qr
         rHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517284;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nFA0m1UkYAx6dZtIKVvzXGW8g05kXBsSRNkEd3Ei8W8=;
        b=2tIDDiwj/6g32vBkksZZKu6876Q/2BK08ZOF0l0vkYv5jV2AjFUFytrrRaZ0hXRw5Y
         X3RcZ9hskQXhvgbrBotPLbkhqp+fFl15igsCoCX3hq1RuZTa+5NVogMIPk5Bk4Z3k5Zu
         sKG34FB+aoQgQK8uohmyaOOf+2hHZPKuay1sZmS2wPd8a/OHydHoYVdblyAzPsr3Eoxs
         zjS9MnXOCYFapJQOZNZ6GtOeYJpy9tCFMdk7oS6oBW+IEFyvWd84iB+dLKq5IoSk/FPv
         T0qilwLQ1vRQXEMcZUzH3EMW/l2JiNuayT1caN89BwDRS89I/dVOEmHrHvGiKcgnp6Zn
         QLtA==
X-Gm-Message-State: AAQBX9cqwh2YdSodszb4CMwFrmQmWIX7/jyi5DdetryW93OBFoD99DwE
        P8TaGLMxQctljS6dmm2TjQ6+ROUCZhT4SXm8HZ0=
X-Google-Smtp-Source: AKy350an3Pgw4PS+AFF5KNwFZ+52TqEOtzD8f4ldkr6t493PvCECmWOu5GnYpjiw+s7KgOQk79sFuVpc8NVtigGTQ6A=
X-Received: by 2002:adf:e84c:0:b0:2e4:c9ac:c49e with SMTP id
 d12-20020adfe84c000000b002e4c9acc49emr3095250wrn.9.1680517284120; Mon, 03 Apr
 2023 03:21:24 -0700 (PDT)
MIME-Version: 1.0
Sender: salifbrimma69@gmail.com
Received: by 2002:a05:6020:7116:b0:277:5d03:f74 with HTTP; Mon, 3 Apr 2023
 03:21:23 -0700 (PDT)
From:   Kim Chang <chankimberley04@gmail.com>
Date:   Mon, 3 Apr 2023 03:21:23 -0700
X-Google-Sender-Auth: tWVg5gZ8XgTkhwp1m-FVrZBTJIw
Message-ID: <CAHm08fNwG2FvATH0WN+S-8Emq+KFj9QdvS5PcpNNwqr+o4N+9Q@mail.gmail.com>
Subject: Greetings from Ukraine
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My name is Kim Chang, I am working with the Humanitarian office of the
Red Cross and volunteer service in Kyiv, Ukraine. I have something
that would be considered to be of interest to us. I would like us to
discuss about it.
Please, kindly contact me for more details through this email.
chankimberley04@gmail.com

Thanks
Kim Chang.
Velyka Vasylkivska St,
Kyiv, Ukraine, 03150.
