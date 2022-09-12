Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B625B5E72
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiILQm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiILQm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:42:26 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2693E747;
        Mon, 12 Sep 2022 09:42:24 -0700 (PDT)
Date:   Mon, 12 Sep 2022 16:42:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1663000941; x=1663260141;
        bh=8Z6sOvoR0Mf6iacQoRSQnQtm2aSwmES8KBfExntrpTQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=oxcvinPpZ4pIgnr3U2EL1coduF7WuQA4cYNoLMJZn99xdBg9ik5zNZm9qQiZNNBzw
         Jswp6clwVpmTx9TusCrLyYtCX3HNPd9U9Ns+pQOmXH/epsG7524Do4p9/9iNs9zGne
         Rq/VttL6PE+nqVK7eJ89G5VHOWwPxcxx7CLY1BBddFgHTeDWLHdH2PO7QqF6i39qRz
         tMV+YXbqW+ObC/MuPGryWwGaCGWFxX58HZruLh+0HGAq9bYLZf0YDfLfYtEp+z0NQo
         MnM98DnRwXc1rJ4nYCFdq9kFW18Y1+uM4eILMgVSRt1hjT39C1WU+T1hyuxsGjQdpD
         owWdIxxcA+xnA==
To:     Armin Wolf <W_Armin@gmx.de>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, rafael@kernel.org,
        lenb@kernel.org, hmh@hmh.eng.br, matan@svgalib.org,
        corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: Re: [PATCH 3/5] ACPI: battery: Allow battery hooks to be registered multiple times.
Message-ID: <wY3UHtenNt5tmQSMtoDLmzNxvJ7B56SLwlhguYfg6rqC71dDDCYypvSqvS0SUhRJwsel8wBEy3yeS8rDlJCOii24Llo0XKU34IcSn5WNwg8=@protonmail.com>
In-Reply-To: <20220912125342.7395-4-W_Armin@gmx.de>
References: <20220912125342.7395-1-W_Armin@gmx.de> <20220912125342.7395-4-W_Armin@gmx.de>
Feedback-ID: 20568564:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

2022. szeptember 12., h=C3=A9tf=C5=91 14:53 keltez=C3=A9ssel, Armin Wolf =
=C3=ADrta:

> Registering multiple instances of a battery hook is beneficial
> for drivers which can be instantiated multiple times. Until now,
> this would mean that such a driver would have to implement some
> logic to manage battery hooks.
>=20
> Extend the battery hook handling instead.

I think this is already possible by embedding the acpi_battery_hook
object inside the driver's device specific data object, no?

Regards,
Barnab=C3=A1s P=C5=91cze


> [...]
