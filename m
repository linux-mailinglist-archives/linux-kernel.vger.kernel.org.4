Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C5647306
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiLHPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiLHPaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BE7B56C;
        Thu,  8 Dec 2022 07:30:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDD33B8243F;
        Thu,  8 Dec 2022 15:30:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33015C433C1;
        Thu,  8 Dec 2022 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670513405;
        bh=u7Sr2/R5rd1tjS3lenrB34/9f8Y7dq1TXgLcTG+fIPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkOzjlsnnWKsKJV4g3AodJztXSCo4UNrpDzrKoQhHGLHh84bRg1As06Y0cp0Hd3QP
         TFhvnlu3Q1J7CtjFuPXuFKrS4f8h+MFaPW5uHBGRHPoxuo99QTd7M2zazjd0yqTMUq
         wj+iZFoXeMj5kAZ9bn7a43VPdt8qM28sGqGeEF4o=
Date:   Thu, 8 Dec 2022 16:30:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Message-ID: <Y5IC+4dkSTyaROgo@kroah.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:19:18PM +0100, Quentin Schulz wrote:
> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> 
> From: Bin Yang <yangbin@rock-chips.com>

Can't have multiple "From:" lines, odd.  I'll try to fix this up on my
end...

