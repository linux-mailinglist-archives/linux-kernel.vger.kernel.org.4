Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED8A6C6C70
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCWPkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjCWPkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:40:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA7E20576;
        Thu, 23 Mar 2023 08:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB53EB8217C;
        Thu, 23 Mar 2023 15:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED284C433D2;
        Thu, 23 Mar 2023 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679586040;
        bh=wFNk0PMfOOI+CqATyTjtD0/9jNHnSxyxFgJE5ar9UM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tnilC1zVLejPKPWj7NBoQUZW0RnAqpfSblanzNCdJUwCl0MwUnPzZP8O84tv3Dk43
         cnCOzQLFcLt5QUCn9cPLl6iJEwDRsu/Y2bwpYk/mZ+H+DADeGhhNuMs7nKhDU3sNz1
         s6k37Ufazast4a3Xoo3K7XhHdND+kZsIVMvvDB0o=
Date:   Thu, 23 Mar 2023 16:40:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <ZBxy9LYz+JyNW6GY@kroah.com>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 05:53:10PM +0800, Mingxuan Xiang wrote:
> platform_get_irq() no longer returns 0, so there is no
> need to check whether the return value is 0.

How did you find this issue?

How was it tested?

thanks,

greg k-h
