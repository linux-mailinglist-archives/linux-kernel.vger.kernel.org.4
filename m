Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FE2604EF2
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJSRgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbiJSRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:35:34 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB83148F71;
        Wed, 19 Oct 2022 10:34:47 -0700 (PDT)
Received: from darkstar.musicnaut.iki.fi (85-76-8-144-nat.elisa-mobile.fi [85.76.8.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 6C68C205A6;
        Wed, 19 Oct 2022 20:34:39 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1666200880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIG98sURNpqYREMByDWj4WJbfZaVepdUxI0t705Dn24=;
        b=woiIGA7CBhVDCbqWL3ENjdTY8ljs/hXL9GUXVqyjFDRzgEwnu3SVbMH5801mKj1q+zd+UP
        N8rZe/AK3Sfp7582bAFaZBDbbHjgUGyyATnri0WDt2Xc+egBIbWWIKEjYKFdAGUncOPmQE
        +nOwqfjDcO4y1VYws8vGoHQ+SA/A2to=
Date:   Wed, 19 Oct 2022 20:34:37 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul@pwsan.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org,
        Kevin Hilman <khilman@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, Bin Liu <b-liu@ti.com>,
        Helge Deller <deller@gmx.de>, linux-usb@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 14/17] ARM: omap1: remove dead code
Message-ID: <20221019173437.GB41568@darkstar.musicnaut.iki.fi>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-14-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019150410.3851944-14-arnd@kernel.org>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1666200880; a=rsa-sha256; cv=none;
        b=I/pBm0aTzCNCuLzHN+MVr6kleAVil0QyuIhK/c2YWJJr+BvybOpZ58a/l4FP0KbR0/NBPv
        Ic8ehOpxamVv3kgysU1E9+j1nDAFiOiDoVrwmi6Rqr2BPo59v4GrJMCmgerqovuv5t8+8K
        qwvvucjEMGPxjNOYrMLoyFq1Ebao1EM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1666200880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gIG98sURNpqYREMByDWj4WJbfZaVepdUxI0t705Dn24=;
        b=Whocu0i/zmCyeCVGAmHY1hls48Sp7JYvAxZLb/yypsH236nuxpWrTHSMBrzQpgp30xSXZQ
        fzjgRMTOc1KsGUITFPPPcjB4pzIqxl+ByucCf1NgsAuFJf+AA2aYX9LBBE/skOPLtfnFi7
        iwPCUqDnzXGIFdpaXoN0ArUtBtc2QAY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 19, 2022 at 05:03:36PM +0200, Arnd Bergmann wrote:
>  drivers/usb/phy/phy-isp1301-omap.c | 91 +-----------------------------

This driver and config option ISP1301_OMAP can be deleted altogether as
there are no users after H2/H3 boards are gone.

A.
