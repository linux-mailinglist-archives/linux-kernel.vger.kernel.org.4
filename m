Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AE46C9E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjC0InG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbjC0Imp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:42:45 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EB07AA9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:38:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id cn12so32641066edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679906301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNVnc/90+f2lvbZbSH9LWWMaxMwruTlZ8I2hMPaGmeQ=;
        b=XPdUVjSET90ZXTary0IkK8dA5qQPnBeRf1MakgnKXLw+cILHzy9A3Tr3xnaJHbj1WY
         j3txXroOLxDJZd/pdpVR1UDVTEGJfQG2fvez/att0uu4TXVQ5V4qKCi8XhiotmELwoLM
         Olrs3viPRrNusNbrZ0CZ/jxAr7o1h8jBHySHdEgJ28lzSH/Y3Ie0QJtj+gmiO1+kuhJ6
         VpjxbflmdecPa3lzFT5MXybGVsA6yJMLgMPf7dueqeGSTsEvPecTJINs0s4kxyZDNQ0/
         1PfHgSEeVNl2Kj4Il/69x2Q8T/KSObdfmdEgfx5XxNA1qxsFm9DzFUnyn4a1SCpYZgK3
         /1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679906301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNVnc/90+f2lvbZbSH9LWWMaxMwruTlZ8I2hMPaGmeQ=;
        b=z2n6Qt4Jvg2fQhHK4Ug7Xtmn2WDDLF0+aeFwwSsVrn+CUwaxUIE/+CgB1m3kpmafIl
         DNDkcB7EdCKLIOyKjgRkYNEIusoG/zRTErsb7Lpghb8fK+/94MVeOXcomJlzlC7br+m0
         kVyRQQZdUd5pt8b469gjNIzIogHBYYRUpeB0UDztbxzji6qg+9LjK592UTNCkEnEFkNf
         fB6HWzivMKo1qCOZQLu2txwS2wyFGOAOxOgv6ePl7JZzRaddyLkP5p01A6pHFd3xzTRN
         S942WoYo4Zzk5kRcO80NXti3wEK//pTntxU5VrQh96Owp+XDJS0bD0sTEnofHNNhjQxM
         H+KQ==
X-Gm-Message-State: AAQBX9fKJJCmzyQNj51+Q1KeJrR7vMvefnVP8Un/6809VdgGVpMnhhIe
        48HiZzoGobXfEXOvNQsKxjxeXgQrwB3HNA5m1ek=
X-Google-Smtp-Source: AKy350ZBClH8vnHiHREIlIn2x+Jcdi1WCNrrLl9BaQROZUMwfE8Td5j9oXq3ybAAJTkGkBiO78SDrJ+HHZfxPS/2sgQ=
X-Received: by 2002:a50:cdda:0:b0:4fb:dc5e:6501 with SMTP id
 h26-20020a50cdda000000b004fbdc5e6501mr5363908edj.1.1679906301632; Mon, 27 Mar
 2023 01:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230325083643.7575-1-clamor95@gmail.com> <20230327083316.GR68926@ediswmail.ad.cirrus.com>
In-Reply-To: <20230327083316.GR68926@ediswmail.ad.cirrus.com>
From:   Svyatoslav Ryhel <clamor95@gmail.com>
Date:   Mon, 27 Mar 2023 11:38:10 +0300
Message-ID: <CAPVz0n3F7pR8_duOd3-mq6iqNEYxDJ8-6AQL4M_8T5rDwbntoA@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] Implement DMIC support in WM8903
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=D0=BF=D0=BD, 27 =D0=B1=D0=B5=D1=80. 2023=E2=80=AF=D1=80. =D0=BE 11:33 Char=
les Keepax <ckeepax@opensource.cirrus.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Mar 25, 2023 at 10:36:42AM +0200, Svyatoslav Ryhel wrote:
> > According to comments in wm8903, driver lacks DMIC support.
>
> Which comments? I am having some difficulty finding these?
>

Lines 10-12

* TODO:
* - TDM mode configuration.
* - Digital microphone support.

> Thanks,
> Charles
