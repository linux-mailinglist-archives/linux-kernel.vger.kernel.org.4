Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DE66BFB9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 14:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjAPNYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 08:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjAPNY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 08:24:27 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E6417CF6;
        Mon, 16 Jan 2023 05:23:34 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:23:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673875412; x=1674134612;
        bh=HHEPb+FSYfInu1nGAlCBXquqHc3nD5GHUbvyD7P7K+E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=KBHfF46d8tWixUotXkxMVXFrCuNQuli5stA2cygRpvgLi7yQjwrtbSyRtC/vR1LFq
         Jqu6piQ1duj/iwPuWrZ1436nj9dxMc/uBnXWnNFzA7lesN7WCLDmOHr9fYdRgUF1MN
         wbp0AyawFsN4lrMqDNSL7teJVYYa+0xyXBrdSmCejRKCQMBxx+u7dp8bRRB9pYoiGh
         QGfV4x84SB/4RYm6hw/TgIb+9ipTF1f+YbOQEAxT+rFd66/3Za1Uz8lsqvl0IVDoGC
         pQB7q1x6EQihIOldWDBnRgc6DL8X4V3LzwLg1KTAxyr/mO0q+p8KoE7ySW68zXfW2Y
         J44g9BYSSAZaA==
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@dominikbrodowski.net" <linux@dominikbrodowski.net>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] pcmcia: avoid defines prefixed with CONFIG
Message-ID: <v3ljEwMO_JmxXsJBi8zDkqbj1cLa5SuzFZ6Xsdc-QypVtTwok_YApIRX5Rmj7HqplbMiAVjS7UyfYi-_tNh1hzv2u-KPB8i5mx4HMhviHrU=@n8pjl.ca>
In-Reply-To: <CAKXUXMwbkDgwMvB-CDyDbL7CS1eSn4P=87BqfWCyvCvP+SkQ8A@mail.gmail.com>
References: <n-Xd5VZl4mxdBIPvH-LgdDqAi8N9cL3TiAQ6fKEOpXLKsyDAxcf9VWQZfnMobTdIXucJJ1U2B82W6KhoODwWr_n3d-V9YkDcV92AjzxMrys=@n8pjl.ca> <CAKXUXMwbkDgwMvB-CDyDbL7CS1eSn4P=87BqfWCyvCvP+SkQ8A@mail.gmail.com>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Peter,
>=20
> If you are interested in doing more clean-up work in this area, please
> let me know. I have a longer patch series of various changes that have
> been partially submitted and have not been included yet and some
> changes I have not sent yet, as they are really minor spelling fixes
> in comments. Further, I have a list of known false positives from the
> ./scripts/checkkconfigsymbols.py warnings, which you can use to filter
> out some of the warnings, and some experience on this script to find
> what is more relevant to address first and what could go to the
> low-priority TODO list (that just might disappear, as old code is
> completely deleted).
>=20
> I can share all that with you if you just give me a ping.

Why not? I wouldn't mind helping with this effort.

> Best regards,
>=20
> Lukas

Cheers,
Peter
