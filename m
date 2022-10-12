Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA5F5FC599
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 14:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiJLMso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 08:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJLMsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 08:48:42 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A23ACA00
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 05:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jyRCSkJgo7N3Rt4/n9AA6aDgtpcxhME5uUTWnzA9JCk=; b=sTBYW1UDcEx5muxldg0ILajyMh
        VpwmXXiKY8uSvOCMZ+RIu+iYub2Cqjesl4tDT7+C+fz7NNTimuDe9UNPd2ZqVIjb3uypjoh7jOn81
        UlixxMWnrwRz2C2P9qpeTmC51UUlOwQ8YHi3jD9ptl6oHdHHD5ThWboCChZT38VUQSzI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oibA3-001nms-Eq; Wed, 12 Oct 2022 14:48:35 +0200
Date:   Wed, 12 Oct 2022 14:48:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     yexingchen116@gmail.com
Cc:     sebastian.hesselbarth@gmail.com, gregory.clement@bootlin.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>
Subject: Re: [PATCH linux-next v2] soc: dove: Use generic_handle_domain_irq()
Message-ID: <Y0a3o78Rx0+rCZMn@lunn.ch>
References: <20221012010522.334885-1-ye.xingchen@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221012010522.334885-1-ye.xingchen@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 01:05:22AM +0000, yexingchen116@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace generic_handle_irq(irq_find_mapping()) with
> generic_handle_domain_irq().

Thanks for the improves subject line.

When reposting a patch, please add any Acked-by, or Reviewed-by you
received for previous versions. It is hard for a Maintainer to track
these things over multiple versions. And it is extra effort to add
them, slowing down the whole process of merging patches.

	Andrew
