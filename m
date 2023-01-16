Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35A066C3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjAPPXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjAPPXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:23:23 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34CBF23107
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 07:21:07 -0800 (PST)
Date:   Mon, 16 Jan 2023 15:20:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673882466; x=1674141666;
        bh=9ROIcCxSwU24OpoN9yTEGGEsUmOW1HNyhUpmcbioTJg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=5UBduxfG1gCOkgNJ2vWniOv8muZ9owo/AT8a190wmqu0hVW8kRITBYfIzbb5DNr6d
         pHpmsCxvBRWWXDO6lQ0ZtzXiRBGSAm675HVV5f/s60oTpnoRWXG0cSlX7vefC7SoNU
         BUL/YDAdFB1WgleJxIocfcSkmLaz5MYWGKfOts1ygr3kewS/imolDKQOAT8KR4aR08
         9r9w6tEodCVuRxeT4dsNMQAOFy0x1lJAlIiUbhG2ZFlafWTPvRppLS48ZJJDE4MupQ
         LD6ctfuKCKascrxm9osuYFJ56a2brt+S79yC0wDmGYNb5aaa9pxV8DlK/378B1/T9A
         sYTJlzudusD3Q==
To:     Ard Biesheuvel <ardb@kernel.org>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Message-ID: <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca>
In-Reply-To: <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca> <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please don't send encrypted emails to the mailing list. Plaintext
> only, with the patch in the message body (not as an attachment).
> Please use git send-email if you have trouble configuring your email
> client.

My apologies. I was having difficulties configuring git send-email,
but now I believe that I have the issues resolved. Future patches will
be properly formatted.

- Peter
