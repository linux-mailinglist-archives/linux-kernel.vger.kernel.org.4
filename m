Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CC56EFE03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240740AbjDZX3M convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Apr 2023 19:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240069AbjDZX3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:29:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242223C1B;
        Wed, 26 Apr 2023 16:29:02 -0700 (PDT)
Received: from ip4d1634d3.dynamic.kabel-deutschland.de ([77.22.52.211] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1proZ6-0000GR-FU; Thu, 27 Apr 2023 01:28:48 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu
Subject: Re: [PATCH v4 0/4] Implement GCM ghash using Zbc and Zbkb extensions
Date:   Thu, 27 Apr 2023 01:28:47 +0200
Message-ID: <5008634.irdbgypaU6@diego>
In-Reply-To: <20230426232331.GB65659@sol.localdomain>
References: <20230329140642.2186644-1-heiko.stuebner@vrull.eu> <7664296.GXAFRqVoOG@diego>
 <20230426232331.GB65659@sol.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Donnerstag, 27. April 2023, 01:23:31 CEST schrieb Eric Biggers:
> On Thu, Apr 27, 2023 at 01:20:31AM +0200, Heiko Stübner wrote:
> > But for me, this small bit of scalar crypto is also sort of a stepping
> > stone :-). Previous versions [0] already included patches using the
> > vector crypto extensions too, I just split that into a separate thing,
> > as _this_ series actually uses ratified extensions :-)
> > 
> > 
> > Heiko
> > 
> > 
> > 
> > [0] https://lore.kernel.org/lkml/20230313191302.580787-12-heiko.stuebner@vrull.eu/T/
> 
> That patchset wasn't sent to linux-crypto.  Can you make sure to include
> linux-crypto@vger.kernel.org on any subsequent patchsets?  Thanks!

yeah, that was a fault on my part, which I managed to rectify with v4 here
[haven't had time to send the vector part as separate v4 yet]

Will include linux-crypto in further submissions.


Heiko


