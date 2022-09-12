Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F8C5B58DC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiILK5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiILK5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:57:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C43399E6;
        Mon, 12 Sep 2022 03:57:06 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a8so14123824lff.13;
        Mon, 12 Sep 2022 03:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=SfQ57WCd2filUQKaiahUm3tHK33Vpzs3bBhJ7Iu9Mas=;
        b=pahlf/KkG2TqqRIkSUFAssCyCUSn32bhXczkTl98v792cAqfsrDghieOW+wV1nfaDC
         PKbvX7tCxIfIy4qoFCrQKICFzHz82bTwOFc+/N2DYHw5mpKNR9H2qrZMUIdroCG9TTkS
         mWwtgpxkz14pIUW8kCFCUTrhjXWFHJM7K0mVDkr5zUOvDZ15odhYX94yTH6jSnJ4UyG/
         T6cMrn+2bXu4RcMG/mogtCTZTS7+UcWOcx8AhFkbQjkBlpp3xpmuprq4KyzmEmnb9Fkb
         2IQGeQsT7KJ0JkKewO3c8wptoiEwy5S4bxOsL6aaasRcdajYevsur5NXAYgkcmVr+5DA
         x1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SfQ57WCd2filUQKaiahUm3tHK33Vpzs3bBhJ7Iu9Mas=;
        b=Wo911hPFBzByuWgTHq6q/BLIIQQ8EAICGKgtNj9Gg5bFF8bts/2s0uxyw4meVoqgLP
         C6OX1Y7q/lJ7tJpmK+HGa50WS1n9za7bmDN9XuhjjyMm8l2cnsFbVdV0Ri8QAcmkNIdr
         bGedFqLDAo6iMrnCEGFajEQbLcnBkJW9+2d2LReXzQuXR5H1qmGxUv8evG5YbbdVlXf4
         PqTLeXqsl1QFitHitCYHtaqnpEdRTxKshLW1GaqNx9GWBnGp7VqLl3GqlweXsejKs4Vj
         RvY08mwihTfAXZi6UgEafmS7jsgkmqRZmEL1DYBu8+++TYqcHgxUvs1/YpBNFNv2Fik4
         DJZQ==
X-Gm-Message-State: ACgBeo3Rgtk+WKkBFkOklO1Dl+updUpHbaKJyWGzVfI8q2W3H2qn6vw3
        z0r76Q0NLfGiGKGj6wKrg9I=
X-Google-Smtp-Source: AA6agR7ZSaCF1JNh7jJYFNvT/rUQTL1Ugzt7WYhpjAh72ciQd3+jLN/b1KQ83Q4KpArjnx9LVzpgEA==
X-Received: by 2002:a05:6512:3ca8:b0:499:2f89:cb42 with SMTP id h40-20020a0565123ca800b004992f89cb42mr4210284lfv.227.1662980224856;
        Mon, 12 Sep 2022 03:57:04 -0700 (PDT)
Received: from gmail.com (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id d19-20020a2e3313000000b0025d5eb5dde7sm427198ljc.104.2022.09.12.03.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 03:57:04 -0700 (PDT)
Date:   Mon, 12 Sep 2022 13:02:19 +0200
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <Yx8Ru3x1IgmUYzUA@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
 <20220815061625.35568-5-marcus.folkesson@gmail.com>
 <20220820134150.2b45339c@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220820134150.2b45339c@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 20, 2022 at 01:41:50PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Aug 2022 08:16:20 +0200
> Marcus Folkesson <marcus.folkesson@gmail.com> wrote:
>=20
> > Keep using managed resources as much as possible.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > ---
> >  drivers/iio/adc/mcp3911.c | 53 ++++++++++++---------------------------
> >  1 file changed, 16 insertions(+), 37 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> > index 890af7dca62d..7e2efe702e57 100644
> > --- a/drivers/iio/adc/mcp3911.c
> > +++ b/drivers/iio/adc/mcp3911.c
> > @@ -258,6 +258,13 @@ static int mcp3911_config(struct mcp3911 *adc)
> >  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
> >  }
> > =20
> > +static void mcp3911_cleanup_regulator(void *_adc)
>=20
> Missed this on previous versions, but why not pass
> the regulator pointer in as the parameter for the callback?
>=20
> static void mcp391_cleanup_regulator(void *reg)
> {
> 	regulator_disable(adc->vref);
> }
>=20
> Note this can't use the new devm_regulator_get_enable()
> because we need access to the regulator within the driver.
>=20
> I can tidy this up whilst applying (or given it's really minor I might
> not bother :)
>=20
> Note we are stalled at the moment with this series on getting the
> fixes upstream.  I'll probably send that pull request shortly.

Just a friendly reminder to not forget to pick up this series.

Thanks,

/Marcus
