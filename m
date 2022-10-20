Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C7E605FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJTMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJTMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:01:36 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF3C176504;
        Thu, 20 Oct 2022 05:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1666267294; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kYZkMXb8cLrbAN/CA61ncAdPT59/Ov5LSx67xqlB97U=;
        b=L18CzQrw7V+n4B5ZpLcqlPBG/6rfQV04LgnOvTJ6SITL6SqOXJRru6HOVr7mXV67vKz82z
        XisgI6GBSkwD0psBpHRV63JFijaOkmotWJ+2CmYYyJROkxz0cnFCqb5LyiUdPGHnvZiijV
        /MNpWHEOKupv92NNGocYJSSrpCBQt3U=
Date:   Thu, 20 Oct 2022 13:01:24 +0100
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH v3 0/7] ASoC: codecs: jz4725b: Various improvements and
 fixes
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-mips@vger.kernel.org, alsa-devel@alsa-project.org
Message-Id: <C2W1KR.XY3W8ZXSCSAD1@crapouillou.net>
In-Reply-To: <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
References: <20221016132648.3011729-1-lis8215@gmail.com>
        <166609251307.155136.11548088283059583394.b4-ty@kernel.org>
        <CAKNVLfbfRRE3O2uFH6MQxoa_cdqTUcvpGzmcxFm3oCLKFfHv6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Siarhei,

Le jeu., oct. 20 2022 at 14:58:51 +0300, Siarhei Volkau=20
<lis8215@gmail.com> a =C3=A9crit :
> =D0=B2=D1=82, 18 =D0=BE=D0=BA=D1=82. 2022 =D0=B3. =D0=B2 14:28, Mark Brow=
n <broonie@kernel.org>:
>>  Applied to
>>=20
>>    =20
>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git=20
>> for-next
>>=20
>>  Thanks!
>=20
> Great! Thank you!
>=20
> Unfortunately I found a critical bug in my patchset, yet easy to fix.
> So I need some help to make and send the fix.
>=20
>>  If any updates are required or you are submitting further changes=20
>> they
>>  should be sent as incremental updates against current git, existing
>>  patches will not be replaced.
>=20
> What are mailing lists it needs to be sent to?
> Any additional tags needed? I know about Fixes tag.
> Do I need to keep a link on this patchset somehow?
> Do I need to mail a patch with the fix to this thread or
> create a new one?
>=20
> PS: the patch will look like:
>  - {"ADC Sourc Capture Routee", "Line In", "Line In"},
>  + {"ADC Source Capture Route", "Line In", "Line In"},

Somebody already submitted a fix.

> Thanks in advance,
> Siarhei

Cheers,
-Paul


