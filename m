Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8017317CC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344531AbjFOLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345057AbjFOLpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:45:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E73A3C3E;
        Thu, 15 Jun 2023 04:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FC061892;
        Thu, 15 Jun 2023 11:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A889C433C0;
        Thu, 15 Jun 2023 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686829253;
        bh=LckNHiaqcOAmyFMYmvjfzWDptBSbUAyKA/Eb3MHyar4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=we1ZHvATxPN1dC+oPbIyH9xvD9p9e8nFfo5qwgo4Zcb9d4m8VP/WYXOQg16f0S5rX
         noSVBPD1AM+lumjpI1kNw2nzpHzDl/9rcneIKJqiZXNrR+t9XlbRypQU3GvEVImnD0
         KpZAw27wDskExBtEZnVStF+B6sNwRmnWs2gBSBE8=
Date:   Thu, 15 Jun 2023 13:40:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lee Jones <lee@kernel.org>
Cc:     Julien Panis <jpanis@baylibre.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, arnd@arndb.de, derek.kiernan@xilinx.com,
        dragan.cvetic@xilinx.com, macro@orcam.me.uk,
        baolu.lu@linux.intel.com, yi.l.liu@intel.com, jirislaby@kernel.org,
        rostedt@goodmis.org, revest@chromium.org, gehao@kylinos.cn,
        akpm@linux-foundation.org, jgg@ziepe.ca, razor@blackwall.org,
        stephen@networkplumber.org, prabhakar.csengg@gmail.com,
        contact@emersion.fr, alex.williamson@redhat.com,
        akrowiak@linux.ibm.com, mark.rutland@arm.com,
        ye.xingchen@zte.com.cn, ojeda@kernel.org, me@kloenk.de,
        milan@mdaverde.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        sterzik@ti.com, u-kumar1@ti.com, eblanc@baylibre.com,
        jneanne@baylibre.com, aseketeli@baylibre.com
Subject: Re: [GIT PULL] Immutable branch containing TPS6594 core (MFD)
 support due for the v6.5 merge window
Message-ID: <2023061531-unfazed-calamari-91a2@gregkh>
References: <20230511095126.105104-1-jpanis@baylibre.com>
 <20230523074416.GA2174496@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523074416.GA2174496@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:44:16AM +0100, Lee Jones wrote:
> As promised.
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-tps6594-core-v6.5
> 
> for you to fetch changes up to 325bec7157b3859b45b9471447f5d130ab8a8723:
> 
>   mfd: tps6594: Add driver for TI TPS6594 PMIC (2023-05-18 16:06:14 +0100)

Thanks, I've pulled this into my char-misc tree so that I can take the
other patches here.

greg k-h
