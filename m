Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4596E9FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 01:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231621AbjDTXJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 19:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjDTXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 19:09:22 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DF7CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:09:21 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-18482e20958so1102505fac.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682032159; x=1684624159;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBGcORFlx3mmfZ9Ef5BjM/SdwRHzq8zieg/Y4xH2/5Q=;
        b=KdqyUqVE71bVdiA9SO9u+o5nR7iEtS/1XK8kUMBi5i77ALLKN73ZqJCTW2iVoXj4Il
         iZHPa8Z5gWiR9Zd6y+5HJs4Youh/r3kedkP8eQmGtXFDU3gFhMwSWZobcJpN8RaEr9Jr
         /jRNEgcE4x4gDRF6AJd1KHaROYqANryUx1Fz686J0zmW24lwug3CoEqvM+1Q3/U0bJ/L
         GXCTs6AYPcnyu+erAueNLUKs1gKrI2xrVyFJPq6VkU0fu3Gzcy0sNr8XtkMCRSt+rp5C
         W+HSog0SZGxlcULtSqoRezCbez4dtHJrJi94JqxeFyFY46EouPqnDJyu9RFgtWmYbbWR
         r3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682032159; x=1684624159;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBGcORFlx3mmfZ9Ef5BjM/SdwRHzq8zieg/Y4xH2/5Q=;
        b=R2jiJJDq4DGLDV69oXtpDdvDzwgvjerNC/co0lLrZ3zB1wAOSZUHAqU19kvArIh5zQ
         C6aZkk9QtzseXnjWMY378kSyFc0gdNEXYuuuhjb5+xhJBSSBNQhIsShd0mwSrEEoroAK
         FPrtNAQiDV8JP9f0meCZqJ2V0L61QQnSJTAJ42NjYPvacVdH4Tao3Cg3uDMzcIZDcaUP
         P54HV0qv4AjNPuGjauXBQ8iLt12v1EQz5K/fhypxZ+y2BEfCMK2pz8bjFk+YAC+zpWwY
         wL29GtTVnF4Hwm8G+ukr1DRW4Dt2YKHAG19f5bDoDw0OXHLAqN9lpB7u6daZM0UNkf4K
         ebQA==
X-Gm-Message-State: AAQBX9eUlJ8g1YD+k9nBC3NfZMCeuab6D+JA4LkyEOiItO0binBifzyh
        DSlACIEA4A0UAKEocB4+fjAr+Mj47WtrF/aX6MU=
X-Google-Smtp-Source: AKy350a24msXs59EyyWm6fm3KmjAsKsV+jO/JleityDHxSngqMNLKQ8GyP2GjJswDo/mxnI2KVmyrhcl3NgEki7yz2I=
X-Received: by 2002:a05:6871:6c81:b0:180:2a9f:1ac1 with SMTP id
 zj1-20020a0568716c8100b001802a9f1ac1mr1057297oab.2.1682032158981; Thu, 20 Apr
 2023 16:09:18 -0700 (PDT)
MIME-Version: 1.0
Sender: insurancepolicy668@gmail.com
Received: by 2002:a05:6840:1c36:b0:1255:75af:909f with HTTP; Thu, 20 Apr 2023
 16:09:18 -0700 (PDT)
From:   Moon Lee Park <leeparkmoon14@gmail.com>
Date:   Fri, 21 Apr 2023 00:09:18 +0100
X-Google-Sender-Auth: QGZf-hp4Dd5fYAR8AG4ktGnPsVk
Message-ID: <CALH=hAhHyqAdLgBASJ0x-DEJsNuqzH0q7K=q5O8=UpaaDjpOpg@mail.gmail.com>
Subject: YOUR URGENT RESPONDS IS NEEDED.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORM_FRAUD_5,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,MONEY_FORM_SHORT,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing with tears and sorrow in my heart,My name is Moon Lee
Park. I am  24 year old girl and the only child of my deceased
parents. My father was an oil drilling engineer and he deposited the
sum of Two million five hundred thousand U.S Dollars in my name in
United kingdom bank  before he died in January 2019.

Please,I want you to help me and evacuate this money into the account
for investment purposes. After fter transfer, you will also help me to
get a student visa to come to your country to further my studies. I
made this decision because my uncle wants to kill me and take away my
inheritance!.I reported my uncle to the local Police here in my
country South Korea but nothing has been done to help me. My life is
in danger here in my country!

I am writing this letter to you from a local hotel where I am
currently hiding for my safety until i leave my country after my
transfer,I am willing to give you thirty percent of the money as
compensation.If you agree to help me. Please answer me quickly in my
private email address so that I can send you more information.

leeparkmoon14@gmail.com

Yours faithfully
Moon Lee Park.
