Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6516E59A3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjDRGrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjDRGrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091B749D9;
        Mon, 17 Apr 2023 23:46:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E77D62D39;
        Tue, 18 Apr 2023 06:46:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0DCC433D2;
        Tue, 18 Apr 2023 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681800413;
        bh=vdWe6yc5jl5yxLVf/L/4oLTsUXja3Ub8kkkO73S+zgQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ALRWVTwSlIv6H1e+p0Kw+ZivCixUIkJ4Chx/tD4BIlCp19o+iQ85HgukdQ2m04/w7
         v2vd6xveugra8sHmXL1mtTOVL2L9sOwHjOnVqg6UQZifGR5ytjNnhBT/mLPmY9xFvi
         fk3Y69/7JAx/CypOwxrTsGmxYcFK0SEszgyXpDtRy7hocYYX5vwUIdJJ2Y8bhcYULg
         FzsFJpOc2ZuNZUI/Q0VpLVeGsKmtVazFbjxm/3z+mJV1ChTkR1I4lK8kKRUqK39DE7
         EAaj/V3tBeaAhL75ese7dcqxsql5jNnDGPLK3zlpsojTLAj3hf0Gh8Yceqqn9QB0J1
         xs2pqi7bXZXWg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pof7I-0004e0-92; Tue, 18 Apr 2023 08:47:04 +0200
Date:   Tue, 18 Apr 2023 08:47:04 +0200
From:   Johan Hovold <johan@kernel.org>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, me@1conan.com,
        erkin.bozoglu@xeront.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: option: add UNISOC vendor and TOZED
 LT70C product
Message-ID: <ZD486HCPdkTg6BVT@hovoldconsulting.com>
References: <20230417152003.243248-1-arinc.unal@arinc9.com>
 <ZD1ufX/oyif5LRY7@hovoldconsulting.com>
 <8d185a8c-f5b5-b11a-cb83-23b250c235e8@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8d185a8c-f5b5-b11a-cb83-23b250c235e8@arinc9.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:19:23PM +0300, Arınç ÜNAL wrote:
> On 17.04.2023 19:06, Johan Hovold wrote:
> > On Mon, Apr 17, 2023 at 06:20:03PM +0300, arinc9.unal@gmail.com wrote:
> >> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> >>
> >> Add UNISOC vendor ID and TOZED LT70-C modem which is based from UNISOC
> >> SL8563. The modem supports the NCM mode. Interface 0 is used for running
> >> the AT commands. Interface 12 is the ADB interface.

> > Now applied, thanks.
> 
> Thanks a lot. I just realised I made a slight mistake on the comment 
> line, calling the modem TL70-C instead of LT70-C. Would you take another 
> patch for this or apply a potential v3 instead?

I've fixed that up now by amending the commit.

Johan
