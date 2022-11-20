Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB66314D2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiKTPQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 10:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKTPQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 10:16:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F12635
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 07:16:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B614860C70
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 15:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846CDC433C1;
        Sun, 20 Nov 2022 15:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668957392;
        bh=/UximhifsHnyMuRvxnsCs//tzMn6Vtl9erSlkKEjSCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYJngp+pH/YWXZX16wFxFDPZP7sTEzDRTZv8dV0eJgkJSHD+ylQH7bMq0E7Y1YrwD
         rlu/dlUXBx700+9aOFsmfqP546lSRTxNdnpAPQGPEeLpaRBYHebEsbmpXy4gJPu+jv
         ed9cy8ClWcpq9X3N01QxLVbVREhXrT6NsOuftGrrqrBFyIc6zzwGV8uo8wTjl5lXEa
         o7clSrLxmZSP0qcFDyYqWnzVfQ0bj5/b6p/3QtZhKDASYYu7CcfoQHH+mfjtgE707t
         zmqx1pb0EAjnN2NqLCySpyDbX28PeioFwO0X2/27eWRUrueJvRB6lWQ9S1gsXK61Hk
         H5CY3TRoB79lg==
Date:   Sun, 20 Nov 2022 16:15:40 +0100
From:   Pratyush Yadav <pratyush@kernel.org>
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>
Subject: Re: [RESEND PATCH v4 1/1] mtd: spi-nor: winbond: Add support for
 w25q01jvq
Message-ID: <20221120151540.mqovzmbabnstul6y@yadavpratyush.com>
References: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111060530.2201084-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/22 02:05PM, Potin Lai wrote:
> From: Potin Lai <potin.lai@quantatw.com>
> 
> Add support for winbond w25q01jvq chip
> 
> Signed-off-by: Potin Lai <potin.lai@quantatw.com>
> Signed-off-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>

-- 
Regards,
Pratyush Yadav
