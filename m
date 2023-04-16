Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A5D6E37F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 14:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjDPMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDPMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 08:23:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C887270E;
        Sun, 16 Apr 2023 05:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C5A360F94;
        Sun, 16 Apr 2023 12:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047E3C433D2;
        Sun, 16 Apr 2023 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681647832;
        bh=aP1qUe64Ea8WYk6U+eHRssPcrGTNk8le/9pqK8F/18A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GXYMaLnRLalPAAusfsc6fwsmkoADn6aOi6HgDYR7v8bQa1bKc4lXveGjTLNQMs77t
         4ab1b9lgDfDJq6TG6D/+Xo9a477PSXVWoK2YD9HcFYi+XiDR1jYJE3RdriuH3Aj2Ht
         7yiqKmW3HAVKGa2qvmmDbyP53LCXEoGbcwfwK+Ylyfj1id2OkQXfQIcYxoeoJ6zGaY
         CE/QIXYNammx4gloUecwpXPWLXTdtKzoSkw/XRSxSjbt022XfQMrl/8AMTlEWsNP7d
         knyaTWz54d5hUVd1auFNIX8QXzDnPvSnDMLI9uxZeadFWkojA9F54ToYzVdSwuJ0pD
         bbkbpPuH6L62Q==
Date:   Sun, 16 Apr 2023 13:23:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marius Hoch <mail@mariushoch.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v3 6/6] dt-bindings: iio: st-sensors: Add LSM303D
 accelerometer+magnetometer
Message-ID: <20230416132353.2ed1651a@jic23-huawei>
In-Reply-To: <01a997c9-ea2c-469e-8de7-7a376b880f23@linaro.org>
References: <20230415231130.115094-1-mail@mariushoch.de>
        <20230415231130.115094-7-mail@mariushoch.de>
        <01a997c9-ea2c-469e-8de7-7a376b880f23@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Apr 2023 09:29:23 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 16/04/2023 01:11, Marius Hoch wrote:
> > Same as the lsm9ds0, except that the lsm303d doesn't
> > feature a gyroscope.
> > 
> > Signed-off-by: Marius Hoch <mail@mariushoch.de>
> > ---
> >  Documentation/devicetree/bindings/iio/st,st-sensors.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > index c6201976378f..194aca5542c2 100644
> > --- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > +++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
> > @@ -85,6 +85,7 @@ properties:
> >        - description: IMUs
> >          enum:
> >            - st,lsm9ds0-imu
> > +          - st,lsm303d-imu  
> 
> The entries are ordered by name.
> 
> With fixed:
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 

I tidied up the ordering whilst applying and also swapped the ordering in
patch 3 for similar reason.

Note that we are very late in this cycle so unless there is an unexpected
delay these will sit in the branch I push out as iio.git/testing until
after rc1 when I'll rebase it on rc1 and push out as togreg for linux-next
to pick up for the 6.5 cycle.

Plenty of time for others to comment in the meantime, but I'm guessing we
won't get much and this way I can 'probably' forget about handling this
series individually.

Jonathan
 
> 
> Best regards,
> Krzysztof
> 

