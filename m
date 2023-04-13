Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C786B6E0E9D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjDMN3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjDMN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:29:15 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B8C9ECC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:28:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so4191101pjk.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 06:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681392535; x=1683984535;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OX1s2Ip7hpbO50rw0mpQgWKmr2sKio07VQZqXu2V7Lo=;
        b=bie1TryaADvIG1Dc0ltt89H/pABTzYLC17fCxYN+7s8SgByLGREkhrUviYqZlzc14B
         1GY4UETPLoD+u5ObJJ5YcxFa/7qPFftfhDOQPg+Utzruu3RTXJtWcl9+t+yhwxA3X0QE
         Q1k0JFDdAOrkdB9vjstn7n2XILFo+szwa+2HcB1RjvOXRZCj11RmM+e6eAfm/NjnEoc4
         KdlxTAP6JHYlsfq2tNIrJ1tUPf2H87kvzQGejHiddR85nSv05w69gquXo88h2f72oMY3
         Mp6cuuOMXQq51TTaGyCTk4AO8kd9KwHCUKh7ed9QqTcovGr8nYUic7yanxM5Zks7aFkA
         v3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392535; x=1683984535;
        h=to:subject:message-id:date:from:sender:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OX1s2Ip7hpbO50rw0mpQgWKmr2sKio07VQZqXu2V7Lo=;
        b=NGS6E87msZm/KYli9ixYOGJ/9N+HmMhWi++4jIrwjWK8eN3/CZGfpj3Vua+UdXuDAq
         tQ4QDgDVNsSxZKq6blHUFMY4cSPmACUB+b8i9jxd90LMjDL2YAHvS2+Q2SNLJJm0Iezi
         CmQaMJxLuoviurwYF2rbs1+pdGD+QuogUPL0besF5NdxvebQE5ZPkZC3tTsyTN6rUx51
         TgXcirxH4RFxVeYEuqnWSlJFnmu8AR8zj5c6riF6cnGkUloUiF76U6PM89xD8+Ac0Ia8
         WaJJNoljnl9Jq6ft+qela81F0Ob5lsA+5QBlN0wKHBbXTOn5Vuj7m2auqmy4iLj62Yqz
         epeQ==
X-Gm-Message-State: AAQBX9doNN4ZlobYUY21oUq7PVOYbMxlJ2FP+b58AQyzlP+VoRP9MxZD
        XSIYFkcNSrc7TSquKCPprhlR2DZqOumPPEtKXuw=
X-Google-Smtp-Source: AKy350aXdh7BXHczF5FuaM+fP823Gf4hUBd/zDoBEfnFyBHTojRujZ5iJIXYvUfplGDesLDcFyUb5aGgUviw3aczItE=
X-Received: by 2002:a17:902:e54a:b0:1a6:898a:41fd with SMTP id
 n10-20020a170902e54a00b001a6898a41fdmr545554plf.6.1681392535331; Thu, 13 Apr
 2023 06:28:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: johv19344@gmail.com
Sender: drmusazongo11@gmail.com
Received: by 2002:a05:7022:1a84:b0:61:df4b:618 with HTTP; Thu, 13 Apr 2023
 06:28:54 -0700 (PDT)
From:   Van Der Kuil Johannes <johv1934@gmail.com>
Date:   Thu, 13 Apr 2023 13:28:54 +0000
X-Google-Sender-Auth: Cl5Lae-zbfyTZqeryOyaEnYuH90
Message-ID: <CAGKduDyD8Dw3VFN1R=7qhv_Q7DDbrnBMC4Vhc+ds9_2NqT1NmA@mail.gmail.com>
Subject: Are you ready?
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, how are you?  my name is Van Der Kuil Johannes Gerhardus Maria.
I am a lawyer from the Netherlands who reside in Belgium and I am
working on the donation file of my client, Mr. Bartos Pierre
Nationality of Belgium.  I would like to know if you will accept my
client's donation Mr. Bartos Pierre?
