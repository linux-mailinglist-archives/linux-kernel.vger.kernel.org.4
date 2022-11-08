Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10946218BE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbiKHPrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234504AbiKHPrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:47:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B691258BD1;
        Tue,  8 Nov 2022 07:47:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0C605CE1BDA;
        Tue,  8 Nov 2022 15:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A244C433D7;
        Tue,  8 Nov 2022 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667922452;
        bh=za4WbEtLefrKEzgLi73bg/HM+ESMxSvU10ePvP+t5j4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=huE/SXUEGR1joRt6ooEIUKklN/HLnn9Zea75Xz7GxdEbNcACWLMoY71rWU/yF+QSt
         8poWuZCjX+5jqJfQ1PFkaQ1vHrLimy9t9mTA4ugE49WpEZFoTkCNMkN96Vds5qpMC2
         1Zj16EoBoG8zkoSW12eSKxi2EG2cW51AYjeeaw0I=
Date:   Tue, 8 Nov 2022 16:47:28 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jing Leng <jleng@ambarella.com>
Cc:     balbi@kernel.org, bilbao@vt.edu, corbet@lwn.net,
        laurent.pinchart@ideasonboard.com, mchehab+huawei@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH v5] usb: gadget: uvc: add bulk transfer support
Message-ID: <Y2p6ELhnZ9GE1ASQ@kroah.com>
References: <20220513004201.25563-1-3090101217@zju.edu.cn>
 <20221103061303.26813-1-jleng@ambarella.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103061303.26813-1-jleng@ambarella.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 02:13:03PM +0800, Jing Leng wrote:
> **********************************************************************
> This email and attachments contain Ambarella Proprietary and/or Confidential Information and is intended solely for the use of the individual(s) to whom it is addressed. Any unauthorized review, use, disclosure, distribute, copy, or print is prohibited. If you are not an intended recipient, please contact the sender by reply email and destroy all copies of the original message. Thank you.

Now deleted.
