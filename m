Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1CF5F607B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 07:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbiJFFMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 01:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJFFMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 01:12:12 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AC589AEF
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 22:12:11 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b2so714818plc.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 22:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hTJJPYSRY685vzhqWKo5B6rubnA36bCEXmZnw2zvpvI=;
        b=OnLu5PxTXEVk4QwLnWrVWgkGoHJYLLUcxGyAWIE+4Oi4ZvIGkQ+0cqLen/qkyceaJQ
         UjmOi4vEe1vyyGEDjsVv2m67csRT3JY7tVRXqZyAlFwItwUgT3YxLs2zxoHjTUaJjgtz
         rQ6ucfxz8xZaSMb46O0dXPA6478UDHn5A6/qM0u5ZoM/bd7QIwBPrV0TMKuekO+YLp/Y
         gJjolJ5eKOPhIeSIan/36j/eDVO1wadguS4MSFbTaMaCK0cnupZ5sezL9UULv84+7Z/q
         WTAAYPS9p8L6wwG3fVQblQl2M01rUZyW5Sl+fsDPckJvdAlYjuhoOyeweYiN0MP+VsHu
         mPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hTJJPYSRY685vzhqWKo5B6rubnA36bCEXmZnw2zvpvI=;
        b=ecJmtdDTKW/0LvhsO5EUPCgo0vz4NJQ0ByUJCvnT8W1aWvUU06e5ZZRhSMqCEYXCqG
         vjOBLgUa/KSXFivNPk5WreZH5mS9w3/KSZd9zy2Sbq635jmAbX/4s2kikWLeotAwYRhM
         J6XkJUryiUwm51vnFhiuKEPfzyOcjalapn14TE6xB0Pk+pPUc6RHkA9hyAdwC8mFOFUV
         CKLdrR85HHzdffmsUlFpSRy3c2Iag25S2PnmjZVUtDYDrCPA0k1QCAEXAurpDoNAOYWM
         AqwNvIXfTMy52MUSG1gacoanwDndGotW9lWP55GwoIbRnGZcMkL2KuVKV+NnzXgv/TGU
         KdZA==
X-Gm-Message-State: ACrzQf0ICsqdlISj0bnqokt68YTARt6TXdZaG2OWMF4YyFCsmvBhS1dS
        g1QBAGp7+i2v3Y/8WMOitU4/JFvgWBpJqgZTOVI=
X-Google-Smtp-Source: AMsMyM4H7sdKukSqx1hiyWVGFXFcfOd8cZ+iJoVUFDYcDZn530auCcjXMDlaLxw5fc1qiuR0z/NKd1BrGJBDxfHvhbg=
X-Received: by 2002:a17:90a:bf84:b0:20a:d039:f1ea with SMTP id
 d4-20020a17090abf8400b0020ad039f1eamr3156791pjs.245.1665033130657; Wed, 05
 Oct 2022 22:12:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a06:1d21:b0:536:3e39:13fc with HTTP; Wed, 5 Oct 2022
 22:12:08 -0700 (PDT)
From:   DR AVA SMAITH <dravasmith69@gmail.com>
Date:   Wed, 5 Oct 2022 22:12:08 -0700
Message-ID: <CADPm2ET2++VD=eU6k4WEn_FfuYx-R_DcRMcDgcF63RXYBZoWsw@mail.gmail.com>
Subject: From Dr. Ava Smith From United States
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
Can we be friends? Reply me through my official email
(avamedicinemed1@gmail.com)
Thanks
Ava
