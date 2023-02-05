Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD9D68B0E8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 17:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjBEQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 11:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjBEQTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 11:19:45 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E520D6EA3;
        Sun,  5 Feb 2023 08:19:43 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pOhjy-0000RS-02; Sun, 05 Feb 2023 17:19:42 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E13A4C265A; Sun,  5 Feb 2023 17:03:01 +0100 (CET)
Date:   Sun, 5 Feb 2023 17:03:01 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-mips@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: lantiq: Remove bogus interrupt-parent; line
Message-ID: <20230205160301.GC4459@alpha.franken.de>
References: <20230129152059.1535947-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230129152059.1535947-1-j.neuschaefer@gmx.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 04:20:58PM +0100, Jonathan Neuschäfer wrote:
> Specifying interrupt-parent without a value (in other words, as a bool)
> doesn't really mean anything. Remove one such property in the Lantiq
> Danube DT, at /sram@1f000000/eiu@101000.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  arch/mips/boot/dts/lantiq/danube.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi b/arch/mips/boot/dts/lantiq/danube.dtsi
> index 510be63c8bdf1..7a7ba66aa5349 100644
> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
> @@ -40,7 +40,6 @@ sram@1f000000 {
>  		eiu0: eiu@101000 {
>  			#interrupt-cells = <1>;
>  			interrupt-controller;
> -			interrupt-parent;
>  			compatible = "lantiq,eiu-xway";
>  			reg = <0x101000 0x1000>;
>  		};
> --
> 2.39.0

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
