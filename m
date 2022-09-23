Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D825E8177
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 20:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiIWSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiIWSEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 14:04:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF83148A11;
        Fri, 23 Sep 2022 11:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F10D6109A;
        Fri, 23 Sep 2022 18:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82104C433D6;
        Fri, 23 Sep 2022 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663956149;
        bh=vJ6/DgXwp3pd7Ho4JNS0CsS1fC7rRPQIoSmqkclc0a8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uUpxDvNO//99GcCpHygBdagS+uLqeL7PrG2BTvLtoajNNSsVMf9fyAbjlYFjnPFmS
         FZpNCWPLSFOOXF6zIHjkhHvEG/0Znn8Rr/E0bZdRjBFxcltdF6oGmaKwmXZVj8M+fl
         S4nfIBMJk5stmdQsKjcHECtiy0+UjYkOULqK9Dgqoh4ZS2iSScVQ+FTSoHltdxQMI8
         ehjGcuMsuLwQ1Ym/mYRvNocppAAngMP5m950LKnK/aaAO5Q4nWK5JOG+kN/1diUShJ
         AstknDQ+isR0LIfWAAPUJOYKWH0NRgxTJkDI1Pg0BZNSrQ03m5Kdp0ybF8WnVGpZUj
         kPsvcQHVvw4jg==
Received: by pali.im (Postfix)
        id 6792D677; Fri, 23 Sep 2022 20:02:26 +0200 (CEST)
Date:   Fri, 23 Sep 2022 20:02:26 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     maukka@ext.kapsi.fi, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
Message-ID: <20220923180226.vmjcefxlujg2r6u3@pali>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
 <Yy2iqE8XgXe8qYd9@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy2iqE8XgXe8qYd9@lunn.ch>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 September 2022 14:12:24 Andrew Lunn wrote:
> > > > +	if (of_machine_is_compatible("dlink,dns323a1")) {
> > > > +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
> > > 
> > > I spotted this in dns323-setup.c as well. Do you have any idea what it
> > > does?
> > > 
> > 
> > No idea. I have tried to replicate what was in dns323-setup.c as exactly as
> > possible.
> > I can try to leave it out and see if anything changes.
> 
> It is best to keep what we don't understand. It will be there for a
> reason.
> 
> 	Andrew

Hello! I tried to index all publicly available Marvell SoC
documentations into kernel documentation subfolder:
https://docs.kernel.org/arm/marvell.html

For Orion there is linked Datasheet and User Manual, so you could try to
find in those documents that mentioned register and check what it is
doing.
