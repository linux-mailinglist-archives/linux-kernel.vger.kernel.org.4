Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F8862FC73
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 19:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242601AbiKRSVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 13:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241807AbiKRSVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 13:21:39 -0500
Received: from mail-4318.protonmail.ch (mail-4318.protonmail.ch [185.70.43.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9987D533;
        Fri, 18 Nov 2022 10:21:31 -0800 (PST)
Date:   Fri, 18 Nov 2022 18:21:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1668795689; x=1669054889;
        bh=HgXLOqW8YZDy/6BgDftp8Q5C+odX4Kj1c/qv3mh3a2U=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=lANDadsB+2EPEpzGgdkB6Xxf4Owh+1EWZV0uwixSAQl4/f4p/BkppkH3VogwpOBE8
         VT4Blk+W8XAlPOGj2URKNndtnbGXJnXhuPkCcuk3egL8TyOn+frdzK2Fr5A3pm3QBR
         nzHEeKMLi+zOk7gmz2vYSIfbNnqd40LvTSusZ4y5ek+lmaPg4v5aXPz9cNeowEHPrS
         rFAlHZiWy/RNf7Wg3yTYdHr+8C0Bol85YTHHqH54Xn0rgVmglB0IE8jE5Oi2h6NtPA
         HaxeSzMBG8nrd8mVUhnJHo89mDGSiHdu+YJXo1DrWvjgFfC3g0CnfCKO64Cnxw9gsn
         I2k8N9/h3rZrw==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Markuss Broks <markuss.broks@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/3] Add support for Imagis IST3038
Message-ID: <20221118182103.3405-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2: Drop untested, wildcard ist30xxb

This series adds support for Imagis IST3038, which is a variants of
Imagis IST3038 IC. It has a different register map (labeled protocol b),
but otherwise it seems to be the same IC.
It is also possible to support various other Imagis ICs using protocol b,
such as (but not limited to) IST3044B, IST3026, IST3032, IST3026B,
IST3032B. However, most of them (all except IST3044B) use a different
coordinate format, so extra effort would be needed to support those.

Tested on Samsung Galaxy Core Prime and Grand Max.

