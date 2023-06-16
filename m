Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969317336CA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbjFPQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346140AbjFPQzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:55:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D8434EFC;
        Fri, 16 Jun 2023 09:53:33 -0700 (PDT)
Received: from p5dcc3b18.dip0.t-ipconnect.de ([93.204.59.24] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qAChO-0003FG-Nz; Fri, 16 Jun 2023 18:53:22 +0200
Date:   Fri, 16 Jun 2023 18:53:20 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tony@atomide.com, afd@ti.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230616185320.61b33510@aktux>
In-Reply-To: <37ef78ee-b290-ecfb-504d-cef5653d23f2@linaro.org>
References: <20230515074512.66226-1-andreas@kemnade.info>
        <20230613193257.267ad763@aktux>
        <37ef78ee-b290-ecfb-504d-cef5653d23f2@linaro.org>
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

On Tue, 13 Jun 2023 20:43:55 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/06/2023 19:32, Andreas Kemnade wrote:
> > Hi,
> > 
> > any action still expected from my side?
> > people gave R-bys...
> > So looks like it is ready for the dt-folks to pick it up.
> >   
> 
> It's SoC file, isn't it? Then goes via SoC tree.
> 
Apparently there was confusion about it. Quoting
Tony:"And thanks for getting the
omap.yaml conversion going, that will get merged by the dt folks."

I am fine with either, 

Regards
Andreas
