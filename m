Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E680617CF2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKCMqN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 3 Nov 2022 08:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKCMqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:46:11 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83DAF1182C;
        Thu,  3 Nov 2022 05:46:10 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C3F85814A;
        Thu,  3 Nov 2022 12:36:34 +0000 (UTC)
Date:   Thu, 3 Nov 2022 14:46:08 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm: omap2: n8x0: stop instantiating codec platform
 data
Message-ID: <Y2O4EMn4Ja/DeHZH@atomide.com>
References: <20221102232004.1721864-1-dmitry.torokhov@gmail.com>
 <Y2Ow81ALm1Osd8xM@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <Y2Ow81ALm1Osd8xM@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mark Brown <broonie@kernel.org> [221103 12:06]:
> On Wed, Nov 02, 2022 at 04:20:02PM -0700, Dmitry Torokhov wrote:
> > As of 0426370b58b2 ("ARM: dts: omap2420-n810: Correct the audio codec
> > (tlv320aic33) node") the DTS properly specifies reset GPIO, and the
> > device name in auxdata lookup table does not even match the one in
> > device tree anymore, so stop instantiating it.
> 
> Tony, I guess it makes sense for this to go via ASoC if you're OK with
> it?

Yes please pick it via ASoC, I've acked the first patch.

Regards,

Tony
