Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6526408A5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 15:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiLBOnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLBOnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 09:43:40 -0500
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED860A8093;
        Fri,  2 Dec 2022 06:43:36 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id A14142030; Fri,  2 Dec 2022 15:43:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 9D76B1FC9;
        Fri,  2 Dec 2022 15:43:29 +0100 (CET)
Date:   Fri, 2 Dec 2022 15:43:29 +0100 (CET)
From:   Nikolaus Voss <nv@vosn.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
cc:     Nikolaus Voss <nikolaus.voss@haag-streit.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Gstir <david@sigma-star.at>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] crypto: caam: blob_gen.c: warn if key is insecure
In-Reply-To: <94f5f20b-f7c9-b9b5-1b49-3c4366b47370@pengutronix.de>
Message-ID: <46085da-4dd4-f02e-1e1d-442cfceeeb15@vosn.de>
References: <20221121141929.2E36427E9@mail.steuer-voss.de> <94f5f20b-f7c9-b9b5-1b49-3c4366b47370@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2022, Ahmad Fatoum wrote:
> On 21.11.22 15:12, Nikolaus Voss wrote:
>> +	ctrlpriv = dev_get_drvdata(jrdev->parent);
>> +	moo = FIELD_GET(CSTA_MOO, ioread32(&ctrlpriv->ctrl->perfmon.status));
>
> Sorry for not having spotted this the first time, but ioread32 is not
> completely correct here as the CAAM may be big endian while the CPU is
> little endian.
>
> You should be using rd_reg32 here.

Ok.

Herbert, shall I spin v3 of the patch or patch against v2?

Niko
