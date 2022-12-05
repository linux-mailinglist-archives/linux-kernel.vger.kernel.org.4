Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015ED642EA8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiLERZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiLERZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:25:34 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954F82182D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:25:01 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id y2so3592324ily.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:25:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RySgEr1sUrHZ1nCymQmDeo4/Y6ZOXyOJnU/yj5J5hPk=;
        b=jk/sO03XWU7B+5BxvbidUGg1TqxV0JKJkO0ZUSHCzCKgw0EwCHR2G4U2Cio6qiPMAS
         WzOhXtv40Us4zZtxD7bxfTOWmsdHFp8EeYRHGYsANXcwUucUqleazvtHmFWR/1ly1HKP
         w0nf2Y31smroEHo6yHqRMAor1loYRgGsFco55tCpLoadMTQBrb9x7eZiKRiYeo+z+xXB
         yt1+/GLji90LXjjpHCVok7GUdLMvoo8m6zytufr1LB25T2JNsSor6JtXD4IrcKZncDIF
         U4wD36zEmK3QGuKjnoV5BdURrDxqYmffhKcJEJs7dbNyntal+z7NroySBLCN2c7LpmoP
         0Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RySgEr1sUrHZ1nCymQmDeo4/Y6ZOXyOJnU/yj5J5hPk=;
        b=M6Z3eBZFrBkhqjetDMzxzP+or8pNrwJv1S6llUxo3YswGR4AsImZreuGYLG1XEc2ez
         QYibW0CMRMF4mIilJWmJLjEUlw9WxYv65Bby1gR/f6RS45DLwAKaID5WabS7ds/frctm
         Z3uz6/wlZSAWI/N9qkkF89TrjrwG3VkO0A9lFZgyodKR51oPVruVjSDXzLthK/2M2Ao/
         4s8lw9ZvaR1CtK5eCfmimqi7qjscKBeoKYila/DkYwRF8Db7PCgU379/REywne0R5q2e
         U60U6YkbKLSFLMpI6rAIi2EMy94Jshn7dKdf6FKjKWKZ1AP+RQsbPRJhii4Rcr6cLGAz
         eAcw==
X-Gm-Message-State: ANoB5pnLQHu5UEoj01CMj3Pv+ooU35VDCqWNxjvXWfQsqqLEjZ9gtGwX
        hLPDr5mKm+l8SSpujFmEexiSmn/GlsUWHwaAmbpH+l/E1z9PNg==
X-Google-Smtp-Source: AA0mqf60ATo6agV4JyMK9bqx86xQx3PiS4Uc05Puk4GWZywUQxl83TslhpKnozbKFULr20r1ijqitmL4cz1/uYQ27WU=
X-Received: by 2002:a05:6e02:1101:b0:300:d3e3:a124 with SMTP id
 u1-20020a056e02110100b00300d3e3a124mr29618361ilk.260.1670261099858; Mon, 05
 Dec 2022 09:24:59 -0800 (PST)
MIME-Version: 1.0
References: <20221128134120.0afdceb3@canb.auug.org.au>
In-Reply-To: <20221128134120.0afdceb3@canb.auug.org.au>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Mon, 5 Dec 2022 10:24:48 -0700
Message-ID: <CANLsYkw0Nq38rZzGTTpCL4J3aWJQpX32iOe4zdTT0+CcfhcOmg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rpmsg tree with the spi tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
        Ben Levinsky <ben.levinsky@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michal Simek <michal.simek@amd.com>,
        Rajan Vaja <rajan.vaja@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Bjorn Andersson <andersson@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen - thanks for the legwork on this.


On Sun, 27 Nov 2022 at 19:41, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the rpmsg tree got a conflict in:
>
>   include/linux/firmware/xlnx-zynqmp.h
>
> between commit:
>
>   1e400cb9cff2 ("firmware: xilinx: Add qspi firmware interface")
>

Mark - since this is in the SPI tree, can you send me a pull request
for this commit?  I will do the refactoring on my side.

Thanks,
Mathieu

> from the spi tree and commit:
>
>   b2bd0a8c3ab1 ("firmware: xilinx: Add ZynqMP firmware ioctl enums for RPU configuration.")
>
> from the rpmsg tree.
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
> diff --cc include/linux/firmware/xlnx-zynqmp.h
> index fac37680ffe7,cf92e739fa3b..000000000000
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@@ -135,7 -138,10 +138,11 @@@ enum pm_ret_status
>   };
>
>   enum pm_ioctl_id {
> +       IOCTL_GET_RPU_OPER_MODE = 0,
> +       IOCTL_SET_RPU_OPER_MODE = 1,
> +       IOCTL_RPU_BOOT_ADDR_CONFIG = 2,
> +       IOCTL_TCM_COMB_CONFIG = 3,
>  +      IOCTL_SET_TAPDELAY_BYPASS = 4,
>         IOCTL_SD_DLL_RESET = 6,
>         IOCTL_SET_SD_TAPDELAY = 7,
>         IOCTL_SET_PLL_FRAC_MODE = 8,
