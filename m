Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF1C6323C4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiKUNeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:34:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiKUNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:34:05 -0500
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 952D7BFF6F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:34:01 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:33:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail3; t=1669037639; x=1669296839;
        bh=cWyjS8gJ5tYyIQcQGe5x9R0S+IOi2uZyenuqRvdGD6M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ILoOFbgNvrObh0zLDV1ydlnFPyd2OcpXrNdSngiGAHxaV+qoBo8sIgM8E9mW5GDXv
         qnGU/jPbxH9zlCS091gM2bF+kgb470a6oyPNV2VGWX/24mQhxQV9Jn911N+xY2SjNO
         8jhVZ/CLaBgipbxki3ThWeYI/YJGxDsPjO33YMbXiCJ/vu912kQSdsXfVNbQclOT2T
         sc17JGHYR17xP7ZKI9cddTVIVfQRU5Dz4mxopOlOC1SixIxmy4iErbJC6mJ9vDfG2/
         FCqMbGlk3LwlnA3QZi9dCLLtsBcSsn1BZtVQKbCbzE0jcX4coZxb1mAYlVDrB1w1+j
         hDW/VC+QRfg0g==
To:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     dri-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: git send-email friendly smtp provider anyone?
Message-ID: <9-qCHLoI7vMtVX2UmZbrcDSyMIJRqoWx6G2sZEn08RP15vYjPwng_fInDkKYPvllUddwXshfYs_fIpPH3_TeFLat2MQx_LT5Hfb0dxb1vGA=@emersion.fr>
In-Reply-To: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
References: <1bc45775-0667-01f8-36e1-9f65d3081092@tronnes.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think you can apply for a linux.dev mailbox [1].

[1]: https://korg.docs.kernel.org/linuxdev.html
