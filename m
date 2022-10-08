Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEE5F85E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbiJHPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJHPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:39:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2C4BD14;
        Sat,  8 Oct 2022 08:39:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B19AACE0AFF;
        Sat,  8 Oct 2022 15:39:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89939C433C1;
        Sat,  8 Oct 2022 15:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665243562;
        bh=mz2vCGCOEvfMyxm2IwhI2TPNWcuWcXnjlouOu3uMn3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=awHIACMQzsGRgKAOjJH2e5yeNW0Y+wbsoTADVnHWhiUhB+7iyhDIeDdr+v3bfXvnN
         w7DuLcqkly9OfVpjny7gO1OatnBu1899qHklv8iC+h1lO1STEuauuz9KYcXFleCYkp
         2t0YTsqshSJYDEKfhQWkEfSxBy/c0W16DtAaQGqs=
Date:   Sat, 8 Oct 2022 17:40:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     3090101217@zju.edu.cn
Cc:     pawell@cadence.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jing Leng <jleng@ambarella.com>
Subject: Re: [PATCH] usb: cdnsp: Fix wrong transmission direction of EP0
Message-ID: <Y0GZ1P0MBR6gi1hl@kroah.com>
References: <20220926075902.7390-1-3090101217@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926075902.7390-1-3090101217@zju.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 03:59:02PM +0800, 3090101217@zju.edu.cn wrote:
> From: Jing Leng <jleng@ambarella.com>
> 
> EP0 transfer is bi-directional, but in the cdnsp gadget, the
> transmission direction of EP0 is not changed after it is
> initialized to IN, so the OUT data from EP0 received by the host
> is invalid.
> 
> The value of ep0_expect_in will change according to the value of
> bRequestType in the SETUP transaction of control transfer, so we
> can use it as the transmission direction of EP0.
> 
> Signed-off-by: Jing Leng <jleng@ambarella.com>

Your email does not match your From: line and the signature of it shows
that it is invalid and does not pass authentication :(

Please work with your university to get an email address that works
properly.

thanks,

greg k-h
