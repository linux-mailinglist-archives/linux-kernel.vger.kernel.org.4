Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD7272CDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 20:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbjFLSVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 14:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237000AbjFLSV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 14:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B76E73
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 11:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686594024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DweJJLld2HQbZcM4M29lIrPOPHeHIdRll60sBYlCG68=;
        b=XqbO3f0Zfi1qRbgLNRkjnBZBorYwbcIzN0d++5q++uo7ATI7B8d9ENy08gc+NgWSrx2Xar
        PGNORSU/XeYvto87sGfSf8ctpYJGfGpdCxapERmm8GzICFvJopifw12b8unfkwpC0BD9fY
        0iRXHykJWMKdMtwYa/fnUDGZjb5z2OU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-MT2yHL5fPISWGWg2lrhwgw-1; Mon, 12 Jun 2023 14:20:20 -0400
X-MC-Unique: MT2yHL5fPISWGWg2lrhwgw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 968DE38117F7;
        Mon, 12 Jun 2023 18:20:19 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 57E1440D1B61;
        Mon, 12 Jun 2023 18:20:19 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 526D3400F7B72; Mon, 12 Jun 2023 11:24:17 -0300 (-03)
Date:   Mon, 12 Jun 2023 11:24:17 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: virt: correct location of haltpoll module
 params
Message-ID: <ZIcqkSzHGTZB6spQ@tpad>
References: <20230610054302.6223-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230610054302.6223-1-rdunlap@infradead.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:43:02PM -0700, Randy Dunlap wrote:
> Module parameters are located in sysfs, not debugfs, so correct the
> statement.
> 
> Fixes: 2cffe9f6b96f ("cpuidle: add haltpoll governor")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> ---
>  Documentation/virt/guest-halt-polling.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/Documentation/virt/guest-halt-polling.rst b/Documentation/virt/guest-halt-polling.rst
> --- a/Documentation/virt/guest-halt-polling.rst
> +++ b/Documentation/virt/guest-halt-polling.rst
> @@ -72,7 +72,7 @@ high once achieves global guest_halt_pol
>  
>  Default: Y
>  
> -The module parameters can be set from the debugfs files in::
> +The module parameters can be set from the sysfs files in::
>  
>  	/sys/module/haltpoll/parameters/
>  
> 
> 

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

