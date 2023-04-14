Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3CF6E1CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 09:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDNHDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 03:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNHDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 03:03:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CAD30F3;
        Fri, 14 Apr 2023 00:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0FC2E6142A;
        Fri, 14 Apr 2023 07:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA87C433D2;
        Fri, 14 Apr 2023 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681455813;
        bh=rqjQ+JkmQ5s8hFO6KOYrqJpPjXCe/ybWx2ES9pfKxNY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OeVa61hpWjJ355wmCLO1BoZhJiNSREBnBDe+T/Sl542IrJ34P0/Qs0XNcqYRPOfwS
         71N3861EHRYKuIko2FBs+YPNMb2fW8jY/Zg1kD7dDsWSYJVXzBocLn9+nKvm0H8yX1
         gHuFJ1gt4jE8K2RidIXyn5VlNnFlkWvOvq8BJnwzOyHm2NHaMDaLPG5aO7IFHKkZiG
         w6RmvDN0olHUmWpZURGrYsSQhgwQcnG4WnEyBnD7PouZCBskpHkNOfEm2pVkj4gRLr
         K4JEudrWmKe6KR1+gxklLROMsbaZgdYE5hstLqJxWl0gtIpvCMKZkpadblSN1sae54
         4PDEErmfBSEGw==
Date:   Fri, 14 Apr 2023 08:03:26 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v7 05/12] dt-bindings: mfd: syscon: Add
 nuvoton,ma35d1-sys compatible
Message-ID: <20230414070326.GA1036697@google.com>
References: <20230412053824.106-1-ychuang570808@gmail.com>
 <20230412053824.106-6-ychuang570808@gmail.com>
 <d11b6acb-b072-9496-5ad6-0635357394f1@linaro.org>
 <69b0aa3a-f5d2-8310-81ae-61d379db0d3b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69b0aa3a-f5d2-8310-81ae-61d379db0d3b@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Apr 2023, Jacky Huang wrote:

> Dear Krzysztof,
>
>
> On 2023/4/14 上午 12:47, Krzysztof Kozlowski wrote:
> > On 12/04/2023 07:38, Jacky Huang wrote:
> > > From: Jacky Huang <ychuang3@nuvoton.com>
> > >
> > > Add Nuvoton ma35d1 system registers compatible.
> > >
> > > Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> > What about the tag? Why did you ignore it?
> >
> > Also, wasn't this applied? Why do you resend (incorrect version)?
> >
> > Best regards,
> > Krzysztof
> >
>
> When I was making this patchset, this patch was still not merged.
> So I'm not sure if I should remove it.
> This is just a resend with no updates. And I will remove this patch
> in the next version as it was applied.
> If possible, please add the following tags for this patch.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I added this.

> Reviewed-by: Lee Jones <lee@kernel.org>

When did I provide this?

--
Lee Jones [李琼斯]
