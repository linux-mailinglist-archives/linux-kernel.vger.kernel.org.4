Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D66710E7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjEYOob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjEYOo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:44:29 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0965BE7;
        Thu, 25 May 2023 07:44:28 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 29B092130A;
        Thu, 25 May 2023 16:44:26 +0200 (CEST)
Date:   Thu, 25 May 2023 16:44:21 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, kamlesh@ti.com
Cc:     vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Remove power-domains from
 crypto node
Message-ID: <ZG90RS4KYo0bCwF7@francesco-nb.int.toradex.com>
References: <20230417133308.1990057-1-kamlesh@ti.com>
 <20230417134241.oj5cmrqjeoxj2sb2@power>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417134241.oj5cmrqjeoxj2sb2@power>
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,TVD_SUBJ_WIPE_DEBT,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:42:41AM -0500, Nishanth Menon wrote:
> On 19:03-20230417, kamlesh@ti.com wrote:
> > From: Kamlesh Gurudasani <kamlesh@ti.com>
> > 
> > With latest firmware update, we can no longer control power of SA3UL from
> > main domain.
> 
> How is this backward compatible?

I just stumbled across this commit since I had an issue with crypto@40900000
not being probed on Verdin AM62.

Not sure how this is supposed to work about backward/forward
compatibility, however this is needed for having it working with the
latest firmware.

And if there is a proper way that take care of this, it should be
backported IMO.

Francesco

