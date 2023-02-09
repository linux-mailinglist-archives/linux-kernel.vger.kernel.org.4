Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B256690C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjBIOyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbjBIOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:54:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE1020D26
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tm9p9B92wuiXvWtB5X8K6MLqf1n5zJucRs53CwjBdIM=;
        b=AKDfpwHdK+5pB/fiI3EiNRo2Trl3DKZxuR1FEAuOAMIUVehgm2NVmbuhYp5CZ3+9R06zxe
        3xeSrfJhIQLqw9ELNWjDqvXN9hALzckX4r2CF8ohi9MoWi4dsLdQ/iKk/gf+HCQw623FOl
        aSom9HEoKFdV/XjEKPERKBMLAhroMlw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-uAuaUL9YP9mvCHEN-d1U-A-1; Thu, 09 Feb 2023 09:53:39 -0500
X-MC-Unique: uAuaUL9YP9mvCHEN-d1U-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C87693C0F22C;
        Thu,  9 Feb 2023 14:53:38 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BFDB1121315;
        Thu,  9 Feb 2023 14:53:35 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:53:31 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v2 3/3] HID: logitech-hidpp: Add myself to authors
Message-ID: <20230209145331.qqryivtatswdxvlf@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
 <20230206221256.129198-3-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206221256.129198-3-hadess@hadess.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06 2023, Bastien Nocera wrote:
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> 
> Same as v1
> 
>  drivers/hid/hid-logitech-hidpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 9e94026de437..03b77ca03081 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -30,6 +30,7 @@
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Benjamin Tissoires <benjamin.tissoires@gmail.com>");
>  MODULE_AUTHOR("Nestor Lopez Casado <nlopezcasad@logitech.com>");
> +MODULE_AUTHOR("Bastien Nocera <hadess@hadess.net>");

Just FTR, I have asked Bastien to set himself as an author given all of
the work he has been doing on this and to have one more person to be the
go-to person from folks having an issue.

And Bastien, would you mind adding yourself to the MAINTAINERS file too?
This way you'll get Cc-ed when people submit patches.

Cheers,
Benjamin

>  
>  static bool disable_tap_to_click;
>  module_param(disable_tap_to_click, bool, 0644);
> -- 
> 2.39.1
> 

