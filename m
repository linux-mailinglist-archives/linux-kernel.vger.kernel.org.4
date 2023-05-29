Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8794714AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjE2NxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjE2Nwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:52:47 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 29 May 2023 06:52:37 PDT
Received: from h1.cmg2.smtp.forpsi.com (h1.cmg2.smtp.forpsi.com [81.2.195.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92610D
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:52:37 -0700 (PDT)
Received: from lenoch ([91.218.190.200])
        by cmgsmtp with ESMTPSA
        id 3dHYqCUKwv5uI3dHZqr1YP; Mon, 29 May 2023 15:51:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1685368294; bh=bucKz+Haz4+7MKDRJpT6h861a2KK5U5c1O/AVn8p7ms=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=DsmAZxR3norjQhadCmq+hoRZRqlNmEJTtEXp6muIvEDLVaCJLYJVSIwasV3UMtVSt
         s0komLwOPpk7leLdLEuUr3aKWiJu2+hB8X7AMC7xraDFUM1ul9DrF6y4h7CBJJ9hmS
         QEyqAXoTbr20RfSt800IQ9Dpju11wqj/XBrBnMku1t9Rfr0x+dX62DlicDOgzX1GnY
         caHQhKbODqABrTtrno20JFq1n32pqIoTj4Cuj+2veoFZhcTqqoZodRScrqAhpp9h78
         wDMKA9l4BrvyiFvHCMgQ7iInc+wfQLJIodW4o98gtxLxCaEs7tOA/ooUvNdAYq4Y/1
         eHCPzCYRu12Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triops.cz; s=f2019;
        t=1685368294; bh=bucKz+Haz4+7MKDRJpT6h861a2KK5U5c1O/AVn8p7ms=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=DsmAZxR3norjQhadCmq+hoRZRqlNmEJTtEXp6muIvEDLVaCJLYJVSIwasV3UMtVSt
         s0komLwOPpk7leLdLEuUr3aKWiJu2+hB8X7AMC7xraDFUM1ul9DrF6y4h7CBJJ9hmS
         QEyqAXoTbr20RfSt800IQ9Dpju11wqj/XBrBnMku1t9Rfr0x+dX62DlicDOgzX1GnY
         caHQhKbODqABrTtrno20JFq1n32pqIoTj4Cuj+2veoFZhcTqqoZodRScrqAhpp9h78
         wDMKA9l4BrvyiFvHCMgQ7iInc+wfQLJIodW4o98gtxLxCaEs7tOA/ooUvNdAYq4Y/1
         eHCPzCYRu12Cg==
Date:   Mon, 29 May 2023 15:51:32 +0200
From:   Ladislav Michl <oss-lists@triops.cz>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] mips: Fix spacing issue
Message-ID: <ZHSt5JKOc1hwEGTv@lenoch>
References: <20230529113421.8970-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529113421.8970-1-franziska.naepelt@gmail.com>
X-CMAE-Envelope: MS4wfFGH8mxnUyFuhTzkkGt7Soejk5fMTIEVBPNRnTKF6XyLaT6iiUEg5SsoktNQEZ2uVE8TTq8mnYyXIpX4IC/dBPvR1qurIJjOJbnFlixuWMxuhWu7m739
 NLzA7yWAGay8rxLWlTcSqYK2G6VKcKx2wBseRzVdMyBkWKTZnD/paTdZSaS3AwPbYYEwcEzO0AuPnwW4103RBl31A4SM+8FRhMZgswTqGZeSybP5DSOoi7Y+
 5YYxp8PTJ39HS2Un8+W56pis7qAdPNxNSi617s7FO2tGnK4Aa85cBuVdJvp9aX5dwRbxlm9IzwLteHByT80q5pb1iC3mHy0p4QA+JnvQBVU=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

coould we just fix all whitespaces while there?

diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
index 484969db7713..339d77a0a08f 100644
--- a/arch/mips/sibyte/swarm/platform.c
+++ b/arch/mips/sibyte/swarm/platform.c
@@ -88,15 +88,15 @@ device_initcall(swarm_pata_init);
 #define sb1250_dev_struct(num) \
 	static struct resource sb1250_res##num = {		\
 		.name = "SB1250 MAC " __stringify(num),		\
-		.flags = IORESOURCE_MEM,		\
-		.start = A_MAC_CHANNEL_BASE(num),	\
-		.end = A_MAC_CHANNEL_BASE(num + 1) -1,	\
+		.flags = IORESOURCE_MEM,			\
+		.start = A_MAC_CHANNEL_BASE(num),		\
+		.end = A_MAC_CHANNEL_BASE(num + 1) - 1,		\
 	};\
 	static struct platform_device sb1250_dev##num = {	\
-		.name = "sb1250-mac",			\
-	.id = num,					\
-	.resource = &sb1250_res##num,			\
-	.num_resources = 1,				\
+		.name = "sb1250-mac",				\
+		.id = num,					\
+		.resource = &sb1250_res##num,			\
+		.num_resources = 1,				\
 	}
 
 sb1250_dev_struct(0);

On Mon, May 29, 2023 at 01:34:21PM +0200, Franziska Naepelt wrote:
> This removes the following checkpatch issue:
> - ERROR: need consistent spacing around '-' (ctx:WxV)
> 
> Signed-off-by: Franziska Naepelt <franziska.naepelt@gmail.com>
> ---
>  arch/mips/sibyte/swarm/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/sibyte/swarm/platform.c b/arch/mips/sibyte/swarm/platform.c
> index 484969db7713..06bf7105e7b1 100644
> --- a/arch/mips/sibyte/swarm/platform.c
> +++ b/arch/mips/sibyte/swarm/platform.c
> @@ -90,7 +90,7 @@ device_initcall(swarm_pata_init);
>  		.name = "SB1250 MAC " __stringify(num),		\
>  		.flags = IORESOURCE_MEM,		\
>  		.start = A_MAC_CHANNEL_BASE(num),	\
> -		.end = A_MAC_CHANNEL_BASE(num + 1) -1,	\
> +		.end = A_MAC_CHANNEL_BASE(num + 1) - 1,	\
>  	};\
>  	static struct platform_device sb1250_dev##num = {	\
>  		.name = "sb1250-mac",			\
> 
> base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
> -- 
> 2.39.2 (Apple Git-143)
