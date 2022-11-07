Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC761EF9F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiKGJwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiKGJwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:52:39 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5975F14D3A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1667814754; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NizqJD8Q016qLqC4Ks9C9UDul8yMaAw6Z3zOtKOWClE=;
        b=Gzdw9P+3UW7itQ/BwCwX4xeIRqQcDWBZHmZag2uZrSuaL+UHXqZPCupe6cIVRQsno4JoFB
        r//slxRQEfrkwFMol9aaskeYzFWa9L2iSBKs2u0BaU3o+kmwvX9x1R286KHIdHP5DXDgO6
        w1nx9bGrSKSTm3umNGthAZoYlywOcss=
Date:   Mon, 07 Nov 2022 09:52:24 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] ASoC: dapm: Don't use prefix for regulator name
To:     Mark Brown <broonie@kernel.org>
Cc:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Message-Id: <C32ZKR.QZWY19EUAOMQ3@crapouillou.net>
In-Reply-To: <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
References: <20221025150149.113129-1-paul@crapouillou.net>
        <166680764848.867857.6473365992161385316.b4-ty@kernel.org>
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

Hi Mark,

Le mer. 26 oct. 2022 =E0 19:07:28 +0100, Mark Brown <broonie@kernel.org>=20
a =E9crit :
> On Tue, 25 Oct 2022 16:01:49 +0100, Paul Cercueil wrote:
>>  When a component has a prefix, and uses a=20
>> SND_SOC_DAPM_REGULATOR_SUPPLY,
>>  the name of the regulator should not use the prefix, otherwise it=20
>> won't
>>  be properly matched in the DT/ACPI.
>>=20
>>=20
>=20
> Applied to
>=20
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20
> for-next

Small reminder that this is a fix for a bug introduced in -rc1, so it=20
should be queued for the next RC.

Cheers,
-Paul

> Thanks!
>=20
> [1/1] ASoC: dapm: Don't use prefix for regulator name
>       commit: 1683d3282f240336a2b4b6b541d435facfe8bbb6
>=20
> All being well this means that it will be integrated into the=20
> linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
>=20
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems=20
> and
> send followup patches addressing any issues that are reported if=20
> needed.
>=20
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>=20
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>=20
> Thanks,
> Mark


