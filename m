Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B5662392
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjAIK7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbjAIK7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:59:46 -0500
Received: from fx302.security-mail.net (mxout.security-mail.net [85.31.212.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC911A34
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 02:59:45 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by fx302.security-mail.net (Postfix) with ESMTP id CC3481C3E747
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:59:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1673261983;
        bh=lZNxzYbAnagx6z12Q0AJlRyEnCWYJIFN1CJf3QiJ9cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=KN+m9mG2IN1tfOCcjhQygAKqIp8wrOXKTVntJupgLIrBwXwv+SVq/Jp7haWMK5AYs
         4F5IFehbC3pV8vC05z+xuudMPWM0itYe1WGQP3sXUBTzw0fTqNzdCkPrbO+1eME8Ox
         QRpyOKjuYwXRBN9w3Z++ibwvSIZjg004Pb7TxL0c=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id B375C1C3E72D; Mon,  9 Jan 2023 11:59:43 +0100 (CET)
Received: from zimbra2.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 31A381C3E714; Mon,  9 Jan
 2023 11:59:43 +0100 (CET)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1]) by
 zimbra2.kalray.eu (Postfix) with ESMTPS id 0BAF527E03B7; Mon,  9 Jan 2023
 11:59:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1]) by zimbra2.kalray.eu
 (Postfix) with ESMTP id E5B9327E03F5; Mon,  9 Jan 2023 11:59:42 +0100 (CET)
Received: from zimbra2.kalray.eu ([127.0.0.1]) by localhost
 (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026) with ESMTP id
 79E2VWtOVg-y; Mon,  9 Jan 2023 11:59:42 +0100 (CET)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206]) by
 zimbra2.kalray.eu (Postfix) with ESMTPSA id CC76727E03B7; Mon,  9 Jan 2023
 11:59:42 +0100 (CET)
X-Virus-Scanned: E-securemail
Secumail-id: <618a.63bbf39f.30b29.0>
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu E5B9327E03F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
 s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1673261982;
 bh=uuDY2mbHYs3yu9OaIiIFtuSPVXRl0RipgPQRVotTh0o=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=KUyvzl67xsozDcs6ytpSgQ+CiFCu/FWgl9sSdIxk8c2D93xVUCz9ZEgMsoGXz8ic2
 yU92waLFBunuD57yvLzbWoiSImtrEHmf+E5TcWt23d8uLAltc65MSO4QR3MXql6Sm0
 s08ioAlp5ggMoaf4AoNGellDykO7lo8qFd63UTjI=
Date:   Mon, 9 Jan 2023 11:59:41 +0100
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Yann Sionneau <ysionneau@kalray.eu>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clement Leger <clement.leger@bootlin.com>,
        Guillaume Thouvenin <gthouvenin@kalray.eu>
Subject: Re: [PATCH 0/8] kvx documentation improv (was: Re: [RFC PATCH
 01/25] Documentation: kvx: Add basic documentation)
Message-ID: <20230109105941.GA29108@tellis.lin.mbt.kalray.eu>
References: <874jt7fqxt.fsf@meer.lwn.net>
 <20230109095108.21229-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230109095108.21229-1-bagasdotme@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ALTERMIMEV2_out: done
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On Mon, Jan 09, 2023 at 04:51:00PM +0700, Bagas Sanjaya wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> >> Add some documentation for kvx arch and its Linux port.
> >>
> >> CC: Jonathan Corbet <corbet@lwn.net>
> >> CC: linux-doc@vger.kernel.org
> >> CC: linux-kernel@vger.kernel.org
> >> Co-developed-by: Clement Leger <clement.leger@bootlin.com>
> >> Signed-off-by: Clement Leger <clement.leger@bootlin.com>
> >> Co-developed-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> >> Signed-off-by: Guillaume Thouvenin <gthouvenin@kalray.eu>
> >> Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
> >> ---
> >>  Documentation/kvx/kvx-exceptions.txt | 246 ++++++++++++++++++++++++
> >>  Documentation/kvx/kvx-iommu.txt      | 183 ++++++++++++++++++
> >>  Documentation/kvx/kvx-mmu.txt        | 272 +++++++++++++++++++++++++++
> >>  Documentation/kvx/kvx-smp.txt        |  36 ++++
> >>  Documentation/kvx/kvx.txt            | 268 ++++++++++++++++++++++++++
> >>  5 files changed, 1005 insertions(+)
> >>  create mode 100644 Documentation/kvx/kvx-exceptions.txt
> >>  create mode 100644 Documentation/kvx/kvx-iommu.txt
> >>  create mode 100644 Documentation/kvx/kvx-mmu.txt
> >>  create mode 100644 Documentation/kvx/kvx-smp.txt
> >>  create mode 100644 Documentation/kvx/kvx.txt
> >
> >Please write this documentation in the RST format (you're 95% of the way
> >there now) and incorporate into the kernel docs build.
> 
> Here is the polished documentation in reST format. Yann, can you please
> squash this series into your documentation patch?
Thanks a lot, I've already converted the documentation to reST, but I will
take a look at this series and see what I can apply.

> Bagas Sanjaya (8):
>   Documentation: kvx: Convert to reST
>   Documentation: kvx: Wrap diagrams in literal code block
>   Documentation: kvx: Fix lists
>   Documentation: kvx: kvx-iommu: Use reST syntax for subsections
>   Documentation: kvx: kvx-iommu: monospacize kvx iommu device tree path
>   Documentation: kvx: Promote title headings
>   Documentation: kvx: Use literal code block for command-line inputs
>   Documentation: kvx: reword
> 
>  Documentation/arch.rst               |   1 +
>  Documentation/kvx/index.rst          |  12 ++
>  Documentation/kvx/kvx-exceptions.rst | 258 +++++++++++++++++++++++
>  Documentation/kvx/kvx-exceptions.txt | 246 ----------------------
>  Documentation/kvx/kvx-iommu.rst      | 188 +++++++++++++++++
>  Documentation/kvx/kvx-iommu.txt      | 183 -----------------
>  Documentation/kvx/kvx-mmu.rst        | 294 +++++++++++++++++++++++++++
>  Documentation/kvx/kvx-mmu.txt        | 272 -------------------------
>  Documentation/kvx/kvx-smp.rst        |  36 ++++
>  Documentation/kvx/kvx-smp.txt        |  36 ----
>  Documentation/kvx/kvx.rst            | 269 ++++++++++++++++++++++++
>  Documentation/kvx/kvx.txt            | 268 ------------------------
>  12 files changed, 1058 insertions(+), 1005 deletions(-)
>  create mode 100644 Documentation/kvx/index.rst
>  create mode 100644 Documentation/kvx/kvx-exceptions.rst
>  delete mode 100644 Documentation/kvx/kvx-exceptions.txt
>  create mode 100644 Documentation/kvx/kvx-iommu.rst
>  delete mode 100644 Documentation/kvx/kvx-iommu.txt
>  create mode 100644 Documentation/kvx/kvx-mmu.rst
>  delete mode 100644 Documentation/kvx/kvx-mmu.txt
>  create mode 100644 Documentation/kvx/kvx-smp.rst
>  delete mode 100644 Documentation/kvx/kvx-smp.txt
>  create mode 100644 Documentation/kvx/kvx.rst
>  delete mode 100644 Documentation/kvx/kvx.txt
> 
> -- 
> An old man doll... just what I always wanted! - Clara
> 
> 
> 
> 
> 




