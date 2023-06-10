Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5170B72AC92
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 17:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbjFJP1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 11:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232544AbjFJP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 11:27:50 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD64B3AA8
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:27:05 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-977d0288fd2so464768466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Jun 2023 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686410824; x=1689002824;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J2h58As/6CbhJ3fHWyox1/2UfjjLwRjfP8NQKRgd39w=;
        b=lTitWVIag2GN8JkSSfLUaRbB2aXJS/UEwpwWC1IEmTTeVjFvV7GDK1DP7J8GPRU+lQ
         fN7OulgGalI1syJ8cK4nTH25Co+CaHI5UHUiXxH2YZaPUPwQ/2FabNl+0P6Hjz8Mvaim
         VUl0TKvAsXvJYLFAE15WzA7iCy6Kia5HqoEVyoq6EZGxM13OjC5AH81Ovba2lOkagCJu
         fNou5eiHtYd4JUOcu8U4Uw+pAIgg8V6WxSENHsXyp9tYynteQNrsq4iH3ndKzj5adPiU
         6zSIbqREx6vbyjJDUlw/TfGK/e3H5qi0eH3ACq3Yoralr9hmokBazWiQf6hvFv/IP0jq
         oswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686410824; x=1689002824;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2h58As/6CbhJ3fHWyox1/2UfjjLwRjfP8NQKRgd39w=;
        b=WiBwILYDPFfkHo9p+OVntd50jH4GJHMsl49CIImglu9LnZ11PjiA6P7dFJv7CmuM3c
         jDCSmUy6u0pLfrhXI7809TN0+WRrsMyiGHwygITxZoVsuS3H0vIHOgJigXzmTeXHgoYT
         LomTCs9577Cr2cVB/6QqRfm0N9IWnajTbHnkeq2vdAo5q1+CfQlcQH5a152EIZs+KBs6
         eDiQTHnPiIoRpe1HU6VO5Z2wSE0zaqODNqPCM9CYEEddAzpYNPQmz0FukuQBlMdNLg64
         5NvGEY/yi2n/C1t46H2SLOAb0fvNk2GO59Oc5kW77wH6ZeyAo3dNHnxeDrco9gw6pp+D
         3BrQ==
X-Gm-Message-State: AC+VfDzu1NDvh1X5v86lwIZpW9WKDZkltWDdEpgd/v33YF3i1BKENnvR
        JGanMBXQ/axC/LLilANNqOILoAJfYP0Leky3vSU=
X-Google-Smtp-Source: ACHHUZ5Djv9fohZMsXCgcKVLAnCPy87MlHQ6+bHU95G49/lB6xyl3mOAMYQ1lRErmlAiDcNJbLwcAUmoZBj/5W0P1jw=
X-Received: by 2002:a17:906:fe02:b0:965:fb87:4215 with SMTP id
 wy2-20020a170906fe0200b00965fb874215mr5071743ejb.15.1686410824086; Sat, 10
 Jun 2023 08:27:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3801:0:b0:21a:85:e990 with HTTP; Sat, 10 Jun 2023
 08:27:03 -0700 (PDT)
Reply-To: imfcorn@gmail.com
From:   "Director, African Department" <obasidiplomatbasil@gmail.com>
Date:   Sat, 10 Jun 2023 08:27:03 -0700
Message-ID: <CAO+7-siku7KfVxj5+5ABE3bTpZL2+eQ9uOOPwXXJBD-OZS8aCA@mail.gmail.com>
Subject: HAVE YOU RECEIVED YOUR MONEY???
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HAVE YOU RECEIVED YOUR MONEY???



YOUR PAYMENT, PLEASE GET BACK TO US NOW.
