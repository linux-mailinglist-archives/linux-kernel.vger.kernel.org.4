Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0087F66E721
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbjAQTkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235413AbjAQTfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:35:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF114E9B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:40:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D577B819B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 18:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55EFC433EF;
        Tue, 17 Jan 2023 18:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673980800;
        bh=a1MHuq+rXdFJAg8ViD9GH750rnK1Tf4dQGy+Wa8H6Ns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgIHVbiNlW3pTaDVtilAbjof1JEEGYVZUSegSVnadGlQt1G15QrhVyWwMcyeBlbNf
         kOkxb9bVvZGG+o6AuogrZfL6Qa2r/Z+pmJqj+MX9qKNdu0GDcFkHItF5y9IIrCSg0C
         lQZxMrhiMBzhqvH6uMsB7INb1jG7qf/Sakyl5D9A=
Date:   Tue, 17 Jan 2023 19:39:57 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] staging: wlan-ng: Remove unused code
Message-ID: <Y8brfTFpeOnPl5S/@kroah.com>
References: <Y73bhE1VwQ5IfFyt@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73bhE1VwQ5IfFyt@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 03:11:24AM +0530, Deepak R Varma wrote:
> Several structs are defined but never used. Remove such dead code.

Which structs are not needed?  Be specific here, otherwise it is hard to
find changes in the future.

thanks,

greg k-h
