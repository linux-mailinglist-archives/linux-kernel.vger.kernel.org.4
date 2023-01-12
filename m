Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D953B668428
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjALUpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjALUow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:44:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD2A7A22B;
        Thu, 12 Jan 2023 12:13:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FCF46217D;
        Thu, 12 Jan 2023 20:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58933C433F0;
        Thu, 12 Jan 2023 20:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673554432;
        bh=ocPG8mDE8cSQlgOlHVRQopksIHAiKfrTBVrBOx4Y0p0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ylKA9VauOYy4I+4rkzICcL/eJUmYhzNHBxGFHGy1oPlBJgDBuZTPwhf3w5g8zOWQ7
         pxMD9Lcba5nn3MxLeuK5QfylP5P6SWw24A5m4+YXpf93QRpVEvn5NIzz05ULdLsZ6P
         rfvuLsUd5fFtWatWB6sGyJAMvoKBk/VkDT5VZ+AI=
Date:   Thu, 12 Jan 2023 21:13:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?5p2O5ZOy?= <sensor1010@163.com>
Cc:     jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] serial: linflexuart: Remove redundant uart type
 assignment
Message-ID: <Y8Bp94bR/7HmgqrD@kroah.com>
References: <20230105170437.4437-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105170437.4437-1-sensor1010@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:04:37AM -0800, 李哲 wrote:
> in linflex_config_port() the member variable type will be
> assigned again. see linflex_connfig_port()
> 
> Signed-off-by: 李哲 <sensor1010@163.com>
> V4 -> V5: Link: https://lore.kernel.org/all/ddcf396b-7b91-00f3-8c16-7de5dc891aef@kernel.org/
> V3 -> V4: Link: https://lore.kernel.org/all/2f726128-29c-b7dd-ad8-f8b536fbe5f@linux.intel.com/
> V2 -> V3: Link: https://lore.kernel.org/all/8f433e5-fb46-d3b8-431b-4bddcc938f6b@linux.intel.com/
> V1 -> V2: Link: https://lore.kernel.org/all/1c33a2af-cd0d-cdde-5bc7-49b418665784@kernel.org/

Links are not ok for versioning, sorry, please read the documentation
for how to do this properly.

greg k-h
