Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955F699D27
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 20:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjBPTsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 14:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjBPTsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 14:48:10 -0500
Received: from mr85p00im-hyfv06011401.me.com (mr85p00im-hyfv06011401.me.com [17.58.23.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0B73A098
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676576888; bh=272IpGifcob1h7i4za6DArHBJ6II8B7mIFewvGBIsh4=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=FSurgnNF0VeTg1E2NS/cQBRLVI5NYSPWcuLGNiSI2AUIpEtEG+Kt7Fkfqpk2a2020
         J7nA3D3vBxr9ZqKboqfD5nZ8ZUjdx5V696h+9BGfE3wTCEyqCJcA8ebCSjlVWVXcCi
         PteS4dhI9vta2kPEmDqR0Mj4SMMJJ/ii2t4fWJ/UXjSgCRnxzJ+aA549AsiJ30zczv
         kQ7Bq9P06td+CuyshGXXprlK/vBmuJb8j/aVMsgl3Hjd7bA73t1zeG2rzmvRL5ygWn
         ez0wc0xabsgBxGLtvVAlOTKVk6GE7s12QoNKhinMb4F0K3otvz5XucajOfO7ZTYxOp
         3uNjGCQamBF8A==
Received: from imac101 (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-hyfv06011401.me.com (Postfix) with ESMTPSA id 4010C357FA6E;
        Thu, 16 Feb 2023 19:48:07 +0000 (UTC)
Date:   Thu, 16 Feb 2023 20:48:02 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <Y+6IcubsNszRK/59@imac101>
Mail-Followup-To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
References: <20230216113035.3050871a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216113035.3050871a@canb.auug.org.au>
X-Proofpoint-GUID: zzNxAMAd2ONhDyaucm8hkiZIXI0-XXvH
X-Proofpoint-ORIG-GUID: zzNxAMAd2ONhDyaucm8hkiZIXI0-XXvH
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 clxscore=1011 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302160170
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for the mistake.  I should have made a serie with those
2 patches in order to avoid this conflict.  Sorry about that.
I know now for a next case.

Cheers
Alain

On Thu, Feb 16, 2023 at 11:30:35AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the spi tree got a conflict in:
> 
>   MAINTAINERS
> 
> between commit:
> 
>   b3de755d6041 ("dt-bindings: i2c: i2c-st: convert to DT schema")
> 
> from the i2c tree and commit:
> 
>   7ec844a2c753 ("spi: spi-st-ssc: convert to DT schema")
> 
> from the spi tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc MAINTAINERS
> index 71e92d3c51c6,daa33e7bb457..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -2791,7 -2925,8 +2791,8 @@@ M:	Patrice Chotard <patrice.chotard@fos
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
>   W:	http://www.stlinux.com
> + F:	Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
>  -F:	Documentation/devicetree/bindings/i2c/i2c-st.txt
>  +F:	Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
>   F:	arch/arm/boot/dts/sti*
>   F:	arch/arm/mach-sti/
>   F:	drivers/ata/ahci_st.c


