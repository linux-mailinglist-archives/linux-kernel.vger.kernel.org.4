Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7970375D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbjEORUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 13:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243965AbjEORTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 13:19:47 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA7A49D5;
        Mon, 15 May 2023 10:17:48 -0700 (PDT)
Received: from p5dc58da0.dip0.t-ipconnect.de ([93.197.141.160] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1pybpK-0004pc-2e; Mon, 15 May 2023 19:17:38 +0200
Date:   Mon, 15 May 2023 19:17:35 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tony Lindgren <tony@atomide.com>
Cc:     arnd@arndb.de, olof@lixom.net, soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, bcousson@baylibre.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: omap4: add initial support for Epson Moverio
 BT-200
Message-ID: <20230515191735.6d671ef1@aktux>
In-Reply-To: <20230327082137.GH7501@atomide.com>
References: <20230313110409.2294154-1-andreas@kemnade.info>
        <20230327082137.GH7501@atomide.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 27 Mar 2023 11:21:37 +0300
Tony Lindgren <tony@atomide.com> wrote:

> * Andreas Kemnade <andreas@kemnade.info> [230313 13:04]:
> > yes, epson,embt2ws is unknown, is the txt->yaml conversion around the
> > corner? I would then resubmit it includding an addition
> > to that yaml. If not probably I resubmit the conversion patch with
> > the compatible added. But that should not stop the rest of this patch from
> > being reviewed.  
> 
> Yeah let's do the yaml conversion first as otherwise we'll be adding some
> extra warnings for the dt folks.
> 
> Your patch looks otherwise OK to me.
> 
do you expect any action from me here? As Krzysztof has given his
Reviewed-by on the conversion patch, I would expect that it gets in right
after that omap.yaml conversion patch if nobody objects.

Regards,
Andreas
