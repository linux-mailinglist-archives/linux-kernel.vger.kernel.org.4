Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C5632A30
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKURDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbiKURDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:03:10 -0500
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38D168689
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:03:08 -0800 (PST)
Date:   Mon, 21 Nov 2022 17:02:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1669050183; x=1669309383;
        bh=jIwhtVqiPBD1rHokp4VDGo3ANO+jasGNytDOydWD1NA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=FxzWR6n2hgvy2nlcNngrgmpUJlAYby24mS11f5lwUXxq7UuQHcZyE1BRPjDWxKbRO
         G2savClyLGnLMRvnPv/kZIj9G6EhQLaRezRiZOPtHBhs7WT6T5N0evAXWdeImovLaR
         2qbeq37MwmBDjPojiKdB5ihawkKN5xWByRBIH/8Z9IRlfdsoq+ymGO0EI3iZ5ckYg8
         t850sdBtbSLdCAKPtQVsJU3olMx5IKOUrl3kBWzs1oTJz8V/y0SsxBjO9NqsNWrjlu
         JNSxcyQ6fmJRpa6+7I2mhdb7ZNQybJqa1UU5tQc9GpgVwuoyl7whHVY+kKebo6qez6
         n4sizTBV8TgHg==
To:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: git send-email friendly smtp provider anyone?
Message-ID: <29wzxSbEeYmXyru0ObDIAEG_W_4Wh0qj77Y6zMgmfT6UbaftflIVKCcAdEuSsmsIoK-85IvhTC73Yh8UDm6et4EK5JZZbeeByj_j0spUc9Y=@emersion.fr>
In-Reply-To: <72e873e9-d4df-895b-2531-30168b8a4d64@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org> <9-qCHLoI7vMtVX2UmZbrcDSyMIJRqoWx6G2sZEn08RP15vYjPwng_fInDkKYPvllUddwXshfYs_fIpPH3_TeFLat2MQx_LT5Hfb0dxb1vGA=@emersion.fr> <72e873e9-d4df-895b-2531-30168b8a4d64@tronnes.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, November 21st, 2022 at 17:52, Noralf Tr=C3=B8nnes <noralf@tronne=
s.org> wrote:

> Den 21.11.2022 14.33, skrev Simon Ser:
>=20
> > I think you can apply for a linux.dev mailbox 1.
>=20
> Yeah you're right, I didn't know about that possibility.
> But it depends on whether or not I can just use their smtp server and
> keep my current email address. This looks like what's the problem with
> my current ISP, I need to use the email account I have in their email
> service (that I've never used) for sending through their smtp server,
> but I want to send From: another email address.

That's not possible. It breaks DKIM, so your emails will end up in Spam
folders or be rejected. You need to use the SMTP server tied to your
email address.
