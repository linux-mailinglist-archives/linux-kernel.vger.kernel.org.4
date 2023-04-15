Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142256E3294
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDOQvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDOQvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:51:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD34699;
        Sat, 15 Apr 2023 09:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BAF161251;
        Sat, 15 Apr 2023 16:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C57C433D2;
        Sat, 15 Apr 2023 16:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681577463;
        bh=n0oePJtWdj05yVNtBX56JZ7CGqEDY5FheJdpHy8D2dM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qfHroG1/Jh8JlgMHRXDTAp48D/jUd4WysjMx//m7PNio9qzYlcEARajJiMtmKZlzx
         /JFR1Zr6dvdxNjzXx2Sh+R5FKl7Ei5SMOVvPtO4lA1FUcLIEXHhtqVtiFZrmTBtN9j
         ZHqPvF3h8BZixI3fXhYiLI6mPr5LCkCUAP085quVsj+lrfjjcp/47S8ADYZx3Ka39d
         ZB51pfDyJe4ivCzjlz8N7YQoZe0V3PkKS/ZEd9oyIzqKiYymBaMQ1St3m2QDTXlgWA
         8MjfDJl/qIWrqtlFALtHPt/s4uiA3wCZkVnFW29dwMdpjVC5bGZtyGe4/qzWZa87W4
         I4WyYi3+J5vTw==
Date:   Sat, 15 Apr 2023 17:51:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Marius Hoch <mail@mariushoch.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 6/6] dt-bindings: iio: st-sensors: Add LSM303D
 accelerometer+magnetometer
Message-ID: <20230415175104.3f8f4e09@jic23-huawei>
In-Reply-To: <501892f8-cad3-d1c7-7d24-6226eefe7edd@kernel.org>
References: <20230413024013.450165-1-mail@mariushoch.de>
        <20230413024013.450165-7-mail@mariushoch.de>
        <501892f8-cad3-d1c7-7d24-6226eefe7edd@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Apr 2023 10:07:04 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 13/04/2023 04:40, Marius Hoch wrote:
> > Same as the lsm9ds0, except that the lsm303d doesn't
> > feature a gyroscope.
> > 
> > Signed-off-by: Marius Hoch <mail@mariushoch.de>  
> 
> Please use scripts/get_maintainers.pl to get a list of necessary people
> and lists to CC.  It might happen, that command when run on an older
> kernel, gives you outdated entries.  Therefore please be sure you base
> your patches on recent Linux kernel.

Just to avoid any confusion.  Point here is that the dt-binding
maintainers and list should be cc'd on series that touch bindings.

Jonathan

> 
> Best regards,
> Krzysztof
> 

