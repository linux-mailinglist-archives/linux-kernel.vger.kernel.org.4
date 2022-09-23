Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B65E7F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 18:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiIWQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIWQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 12:00:34 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE710D66B
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:00:32 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 3so367456qka.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 09:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=X88HL68aCJfUdncHY2qCCi0nVDkqRyJbXT1bnLIzN/g=;
        b=VUpkFa4te7+t8eoE80PTwHihbzULcEDPH782yyzbWnAH8w5kGE4rPY+uKn2oNFebBr
         xNYOkeyNA+UQwMBvd1BtkUKIsQHIhLpgtkmbWT0J/JkYRM28U8Dt9R+2fOI/jsM/vsuw
         wMrgA96CpiaRhX6fESL5ksDfIk6ONv35FU0JNtbKegRkViNDky/OjLgDjp9rIEDl+Fry
         TIqZcM6HHx9aFV6DcWUWeFbd5i1oSNy80vdrqBZm5DxWGQUv2XjSy5Y1guDRNpOF79Z8
         LO8MF+saot5atdu13Ig8RfUUX5EZzEWjWC1Kkq9mO18HlVXmRCLM+Fwj+vusXQj9TiZP
         9Beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=X88HL68aCJfUdncHY2qCCi0nVDkqRyJbXT1bnLIzN/g=;
        b=I8Yjsgmnjl7Vd2gtM4T0r9xK1QtIaWl3xpgmEo39oF15fiQGpm8EqijdCH21prMBO6
         jKD5qRipxSdoCu/bxMzJF+HS7NjoJ6AiKsr5OKiWvliJvYD8yJPgbKXVRPbSGUUj8IeW
         hh21A31MIWsZUpRBEPIGdr77h4/G4w+eWxqJbndK/hs1kjusmwxES0afcc6hH9y2SElP
         8d2CqiLUAVIt+Xb6IUHz2D6Sr/qB4/Gxf8P/wUDZ0opdo0Nt1LKzGRcWwIa166dKebYC
         0qIlYBQUzRzopOhEkSjwpMhNK87i5891TBwpjJ+oYfTg9TZzspDpVOd2hxcAcLZ2zPcE
         UClg==
X-Gm-Message-State: ACrzQf2gzPTLTBTy/foXSP9bySnedKISgPzocyJRWESeSxIIG+hTsAoD
        9RIM122Mr2gk1FhKjwNiybHkdQ==
X-Google-Smtp-Source: AMsMyM7IAev448Zrmf+Niu2uyhsLlID8pvs9GcXbVVcKhh+AbrsvOR/difIN2QuQyu5B0IygdBrt1Q==
X-Received: by 2002:a05:620a:2442:b0:6ce:d766:ca81 with SMTP id h2-20020a05620a244200b006ced766ca81mr5956031qkn.687.1663948831972;
        Fri, 23 Sep 2022 09:00:31 -0700 (PDT)
Received: from fedora ([204.156.113.250])
        by smtp.gmail.com with ESMTPSA id do11-20020a05620a2b0b00b006ce441816e0sm6245068qkb.15.2022.09.23.09.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 09:00:31 -0700 (PDT)
Date:   Fri, 23 Sep 2022 10:55:46 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mranostay@ti.com
Subject: Re: [PATCH v9 0/4] ECAP support on TI AM62x SoC
Message-ID: <Yy3I8vKSfYdaZunw@fedora>
References: <20220923142437.271328-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qnNNKSKTZQ4BW8h"
Content-Disposition: inline
In-Reply-To: <20220923142437.271328-1-jpanis@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6qnNNKSKTZQ4BW8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 23, 2022 at 04:24:33PM +0200, Julien Panis wrote:
> The Enhanced Capture (ECAP) module can be used to timestamp events
> detected on signal input pin. It can be used for time measurements
> of pulse train signals.
>=20
> ECAP module includes 4 timestamp capture registers. For all 4 sequenced
> timestamp capture events (0->1->2->3->0->...), edge polarity (falling/ris=
ing
> edge) can be selected.
>=20
> This driver leverages counter subsystem to :
> - select edge polarity for all 4 capture events (event mode)
> - log timestamps for each capture event
> Event polarity, and CAP0/1/2/3 timestamps give all the information
> about the input pulse train. Further information can easily be computed :
> period and/or duty cycle if frequency is constant, elapsed time between
> pulses, etc...
>=20
> This patchset must be applied on top of the following counter subsystem p=
atchset :
> https://lore.kernel.org/all/cover.1663693757.git.william.gray@linaro.org/

Hello Julien,

Tentatively, this version looks good to me. Due to the amount of changes
we've made in the past week I'm going to let it sit on the list for a
while to give any lingering issues we missed a chance to be found. If
nothing pops up during that time, I expect to queue this next week and
hopefully include it with the other Counter changes in time for the 6.1
merge window.

By the way, in the future you can use the '--base' git format-patch
argument to specify the base commit (and any prereq patches) that your
series is based on: https://git-scm.com/docs/git-format-patch#_base_tree_in=
formation

That makes it clear to reviewers and maintainers where they should apply
your patchset, and should also prevent the kernel test robot from
testing against the wrong base.

William Breathitt Gray

--6qnNNKSKTZQ4BW8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCYy3I8gAKCRC1SFbKvhIj
K4VyAP0TS6xWP5CFMk76z6N5ksg9cJ2R+S8ZmLw3qAg8JHdBVgEAno4zuIl4Uf9n
dXIjZ9ayvffGfaYRnYTBD2XUXT8G8gs=
=tET1
-----END PGP SIGNATURE-----

--6qnNNKSKTZQ4BW8h--
