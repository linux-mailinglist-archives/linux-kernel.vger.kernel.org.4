Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF1F6736438
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 09:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjFTHPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 03:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFTHPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 03:15:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DBE7;
        Tue, 20 Jun 2023 00:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 373C961028;
        Tue, 20 Jun 2023 07:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95297C433C8;
        Tue, 20 Jun 2023 07:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687245338;
        bh=LkMp9qTmcaups5Fx8bJgkCG0ZHEHB6F3Fq6a6AFyrpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJwdrWKw5mKUf3aubmM2P4qN0QzZkzLRkEF8YOM6GZOm3ooyZAVM85uofuWmQAgYU
         qzCFQrCAPWw5s/lwcPpFomp6dDfBx7N50UuF4jz7V4rj2/W6vA0w0434rzAQ17wstT
         PMwlNzkDACIyTcWG8UlJh5aXkgqu3sNmENu55e08+ODL4SR109O7eR/aTxCeuF2ko2
         /7Zkx2ddhsFyBX+j3j2x0aOwcvExfY6ycuPDfOD1z6rJjkitfjbXB8HaEii4OytiQs
         RfRvOmO1Pdio0J5lwdlNQtHsuKNyhXVmftKRv7m2e044+iaWslOm0BJVlq3yq1WBv4
         ULurZaP8K71ig==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qBVaU-0006s7-IJ; Tue, 20 Jun 2023 09:15:38 +0200
Date:   Tue, 20 Jun 2023 09:15:38 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/5] gnss: ubx: 'vcc' can be optional
Message-ID: <ZJFSGtbJEaq7UN3Y@hovoldconsulting.com>
References: <20230523064310.3005-1-wsa+renesas@sang-engineering.com>
 <20230523064310.3005-4-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523064310.3005-4-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 08:43:08AM +0200, Wolfram Sang wrote:
> There are devices where 'vcc' is always on. The reset pin is used for
> silencing the chip. Make the 'vcc' regulator optional.

The device still has a vcc supply even if it happens to be always-on on
a particular board (and this should be reflected in the DT).

Johan
