Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C426F32CA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 17:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjEAPXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 11:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbjEAPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 11:23:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699AAE61;
        Mon,  1 May 2023 08:23:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0580160FE2;
        Mon,  1 May 2023 15:23:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B91C433EF;
        Mon,  1 May 2023 15:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682954615;
        bh=K9XsLWqKQn/jP/mzZLutSFMX6fSlEieZ9hD0h7aMKuQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rBN3xIw3wm0gT2YzECj/+dlrmUTTGFlmIcNCrp2kQLoPURG2ISD8lWl3zbX2qhqEr
         LTYtKzkMteBMUD3uM3kcOKWG2hLrk51uqTaQ5MoatCGLR1cNyrc3zwOydcJuZSdEnJ
         pjGJ3CFAMKpW5BEuDg7WF+yA61bao13Wa2/GHS2XHrMBi1CQRn+FEbYRBwn09lPYVE
         q5Kk8tB49iUVW0TDNd1Tn/W3nGGXfRbm4GfK07tjDFDd23hspyVujAGOfbE40Seqs5
         bHQBMI4hRzLO9+6jjPULW3JH5aw3WYAEu+zBfdjFfn9Uuo70i0wQedLSY+VRbcjIXB
         0P8jqU+bfGuUw==
Date:   Mon, 1 May 2023 16:39:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Message-ID: <20230501163920.65cc9454@jic23-huawei>
In-Reply-To: <20230424090318.4750a5e7@bootlin.com>
References: <20230421085245.302169-1-herve.codina@bootlin.com>
        <20230421085245.302169-2-herve.codina@bootlin.com>
        <20230422171807.510d7fa3@jic23-huawei>
        <20230424090318.4750a5e7@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 09:03:18 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Jonathan, Krzysztof,
> 
> On Sat, 22 Apr 2023 17:18:07 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Fri, 21 Apr 2023 10:52:43 +0200
> > Herve Codina <herve.codina@bootlin.com> wrote:
> >   
> > > The Renesas X9250 is a quad digitally controlled potentiometers.
> > > 
> > > Signed-off-by: Herve Codina <herve.codina@bootlin.com>    
> > 
> > Hi Herve,
> > 
> > Historically we've been a bit lax in IIO bindings in always making
> > sure the per supplies are included.  As a result we frequently get
> > them added later and it just makes things messier than they should
> > be.
> > 
> > So please add vcc-supply from the start.  V+ and V- are a little trickier.
> > I was expecting datasheet to say they should be symmetric about 0 but it
> > doesn't. So they could be two independent supplies.
> > 
> > Also make it required as my current understanding is that we should
> > do that for supplies that are definitely present even if we could
> > rely on the fallback to regulator stubs if they aren't supplied.
> > So add the 3 supplies to required as well.  
> 
> Yes, I will add the following supplies in the next iteration:
>  - 'vcc-supply' for VCC
>  - 'avp-supply' for the analog V+
>  - 'avn-supply' for the analog V-
> 
> and add them in the required list of properties.
> 
> Are the names correct for these power supplies (avp and avn) ?

I think so.  I'm not totally sure on how DT maintainers think we should deal
with a two voltage level reference though.  Perhaps add some description to
make it very clear what is going on and we'll see what review comments we get!

Jonathan
