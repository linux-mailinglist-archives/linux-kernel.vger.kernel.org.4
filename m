Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E2A6D9FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240236AbjDFSgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240240AbjDFSgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:36:03 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A24C9004;
        Thu,  6 Apr 2023 11:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BN8eRYF3Sq4xpM3Dg9tNo1stv4INQ9PaEfyAW6wwvkI=; b=pc7BxjPxLgOmotAEcEcKSQvKJe
        WenlYuSlqqsMgoed8UuzBBDs6H3i0nka1whGjIn0s8/5IvxmNxV75Q1E3+wBS5FREvDw08leY/fDu
        cK5vgqQzAtxJlTCKdm9oD7590J4WIMfph3g9iIPv6o2WZtv9K9i5trefv/eqyoXJHCnqWZ2VIXNNh
        iD5Jo3jzVxOApkgmH2Qssio7XZ50flmifynRppjCZwbootRe2qVmDVzHDoFIlU+UjC6E/814LjJyN
        +DoKCJoOuAeC87OQMoH5sr4B3aFpqluq2W1CmrD6CVdVn99DvMTrPgv/ZOKYWbKI0Mahjxg/B/ttx
        CGoZKZBA==;
Received: from p200300ccff190e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff19:e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1pkUSb-00030q-K6; Thu, 06 Apr 2023 20:35:50 +0200
Date:   Thu, 6 Apr 2023 20:35:48 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        tony@atomide.com, afd@ti.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: omap: Convert omap.txt to yaml
Message-ID: <20230406203548.152ae065@aktux>
In-Reply-To: <7f43953c-d326-f517-d896-cbb060d8092a@linaro.org>
References: <20230405161908.4312-1-andreas@kemnade.info>
        <20230405161908.4312-2-andreas@kemnade.info>
        <eb4cf82d-f523-d5af-be18-25c37678a95a@linaro.org>
        <7f43953c-d326-f517-d896-cbb060d8092a@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.24; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2023 10:36:36 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 06/04/2023 10:32, Krzysztof Kozlowski wrote:
> > On 05/04/2023 18:19, Andreas Kemnade wrote:  
> >> From: Andrew Davis <afd@ti.com>
> >>
> >> Convert omap.txt to yaml.
> >>  
> > 
> >   
> >> +      - description: TI AM43 SoC based platforms
> >> +        items:
> >> +          - enum:
> >> +              - compulab,am437x-cm-t43
> >> +              - ti,am437x-gp-evm
> >> +              - ti,am437x-idk-evm
> >> +              - ti,am437x-sk-evm
> >> +          - pattern: '^ti,am4372[26789]$'
> >> +          - const: ti,am43
> >> +
> >> +      - description: TI AM57 SoC based platforms
> >> +        items:
> >> +          - enum:
> >> +              - beagle,am5729-beagleboneai
> >> +              - compulab,cl-som-am57x
> >> +              - ti,am5718-idk
> >> +              - ti,am5728-idk
> >> +              - ti,am5748-idk
> >> +          - pattern: '^ti,am57[0124][689]$'  
> > 
> > I don't think my comments were resolved. I asked if it is possible to
> > make a board called "ti,am5718-idk" with "ti,am5749" or with "ti,am5708"?  
> 
> Hm, I cannot find my concern, so maybe it never left my outbox. Anyway,
> it looks like you allow here many incorrect patterns and combinations.
> 
You had concerns about the "dra" stuff for the same valid reasons.

> > 
> > What's more, you dropped several variations and compatibles against
> > original binding (all the "dra") and it is not explained in commit msg
> > at all.  
> 
> All changes against original bindings should be explained.
> 
... which I then just decided not to convert but keep as is in the text file
because there were no comments hints about it more than a month since the first
version was sent so thought that it has to be resolved later.

Regards,
Andreas
