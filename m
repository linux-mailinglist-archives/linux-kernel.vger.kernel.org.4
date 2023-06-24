Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63ECE73CB80
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjFXPBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFXPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:01:07 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71B019B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 08:01:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-634ba7158ecso5267636d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 08:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687618862; x=1690210862;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V1BP0VyTtr/hLBZsil+3oN/qKk/rnCGQTq2fS10pSmk=;
        b=HpkRD2zUIInOzaPOHwx9ujAkdUX8NRB9NWcJDD8wBLXwzcExYM81ZA4p73TF0CLFHW
         8MmJH60Uopaj9+w/pgyPdvGxoZBWYJC7qFehK45NAgzl98wUV+B7jHWgmCW6YttrO0bD
         fl6qPoz1oLbjuIq1FXHm7WPSL8J+5YDMxjiFSYQYpncbDwbGIF/SnNOy/Pmw3kagHL66
         QAKQfKvDfzkbaMiLySEmcbp2MxuwDZKzmyCaj/yuKm6YpcJ8xnDlhr5hVjYnkqr/G53M
         MGZn1HDCoMT0TfNa0q8zqTw0O72KESFbzwquuAnnnBeZIe2+mblvN0MWhnw8UfmnpgtG
         gZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687618862; x=1690210862;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1BP0VyTtr/hLBZsil+3oN/qKk/rnCGQTq2fS10pSmk=;
        b=Y7LY1G6+OPOfEd+nyv4+B/4tSw4rNri9xREEeigaukil2jc6V9sJy33Eq9XrPeowZY
         LQnckuT/NgQSKAg+Dj6ElMoE8Aet+YfYzyOcOe8XslqXzOyrUGjbo/4SVzlcvfOPYX6T
         G2UkEwto5N5HdIC4/JiuUCXhNX9tPDOUGs4DZ+tp5WV1vVwo/La/lgtQhuJmCL53rFjq
         qXpWBGaD8Qvesu0hclRlPMpq0TEXen0x19oPylKkKhDlmoo0u6jDtNNGWwfccEyXobsS
         31hZPBIqbylXmKfJ8T/dnJebmqpJ6R3dSK17gKrGJmgU7Q4YFEhQERfhK1DRelBaSJ2E
         Y3Cw==
X-Gm-Message-State: AC+VfDxIKN9VwgVumfAfvyeJYpTOMaeB5Tift6OAFzXy8NHeT4uJ8B8p
        XZ2ZOYnXBpcTJD6JeaAS5tm9nWWIwBHPdMi2FnY=
X-Google-Smtp-Source: ACHHUZ5gNtDrqFoq2PEUo9Ta1Ul1GzAoXmsLDHa7y756hZf+MtdhzCbIzGqfvU3Q6imlhuLqunHSqcFt/n9NQnKydg4=
X-Received: by 2002:a05:6214:5086:b0:631:f6f1:87dd with SMTP id
 kk6-20020a056214508600b00631f6f187ddmr14259877qvb.8.1687618861536; Sat, 24
 Jun 2023 08:01:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:6984:0:b0:78f:38f1:bc3f with HTTP; Sat, 24 Jun 2023
 08:01:00 -0700 (PDT)
Reply-To: matijevicmaritza@gmail.com
From:   m <mrwilsonnavas34@gmail.com>
Date:   Sat, 24 Jun 2023 15:01:00 +0000
Message-ID: <CAFKvN-wOkgrUN3TNeyfD9_8cZbCfg4PT=SXenQ79kknZKqUV9g@mail.gmail.com>
Subject: Attention please
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

Attention please,

Your package is here in our office please contact for more details
about it, contact the head office (info.www.FIOBANK@accountant.com) Or
Whats app number +447701427678
Thanks
