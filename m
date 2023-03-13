Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349516B6F81
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCMGeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCMGeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:34:22 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7309F2528A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id B7B76CE0C4F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:34:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E566C433D2;
        Mon, 13 Mar 2023 06:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678689257;
        bh=dfnhwwoUlLciibO9JpPLk0EYzIASM++7YkI5B2eE1Ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZB4sv4JVe7uy51VYKjUg26KMInXtrae46P7ZJBioVYM139M9utqeBS9K0GH+wH/ES
         XOnQu0eq6e7TKMvEM6Ia4w8s/B8zMO/v+ZhPv0RANjsrRMFRFIOXtyWIk3XBeYHpFK
         KnaM1uiRJNeOCSvp8dnq3aCoxSmMvBwYo4Ey6aIE=
Date:   Mon, 13 Mar 2023 07:34:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com,
        jhubbard@nvidia.com, willy@infradead.org, jgg@ziepe.ca,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the
 vm_flags in vm_area_struct
Message-ID: <ZA7D54vwYXThZG3U@kroah.com>
References: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 11:42:50PM +0100, Vincenzo Palazzo wrote:
> With 6.3-rc1 is not possible to build the following drivers
> 
> - nvidia, that the compilation returns the following errors

<snip>

> - vboxhost/7.0.6_OSE where the build fails with the following errors

Out-of-tree code needs to be fixed up all the time, this is their
responsibility, not the kernel's responsibility.  Please submit changes
to their codebases if you rely on these modules.

thanks,

greg k-h
