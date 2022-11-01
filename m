Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7972961552F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 23:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKAWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiKAWkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 18:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0892410C9;
        Tue,  1 Nov 2022 15:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93731B81FE7;
        Tue,  1 Nov 2022 22:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BADC433C1;
        Tue,  1 Nov 2022 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667342414;
        bh=WkRx3F7l0URB3nWlmZfohQGMJsgytlqexz3K2O1G9QE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWxk6MOSZjG1ZF10r+HahelcPmQrZiqzYI9CZhL8Vo+clS6B2v66x9vzVdGQBpWCI
         JMZl78kCubv69vPV9MzFVDFVx0LCWMUd/w9Huizfa5XQ1X+5v6k+BpaumRez+bX0ml
         qqa+anH/G9lO7GKlqCMN89qVR388YzMcE08KuWKOM++ZQFIMzazZPtsdI9HVAGZ03y
         o+vOlODJusdUfwV75ktd7kqRxLvVW0+2L/HMgC0ssq89I+gSLyln9KjwrwJXENRuay
         MmqgLCJSnZlnO2DmBgJcdzRSqufW8Zgq8S3eyENtj+jOf2di11pvms1dtfCt9X8GMX
         nF8GwqiaPBlgw==
Received: by pali.im (Postfix)
        id E715D7F8; Tue,  1 Nov 2022 23:40:11 +0100 (CET)
Date:   Tue, 1 Nov 2022 23:40:11 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Gregory Clement <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: armada-3720-turris-mox: Add missing
 interrupt for RTC
Message-ID: <20221101224011.v6wb5tuykojticnr@pali>
References: <20220924115826.7891-1-pali@kernel.org>
 <20221009114838.fsw5xqa3dtntejde@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221009114838.fsw5xqa3dtntejde@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PING?

On Sunday 09 October 2022 13:48:38 Pali Rohár wrote:
> Gregory: PING
> 
> On Saturday 24 September 2022 13:58:26 Pali Rohár wrote:
> > MCP7940MT-I/MNY RTC has connected interrupt line to GPIO2_5.
> > 
> > Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > index 5840ed129309..802862fe2060 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> > @@ -125,9 +125,12 @@
> >  	/delete-property/ mrvl,i2c-fast-mode;
> >  	status = "okay";
> >  
> > +	/* MCP7940MT-I/MNY RTC */
> >  	rtc@6f {
> >  		compatible = "microchip,mcp7940x";
> >  		reg = <0x6f>;
> > +		interrupt-parent = <&gpiosb>;
> > +		interrupts = <5 0>; /* GPIO2_5 */
> >  	};
> >  };
> >  
> > -- 
> > 2.20.1
> > 
