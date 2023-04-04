Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443A66D5FDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234667AbjDDMDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbjDDMC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:02:58 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618902D42;
        Tue,  4 Apr 2023 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1680609751; bh=uVAMkMqMikWXIauVjMve6Gn4H0bTde07iBs06xjAvnU=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=0V074kW0++4v6ZNG2SqAZq7Z8PMfa8C6VJ8LSKbJWbRmQQNxQYsyRmrn3pqvdlWMR
         v1U+SBhm+EfQt+sK9kwqvL6ocBi+02SSFW4IVDeQ3GYJtfY3YbYpFVcYA/H50DgSKq
         jCLK/DFpFXaSuYmoN+lexTBMB8Y8wKNXSrIfFP10=
Date:   Tue, 4 Apr 2023 14:02:31 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Martijn Braam <martijn@brixit.nl>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org,
        Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: rockchip: Change serial baud rate for
 Pinephone Pro to 1.5 MB
Message-ID: <20230404120231.2enpesad2lhde6sb@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Martijn Braam <martijn@brixit.nl>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        linux-kernel@vger.kernel.org, Peter Robinson <pbrobinson@gmail.com>,
        Caleb Connolly <kc@postmarketos.org>,
        Jarrah Gosbell <kernel@undef.tools>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20230403175937.2842085-1-javierm@redhat.com>
 <3738011.44csPzL39Z@diego>
 <52d83a29-0f16-cd4c-9810-7c6bd497fe85@brixit.nl>
 <87ttxvdgb7.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttxvdgb7.fsf@minerva.mail-host-address-is-not-set>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Apr 04, 2023 at 01:42:36PM +0200, Javier Martinez Canillas wrote:
> Martijn Braam <martijn@brixit.nl> writes:
> 
> > On 4/4/23 09:51, Heiko Stübner wrote:
> >> Hi,
> >>
> >> Am Montag, 3. April 2023, 19:59:37 CEST schrieb Javier Martinez Canillas:
> >>> This baud rate is set for the device by mainline u-boot and is also what
> >>> is set in the Pinebook Pro Device Tree, which is a device similar to the
> >>> PinePhone Pro but with a different form factor.
> >>>
> >>> Otherwise, the baud rate of the firmware and Linux don't match by default
> >>> and a 'console=ttyS2,1500000n8' kernel command line parameter is required
> >>> to have proper output for both.
> >> The interesting question is always if this will break someone else's setup.
> >> I've never really understood the strange setting of 1.5MBps, but on the
> >> other hand it _is_ a reality on most boards.
> >
> > It breaks my device test setup at least. The extra speed isn't worth the 
> > hassle
> 
> More than the extra speed is to have consistency accross all the rockchip
> devices in upstream and also sync with mainline u-boot.
> 
> > of having a few devices at weird baudrates and the bootloader already
> > starts outputting debug logs at 115200 baud.
> >
> 
> And mine starts outputting at 1.5MBps :) I guess that there isn't a one
> size fits all, so the question is whether the bikeshed color is what was
> painted in all other rockchip boards or the one that Tow-Boot has chosen.

For what it's worth, levinboot also defaults to 1.5 Mbaud.

  https://gitlab.com/DeltaGem/levinboot/-/blob/release/rk3399/entry.S#L65
  https://gitlab.com/DeltaGem/levinboot/-/blob/release/configure.py#L67

And it's very nice anything above >115200 is not broken by bad HW design,
like on original Pinephone, so this higher speed actually works. ;)

kind regards,
	o.

> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Core Platforms
> Red Hat
> 
