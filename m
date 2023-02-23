Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D416A1378
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBWXEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBWXEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:04:00 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0FE3B230
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:03:56 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f41so15695498lfv.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DejhSAW9gS1KeLEfZjtnIHcYIxdKK3/9PJBS6qI8N94=;
        b=GUbmkZZvDM+GMPwUetZGxWZoVNoocfUzqNSxTokqnBVDTOD0tnFDjTlXst0lH9tuib
         e5/F0NyWYdSl9EtgqQwX2VBEHS+YCSIuJrs/4mALVQPLPR/NGVkRX6IFAaZd/BocVvEU
         kZdvDXKop0xXqVyiFtNVCX2CBSSLWP3Ur7+Zv/QFjAYPQxhx99bh/ADnfM/uSAMpgSef
         mtO4JkLxOiQYPag/mbbieKLkAgnpR6V6f+nAd0OXFMqjKcSz6+ZdShlQxpnP8eVCZkbA
         amMKUr3SHBZuaHRadkscME76uVzYLLFYBmNycYlPSvr0Fcn/NVVyWyIAqIIGFTv4mRrR
         d4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DejhSAW9gS1KeLEfZjtnIHcYIxdKK3/9PJBS6qI8N94=;
        b=bnq+uofqNbqfzb6BHmF6V1JNzPb3Rm0F0voCPo+E4b8/ksuqJo+jnRxhTvIVexJO8r
         v8Jv8oI8jdmwn5mxSLZmWOsh/Qbz7xpYvPlS+8jcItOlBI9i+DeDTKqQBf2M8izf+cV8
         m9qistofxydSFbOgqIDL8Z0ofaN1zReJWVePJbwE/cDKMGI5cBUAME5U+77bAQqD0dl8
         u4BFw2tlx5zq4lS2aHipkY6VYr0ofTxgILNYdgbuZt3eZFCL70vE4mh/TAMccs/QiJQq
         UG9WOJnOYISMUFW8vRNhrbn9v4+4tIo1b0Jr8a5uHWyywwSlzLBeidkX1mJk2X0U6IhO
         ebKg==
X-Gm-Message-State: AO0yUKWzGuC5a3RJAMNaoRi3ImNQDOYRbhRPcMbod2qKNNkVlav1phqg
        v+iv41ETyprJFqN6O/SWnBWZD4REUIiXcjlEJeE=
X-Google-Smtp-Source: AK7set9aVnNVGtRPyrraCVd0DYjMbqxIdYAN00Vt5tT4fS9O/W1yfFKDzWUlz8Jd2eFbeELTJBoty8SB78ZaDEgXAiQ=
X-Received: by 2002:a05:6512:516:b0:4dc:807a:d148 with SMTP id
 o22-20020a056512051600b004dc807ad148mr4277107lfb.7.1677193434626; Thu, 23 Feb
 2023 15:03:54 -0800 (PST)
MIME-Version: 1.0
Sender: samukafand@gmail.com
Received: by 2002:a05:6504:3147:b0:21e:3ecd:7380 with HTTP; Thu, 23 Feb 2023
 15:03:53 -0800 (PST)
From:   "Mr. Daniel Kafando" <daniekafando001@gmail.com>
Date:   Thu, 23 Feb 2023 23:03:53 +0000
X-Google-Sender-Auth: Xqxn9MSMuDC9HCmtoufaeTzXgm4
Message-ID: <CAHLDSskX2acoaHKxn=dhPk7FU+Hy68Tb41-XzjivJcuEdrHYhw@mail.gmail.com>
Subject: Am expecting your response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=20
Goodday Friend,Mr.Daniel kafando. and I work with UNITED BANK OF
AFRICA. Can you use ATM  Visa card to withdraw money at ATM cash
machine in your country?  I want to transfer money to you from my
country;it=E2=80=99s part of money taken by some old politician that was
forced out of power.

I will change the account details to yours, and apply for a visa card with
your details in our bank, they will send the visa card to you and you will
be withdrawing money with it and always send my own percentage of the
money, and the money we are talking about is $4.2Million us dollars.
Whatever amount you withdraw daily, you will send 50% to me and you will
take 50%, the visa card and the bank account will be on your name,I expect
your response. promptly so that I will give you further details.
Mr.Daniel kafando.
