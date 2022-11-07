Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C3E61F3DD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbiKGNBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiKGNBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:01:36 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F6813F5B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667826094; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jg77whTZveEoQ4sEVKCo7IpSsBmp7pePPNkjnV6eYEg=;
        b=iOPNyAbZkJoMiPOsLg/c6jtp5DOovGsw0OK1QlusFqCJaikvF+7HoqshP/uAVBPlS6jsEC
        6W7tjsyTGC8MvWDJNXqq7zqdxUcd9rYNWbWdouEUQIL/1TE3OGMAeq9x224hILegRFdApk
        M6HBKtP3l9TPbqVK3CUeD2aNMlXvrVw=
Date:   Mon, 07 Nov 2022 13:01:24 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: dapm: Don't use prefix for regulator name
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Message-Id: <CUAZKR.FFCM32N7ZV5C@crapouillou.net>
In-Reply-To: <Y2kAoV8gCEZZgHhk@sirena.org.uk>
References: <20221025150149.113129-1-paul@crapouillou.net>
        <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
        <C32ZKR.QZWY19EUAOMQ3@crapouillou.net> <Y2kAoV8gCEZZgHhk@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 7 nov. 2022 =E0 12:57:05 +0000, Mark Brown <broonie@kernel.org>=20
a =E9crit :
> On Mon, Nov 07, 2022 at 09:52:24AM +0000, Paul Cercueil wrote:
>>  Le mer. 26 oct. 2022 =E0 19:07:28 +0100, Mark Brown=20
>> <broonie@kernel.org> a
>=20
>>  > Applied to
>>  >
>>  >   =20
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
>>  > for-next
>=20
>>  Small reminder that this is a fix for a bug introduced in -rc1, so=20
>> it should
>>  be queued for the next RC.
>=20
> This is already queued as a fix.

Ok, thanks. I didn't see it in -rc4 and thought that it was queued for=20
6.2 instead.

Cheers,
-Paul


