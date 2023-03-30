Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699DC6D0B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 18:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbjC3QoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 12:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjC3QoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 12:44:19 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CA4CC38
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:44:18 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ew6so78876742edb.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 09:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680194657;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xwiwBNBs2CE2KZ5BoiMhSpyLqd/F8TwXWRMs/tY8Dk=;
        b=Z0qBg/uzci5gN8BmDOM/7aNb25EG8s1x8UIUHF7YkYBiPUypJ6dwHh6AiE364WjRS0
         wO1BOa0HB0DHEj8bAN5fWFHFFYI05HM8lDlkBtnGZLOwSno/FMcU32SI0xHI2oS9Y+ym
         lnzPP76OWb/NtKkKklGCkuxNFKQB3ljLU1guDhOyV6V/Vb95z5lUM3MRY9aumFGteQBt
         NF+lJiLC6rlQbaon922fax4ZO0ZvQTgDCj0XLUtOvb+j20iuyIoGzYzuXLhRRsjOUe2Z
         gNJmNpD3KVfjFkT3y+SyhMCxj1Uxaumi6mQoDYT+qqev+v/8wjc4GfLrhC59FGiaf6lQ
         vyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680194657;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xwiwBNBs2CE2KZ5BoiMhSpyLqd/F8TwXWRMs/tY8Dk=;
        b=LyQOfSAbKmo3C1th4FmndYF4UNNEOtkikQamHMpyZjBrZIKb0pRppqg61yTKm0OF5L
         vPaCaGRNneGhABF2lzSo5U/hwsalF8nDg6bT0EWlNw0wIR58AbXkfr5+XO5EustOSFVD
         rrignPSKJpQo4oshVdNTvHvYtmywZCCzVOpmylgdzNBBqQibTGBJCWz3PcODgS3NBXY5
         Blbb03NPmNAbfuaJoR+MzNmLxiDmmJFoRzyg3c70E+42/lZeoD1fUx+mrni06/OBzp2L
         6y/5ExTKtOmLep5pRFbzUh5k2BLNIJkPCqJx6mL8hchfIWKPh2hgwSVyfz7wsBS+Is0a
         vNyg==
X-Gm-Message-State: AAQBX9cb/tNtQKT3Oc4RsPNlSl6fH3dxhGFNQcs7YclkOzJI52b3IArW
        T27zcVxo5N6RiHyUaNPfIkaNUlwAtvSPyJau5ic=
X-Google-Smtp-Source: AKy350YLN9vrD4iCAf0hZQl9A1z7j4G5R9T1iieZPHV8DTUsmpJpnVrRF4XaBJkcBaHBB4G3+xQGqWXebAZd98Fhsv8=
X-Received: by 2002:a17:907:7247:b0:8f5:2e0e:6def with SMTP id
 ds7-20020a170907724700b008f52e0e6defmr3414725ejc.0.1680194656947; Thu, 30 Mar
 2023 09:44:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:1456:b0:66:768c:4603 with HTTP; Thu, 30 Mar 2023
 09:44:15 -0700 (PDT)
Reply-To: flevianmeyr@gmail.com
From:   Flevian Meyr <francadavid110@gmail.com>
Date:   Thu, 30 Mar 2023 18:44:15 +0200
Message-ID: <CAB0YgXqBeQJ6pER7gGQ+hhjFHgAkmv5AyFSX-Wf+B-bE93DHAg@mail.gmail.com>
Subject: From Me to you, please pay attension
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,LOTS_OF_MONEY,MONEY_BARRISTER,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [francadavid110[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [francadavid110[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.5 MONEY_BARRISTER Lots of money from a UK lawyer
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.1 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Re: Covid -19 / Relief.


The Corona virus Disease (COVID-19) pandemic has led to unprecedented
disruptions to global supply chains, sharp drop in global crude oil
prices, turmoil in global stock and financial markets, massive
cancellation of sporting and entertainment event, lock down of large
swaths movements of persons in many countries, and intercontinental
travel bans / restrictions across critical air routes across the
world. These outcomes have had severe consequences on households,
livelihoods and business activities, resulting from drop in global
demand, declined consumer confidence and slowdown in production.

In this respect, the World Health Organization (WHO) introduced an
initial package of up to One Hundred Billion USD immediate support to assist
affected countries, households / individuals, Micro, Small and Medium
Business affected by the COVID-19 pandemic. You have been selected as
one of the beneficiaries of the Covid-19 compensation fund. The
approved sum of ( One million, two hundred thousand
dollar ) loaded in an ATM DEBIT CARD for easy withdrawal at any Atm
Machine closest to you. Your prompt response and compliance will help
in initiating the process.

Sincerely,
Barr.Flevian Meyr
