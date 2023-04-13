Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82436E10B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjDMPNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjDMPND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88B8A5C1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681398716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KVlh2R2rtqFDMdS8kPJFoBNNVFL76z0BW6Vc3I+10vo=;
        b=e14kySTlD8IgIdnCYqmvhXtE/1RS8m1yksErXDpflJp2WFhKEUhA1ysl+XY4nE3ZJWu+TH
        eiOU/v8e8vCapvd75o3TUIyfBOYXIm86YlqyPJCF1K/N8cHQ948XDL9FR5cLBp9ntyq/uf
        /E3zKKE/pOKssXlelHqExOH1pI9wGgs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-I1UQ7epONf2DZQdLue3gBw-1; Thu, 13 Apr 2023 11:11:53 -0400
X-MC-Unique: I1UQ7epONf2DZQdLue3gBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2745985C6ED;
        Thu, 13 Apr 2023 15:11:53 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D294F18EC7;
        Thu, 13 Apr 2023 15:11:51 +0000 (UTC)
Date:   Thu, 13 Apr 2023 17:11:49 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] HID: explicitly include linux/leds.h
Message-ID: <20230413151149.tdpq3zlj333bwvtm@mail.corp.redhat.com>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
 <7fb9e268-189a-47d5-8737-310d9b6f0f35@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fb9e268-189a-47d5-8737-310d9b6f0f35@t-8ch.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 20 2023, Thomas Weiﬂschuh wrote:
> Friendly ping,
> 
> this seems to have fallen through the cracks.

Sorry for the delay.

I have applied them now, as should have told you the automatic
notifications.

Cheers,
Benjamin

> 
> Thanks,
> Thomas
> 
> On Wed, Feb 15, 2023 at 01:03:33AM +0000, Thomas Weiﬂschuh wrote:
> > Instead of relying on an accidental, transitive inclusion of linux/leds.h
> > use it directly.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > ---
> > Thomas Weiﬂschuh (4):
> >       HID: steelseries: explicitly include linux/leds.h
> >       HID: lg-g15: explicitly include linux/leds.h
> >       HID: asus: explicitly include linux/leds.h
> >       HID: apple: explicitly include linux/leds.h
> > 
> >  drivers/hid/hid-apple.c       | 1 +
> >  drivers/hid/hid-asus.c        | 1 +
> >  drivers/hid/hid-lg-g15.c      | 1 +
> >  drivers/hid/hid-steelseries.c | 1 +
> >  4 files changed, 4 insertions(+)
> > ---
> > base-commit: e1c04510f521e853019afeca2a5991a5ef8d6a5b
> > change-id: 20230215-power_supply-leds-hid-f99a0a3fd2bf
> > 
> > Best regards,
> > -- 
> > Thomas Weiﬂschuh <linux@weissschuh.net>
> > 

