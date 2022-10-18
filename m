Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB45603072
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiJRQCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiJRQB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:01:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9794E6C964;
        Tue, 18 Oct 2022 09:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A574B81FEA;
        Tue, 18 Oct 2022 16:01:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB205C433D6;
        Tue, 18 Oct 2022 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666108916;
        bh=Hn/UlsHxFMZytEorg4BSDyJiZpF+QOnOBXapsACQcrQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHxOk36gAwYbktOc8LmDZyJGSMN9auJnaUbH9Y/D1YD3J25ZLw6F2fdjTZ6+sDW6C
         yVC470JlYJTLXnG3z2IAwUvEtYth+8QYkjfdwap6daW0v9w0H4ZxMNl9R1UuwujK8S
         NnW9PGdxch6G6DdFumjVWBS1fyR4fiEiewwBhHTj2pHWGx2P9C1ilzblOuR3drsvIl
         cawGlhcQs0Suwk5p/Wb0KAF4CiXt2/nSWF3L9vVRrIVQ3f6iz+fr5++qq9B4V2PUgE
         sNuD3JF6XiBdFqC9LlsunLhRrK4qDG2UykNkuN3sLc+p/F3QmG/TyILB0HpdDopjIM
         xQrwHpWNbpjGA==
Date:   Tue, 18 Oct 2022 17:01:48 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tom Rini <trini@konsulko.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        William Zhang <william.zhang@broadcom.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 1/2] dt-bindings: mtd: partitions: u-boot: allow
 dynamic subpartitions
Message-ID: <Y07N7DXAKuPk5OTU@spud>
References: <20221018154202.4634-1-zajec5@gmail.com>
 <Y07LYoq6Dh+k0uJm@spud>
 <bd2bcbeb-c800-4f14-c801-c6b5489dbf49@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2bcbeb-c800-4f14-c801-c6b5489dbf49@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 05:55:14PM +0200, Rafał Miłecki wrote:
> On 18.10.2022 17:50, Conor Dooley wrote:
> > On Tue, Oct 18, 2022 at 05:42:01PM +0200, Rafał Miłecki wrote:
> > > From: Rafał Miłecki <rafal@milecki.pl>
> > > 
> > > U-Boot partition may contain subpartitions. For example Broadcom
> > > includes environment data block in the middle of its U-Boot partition.
> > > 
> > > This allows describing Broadcom's U-Boot env data and will allow
> > > referencing its NVMEM cell in the future.
> > > 
> > > Reg: 118f3fbe517f4 ("dt-bindings: mtd: partitions: support label/name only partition")
> > 
> > Pardon my ignorance here, but what is the significance of a "Reg" tag?
> 
> That was meant to be "Ref:" and was meant to show commit that introduced
> concept of dynamic partitions. I thought it's a new feature not everyone
> may be familiar with yet. I thought it may help to review this patch.

Ah nw, I wasn't sure if it ws a typo or "Reg" short for regression.

> 
> If that is pointless though could you Rob just drop those tags while
> applying, please? I guess I'll just let you decide.
> 
> 
> > > Ref: dd638202dfb65 ("dt-bindings: mtd: partitions: add additional example for qcom,smem-part")
> > > Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> 
