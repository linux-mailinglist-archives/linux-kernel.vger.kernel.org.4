Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 177D66F811D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjEEK66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjEEK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:58:57 -0400
X-Greylist: delayed 65310 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 May 2023 03:58:54 PDT
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F52111629;
        Fri,  5 May 2023 03:58:54 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id BF79C20B74;
        Fri,  5 May 2023 12:58:49 +0200 (CEST)
Date:   Fri, 5 May 2023 12:58:45 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        devicetree@vger.kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, jun.li@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        francesco.dolcini@toradex.com
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <ZFThZc7NW4AV99hy@francesco-nb.int.toradex.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
 <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
 <20230505112351.1c79f6b2@booty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505112351.1c79f6b2@booty>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 11:23:51AM +0200, Luca Ceresoli wrote:
> On Thu, 4 May 2023 18:50:14 +0200
> Francesco Dolcini <francesco@dolcini.it> wrote:
> 
> > Hello Luca,
> > I guess your mail to Philippe bounced, let me try to answer since I am aware
> > of the issue here.
> > 
> > On Thu, May 04, 2023 at 06:23:12PM +0200, Luca Ceresoli wrote:
> > > I found this thread after several hours spent in debugging why USB host is
> > > not detecting new devices on a custom board using the iMX6ULL Colibri
> > > SoM.
> > > 
> > > My best workaround at the moment is:  
> > We have the same workaround in our BSP since quite some time, see
> > https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-kernel/linux/linux-toradex-mainline-git/0002-drivers-chipidea-disable-runtime-pm-for-imx6ul.patch
> > 
> > > I haven't found any follow-up patches from you, so I'm wondering whether
> > > you have made any progress on this issue.  
> > You can find the latest discussion on that regard here
> > https://lore.kernel.org/all/Y1vLpaxpc5WBCuGD@francesco-nb.int.toradex.com/
> 
> Thanks for this pointer! I have read the discussion and it was a bit
> confusing, especially about whether the hardware can work at all.

It can work. Hardware wise is just fine, software wise I tried to
explain how in my previous answer to you. Worst case we would have to
describe the hardware in a different way in the DTS, but I do not expect
this to be required.

> Are you planning to continue on that work?

Hopefully NXP / Li Jun will be able to help.

Francesco

