Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51BA6B8721
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjCNAmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjCNAmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:42:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F8C84F7B;
        Mon, 13 Mar 2023 17:42:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6B0DB81689;
        Tue, 14 Mar 2023 00:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D9C433D2;
        Tue, 14 Mar 2023 00:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678754529;
        bh=rhuR0525d0xOEscAwkyPRV01tY0JwoVYr5/YHEfeQxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lf3spT6fwbRActGeXR3v1Lq8Gdg2kOKUDlGjBDVYzmeODfsl+caccIDw58C2y590h
         9GaXw8kfhcznQvGmvbczHfUUUlAiDrhHfvwT2KV8GtE9ulfiGj4rDx8RTU4A0+eWmp
         fhhgyLrI5ujgw/uDXZxUjP2C3ocEzs2A+8qFBgHomgzJVVaXn11lDUXLins+HZINC7
         fx0YaYN9CHe7B6dHzuX45MbCEKeizkl6mzG/VVWrEqDSVJ0tlr4ECE6ZiC+aQIQnqF
         /4Ii1NNh6YJoR1q9gsOsjYCjs+53MyNoZ+1kqBjbLkBNnNK4ESEkMA9UyMR45Tnnu3
         aOWTzXt/LZ2ZQ==
Date:   Tue, 14 Mar 2023 08:42:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 5/6] ARM: dts: =?iso-8859-1?Q?i?=
 =?iso-8859-1?Q?mx6dl-yapp43=3A_Add_support_for_new_HW_revision_of_the_IOT?=
 =?iso-8859-1?Q?A=A0board?=
Message-ID: <20230314004201.GS143566@dragon>
References: <20230210154855.3086900-1-michal.vokac@ysoft.com>
 <20230210154855.3086900-6-michal.vokac@ysoft.com>
 <20230313082348.GM143566@dragon>
 <6a942ff5-4bf4-ae23-fe78-900d1965e821@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a942ff5-4bf4-ae23-fe78-900d1965e821@ysoft.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 05:42:21PM +0100, Michal Vokáč wrote:
> > > +	eeprom@57 {
> > > +		compatible = "atmel,24c128";
> > > +		reg = <0x57>;
> > > +		pagesize = <64>;
> > > +		status = "okay";
> > 
> > The "okay" status is only needed to flip a "disabled" one.
> 
> OK, I will remove the status "okay" from all device nodes defined
> by this dtsi that should be enabled by default.
> 
> I assume that using status "okay" (or "disabled") for referenced
> nodes coming from included SoC dtsi files is fine even if these
> nodes already have the required status at the moment.

Yeah, that would be fine.

Shawn

> Otherwise I see no guarantee that the node will have my required
> status in the future as well. The status in the included files
> may be changed by someone else for whatever reason.
