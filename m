Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220FC6959A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:07:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBNHG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbjBNHGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:06:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC5DA1E2BD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:06:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5E5F5B81BD5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2FCC433D2;
        Tue, 14 Feb 2023 07:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358372;
        bh=oIp9CF0MXa2byYkmJm9Ff52ZA0wL8zKpxwXGEQip3G8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XwdXqNxr5unEGXlz4WuQYuwOmzO+71Flvw62ml8YPiSuU5TNfCBV9cnhf8PjmF5eR
         ZZ9LpVoS35ebRte7SA/gn/oB3OFEhFyVQ6AVyYG7MuACQBGo7FxGwT/S8cSyy2raac
         udsMSU0HiTzLXVnH3PDw0TzmOhe76L5VsbbUeeSk=
Date:   Tue, 14 Feb 2023 08:06:08 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 1/6] sign-file: refactor argument parsing logic
Message-ID: <Y+sy4EFvS5nPxrMg@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-1-sshedi@vmware.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:29AM +0530, Shreenidhi Shedi wrote:
> - Use getopt_long_only for parsing input args
> - Use more easy to remember command line argument names
> 
> Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>

Your From: line does not match your signed-off-by, please use your
vmware.com address to send patches out so that it can be validated that
this really is coming from there and not some random fake gmail account.

thanks,

greg k-h
