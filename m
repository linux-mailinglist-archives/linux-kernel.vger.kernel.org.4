Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA56ACC1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 19:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCFSMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 13:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCFSLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 13:11:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149596F61F;
        Mon,  6 Mar 2023 10:11:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4618B61086;
        Mon,  6 Mar 2023 18:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33998C433D2;
        Mon,  6 Mar 2023 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678126257;
        bh=UtbJswbXqXi2I6w5vH95Sbdb/wUtOV35DRwtQbsJ3T4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwAL4/VJ7YYBSdiaJQhfW4Gt8iYGD24Stxl2ArlxfbFRjcDcSfMm0d6iZT8T57MLm
         UL5x3W8Fyq8ZyucInAnV7BJy1ySRsaqmipHvWNBRjnMVbxxbLdaoNbWwAUDaca4X3h
         tvmF7NurmAqeUmO1ELDlfD0MpPADHchZSzlXCfIY=
Date:   Mon, 6 Mar 2023 19:10:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/6] Add basic Minidump kernel driver support
Message-ID: <ZAYsr9xRC6sGs925@kroah.com>
References: <1676978713-7394-1-git-send-email-quic_mojha@quicinc.com>
 <8f3c6bea-ee49-dc0e-7491-19714b97255a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f3c6bea-ee49-dc0e-7491-19714b97255a@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 08:58:04PM +0530, Mukesh Ojha wrote:
> Friendly review reminder..

It is a few hours after the merge window closed, please be patient.

And to help out, please review other submissions to reduce the review
load on maintainers.  To not do that is just asking for others to do
work for you without any help, right?

thanks,

greg k-h
