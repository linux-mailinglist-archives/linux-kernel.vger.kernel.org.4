Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D4A72E9EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239724AbjFMRdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjFMRdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:33:16 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F8419BC;
        Tue, 13 Jun 2023 10:33:11 -0700 (PDT)
Received: from p5dc58481.dip0.t-ipconnect.de ([93.197.132.129] helo=aktux)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1q97t5-0000T3-Nz; Tue, 13 Jun 2023 19:32:59 +0200
Date:   Tue, 13 Jun 2023 19:32:57 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, tony@atomide.com, afd@ti.com,
        andreas@kemnade.info, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v7 0/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230613193257.267ad763@aktux>
In-Reply-To: <20230515074512.66226-1-andreas@kemnade.info>
References: <20230515074512.66226-1-andreas@kemnade.info>
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

any action still expected from my side?
people gave R-bys...
So looks like it is ready for the dt-folks to pick it up.

Regards,
Andreas

On Mon, 15 May 2023 09:45:10 +0200
Andreas Kemnade <andreas@kemnade.info> wrote:

> Convert board compatibles to yaml and add the new yaml file to
> MAINTAINERS so that emails are properly distributed
> 
> Changes in V7:
>  - checked for lost compatibles
>  - remove conversions with pattern matches probably allowing
>    too much
> 
> Changes in V6:
>  - reflect the rename also in the file header
> 
> Changes in V5:
>  - renamed the new file to ti/omap.yaml
> 
> Changes in V4:
>  - fix order 
>  - re-add dra7 to .txt to have it sorted out later
> 
> Changes in V3:
>  - update MAINTAINERS
>  - remove converted stuff from .txt
> 
> Changes in V2:
> - renamed file
> - fixed gta04
> - added Openpandora, Epson Moverio BT-200
> - drop example
> - remove descriptions if just reformatting the name
> 
> Andreas Kemnade (1):
>   MAINTAINERS: add board bindings list to OMAP2+ files
> 
> Andrew Davis (1):
>   dt-bindings: omap: Partially convert omap.txt to yaml
> 
>  .../devicetree/bindings/arm/omap/omap.txt     |  99 ----------
>  .../devicetree/bindings/arm/ti/omap.yaml      | 176 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 177 insertions(+), 99 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/ti/omap.yaml
> 

