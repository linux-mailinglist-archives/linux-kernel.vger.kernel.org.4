Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539116F9229
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjEFM7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjEFM7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:59:51 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3EC18DE6;
        Sat,  6 May 2023 05:59:49 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-50bd87539c2so4432127a12.0;
        Sat, 06 May 2023 05:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683377988; x=1685969988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R63ySz+V7ttCFAv2NgG95z4OLLtMXFqMOA23r5CKM3s=;
        b=ZaTXIxnXuWngC2EDRE6syeFBaz/BSK6g+5+DWgtqjX0vVyDFUC5V7KXPWESgkmlQBl
         RaQH4e7ri0z5JE2HfG73a6c/CA5xV8xT3vpeZdFNyw/DCPWG5CbN8+Ra9NYec90sa2VP
         Jp/t+mr1Vlu/Q9LqjOZ2a3YfI6BRSngcc2ZoP2+WsYcrINAM77LmvNF81as/t1n8A3fb
         AoirCUNp4ehe6D3KE7ZoHf2t2OW+w8SwrYW/5mfe8GpZMemC5fI28VKXiUWSCIyBaraO
         fkIJDpc4okhQwYIK/gHpm5G+SD5IY1gBnUiN3ecr1JANwwWPZHqB0KmxzvczMG9UTPFj
         gzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683377988; x=1685969988;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R63ySz+V7ttCFAv2NgG95z4OLLtMXFqMOA23r5CKM3s=;
        b=HJ5ho5tMfETYOurPU+oTBBGFCg0mTH22/MIGMcMRv7Tn6zF/qusiCgPkvKOOozhE2P
         aX7f2fGs3dvlr9Wr6fRX+/Il5sd8NPTyUCadoozftVnRL1HZCWaDKeJSe6+sTPqOU44y
         NhI64Rav37xEorDDLOOa9cE4U/OCfCkYjaWjHtITi18zKXd448Cl+9UvXWwP2FqoESFm
         kc9cX3DsEVZNkZhqfzRCf3je1GBVn45SvdbKwTjr4DDcTQicXRL9qNS2g1+VHaATMLFB
         evbKkAs/JriqOzBsz8LcaXMcjyle/EvaUnHvpglppBk6uRPlwpE1Zj9wVCSmSOpABiND
         pFPQ==
X-Gm-Message-State: AC+VfDzWS2jeApAyv0jShNBXcZVbycmgjwCUUsp8D4dk3W4roV5MhIjK
        2T/nySg3DIK41g7HOE+GctFcyekQcClQjEZ58q0=
X-Google-Smtp-Source: ACHHUZ6DkTuVM4bTLPk7/b7rUBOl2lOEsBgignS7yOAg+Qy4rPo7Ev+AnOErulzJoivJRsJSH9JfWH2dEpM0tr2qvAc=
X-Received: by 2002:a17:907:168d:b0:949:55fd:34fa with SMTP id
 hc13-20020a170907168d00b0094955fd34famr3968057ejc.39.1683377988143; Sat, 06
 May 2023 05:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230506073018.1411583-1-bigunclemax@gmail.com>
 <20230506073018.1411583-2-bigunclemax@gmail.com> <e38cbcdf-5963-fb00-d7b2-66d4129f9fce@linaro.org>
In-Reply-To: <e38cbcdf-5963-fb00-d7b2-66d4129f9fce@linaro.org>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sat, 6 May 2023 16:59:36 +0400
Message-ID: <CALHCpMhp07DwL+cUZN8rwa1N_PHQ1KstOB+Gw_mCWFzm5rSVrQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] dt-bindings: spi: sun6i: add DT bindings for
 Allwinner R329 SPI
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Should this not be set up as a fallback compatible, per Samuel's
> suggestion here:

Ok, I'll do it in the next version.

> I wonder what is the difference of DBI compatible. You refer to "helper
> functions", which sounds like driver... do you mean some parts of SPI
> controller?

According to the D1 datasheet the SPI_DBI controller uses the same
registers layout as the regular SPI0 controller.
But also it has an additional DBI mode functionality. Support for this
mode is not yet implemented.
So there is no difference between 'sun50i-r329-spi' and
'sun50i-r329-spi-dbi' controllers types in the SPI driver.

Maybe we should drop 'sun50i-r329-spi-dbi' compatible struct from here
https://lore.kernel.org/lkml/20230506073018.1411583-5-bigunclemax@gmail.com/
for a while the DBI mode functionality will not be implemented?
