Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188706FE384
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbjEJR41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEJR4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:56:25 -0400
Received: from smtp.dudau.co.uk (dliviu.plus.com [80.229.23.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27E7D4200;
        Wed, 10 May 2023 10:56:24 -0700 (PDT)
Received: from mail.dudau.co.uk (bart.dudau.co.uk [192.168.14.2])
        by smtp.dudau.co.uk (Postfix) with SMTP id BC40E41D13BF;
        Wed, 10 May 2023 18:56:21 +0100 (BST)
Received: by mail.dudau.co.uk (sSMTP sendmail emulation); Wed, 10 May 2023 18:56:21 +0100
Date:   Wed, 10 May 2023 18:56:21 +0100
From:   Liviu Dudau <liviu@dudau.co.uk>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mips: dts: ralink: Clarify usage of MT7621 ethernet phy
 arguments
Message-ID: <ZFvaxVwVOnzVofrU@bart.dudau.co.uk>
References: <20230509200032.308934-1-liviu@dudau.co.uk>
 <a5fdd37e-6f42-2f37-357f-ad5bb082fa7d@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5fdd37e-6f42-2f37-357f-ad5bb082fa7d@arinc9.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arınç,

On Wed, May 10, 2023 at 02:59:44PM +0200, Arınç ÜNAL wrote:
> On 9.05.2023 22:00, Liviu Dudau wrote:
> > The device tree uses numbers as arguments to the phys property that are
> > confusing for newcomers. Define names for the values and use them in the
> > device tree.
> > 
> > Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> 
> You should document this on
> Documentation/devicetree/bindings/pci/mediatek,mt7621-pcie.yaml instead of
> doing this. Under the phys property, add 'description:' and explain this.

There is already some sort of explanation under
Documentation/devicetree/bindings/phy/mediatek,mt7621-pci-phy.yaml, so I'm
not sure what I'm improving by adding new text in the /pci/ section.

Maybe I haven't explained properly in the commit message, this is meant to
give a name to the 1 and 0 values used in the device tree, not to clarify
any perceived missing documentation.

> 
> Arınç

Best regards,
Liviu

--
Everyone who uses computers frequently has had, from time to time,
a mad desire to attack the precocious abacus with an axe.
       	   	      	     	  -- John D. Clark, Ignition!
